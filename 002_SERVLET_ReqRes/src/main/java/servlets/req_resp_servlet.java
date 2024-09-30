package servlets;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class req_resp_servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public req_resp_servlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			String url = "/index.jsp";
			String name = request.getParameter("txtName");
			String message;

			if (name == null || name.isEmpty()) {
				message = "Rewrite one more";
				request.setAttribute("message", message);
				url = "/index.jsp";
			} else {
				message = "";
				request.setAttribute("message", message);
				url = "/welcome.jsp";
				request.setAttribute("name", name);
			}
			getServletContext().getRequestDispatcher(url).forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
