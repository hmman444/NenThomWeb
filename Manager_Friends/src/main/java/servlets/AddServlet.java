package servlets;

import java.io.IOException;
import dao.FriendDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/AddServlet")
public class AddServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddServlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        FriendDAO dao = new FriendDAO();
        dao.addFriend(name, email, phone);

        // Chuyển hướng về DanhSachBBServlet để load lại danh sách bạn bè
        response.sendRedirect(request.getContextPath() + "/list");
    }
}
