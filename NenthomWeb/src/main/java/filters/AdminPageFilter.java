package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/views/admin.jsp")
public class AdminPageFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String role = (session != null) ? (String) session.getAttribute("role") : null;

        // Nếu không phải manager → cấm truy cập
        if (!"manager".equals(role)) {
            response.sendRedirect(request.getContextPath() + "/views/unauthorized.jsp");
            return;
        }

        // Nếu đúng là manager → đây không phải flow chính, ta không cho vào admin.jsp luôn
        // Có thể redirect ngược về servlet hoặc trang chính của manager
        response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin");
    }
}
