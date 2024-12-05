package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import constant.SystemConstant;
import dao.CartDAO;
import dao.DiscountDAO;
import dao.ProductDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;
import models.Discount;
import models.Product;
import models.User;
import services.ConnectionUtil;

@WebServlet("/servlets/LoadInfoCheckout_Servlet")
public class LoadInfoCheckout_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public LoadInfoCheckout_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = ConnectionUtil.DB()) {
            int userId = SystemConstant.USERID;

            UserDAO userDAO = new UserDAO(connection);
            User user = userDAO.getUserById(userId);
            
            CartDAO cartDAO = new CartDAO(connection);
            List<Cart> cartList = cartDAO.getCartItems(userId);

            double subtotal = 0.0; 
            for (Cart cart : cartList) {
                int productID = cart.getProductID();

                ProductDAO productDAO = new ProductDAO(connection);
                Product product = productDAO.getProductById(productID);
                if (product != null) {
                    // Tính toán tổng giá trị của sản phẩm trong giỏ hàng
                    double productTotalPrice = product.getPrice() * cart.getQuantity();
                    subtotal += productTotalPrice;
                }
            }

            // Tính phí vận chuyển (ví dụ $5.99)
            double shippingCost = 5.99;

            // Tính tổng giá tiền (Subtotal + Shipping)
            double totalAmount = subtotal + shippingCost;

            // Kiểm tra nếu có mã giảm giá (Discount)
            String discountId = request.getParameter("discountID");
            DiscountDAO discountDAO = new DiscountDAO();

            Discount selectedDiscount = null;
            if (discountId != null && !discountId.isEmpty()) {
                selectedDiscount = discountDAO.getDiscountById(Integer.parseInt(discountId)); // Lấy ưu đãi theo ID
                // Cập nhật lại tổng tiền nếu có discount
                if (selectedDiscount != null) {
                    if (selectedDiscount.getDiscountType().equals("percentage")) {
                        totalAmount = totalAmount - (totalAmount * selectedDiscount.getDiscountValue() / 100);
                    } else {
                        totalAmount = totalAmount - selectedDiscount.getDiscountValue();
                    }
                }
            }
            String formattedTotalAmount = String.format("%.2f", totalAmount);
            
            request.setAttribute("user", user);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("shippingCost", shippingCost);
            request.setAttribute("totalAmount", formattedTotalAmount);
            request.setAttribute("selectedDiscount", selectedDiscount);

            // Chuyển tiếp đến trang giỏ hàng (cart.jsp)
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
