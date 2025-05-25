<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="constant.SystemConstant" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - Scented Bliss</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_profile.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/toastify.min.css'/>">
</head>
<body class="bg-faf7f2">
<%
    String csrfToken = (String) request.getAttribute("csrfToken");
%>

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
                        	<input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
                            <div class="info-item">
                                <label for="username">ID User</label>
                                <input type="hidden" id="userId" name="userId" value="${user.userId}">
                                <input type="text" id="username" value="${user.userId}" disabled>
                            </div>
                            <div class="info-item">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="${user.email}" maxlength="100">
                                
                            </div>
                            <div class="info-item">
                                <label for="phone">Phone Number</label>
                                <input type="text" id="phone" name="phoneNumber" value="${user.phoneNumber}" maxlength = "15">
                                
                            </div>
                            <div class="info-item">
                                <label for="address">Shipping Address</label>
                                <input type="text" id="address" name="address" value="${user.address}" maxlength = "255">                                
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
                            <div class="candle-item">
                                <img src="https://i0.wp.com/areonstore.vn/wp-content/uploads/2023/12/nen-thom-areon-candle-premium-vanilla-black.png?w=600&ssl=1" alt="Candle 1">
                                <b>Nến Thơm Để Phòng Cao Cấp Vanilla Black</b>
                            </div>
                            <div class="candle-item">
                                <img src="https://product.hstatic.net/200000691333/product/candle_8f03c9c6c7d445749e9377a9002fe8a5_master.png" alt="Candle 2">
                                <b>Nến thơm Maitre Parfumeur et Gantier SAPIN ENCHANTEUR</b>
                            </div>
                            <div class="candle-item">
                                <img src="https://i0.wp.com/areonstore.vn/wp-content/uploads/2022/12/areon-home-Candle-black-crystal-2.jpg?w=500&ssl=1" alt="Candle 3">
                                <b>Nến Thơm Để Phòng Hương Pha Lê Đen – Areon Scented Candle Black Crystal</b>
                            </div>
                            <div class="candle-item">
                                <img src="https://down-vn.img.susercontent.com/file/sg-11134201-7rbn1-lof8nj6dcpxb36.webp" alt="Candle 3">
                                <b>Nến thơm handmade sáng tạo Giáng sinh nón thông thủy tinh không khói</b>
                            </div>
                            <div class="candle-item">
                                <img src="https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcThAxScMRO1IMM_8jiC7Ud_9cmljqrguGfoBIynFlaMzsEgHfafbO-5zC72UY4n3misHoP_J_Tsuvo5GbrXVwyqIS-5vfm5llm-OAlnaijl&usqp=CAE" alt="Candle 3">
                                <b>Nến thơm hoa văn cổ điển</b>
                            </div>
                            <div class="candle-item">
                                <img src="https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTQ94xLdb62iPMWlTAZV9ueCkBb7R8XYRBs53XRqET-0OiU_1Q-04KakJivdoynWiz2Igb5iIos6cA-gmw07V5T9upVbm-j_nMJp--NI2NwyVKinEXp6IqT&usqp=CAE" alt="Candle 3">
                                <b>Nến thơm Agaya mùi Hội An</b>
                            </div>
                            <!-- More candle items will follow... -->
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
