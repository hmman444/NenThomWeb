package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import dao.TaiKhoanDAO;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import services.ConnectionUtil;
import utils.CSRFUtil;

@WebServlet("/login")
public class Login_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CSRFUtil.attachToken(request); 

        if ("1".equals(request.getParameter("logout"))) {
            request.setAttribute("logoutMessage", "Bạn đã đăng xuất thành công!");
        }

        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!CSRFUtil.isValid(request)) {
            request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
            return;
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String message = "";
        boolean error = false;

        try (Connection conn = ConnectionUtil.DB()) {
            TaiKhoanDAO taiKhoanDao = new TaiKhoanDAO(conn);
            UserDAO userDao = new UserDAO(conn);

            if (!taiKhoanDao.isUsernameExist(username)) {
                message = "Tài khoản không tồn tại!";
                error = true;
            } else {
                String storedPassword = taiKhoanDao.getPasswordByUsername(username);
                if (storedPassword.equals(password)) {
                    String role = taiKhoanDao.getRoleByUsername(username);
                    int userID = userDao.getUserIDByUsername(username);

                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("userID", userID);

                    if ("manager".equals(role)) {
                        request.getRequestDispatcher("/servlets/DSProduct_Servlet?page=admin").forward(request, response);
                    } else {
                        request.getRequestDispatcher("/views/TrangChu.jsp").forward(request, response);
                    }
                    return;
                } else {
                    message = "Mật khẩu không đúng!";
                    error = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Lỗi kết nối cơ sở dữ liệu.";
            error = true;
        }

        if (error) {
            request.setAttribute("message", message);
            request.setAttribute("error", error);
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}
