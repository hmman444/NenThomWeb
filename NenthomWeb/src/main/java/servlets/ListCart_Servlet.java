package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.util.List;

import constant.SystemConstant;
import dao.CartDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;
import services.ConnectionUtil;

@WebServlet("/ListCart_Servlet")
public class ListCart_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ListCart_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
        try (Connection connection = ConnectionUtil.DB())
        {
        	int userId = SystemConstant.UserID;
        	CartDAO cartDAO = new CartDAO(connection);
            List<Cart> cartList = cartDAO.getCartItems(userId);
            request.setAttribute("cartList", cartList);
            request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
        }
        catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
