package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.logging.Logger;

import dao.CategorieDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Categorie;
import services.ConnectionUtil;
import utils.CSRFUtil;
import utils.XSSUtil;

@WebServlet("/servlets/EditCategory_Servlet")
public class EditCategory_Servlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(EditCategory_Servlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!CSRFUtil.isValid(request)) {
            request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
            return;
        }

        try {
            int categoryId = Integer.parseInt(request.getParameter("categoryID"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            if (name != null) {
                name = name.trim();
                if (name.length() > 50) {
                    name = name.substring(0, 50);
                }
            } else {
                throw new IllegalArgumentException("Tên danh mục không được để trống.");
            }

            if (description != null) {
                description = description.trim();
                if (description.length() > 1000) {
                    description = description.substring(0, 1000);
                }
            } else {
                description = "";
            }

            // Kiểm tra ký tự hợp lệ
            if (!name.matches("[a-zA-Z0-9 \\-]{1,50}")) {
                throw new IllegalArgumentException("Tên danh mục không hợp lệ. Chỉ được dùng chữ, số, khoảng trắng và dấu gạch ngang.");
            }
            if (!description.matches("[a-zA-Z0-9 ,.\\-]{0,1000}")) {
                throw new IllegalArgumentException("Mô tả không hợp lệ. Chỉ được dùng ký tự chữ, số, dấu phẩy, chấm, khoảng trắng.");
            }

            // Kiểm tra từ khóa JavaScript nguy hiểm
            if (XSSUtil.containsBannedKeyword(name) || XSSUtil.containsBannedKeyword(description)) {
                throw new IllegalArgumentException("Dữ liệu không được chứa từ khóa JavaScript nguy hiểm.");
            }

            Categorie updatedCategory = new Categorie(categoryId, name, description);

            try (Connection connection = ConnectionUtil.DB()) {
                CategorieDAO categorieDAO = new CategorieDAO(connection);
                boolean isUpdated = categorieDAO.updateCategory(updatedCategory);

                if (isUpdated) {
                    response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=category");
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể cập nhật danh mục.");
                }
            }
        } catch (IllegalArgumentException e) {
            logger.warning("Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/views/xss_error.jsp").forward(request, response);

        } catch (Exception e) {
            logger.severe("Lỗi khi cập nhật danh mục: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }
}
