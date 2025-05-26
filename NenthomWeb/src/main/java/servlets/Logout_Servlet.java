package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/servlets/Logout_Servlet")
public class Logout_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Logout_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session hiện tại
        HttpSession session = request.getSession(false); // false để không tạo session mới nếu không tồn tại

        if (session != null) {
            // Hủy các thuộc tính session
            session.removeAttribute("username");
            session.removeAttribute("userID");

            // Hủy toàn bộ session
            session.invalidate();
        }

        // Đặt thông báo logout thành công vào request
        request.setAttribute("logoutMessage", "Bạn đã đăng xuất thành công!");

        // Chuyển hướng người dùng về trang đăng nhập
        response.sendRedirect(request.getContextPath() + "/servlets/Login_Servlet");
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
