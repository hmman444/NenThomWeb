package servlets;

import java.io.IOException;

import beans.LoginBean;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/CheckUserNamePasswordServlet")
public class CheckUserNamePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public CheckUserNamePasswordServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		LoginBean lb = new LoginBean();
		lb.setUname("minhman");
		lb.setPw("1");

		String uName = request.getParameter("username");
		String pWord = request.getParameter("password");

		if (lb.checkValidate(uName, pWord)) {
		    request.setAttribute("bean", lb);  
		    request.getRequestDispatcher("Login.jsp").forward(request, response);
		} else {
		    response.sendRedirect("error.jsp");
		}
		
//		if (lb.checkValidate(uName, pWord)) {
//			response.sendRedirect("Login.jsp");
//		} else {
//			response.sendRedirect("error.jsp");
//		}

	}

}
