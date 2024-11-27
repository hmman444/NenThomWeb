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
import jakarta.servlet.http.HttpSession;
import services.ConnectionUtil;

@WebServlet("/servlets/Login_Servlet")
public class Login_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login_Servlet() {
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
		String message = "";
		boolean error = false;

		try (Connection conn = ConnectionUtil.DB()) {
			TaiKhoanDAO taiKhoanDao = new TaiKhoanDAO(conn);

			if (!taiKhoanDao.isUsernameExist(username)) {
				message = "Tài khoản không tồn tại!";
				error = true;
			} else {
				String storedPassword = taiKhoanDao.getPasswordByUsername(username);
				if (storedPassword.equals(password)) {
					HttpSession session = request.getSession();
					session.setAttribute("username", username);
					response.sendRedirect("/views/TrangChu.jsp");
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
			request.setAttribute("message", message);
			request.setAttribute("error", error);
			request.getRequestDispatcher("/views/Login.jsp").forward(request, response);
		}
	}

}
