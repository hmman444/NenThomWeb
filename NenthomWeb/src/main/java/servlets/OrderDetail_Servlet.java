package servlets;

import java.io.IOException;
import utils.CSRFUtil;
import java.sql.Connection;
import java.sql.SQLException;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import services.ConnectionUtil;
@WebServlet("/servlets/OrderDetail_Servlet")
public class OrderDetail_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String VIEW_ORDER_DETAIL_PAGE = "/admin.jsp";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderID = Integer.parseInt(request.getParameter("orderID"));
        try (Connection connection = ConnectionUtil.DB()) {
        	OrderDAO orderDAO = new OrderDAO(connection);
            Order order = orderDAO.getOrderById(orderID);
            //List<OrderDetail> orderItems = orderDAO.getOrderDetails(orderID);

            if (order != null) {
                request.setAttribute("order", order);
                request.setAttribute("orderItems", order.getOrderItems());
            }
            CSRFUtil.attachToken(request);
            request.getRequestDispatcher(VIEW_ORDER_DETAIL_PAGE).forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch order details");
        }
    }
}