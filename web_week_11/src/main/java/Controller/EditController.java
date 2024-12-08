package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;

import DBConnection.ConnectJDBC;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Khoa;
import models.MonHoc;

@WebServlet("/EditController")
public class EditController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String maMH = request.getParameter("maMH");
        MonHoc monHoc = null;

        try (Connection conn = new ConnectJDBC().getConnection()) {
            // Lấy thông tin môn học từ cơ sở dữ liệu
            String sql = "SELECT mh.maMH, mh.tenMH, k.tenKhoa, mh.soTC " +
                         "FROM MonHoc mh " +
                         "INNER JOIN Khoa k ON mh.maKhoa = k.maKhoa " +
                         "WHERE mh.maMH = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, maMH);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                monHoc = new MonHoc();
                monHoc.setMaMH(rs.getString("maMH"));
                monHoc.setTenMH(rs.getString("tenMH"));
                monHoc.setTenKhoa(rs.getString("tenKhoa"));
                monHoc.setSoTC(rs.getInt("soTC"));
            }

            // Lấy danh sách khoa để hiển thị trong dropdown
            List<Khoa> listKhoa = utils.DBUtils.getAllKhoa(conn);
            request.setAttribute("listKhoa", listKhoa);
            request.setAttribute("monHoc", monHoc);

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Chuyển tiếp đến trang edit.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/edit.jsp");
        dispatcher.forward(request, response);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String maMH = request.getParameter("maMH");
        String tenMH = request.getParameter("tenMH");
        int maKhoa = Integer.parseInt(request.getParameter("maKhoa"));
        int soTC = Integer.parseInt(request.getParameter("soTC"));

        String updateSQL = "UPDATE MonHoc SET tenMH = ?, maKhoa = ?, soTC = ? WHERE maMH = ?";
        try (Connection conn = new ConnectJDBC().getConnection();
             PreparedStatement ps = conn.prepareStatement(updateSQL)) {

            ps.setString(1, tenMH);
            ps.setInt(2, maKhoa);
            ps.setInt(3, soTC);
            ps.setString(4, maMH);

            ps.executeUpdate();
            System.out.println("Cập nhật môn học thành công: " + tenMH);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi cập nhật môn học: " + e.getMessage());
            return;
        }

        response.sendRedirect("MonHocController");
    }
}
