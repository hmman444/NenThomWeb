package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import dao.CategorieDAO;
import dao.CategoryDAO;
import dao.DiscountDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Categorie;
import models.Category;
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
		try (Connection connection = ConnectionUtil.DB()) {
            ProductDAO productDao = new ProductDAO(connection);
            List<Product> products = productDao.getAllProducts();
            
            OrderDAO orderDao = new OrderDAO(connection);
            List<Order> orders = orderDao.getAllOrders();
            
            DiscountDAO discountDAO = new DiscountDAO();
            List<Discount> discounts = discountDAO.getActiveDiscounts();            

            CategorieDAO categorieDAO = new CategorieDAO(connection);
            List<Categorie> categories = categorieDAO.getAllCategories();
            
            String productID = request.getParameter("productID");
            List<Categorie> categoriesLinked;
            List<Categorie> categoriesNotLinked;
            if(productID != null && !productID.isEmpty() ) {
            	categoriesNotLinked = categorieDAO.getCategoriesNotForProduct(Integer.parseInt(productID));
                categoriesLinked = categorieDAO.getCategoriesForProduct(Integer.parseInt(productID));
            }
            else {
                categoriesNotLinked = categorieDAO.getCategoriesNotForProduct(1);
                categoriesLinked = categorieDAO.getCategoriesForProduct(1);
            }
            String page = request.getParameter("page");
            
            String message = request.getParameter("message");
            String action = request.getParameter("action");
            
            if (message != null) {
                request.setAttribute("message", message);
            }
            request.setAttribute("action", action);
            
            if ("admin".equals(page)) {
                request.setAttribute("products", products);
                request.setAttribute("orders", orders);
                request.setAttribute("discounts", discounts);
                request.setAttribute("categories", categories);
                request.setAttribute("categoriesNotLinked", categoriesNotLinked);
                request.setAttribute("categoriesLinked", categories);
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
