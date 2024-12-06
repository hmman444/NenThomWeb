package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import dao.CategorieDAO;
import dao.DiscountDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Categorie;
import models.Discount;
import models.Product;
import services.ConnectionUtil;

@WebServlet("/servlets/SaveCategory_Servlet")
public class SaveCategory_Servlet extends HttpServlet {

    private CategorieDAO categorieDAO;
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        // Khởi tạo các DAO, truyền Connection vào
        Connection connection = (Connection) getServletContext().getAttribute("DBConnection");
        this.categorieDAO = new CategorieDAO(connection);
        this.productDAO = new ProductDAO(connection);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy thông tin từ form
        String productID = request.getParameter("productID");
        String[] selectedCategoryIDs = request.getParameterValues("categoryIDs[]");

        if (productID != null && selectedCategoryIDs != null) {
            try {
                // Lấy sản phẩm theo productID
                int productIDInt = Integer.parseInt(productID);
                Product product = productDAO.getProductById(productIDInt);

                if (product != null) {
                    // Cập nhật mối quan hệ giữa sản phẩm và các danh mục
                    for (String categoryID : selectedCategoryIDs) {
                        int categoryIDInt = Integer.parseInt(categoryID);
                        Categorie category = categorieDAO.getCategoryByID(categoryIDInt);

                        if (category != null) {
                            // Thêm vào bảng ProductCategories (nếu chưa có mối quan hệ)
                            //productDAO.assignCategoryToProduct(productIDInt, categoryIDInt);
                        }
                    }
                    // Chuyển hướng về trang quản lý sản phẩm sau khi lưu
                    response.sendRedirect("/NenthomWeb/admin/products");
                } else {
                    // Nếu sản phẩm không tồn tại
                    response.getWriter().write("Product not found.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().write("Error while saving categories.");
            }
        } else {
            // Trường hợp không có dữ liệu hợp lệ
            response.getWriter().write("Invalid input data.");
        }
    }
}