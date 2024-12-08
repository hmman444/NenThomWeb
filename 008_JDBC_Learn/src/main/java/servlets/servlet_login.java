package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import beans.actBean;

/**
 * Servlet implementation class servlet_login
 */
@WebServlet("/servlet_login")
public class servlet_login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor. 
	 */
	public servlet_login() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		String username = request.getParameter("username");
		String password = request.getParameter("password");

		actBean a = new actBean(username, password);


		boolean isValid;

		String dbDriver = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
		
		String DB_URL = "jdbc:sqlserver://localhost:1433;databaseName=";
		String DB_NAME = "Account";
		String DB_USER = "sa";
		String DB_PASSWORD = "1";
		String connectionURL = DB_URL + DB_NAME;
		
		Connection conn = null;
		try {
			Class.forName(dbDriver);
			conn = DriverManager.getConnection(connectionURL, DB_USER, DB_PASSWORD);
			String sql = "SELECT * FROM Account WHERE username = ? AND password = ?";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				// Login thành công
				isValid = true;
			} else {
				// Sai username hoặc password
				isValid = false;
			}
			
			conn.close();
		} catch (Exception e) {
			e.printStackTrace();
			isValid = false;
		}

		if(isValid)
		{
			response.sendRedirect("loginSuccess.jsp");
		}
		else
		{
			response.sendRedirect("loginFailed.jsp");
		}
	}

}
