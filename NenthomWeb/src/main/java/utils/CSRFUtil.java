package utils;

import jakarta.servlet.http.HttpServletRequest;
import java.security.SecureRandom;
import java.util.Base64;

public class CSRFUtil {

    public static String generateToken() {
        SecureRandom random = new SecureRandom();
        byte[] token = new byte[32];
        random.nextBytes(token);
        return Base64.getUrlEncoder().encodeToString(token);
    }

    public static void attachToken(HttpServletRequest request) {
        String token = generateToken();
        request.getSession().setAttribute("csrfToken", token);
        request.setAttribute("csrfToken", token);
    }

    public static boolean isValid(HttpServletRequest request) {
        String sessionToken = (String) request.getSession().getAttribute("csrfToken");
        String requestToken = request.getParameter("csrfToken");
        return sessionToken != null && sessionToken.equals(requestToken);
    }
}
