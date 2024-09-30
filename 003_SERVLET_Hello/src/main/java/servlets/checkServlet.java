package servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class checkServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public checkServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		System.out.println(username);
		if ("abc".equals(username) && "123".equals(password)) {
			response.sendRedirect("03_jspHello.jsp");
		} else {
			response.sendRedirect("03_jspError.jsp");
		}
	}

}
