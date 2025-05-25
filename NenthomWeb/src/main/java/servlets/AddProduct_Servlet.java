package servlets;
import java.util.logging.Logger;

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

import org.owasp.esapi.ESAPI;
@WebServlet("/servlets/AddProduct_Servlet")
public class AddProduct_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(AddProduct_Servlet.class.getName());
    public AddProduct_Servlet() {
        super();
    }

    // Phương thức xử lý yêu cầu POST khi form được gửi đi
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
        response.setHeader("Content-Security-Policy", "default-src 'self'; script-src 'self'");

        String name = request.getParameter("name");
        if (name != null) {
                    name = name.trim();
                    if (name.length() > 100) {
                        name = name.substring(0, 100);
                    }
                }
        if (!name.matches("[a-zA-Z0-9 ]{1,50}")) {
            throw new IllegalArgumentException("Tên không hợp lệ");
        }

        double price = Double.parseDouble(request.getParameter("price"));

        String description = request.getParameter("description");
        if (description != null) {
                    description = description.trim();
                    if (description.length() > 1000) {
                        description = description.substring(0, 1000);
                    }
                }
        if (!description.matches("[a-zA-Z0-9 ]{1,500}")) {
            throw new IllegalArgumentException("Mô tả không hợp lệ");
        }

        int stock = Integer.parseInt(request.getParameter("stock"));
        String imageBase64 = request.getParameter("imageBase64");

        Product product = new Product(0, name, description, price, stock, imageBase64);

        logger.info("Bắt đầu thêm sản phẩm: " + name + ", giá: " + price + ", tồn kho: " + stock);

        try (Connection connection = ConnectionUtil.DB()) {
            ProductDAO productDAO = new ProductDAO(connection);
            productDAO.addProduct(product);
            
            logger.info("Thêm sản phẩm thành công: " + name);

            response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=product");

        } catch (Exception e) {
            logger.severe("Lỗi khi thêm sản phẩm: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }

}
