package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Random;

import dao.TaiKhoanDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.TaiKhoan;
import services.AuthCodeUtil;
import services.ConnectionUtil;

@WebServlet("/servlets/Register_Servlet")
public class Register_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Register_Servlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AuthCodeUtil.refreshVerificationCode(request.getSession());
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        String message = "";
        boolean error = false;
        
        if (!AuthCodeUtil.isVerificationCodeValid(request)) {
            AuthCodeUtil.refreshVerificationCode(request.getSession());
            request.setAttribute("message", "Mã xác thực không đúng!");
            request.setAttribute("error", true);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }
        
        if (!AuthCodeUtil.isStrongPassword(password)) {
            AuthCodeUtil.refreshVerificationCode(request.getSession()); // sinh lại mã nếu có dùng
            request.setAttribute("message", "Mật khẩu không đủ mạnh. Vui lòng sử dụng ít nhất 8 ký tự bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.");
            request.setAttribute("error", true);
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
            return;
        }

        try {
            TaiKhoanDAO taiKhoanDao = new TaiKhoanDAO();

            if (taiKhoanDao.isUsernameExist(username)) {
                message = "Tài khoản đã tồn tại!";
                error = true;
            } else if (!password.equals(confirmPassword)) {
                message = "Mật khẩu và xác nhận mật khẩu không khớp!";
                error = true;
            } else {
                TaiKhoan taiKhoan = new TaiKhoan(username, password);
                if (taiKhoanDao.addUser(taiKhoan)) {
                    message = "Đăng ký thành công!";
                    error = false;
                } else {
                    message = "Đăng ký không thành công!";
                    error = true;
                }
            }
            taiKhoanDao.close();
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Lỗi kết nối cơ sở dữ liệu!";
            error = true;
        }

        request.setAttribute("message", message);
        request.setAttribute("error", error);

        if (!error) {
            // Chuyển đến trang login nếu đăng ký thành công
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        } else {
            // Quay lại trang đăng ký nếu có lỗi
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
