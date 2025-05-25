package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Random;

import dao.TaiKhoanDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.AuthCodeUtil;
import services.ConnectionUtil;

@WebServlet("/servlets/Login_Servlet")
public class Login_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login_Servlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		AuthCodeUtil.refreshVerificationCode(request.getSession());
		request.getRequestDispatcher("/views/login.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String message = "";
        boolean error = false;
        
		if (!AuthCodeUtil.isVerificationCodeValid(request)) {
		    AuthCodeUtil.refreshVerificationCode(request.getSession());
		    request.setAttribute("message", "Mã xác thực không đúng!");
		    request.setAttribute("error", true);
		    request.getRequestDispatcher("/views/login.jsp").forward(request, response);
		    return;
		}



        try (Connection conn = ConnectionUtil.DB()) {
            TaiKhoanDAO taiKhoanDao = new TaiKhoanDAO(conn);
            UserDAO userDao = new UserDAO(conn);

            if (!taiKhoanDao.isUsernameExist(username)) {
                message = "Tài khoản không tồn tại!";
                error = true;
            } else {
                String storedPassword = taiKhoanDao.getPasswordByUsername(username);
                if (storedPassword.equals(password)) {
                    // Lấy role của người dùng
                    String role = taiKhoanDao.getRoleByUsername(username);
                    int userID = userDao.getUserIDByUsername(username);

                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("userID", userID);

                    // Chuyển hướng đến trang quản lý theo quyền
                    if ("manager".equals(role)) {
                        request.getRequestDispatcher("/servlets/DSProduct_Servlet?page=admin").forward(request, response);
                    } else if ("user".equals(role)) {
                        request.getRequestDispatcher("/views/TrangChu.jsp").forward(request, response);
                    }
                } else {
                    message = "Mật khẩu không đúng!";
                    error = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu!";
            error = true;
        }

        if (error) {
            // Đưa thông báo và trạng thái lỗi về JSP
            request.setAttribute("message", message);
            request.setAttribute("error", error);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
