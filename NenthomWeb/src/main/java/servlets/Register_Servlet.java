package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.TaiKhoan;
import services.ConnectionUtil;
import utils.CSRFUtil;
@WebServlet("/servlets/Register_Servlet")
public class Register_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Register_Servlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String message = "";
        boolean error = false;

        try (Connection conn = ConnectionUtil.DB()) {
            TaiKhoanDAO taiKhoanDao = new TaiKhoanDAO(conn);

            if (taiKhoanDao.isUsernameExist(username)) {
                message = "Tài khoản đã tồn tại!";
                error = true;
            } else if (!password.equals(confirmPassword)) {
                message = "Mật khẩu và xác nhận mật khẩu không khớp!";
                error = true;
            } else {
                TaiKhoan taiKhoan = new TaiKhoan(username, password); // Bạn có thể mã hóa password trước khi lưu
                if (taiKhoanDao.addUser(taiKhoan)) {
                    message = "Đăng ký thành công!";
                    error = false;
                } else {
                    message = "Đăng ký không thành công!";
                    error = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Lỗi kết nối cơ sở dữ liệu!";
            error = true;
        }

        request.setAttribute("message", message);
        request.setAttribute("error", error);

        if (!error) {
        	CSRFUtil.attachToken(request);
            // Chuyển đến trang login nếu đăng ký thành công
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        } else {
        	CSRFUtil.attachToken(request);
            // Quay lại trang đăng ký nếu có lỗi
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
