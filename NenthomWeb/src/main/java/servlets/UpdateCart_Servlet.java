package servlets;

import java.io.IOException;
import java.sql.Connection;

import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Cart;
import services.ConnectionUtil;
import utils.CSRFUtil;

@WebServlet("/servlets/UpdateCart_Servlet")
public class UpdateCart_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateCart_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (!CSRFUtil.isValid(request)) {
	        request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
	        return;
	    }
		HttpSession session = request.getSession();
    	int userID = (int) session.getAttribute("userID");

        // Lấy productId và action (tăng hoặc giảm)
        int productId = Integer.parseInt(request.getParameter("productId"));
        String action = request.getParameter("action");

        // Kết nối với DB và cập nhật số lượng trong giỏ hàng
        try (Connection connection = ConnectionUtil.DB()) {
            CartDAO cartDAO = new CartDAO(connection);
            Cart cartItem = cartDAO.getCartItem(userID, productId);

            if (cartItem != null) {
                int newQuantity = cartItem.getQuantity();

                // Tăng hoặc giảm số lượng
                if ("increment".equals(action)) {
                    newQuantity++;
                } else if ("decrement".equals(action) && newQuantity > 1) {
                    newQuantity--;
                }

                // Cập nhật lại số lượng trong giỏ hàng
                cartItem.setQuantity(newQuantity);
                cartDAO.updateCartItem(cartItem);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra khi cập nhật giỏ hàng.");
            return;
        }

        // Quay lại trang giỏ hàng
        response.sendRedirect("./ListCart_Servlet");
    }
}
