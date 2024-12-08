package servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import beans.Products;

@WebServlet("/_05_ListProductServlets")
public class _05_ListProductServlets extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public _05_ListProductServlets() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		List<Products> list = new ArrayList<>();
		list.add(new Products("1", "Harry Potter", 450000.d));
		list.add(new Products("2", "Nhà giả kim", 95000.d));
		list.add(new Products("3", "Không phải sói, cũng chẳng phải cừu", 130000.d));
		list.add(new Products("4", "Nghìn lẻ một đêm", 230000.d));
		
		request.setAttribute("productList", list);
		
		response.setContentType("text/html;charset=UTF-8");
		RequestDispatcher dispatcher = request.getServletContext().getRequestDispatcher("/05_productList.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
