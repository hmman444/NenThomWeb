package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import constant.SystemConstant;
import dao.CartDAO;
import dao.CategorieDAO;
import dao.OrderDAO;
import dao.OrderDetailDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;
import models.Categorie;
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
	    int userID = SystemConstant.USERID;

	    Order order = new Order();
	    order.setUserID(userID);
	    order.setTotalPrice(totalAmount);
	    order.setOrderStatus("pending"); 
	    order.setShippingAddress(shippingAddress);
	    order.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));

	    try (Connection connection = ConnectionUtil.DB()) {
	        connection.setAutoCommit(false);

	        OrderDAO orderDAO = new OrderDAO(connection);
	        int orderID = orderDAO.createOrder(order);  

	        CartDAO cartDAO = new CartDAO(connection);
	        List<Cart> cartList = cartDAO.getCartItems(userID);

	        OrderDetailDAO orderDetailDAO = new OrderDetailDAO(connection);  
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

	        CategorieDAO categorieDAO = new CategorieDAO(connection);
	        List<Categorie> categories = categorieDAO.getAllCategories();
	        
	        ProductDAO productDao = new ProductDAO(connection);
	        List<Product> products = productDao.getAllProducts();

	        request.setAttribute("products", products);
	        request.setAttribute("categories", categories);
	        request.setAttribute("successMessage", "Thanh toán thành công! Cảm ơn bạn đã mua hàng.");
	        request.getRequestDispatcher("/views/product.jsp").forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
	        try (Connection connection = ConnectionUtil.DB()) {
	            connection.rollback();  
	        } catch (SQLException ex) {
	            ex.printStackTrace();
	        }
	        
	        request.setAttribute("errorMessage", "Có lỗi xảy ra trong quá trình thanh toán.");
	        request.getRequestDispatcher("/views/product.jsp").forward(request, response);
	    }
	}
}
