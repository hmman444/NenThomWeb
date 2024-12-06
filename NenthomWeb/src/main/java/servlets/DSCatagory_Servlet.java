package servlets;

import dao.CategorieDAO;
import dao.CategoryDAO;
import dao.DiscountDAO;
import dao.OrderDAO;
import dao.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Categorie;
import models.Category;
import models.Discount;
import models.Order;
import models.Product;
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
    	
    }
}
