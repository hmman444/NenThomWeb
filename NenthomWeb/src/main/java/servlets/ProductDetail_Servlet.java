package servlets;

import java.io.IOException;
import java.sql.Connection;
import org.owasp.encoder.Encode;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ConnectionUtil;
import utils.CSRFUtil;
@WebServlet("/servlets/ProductDetail_Servlet")
public class ProductDetail_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ProductDetail_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    String productIDStr = request.getParameter("productID");
    int productID = 0;
    try {
        if (productIDStr == null || productIDStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Thiếu mã sản phẩm (productID).");
        }
        productID = Integer.parseInt(productIDStr);
        if (productID <= 0) {
            throw new IllegalArgumentException("Mã sản phẩm phải là số nguyên dương hợp lệ.");
        }
    } catch (NumberFormatException e) {
        request.setAttribute("errorMessage", "Mã sản phẩm không hợp lệ, phải là số nguyên.");
        request.getRequestDispatcher("/views/xss_error.jsp").forward(request, response);
        return;
    } catch (IllegalArgumentException e) {
        request.setAttribute("errorMessage", e.getMessage());
        request.getRequestDispatcher("/views/xss_error.jsp").forward(request, response);
        return;
    }

    try (Connection connection = ConnectionUtil.DB()) {
        ProductDAO productDao = new ProductDAO(connection);
        Product product = productDao.getProductById(productID);
        if (product == null) {
            request.setAttribute("errorMessage", "Không tìm thấy sản phẩm với mã: " + productID);
            request.getRequestDispatcher("/views/xss_error.jsp").forward(request, response);
            return;
        }

        String safeDescription = Encode.forHtml(product.getDescription());
        product.setDescription(safeDescription);

        request.setAttribute("product", product);
        CSRFUtil.attachToken(request);
        request.getRequestDispatcher("/views/product_detail.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("errorMessage", "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        request.getRequestDispatcher("/views/xss_error.jsp").forward(request, response);
    }
}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
