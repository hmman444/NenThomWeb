package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Product;
import services.ConnectionUtil;


@WebServlet("/servlets/DeleteProduct_Servlet")
public class DeleteProduct_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    public DeleteProduct_Servlet() {
        super();
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String productName = request.getParameter("productName");
        System.out.println("Product to delete: " + productName);
        try (Connection connection =  ConnectionUtil.DB()) {
            ProductDAO productDAO = new ProductDAO(connection);
            productDAO.deleteProductByName(productName);
            response.sendRedirect("/NenthomWeb/servlets/DSProduct_Servlet?page=admin&message=success&action=product");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error occurred while deleting product.");
        }
    }
}
