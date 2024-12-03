package servlets;

import java.io.IOException;
import java.sql.Connection;

import constant.SystemConstant;
import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;
import services.ConnectionUtil;

@WebServlet("/servlets/AddToCart_Servlet")
public class AddToCart_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AddToCart_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy giá trị productID từ request body (POST)
        String productIDStr = request.getParameter("productID");

        // Kiểm tra nếu productID hợp lệ
        if (productIDStr == null || productIDStr.isEmpty()) {
            response.getWriter().write("Error: Missing product ID.");
            return;
        }

        // Chuyển đổi productID từ String sang int
        int productID;
        try {
            productID = Integer.parseInt(productIDStr);
        } catch (NumberFormatException e) {
            response.getWriter().write("Error: Invalid product ID format.");
            return;
        }

        // Tiến hành các xử lý tiếp theo
        int userID = SystemConstant.USERID;
        int quantity = 1;  // Số lượng mặc định là 1

        // Thêm vào giỏ hàng
        Cart cart = new Cart(userID, productID, quantity);
        try (Connection connection = ConnectionUtil.DB()) {
            CartDAO cartDAO = new CartDAO(connection);
            cartDAO.addToCart(cart);
            response.getWriter().write("Product added to cart");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error adding to cart");
        }
    }
}
