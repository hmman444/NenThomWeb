package servlets;

import dao.CategoryDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Category;
import services.ConnectionUtil;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

@WebServlet("/servlets/DSCatagory_Servlet")
public class DSCatagory_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DSCatagory_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection connection = ConnectionUtil.DB()) {
        	CategoryDAO categoriesDAO = new CategoryDAO(connection);
            List<Category> categories = categoriesDAO.getAllCategories();
            request.setAttribute("categories", categories);

            request.getRequestDispatcher("/views/yourJSP.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }
}
