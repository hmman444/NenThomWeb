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

@WebServlet("/servlets/UpdateDiscount_Servlet")
public class UpdateDiscount_Servlet extends HttpServlet {
    private DiscountDAO discountDAO = new DiscountDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int discountID = Integer.parseInt(request.getParameter("discountID"));
        String discountName = request.getParameter("discountName");
        String discountType = request.getParameter("discountType");
        double discountValue = Double.parseDouble(request.getParameter("discountValue"));
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));

        Discount discount = new Discount(discountID, discountName, discountType, discountValue, startDate, endDate, true);

        if (discountDAO.updateDiscount(discount)) {
            response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=success&action=discount");
        } else {
            response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=error");
        }
    }
}