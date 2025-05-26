package services;

import java.util.Random;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class AuthCodeUtil {

    public static String generateCode(int length) {
        String chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
        StringBuilder sb = new StringBuilder();
        Random rnd = new Random();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(rnd.nextInt(chars.length())));
        }
        return sb.toString();
    }

    public static void refreshVerificationCode(HttpSession session) {
        session.setAttribute("authCode", generateCode(6));
    }

    public static boolean isVerificationCodeValid(HttpServletRequest request) {
        String userCode = request.getParameter("authCodeInput");
        String sessionCode = (String) request.getSession().getAttribute("authCode");
        return sessionCode != null && userCode != null && sessionCode.equalsIgnoreCase(userCode);
    }
    public static boolean isStrongPassword(String password) {
        if (password == null) return false;

        // Mật khẩu mạnh: ít nhất 8 ký tự, có chữ hoa, chữ thường, số và ký tự đặc biệt
        String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@#$%^&+=!]).{8,}$";
        return password.matches(pattern);
    }
}

