package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import DBConnection.ConnectJDBC;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.MonHoc;
import utils.DBUtils;

@WebServlet("/FilterController")
public class FilterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public FilterController() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection conn = null;
        List<MonHoc> listMH = null;
        List<MonHoc> listTenMH = null;

        try {
            conn = new ConnectJDBC().getConnection();
            String maMH = request.getParameter("maMH");

            // Lấy danh sách tên môn học cho dropdown
            listTenMH = DBUtils.DanhSachMH(conn);

            // Kiểm tra mã môn học để lọc danh sách
            if (maMH == null || maMH.isEmpty()) {
                listMH = DBUtils.DanhSachMH(conn);
            } else {
                listMH = DBUtils.LocMonHocTheoMa(conn, maMH);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // Gửi danh sách đã lọc về trang JSP
        request.setAttribute("ListMH", listMH);
        request.setAttribute("ListTenMH", listTenMH);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/views/home.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
