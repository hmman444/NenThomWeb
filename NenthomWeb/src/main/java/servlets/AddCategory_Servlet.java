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

@WebServlet("/servlets/AddCategory_Servlet")
public class AddCategory_Servlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(AddCategory_Servlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!CSRFUtil.isValid(request)) {
            request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
            return;
        }

        try {
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
                description = ""; // Có thể cho phép mô tả trống
            }

            // Validate ký tự hợp lệ để tránh XSS hoặc ký tự đặc biệt
            if (!name.matches("[a-zA-Z0-9 \\-]{1,50}")) {
                throw new IllegalArgumentException("Tên danh mục không hợp lệ. Chỉ dùng chữ, số, khoảng trắng và dấu gạch ngang.");
            }
            if (!description.matches("[a-zA-Z0-9 ,.\\-]{0,1000}")) {
                throw new IllegalArgumentException("Mô tả không hợp lệ. Chỉ dùng ký tự chữ, số, dấu phẩy, chấm, khoảng trắng.");
            }

            Categorie newCategory = new Categorie(0, name, description);

            try (Connection connection = ConnectionUtil.DB()) {
                CategorieDAO categorieDAO = new CategorieDAO(connection);
                boolean isAdded = categorieDAO.addCategory(newCategory);

                if (isAdded) {
                    logger.info("Thêm danh mục thành công: " + name);
                    response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=category");
                } else {
                    logger.warning("Không thể thêm danh mục: " + name);
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể thêm danh mục.");
                }
            }

        } catch (IllegalArgumentException e) {
            logger.warning("Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/views/xss_error.jsp").forward(request, response);

        } catch (Exception e) {
            logger.severe("Lỗi khi thêm danh mục: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }
}
