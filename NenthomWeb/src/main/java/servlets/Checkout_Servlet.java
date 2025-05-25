package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import dao.CartDAO;
import dao.CategorieDAO;
import dao.DiscountDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Cart;
import models.Categorie;
import models.Discount;
import models.Order;
import models.OrderDetail;
import models.Product;
import services.ConnectionUtil;

@WebServlet("/servlets/Checkout_Servlet")
public class Checkout_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Checkout_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String totalAmountStr = request.getParameter("totalAmount");        
	    BigDecimal totalAmount = BigDecimal.valueOf(Double.parseDouble(totalAmountStr));
	    String shippingAddress = request.getParameter("address");
	    Boolean flagVoucher = false;
	    HttpSession session = request.getSession();
	    int userID = (int) session.getAttribute("userID");
	    BigDecimal totalAmountReal = BigDecimal.valueOf(5.99);
	    Order order = new Order();
	    order.setUserID(userID);
	    order.setOrderStatus("confirmed"); 
	    order.setShippingAddress(shippingAddress);
	    order.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

	    try (Connection connection = ConnectionUtil.DB()) {
	        connection.setAutoCommit(false);

	        CategorieDAO categorieDAO = new CategorieDAO(connection);
	        List<Categorie> categories = categorieDAO.getAllCategories();
	        
	        ProductDAO productDao = new ProductDAO(connection);
	        List<Product> products = productDao.getAllProducts();
	        request.setAttribute("products", products);
	        request.setAttribute("categories", categories);
	        CartDAO cartDAO = new CartDAO(connection);
	        List<Cart> cartList = cartDAO.getCartItems(userID);

	        OrderDetailDAO orderDetailDAO = new OrderDetailDAO(connection);
	        for (Cart cart : cartList) {
	            ProductDAO productDAO = new ProductDAO(connection);
	            Product product = productDAO.getProductById(cart.getProductID());
	            
	            if (product != null) {
	            	totalAmountReal = totalAmountReal.add(
	            			BigDecimal.valueOf(product.getPrice()).multiply(BigDecimal.valueOf(cart.getQuantity()))
	            		);
	            }
	        }
	     // Kiểm tra nếu có mã giảm giá (Discount)
	        String discountId = request.getParameter("voucherId");
	        DiscountDAO discountDAO = new DiscountDAO();

	        Discount selectedDiscount = null;
	        if (discountId != null && !discountId.isEmpty()) {
	            selectedDiscount = discountDAO.getDiscountById(Integer.parseInt(discountId)); // Lấy ưu đãi theo ID
	            // Cập nhật lại tổng tiền nếu có discount
	            if (selectedDiscount != null) {
	            	System.out.println(selectedDiscount.getDiscountValue());
	                BigDecimal discountValue = BigDecimal.valueOf(selectedDiscount.getDiscountValue());
	                if ("percentage".equals(selectedDiscount.getDiscountType())) {
	                    // totalAmountReal = totalAmountReal - (totalAmountReal * discountValue / 100)
	                    BigDecimal discount = totalAmountReal
	                        .multiply(discountValue)
	                        .divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);
	                    totalAmountReal = totalAmountReal.subtract(discount);
	                } else {
	                    // totalAmountReal = totalAmountReal - discountValue
	                    totalAmountReal = totalAmountReal.subtract(discountValue);
	                }
	            }
	            else {
	    	        flagVoucher = true;
	    	        throw new RuntimeException("Voucher không tồn tại hoặc không hợp lệ.");
	            }

	        }
	        else {
    	        flagVoucher = true;
    	        throw new RuntimeException("Voucher không tồn tại hoặc không hợp lệ.");
            }
		    order.setTotalPrice(totalAmountReal);
		    OrderDAO orderDAO = new OrderDAO(connection);
	        int orderID = orderDAO.createOrder(order);  
	        for (Cart cart : cartList) {
	            ProductDAO productDAO = new ProductDAO(connection);
	            Product product = productDAO.getProductById(cart.getProductID());
	            if (product != null) {
	                OrderDetail orderDetail = new OrderDetail();
	                orderDetail.setProductID(product.getProductID());
	                orderDetail.setProductName(product.getName());
	                orderDetail.setQuantity(cart.getQuantity());
	                BigDecimal price = BigDecimal.valueOf(product.getPrice());
	                orderDetail.setPrice(price);

	                orderDetailDAO.createOrderDetail(orderDetail, orderID);
	            }
	        }

	        cartDAO.clearCart(userID);

	        connection.commit();

	        

	        
	        request.setAttribute("successMessage", "Thanh toán thành công! Cảm ơn bạn đã mua hàng.");
	        request.getRequestDispatcher("/views/product.jsp").forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        try (Connection connection = ConnectionUtil.DB()) {
	            connection.rollback();  
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	        if(flagVoucher) {
		        request.setAttribute("errorMessage", "Voucher không tồn tại. Thanh toán thất bại!!!!!");
	        }
	        else {
		        request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình thanh toán.");
	        }
	        request.getRequestDispatcher("/views/product.jsp").forward(request, response);
	    }
	}
}
