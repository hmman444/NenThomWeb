package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.util.List;

import dao.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Discount;
import services.ConnectionUtil;


@WebServlet("/servlets/DeleteDiscount_Servlet")
public class DeleteDiscount_Servlet extends HttpServlet {
    private DiscountDAO discountDAO = new DiscountDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int discountID = Integer.parseInt(request.getParameter("discountID"));

        if (discountDAO.deleteDiscount(discountID)) {
            response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=success&action=discount");
        } else {
            response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=error");
        }
    }
}