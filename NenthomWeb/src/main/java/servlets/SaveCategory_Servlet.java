package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.ProductCategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.ConnectionUtil;

@WebServlet("/servlets/SaveCategory_Servlet")
public class SaveCategory_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SaveCategory_Servlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = ConnectionUtil.DB()) {
            // Lấy thông tin từ request
            String[] categoryIds = request.getParameterValues("categoryIDs[]");
            int productId = Integer.parseInt(request.getParameter("productID"));

            // Tạo đối tượng DAO để xử lý liên kết danh mục
            ProductCategoryDAO productCategoryDAO = new ProductCategoryDAO(connection);

            // Kiểm tra xem các danh mục đã liên kết hay chưa, nếu chưa thì thực hiện liên kết
            for (String categoryIdStr : categoryIds) {
                int categoryId = Integer.parseInt(categoryIdStr);
                // Kiểm tra nếu danh mục chưa liên kết
                if (!productCategoryDAO.isCategoryLinked(productId, categoryId)) {
                    // Thực hiện liên kết danh mục
                    productCategoryDAO.linkCategoryToProduct(productId, categoryId);
                }
            }

            // Chuyển hướng về trang admin sau khi lưu
            response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=success&action=product");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi lưu danh mục.");
        }
    }
}