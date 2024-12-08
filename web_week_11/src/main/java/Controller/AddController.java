package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;

import DBConnection.ConnectJDBC;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Khoa;

@WebServlet("/AddController")
public class AddController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = new ConnectJDBC().getConnection()) {
            List<Khoa> listKhoa = utils.DBUtils.getAllKhoa(conn);
            request.setAttribute("listKhoa", listKhoa);
        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/add.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String maMH = request.getParameter("maMH");
        String tenMH = request.getParameter("tenMH");
        int maKhoa = Integer.parseInt(request.getParameter("maKhoa"));
        int soTC = Integer.parseInt(request.getParameter("soTC"));

        String insertSQL = "INSERT INTO MonHoc (maMH, tenMH, maKhoa, soTC) VALUES (?, ?, ?, ?)";
        try (Connection conn = new ConnectJDBC().getConnection();
             PreparedStatement ps = conn.prepareStatement(insertSQL)) {

            ps.setString(1, maMH);
            ps.setString(2, tenMH);
            ps.setInt(3, maKhoa);
            ps.setInt(4, soTC);

            ps.executeUpdate();
            System.out.println("Thêm môn học thành công: " + tenMH);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi thêm môn học: " + e.getMessage());
            return;
        }

        response.sendRedirect("MonHocController");
    }
}
