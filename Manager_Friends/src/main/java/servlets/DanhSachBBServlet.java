package servlets;

import java.io.IOException;
import java.util.List;

import dao.FriendDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Friend;

@WebServlet("/list")
public class DanhSachBBServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FriendDAO dao = new FriendDAO();
        List<Friend> friends = dao.getAllFriends();
        request.setAttribute("friends", friends);
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
