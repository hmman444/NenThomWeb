package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import dao.OrderDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
		HttpSession session = request.getSession();
    	int userID = (int) session.getAttribute("userID");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String address = request.getParameter("address");
     // Xử lý Address: Cắt tối đa 255 ký tự để chống overflow
        if (address != null) {
            address = address.trim();
            if (address.length() > 255) {
                address = address.substring(0, 255);
            }
        }

        // Xử lý Email: Trim, kiểm tra độ dài và định dạng
        if (email != null) {
            email = email.trim();
            if (email.length() > 100) {
                throw new IllegalArgumentException("Email is too long.");
            }
            String emailRegex = "^[\\w.%+-]+@[\\w.-]+\\.[a-zA-Z]{2,}$";
            if (!email.matches(emailRegex)) {
                throw new IllegalArgumentException("Invalid email format.");
            }
        }

        // Xử lý Phone number: Trim, kiểm tra độ dài và ký tự hợp lệ
        if (phoneNumber != null) {
            phoneNumber = phoneNumber.trim();
            if (phoneNumber.length() > 15) {
                throw new IllegalArgumentException("Phone number is too long.");
            }
            String phoneRegex = "^[0-9+\\-()\\s]+$";
            if (!phoneNumber.matches(phoneRegex)) {
                throw new IllegalArgumentException("Invalid phone number.");
            }
        }
        try (Connection connection = ConnectionUtil.DB()) {
        	User user = new User();
            user.setUserId(userID);
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
            
            user = userDAO.getUserById(userID);
            
            OrderDAO orderDAO = new OrderDAO(connection);
            List<Order> orders = orderDAO.getOrdersByUserId(userID);
            
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
