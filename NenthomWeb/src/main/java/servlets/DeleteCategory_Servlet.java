package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;

import dao.CategorieDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Categorie;
import services.ConnectionUtil;
import utils.CSRFUtil;

@WebServlet("/servlets/DeleteCategory_Servlet")
public class DeleteCategory_Servlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	if (!CSRFUtil.isValid(request)) {
            request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
            return;
        }
    	int categoryId = Integer.parseInt(request.getParameter("categoryID"));
    	try (Connection connection =  ConnectionUtil.DB()) {
    		CategorieDAO categorieDAO = new CategorieDAO(connection);
    		categorieDAO.deleteCategory(categoryId);
            response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=category");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error occurred while deleting category.");
        }
    }
}