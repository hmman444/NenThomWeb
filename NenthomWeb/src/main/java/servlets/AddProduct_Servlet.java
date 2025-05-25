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
import utils.CSRFUtil;

@WebServlet("/servlets/AddProduct_Servlet")
public class AddProduct_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddProduct_Servlet() {
        super();
    }

    // Phương thức xử lý yêu cầu POST khi form được gửi đi
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	if (!CSRFUtil.isValid(request)) {
            request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
            return;
        }
        String name = request.getParameter("name");
        double price = Double.parseDouble(request.getParameter("price"));
        String description = request.getParameter("description");
        int stock = Integer.parseInt(request.getParameter("stock"));
        String imageBase64 = request.getParameter("imageBase64");
        if (name != null) {
        	name = name.trim();
            if (name.length() > 100) {
            	name = name.substring(0, 100);
            }
        }
        if (description != null) {
        	description = description.trim();
            if (description.length() > 1000) {
            	description = description.substring(0, 1000);
            }
        }
        Product product = new Product(0, name, description, price, stock, imageBase64);
        
        try (Connection connection = ConnectionUtil.DB()) {
            ProductDAO productDAO = new ProductDAO(connection);
            productDAO.addProduct(product);
            response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=product");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }
}
