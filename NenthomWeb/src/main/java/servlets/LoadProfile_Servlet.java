package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import constant.SystemConstant;
import dao.OrderDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Order;
import models.User;
import services.ConnectionUtil;

@WebServlet("/servlets/LoadProfile_Servlet")
public class LoadProfile_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoadProfile_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = ConnectionUtil.DB()) {
            int userId = SystemConstant.USERID;

            UserDAO userDAO = new UserDAO(connection);
            User user = userDAO.getUserById(userId);
            
            OrderDAO orderDAO = new OrderDAO(connection);
            List<Order> orders = orderDAO.getOrdersByUserId(userId);
            
            request.setAttribute("user", user);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
