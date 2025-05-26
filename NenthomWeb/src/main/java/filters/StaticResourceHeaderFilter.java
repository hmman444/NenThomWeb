package filters;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter(urlPatterns = {"*.css", "*.js"})
public class StaticResourceHeaderFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletResponse httpResp = (HttpServletResponse) response;

        // Thêm header bảo mật cho file CSS/JS
        httpResp.setHeader("X-Content-Type-Options", "nosniff");

        chain.doFilter(request, response);
    }
}
