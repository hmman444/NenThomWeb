<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Profile - Scented Bliss</title>
    <link rel="stylesheet" href="../css/styles_header_footer.css">
    <link rel="stylesheet" href="../css/styles_profile.css">
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
                        <div class="info-item">
                            <label for="username">Full Name</label>
                            <p id="username">Huỳnh Minh Mẫn</p>
                        </div>
                        <div class="info-item">
                            <label for="email">Email</label>
                            <p id="email">nsndman0404@gmail.com</p>
                        </div>
                        <div class="info-item">
                            <label for="phone">Phone Number</label>
                            <p id="phone">+84 377179132</p>
                        </div>
                        <div class="info-item">
                            <label for="address">Shipping Address</label>
                            <p id="address">Thiên hà số 67, hành tinh 48</p>
                        </div>
                    </div>
                </div>

                <!-- Right Section: Order Management and Favorite Candles -->
                <div class="profile-right">
                    <!-- Upper Section: Orders Management -->
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
                                <tr>
                                    <td>#1</td>
                                    <td>2024-11-25</td>
                                    <td>Delivered</td>
                                    <td>$50.00</td>
                                </tr>
                                <tr>
                                    <td>#2</td>
                                    <td>2024-11-20</td>
                                    <td>Processing</td>
                                    <td>$35.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Lower Section: Favorite Candles -->
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

</body>
</html>
