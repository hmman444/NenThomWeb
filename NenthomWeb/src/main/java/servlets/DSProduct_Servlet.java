package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;
import org.apache.commons.text.StringEscapeUtils;

import dao.CategorieDAO;
import dao.DiscountDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Categorie;
import models.Discount;
import models.Order;
import models.Product;
import services.ConnectionUtil;

@WebServlet("/servlets/DSProduct_Servlet")
public class DSProduct_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public DSProduct_Servlet() {
		super();
	}

protected void doGet(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
	
	// response.setHeader("Content-Security-Policy", "default-src 'self'; script-src 'self'");

	try (Connection connection = ConnectionUtil.DB()) {

        String page = request.getParameter("page");
        
        String message = request.getParameter("message");
        String action = request.getParameter("action");
        
        if (message != null) {
            request.setAttribute("message", message);
        }
        request.setAttribute("action", action);
        
	ProductDAO productDao = new ProductDAO(connection);
	List<Product> products = productDao.getAllProducts();
	for (Product p : products) {
	    String escapedName = StringEscapeUtils.escapeHtml4(p.getName());
	    escapedName = StringEscapeUtils.escapeEcmaScript(escapedName);
		p.setName(escapedName);
		
		String escapedDecription = StringEscapeUtils.escapeHtml4(p.getDescription());
		escapedDecription = StringEscapeUtils.escapeEcmaScript(escapedDecription);
	    p.setDescription(escapedDecription);
	}
	
	OrderDAO orderDao = new OrderDAO(connection);
	List<Order> orders = orderDao.getAllOrders();
	for (Order p : orders) {
		String escapedShippingAddress = StringEscapeUtils.escapeHtml4(p.getShippingAddress());
		escapedShippingAddress = StringEscapeUtils.escapeEcmaScript(escapedShippingAddress);
	    p.setShippingAddress(escapedShippingAddress);
	}
	
	DiscountDAO discountDAO = new DiscountDAO();
	List<Discount> discounts = discountDAO.getActiveDiscounts();            
	
	CategorieDAO categorieDAO = new CategorieDAO(connection);
	List<Categorie> categories = categorieDAO.getAllCategories();
	for (Categorie p : categories) {
	 	String escapedName = StringEscapeUtils.escapeHtml4(p.getName());
	    escapedName = StringEscapeUtils.escapeEcmaScript(escapedName);
		p.setName(escapedName);
		
		String escapedDecription = StringEscapeUtils.escapeHtml4(p.getDescription());
		escapedDecription = StringEscapeUtils.escapeEcmaScript(escapedDecription);
	    p.setDescription(escapedDecription);
	}
	
	if ("admin".equals(page)) {
	    request.setAttribute("products", products);
	    request.setAttribute("orders", orders);
	    request.setAttribute("discounts", discounts);
	    request.setAttribute("categories", categories);
	    request.getRequestDispatcher("/views/admin.jsp").forward(request, response);
	} else {
	    request.setAttribute("products", products);
	    request.setAttribute("categories", categories);
	    request.getRequestDispatcher("/views/product.jsp").forward(request, response);
	}
        
    } catch (Exception e) {
        e.printStackTrace();
        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
    }
}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
