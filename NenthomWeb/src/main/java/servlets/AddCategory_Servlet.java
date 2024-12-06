package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
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

@WebServlet("/servlets/AddCategory_Servlet")
public class AddCategory_Servlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String name = request.getParameter("name");
        String description = request.getParameter("description");

        Categorie newCategory = new Categorie(0, name, description);
        try (Connection connection = ConnectionUtil.DB()) {
            CategorieDAO categorieDAO = new CategorieDAO(connection);
            boolean isUpdated = categorieDAO.addCategory(newCategory); 

            if (isUpdated) {
                response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=category");
            } else {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Không thể thêm danh mục.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }
}