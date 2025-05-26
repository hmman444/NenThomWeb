package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import services.ConnectionUtil;
import utils.AccessControlUtil;
import utils.CSRFUtil;
@WebServlet("/servlets/DSOrder_Servlet")
public class DSOrder_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DSOrder_Servlet() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ✅ Kiểm tra quyền truy cập manager
        if (!AccessControlUtil.requireManager(request, response)) return;

        try (Connection connection = ConnectionUtil.DB()) {
            OrderDAO orderDao = new OrderDAO(connection);
            List<Order> orders = orderDao.getAllOrders();

            request.setAttribute("orders", orders);
            CSRFUtil.attachToken(request);
            request.getRequestDispatcher("/views/admin.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
