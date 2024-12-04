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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
