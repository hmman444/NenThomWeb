package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import dao.CategorieDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Categorie;
import models.Product;
import services.ConnectionUtil;

@WebServlet("/servlets/SearchProduct_Servlet")
public class SearchProduct_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public SearchProduct_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchQuery = request.getParameter("search");
        String category = request.getParameter("category");
        String priceRange = request.getParameter("price");
        
        if(category!=null)
        {
        	if(category.equals("all")) 
        	{
        		category = null;
        	}       
        }
        
        if(category!=null)
        {
        	if(category.equals("Categories")) 
        	{
        		category = null;
        	}       
        }
        
        if(priceRange!=null)
        {
        	if(priceRange.equals("all")) 
        	{
        		priceRange = null;
        	}       
        }       
        
//        if((category!=null && category.equals("all")) || category.equals("Categories"))
//        {
//        	category = null;
//        }
//        if(priceRange.equals("all")) 
//        {
//        	category = null;
//        }
        try (Connection connection = ConnectionUtil.DB()) {
            ProductDAO productDao = new ProductDAO(connection);

            List<Product> products = productDao.searchProducts(searchQuery, category, priceRange);

            CategorieDAO categorieDAO = new CategorieDAO(connection);
            List<Categorie> categories = categorieDAO.getAllCategories();

            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/views/product.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
