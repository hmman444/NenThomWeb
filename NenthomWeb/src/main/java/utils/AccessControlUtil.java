package utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class AccessControlUtil {

    // Chỉ cho phép người có role = "manager"
    public static boolean requireManager(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (!"manager".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/views/unauthorized.jsp");
            return false;
        }

        return true;
    }

    // Dùng cho các servlet có tham số page=admin
    public static boolean checkManagerAccess(HttpServletRequest request, HttpServletResponse response, String requiredPage) throws IOException {
        HttpSession session = request.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;
        String page = request.getParameter("page");

        if (requiredPage.equals(page) && !"manager".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/views/unauthorized.jsp");
            return false;
        }
        return true;
    }
}
