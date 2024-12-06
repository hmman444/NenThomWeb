<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="constant.SystemConstant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - Scented Bliss</title>
    <link rel="stylesheet" href="../css/styles_header_footer.css">
    <link rel="stylesheet" href="../css/styles_profile.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.11.2/toastify.min.css" rel="stylesheet">
</head>
<body class="bg-faf7f2">
    
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Profile Section -->
    <main class="profile-section">
        <div class="container">
            <div class="profile-content">
                <!-- Left Section: User Information -->
                <div class="profile-left">
                    <h2>User Information</h2>
                    <!-- Avatar Section -->
                    <div class="user-avatar">
                        <img src="https://png.pngtree.com/thumb_back/fh260/background/20230615/pngtree-an-image-of-a-capybara-image_2881516.jpg" alt="User Avatar" class="avatar-img">
                    </div>
                    <div class="user-info">
                        <form action="/NenthomWeb/servlets/UpdateProfile_Servlet" method="post">
                            <div class="info-item">
                                <label for="username">ID User</label>
                                <input type="hidden" id="userId" name="userId" value="${user.userId}">
                                <input type="text" id="username" value="${user.userId}" disabled>
                            </div>
                            <div class="info-item">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="${user.email}">
                            </div>
                            <div class="info-item">
                                <label for="phone">Phone Number</label>
                                <input type="text" id="phone" name="phoneNumber" value="${user.phoneNumber}">
                            </div>
                            <div class="info-item">
                                <label for="address">Shipping Address</label>
                                <input type="text" id="address" name="address" value="${user.address}">
                            </div>

                            <!-- Nút submit -->
                            <div class="info-item">
                                <button class="update-btn" type="submit">Save Information</button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Right Section: Order Management and Favorite Candles -->
                <div class="profile-right">
                    <div class="order-management">
                        <h3>Order Management</h3>
                        <table class="order-table">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Date</th>
                                    <th>Status</th>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>#${order.orderID}</td>
                                        <td>${order.createdAt}</td>
                                        <td>${order.orderStatus}</td>
                                        <td>${order.totalPrice}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="favorite-candles">
                        <h3>Favorite Candles</h3>
                        <div class="candle-list">
                            <!-- Các sản phẩm nến yêu thích -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.11.2/toastify.min.js"></script>
    <script>
        // Kiểm tra nếu có thông báo thành công từ servlet
        const successMessage = '<%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : "" %>';

        if (successMessage) {
            // Hiển thị thông báo Toast
            Toastify({
                text: successMessage,
                duration: 3000, // 3 seconds
                gravity: "top", // Top of the screen
                position: "right", // Right side of the screen
                backgroundColor: "green", // Green color for success
            }).showToast();
        }
    </script>
</body>
</html>
