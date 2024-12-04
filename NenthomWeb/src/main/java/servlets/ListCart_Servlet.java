package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import constant.SystemConstant;
import dao.CartDAO;
import dao.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Cart;
import models.Discount;
import models.Product;
import services.ConnectionUtil;

@WebServlet("/servlets/ListCart_Servlet")
public class ListCart_Servlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public ListCart_Servlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection connection = ConnectionUtil.DB()) {
            int userId = SystemConstant.USERID;

            // Lấy danh sách các sản phẩm trong giỏ hàng của người dùng
            CartDAO cartDAO = new CartDAO(connection);
            List<Cart> cartList = cartDAO.getCartItems(userId);

            // Tạo danh sách các sản phẩm trong giỏ hàng (bao gồm tên, mô tả, giá, số lượng, hình ảnh)
            List<Product> productList = new ArrayList<>();
            double subtotal = 0.0; // Tổng giá trị của các sản phẩm trong giỏ hàng
            for (Cart cart : cartList) {
                int productID = cart.getProductID();

                // Lấy thông tin sản phẩm từ bảng Products
                String productSql = "SELECT * FROM Products WHERE ProductID = ?";
                try (PreparedStatement stmt = connection.prepareStatement(productSql)) {
                    stmt.setInt(1, productID);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        String name = rs.getString("Name");
                        String description = rs.getString("Description");
                        double price = rs.getDouble("Price");
                        int stock = rs.getInt("Stock");
                        String imageBase64 = rs.getString("ImageBase64");

                        // Tính toán tổng giá trị của sản phẩm trong giỏ hàng
                        double productTotalPrice = price * cart.getQuantity();
                        subtotal += productTotalPrice;

                        // Tạo đối tượng Product và thêm vào danh sách
                        Product product = new Product(productID, name, description, price, stock, imageBase64);
                        productList.add(product);
                    }
                }
            }

            // Tính phí vận chuyển (ví dụ $5.99)
            double shippingCost = 5.99;

            // Tính tổng giá tiền (Subtotal + Shipping)
            double totalAmount = subtotal + shippingCost;

            // Kiểm tra nếu có mã giảm giá (Discount)
            String discountId = request.getParameter("discountId");
            DiscountDAO discountDAO = new DiscountDAO();
            List<Discount> activeDiscounts = discountDAO.getActiveDiscounts();

            Discount selectedDiscount = null;
            if (discountId != null && !discountId.isEmpty()) {
                selectedDiscount = discountDAO.getDiscountById(Integer.parseInt(discountId)); // Lấy ưu đãi theo ID
                // Cập nhật lại tổng tiền nếu có discount
                if (selectedDiscount != null) {
                    if (selectedDiscount.getDiscountType().equals("percentage")) {
                        totalAmount = totalAmount - (totalAmount * selectedDiscount.getDiscountValue() / 100);
                    } else {
                        totalAmount = totalAmount - selectedDiscount.getDiscountValue();
                    }
                }
            }

            // Truyền dữ liệu giỏ hàng, sản phẩm, các thông tin tính toán và ưu đãi vào request
            request.setAttribute("cartList", cartList);
            request.setAttribute("productList", productList);
            request.setAttribute("subtotal", subtotal);
            request.setAttribute("shippingCost", shippingCost);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("activeDiscounts", activeDiscounts);
            request.setAttribute("selectedDiscount", selectedDiscount);

            // Chuyển tiếp đến trang giỏ hàng (cart.jsp)
            request.getRequestDispatcher("/views/cart.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Đã xảy ra lỗi khi kết nối với cơ sở dữ liệu.");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
