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

@WebServlet("/servlets/UpdateProfile_Servlet")
public class UpdateProfile_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateProfile_Servlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int userId = SystemConstant.USERID;
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
       
        try (Connection connection = ConnectionUtil.DB()) {
        	User user = new User();
            user.setUserId(userId);
            user.setEmail(email);
            user.setPhoneNumber(phoneNumber);
            user.setAddress(address);
            
            UserDAO userDAO = new UserDAO(connection);
            boolean isUpdated = userDAO.updateUser(user);

            if (isUpdated) {
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("successMessage", "Profile update failed.");
            }
            
            userId = SystemConstant.USERID;

            user = userDAO.getUserById(userId);
            
            OrderDAO orderDAO = new OrderDAO(connection);
            List<Order> orders = orderDAO.getOrdersByUserId(userId);
            
            request.setAttribute("user", user);
            request.setAttribute("orders", orders);
            
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("successMessage", "Error updating profile.");
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
        }
    }
}
