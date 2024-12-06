package servlets;

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

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/servlets/DSCatagory_Servlet")
public class DSCatagory_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DSCatagory_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	try (Connection connection = ConnectionUtil.DB()) {
    		CategorieDAO categorieDAO = new CategorieDAO(connection);
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
            String action = request.getParameter("action");
            
            request.setAttribute("action", action);
            request.setAttribute("categoriesNotLinked", categoriesNotLinked);
            request.setAttribute("categoriesLinked", categoriesLinked);
            response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=selectCategory");
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }
}
