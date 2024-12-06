package servlets;

import java.io.IOException;
import java.sql.Connection;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ConnectionUtil;

@WebServlet("/servlets/ProductDetail_Servlet")
public class ProductDetail_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProductDetail_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
    	int productID = Integer.parseInt(request.getParameter("productID"));
    	try (Connection connection = ConnectionUtil.DB()) {
            ProductDAO productDao = new ProductDAO(connection);
            Product product = productDao.getProductById(productID);                      
           
            request.setAttribute("product", product);
            request.getRequestDispatcher("/views/product_detail.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
