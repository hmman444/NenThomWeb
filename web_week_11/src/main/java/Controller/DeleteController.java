package Controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import DBConnection.ConnectJDBC;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteController")
public class DeleteController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DeleteController() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String maMH = request.getParameter("maMH");

        if (maMH == null || maMH.isEmpty()) {
            response.sendRedirect("MonHocController");
            return;
        }

        String deleteSQL = "DELETE FROM MonHoc WHERE maMH = ?";
        try (Connection conn = new ConnectJDBC().getConnection();
             PreparedStatement ps = conn.prepareStatement(deleteSQL)) {

            ps.setString(1, maMH);
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Xóa môn học thành công: " + maMH);
            } else {
                System.out.println("Không tìm thấy môn học với mã: " + maMH);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi khi xóa môn học: " + e.getMessage());
        }

        response.sendRedirect("MonHocController");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("MonHocController");
    }
}
