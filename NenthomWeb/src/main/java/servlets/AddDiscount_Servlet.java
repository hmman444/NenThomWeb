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

@WebServlet("/servlets/AddDiscount_Servlet")
public class AddDiscount_Servlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(AddDiscount_Servlet.class.getName());
    private DiscountDAO discountDAO = new DiscountDAO();

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!CSRFUtil.isValid(request)) {
            request.getRequestDispatcher("/views/csrf_error.jsp").forward(request, response);
            return;
        }

        try {
            String discountName = request.getParameter("discountName");
            String discountType = request.getParameter("discountType");

            if (discountName != null) {
                discountName = discountName.trim();
                if (discountName.length() > 255) {
                    discountName = discountName.substring(0, 255);
                }
            }

            // Lọc discountName chỉ cho phép chữ cái, số, khoảng trắng và một số ký tự cơ bản
            if (!discountName.matches("[a-zA-Z0-9 \\-_'\\.]{1,255}")) {
                throw new IllegalArgumentException("Tên khuyến mãi không hợp lệ. Vui lòng chỉ dùng chữ, số và ký tự cơ bản (tối đa 50 ký tự).");
            }

            // Kiểm tra discountType nếu cần (ví dụ: "percent" hoặc "fixed")
            if (discountType != null) {
                discountType = discountType.trim();
                if (!discountType.matches("percent|fixed")) {
                    throw new IllegalArgumentException("Loại giảm giá không hợp lệ.");
                }
            }

            double discountValue = Double.parseDouble(request.getParameter("discountValue"));
            Date startDate = Date.valueOf(request.getParameter("startDate"));
            Date endDate = Date.valueOf(request.getParameter("endDate"));

            Discount discount = new Discount(0, discountName, discountType, discountValue, startDate, endDate, true);

            if (discountDAO.addDiscount(discount)) {
                response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=success&action=discount");
            } else {
                response.sendRedirect(request.getContextPath() + "/servlets/DSProduct_Servlet?page=admin&message=error");
            }

        } catch (IllegalArgumentException e) {
            logger.warning("Dữ liệu đầu vào không hợp lệ: " + e.getMessage());
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/views/xss_error.jsp").forward(request, response);

        } catch (Exception e) {
            logger.severe("Lỗi khi thêm khuyến mãi: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Đã xảy ra lỗi khi xử lý yêu cầu.");
        }
    }
}
