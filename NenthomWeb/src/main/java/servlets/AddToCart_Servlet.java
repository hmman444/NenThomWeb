package servlets;

import java.io.IOException;
import java.sql.Connection;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;
import services.ConnectionUtil;

@WebServlet("/AddToCart_Servlet")
public class AddToCart_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddToCart_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userID = Integer.parseInt(request.getParameter("userID"));
        int productID = Integer.parseInt(request.getParameter("productID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));

        Cart cart = new Cart(userID, productID, quantity);

        try (Connection connection = ConnectionUtil.DB()) {
            CartDAO cartDAO = new CartDAO(connection);
            cartDAO.addToCart(cart);
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("cart.jsp"); 
    }
}
