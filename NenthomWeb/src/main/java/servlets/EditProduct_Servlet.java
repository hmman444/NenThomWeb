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

@WebServlet("/servlets/EditProduct_Servlet")
public class EditProduct_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public EditProduct_Servlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!CSRFUtil.isValid(request)) {
            request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
            return;
        }

        String name = request.getParameter("productName");
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

        try (Connection connection = ConnectionUtil.DB()) {
            ProductDAO productDAO = new ProductDAO(connection);
            Product existingProduct = productDAO.getProductByName(name);

            System.out.println("Sản phẩm tìm được từ tên: " + name + price + description + stock + imageBase64);
            if (existingProduct != null) {
                System.out.println("ID: " + existingProduct.getProductID());
                System.out.println("Tên: " + existingProduct.getName());
                System.out.println("Mô tả: " + existingProduct.getDescription());
                System.out.println("Giá: " + existingProduct.getPrice());
                System.out.println("Tồn kho: " + existingProduct.getStock());
                System.out.println("Ảnh (base64): " + existingProduct.getImageBase64());
            } else {
                System.out.println("Không tìm thấy sản phẩm.");
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy sản phẩm.");
                return;
            }

            int productID = existingProduct.getProductID();
            Product updatedProduct = new Product(productID, name, description, price, stock, imageBase64);

            boolean isUpdated = productDAO.updateProductById(updatedProduct);

            if (isUpdated) {
                response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=product");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật sản phẩm.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }
}
