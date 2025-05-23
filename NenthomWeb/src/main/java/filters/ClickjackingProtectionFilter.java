package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*") // Áp dụng cho tất cả các request
public class ClickjackingProtectionFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse httpResp = (HttpServletResponse) response;

        // Thêm header ngăn chặn Clickjacking
        httpResp.setHeader("X-Frame-Options", "DENY");

        // Nếu bạn dùng CSP thay thế:
        // httpResp.setHeader("Content-Security-Policy", "frame-ancestors 'none'");

        chain.doFilter(request, response);
    }
}
