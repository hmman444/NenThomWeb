package servlets;

import java.io.File;
import java.io.FileWriter;
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
		String url = "index.jsp";
		String so1Str = request.getParameter("txtSo1");
		String so2Str = request.getParameter("txtSo2");
		int kq = 0;
		try {
			int so1 = Integer.parseInt(so1Str);
			int so2 = Integer.parseInt(so2Str);
			
			kq = so1 + so2;
		} catch (Exception e) {
			System.out.println("Only number!");
			System.out.println(e.getMessage());
			String msg_log = "Entered: Number 1: " + so1Str + ", "  + "Entered: Number 2: " + so2Str + " on: " + new java.util.Date().toString();
			File fl = new File("D:\\LTWeb\\log");
			if(!fl.exists()) {
				fl.createNewFile();
			}
			FileWriter myWriter = new FileWriter(fl);
			myWriter.append(msg_log);
			myWriter.close();
		}
		url = "/outcome.jsp";
		request.setAttribute("kq", kq);
		getServletContext().getRequestDispatcher(url).forward(request, response);
	}

}
