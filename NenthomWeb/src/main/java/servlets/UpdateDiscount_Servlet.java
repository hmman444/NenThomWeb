package servlets;

import java.io.IOException;
import java.sql.Date;
import java.util.logging.Logger;

import dao.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Discount;
import utils.CSRFUtil;

@WebServlet("/servlets/UpdateDiscount_Servlet")
public class UpdateDiscount_Servlet extends HttpServlet {

    private static final Logger logger = Logger.getLogger(UpdateDiscount_Servlet.class.getName());
    private DiscountDAO discountDAO = new DiscountDAO();

    private static final String[] BANNED_KEYWORDS = {
        "script", "onload", "onclick", "onerror", "onmouseover", "onmouseenter",
        "onmouseleave", "javascript:", "eval(", "document.cookie", "alert("
    };

    private boolean containsBannedKeyword(String input) {
        if (input == null) return false;
        String lower = input.toLowerCase();
        for (String keyword : BANNED_KEYWORDS) {
            if (lower.contains(keyword)) {
                return true;
            }
        }
        return false;
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!CSRFUtil.isValid(request)) {
            request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
            return;
        }

        try {
            int discountID = Integer.parseInt(request.getParameter("discountID"));
            String discountName = request.getParameter("discountName");
            String discountType = request.getParameter("discountType");
            double discountValue = Double.parseDouble(request.getParameter("discountValue"));
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));

            if (discountName != null) {
                discountName = discountName.trim();
                if (discountName.length() > 255) {
                    discountName = discountName.substring(0, 255);
                }
            } else {
                throw new IllegalArgumentException("Tên chương trình giảm giá không được để trống.");
            }

            // Kiểm tra ký tự hợp lệ cho discountName (cho phép chữ, số, khoảng trắng, dấu gạch ngang, dấu chấm, dấu phẩy)
            if (!discountName.matches("[a-zA-Z0-9 \\-.,]{1,255}")) {
                throw new IllegalArgumentException("Tên chương trình giảm giá không hợp lệ.");
            }

            // Kiểm tra từ khóa JS nguy hiểm
            if (containsBannedKeyword(discountName)) {
                throw new IllegalArgumentException("Tên chương trình giảm giá chứa từ khóa JavaScript nguy hiểm.");
            }

            Discount discount = new Discount(discountID, discountName, discountType, discountValue, startDate, endDate, true);

            if (discountDAO.updateDiscount(discount)) {
                response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=success&action=discount");
            } else {
                response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=error");
            }
        } catch (IllegalArgumentException e) {
            logger.warning("Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/views/xss_error.jsp").forward(request, response);
        } catch (Exception e) {
            logger.severe("Lỗi khi cập nhật chương trình giảm giá: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi xử lý dữ liệu.");
        }
    }
}
