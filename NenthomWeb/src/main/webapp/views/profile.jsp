<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <link rel="stylesheet" href="../css/styles_header_footer.css">  
    <link rel="stylesheet" href="../css/styles_profile.css">      
</head>
<body>
    <!-- Header -->
    <%@ include file="header.jsp" %>
    
    <div class="container">
        <!-- Phần thông tin người dùng -->
        <div class="user-info">
            <img src="https://img.pikbest.com/wp/202345/male-avatar-image-in-the-circle_9588978.jpg!w700wp" alt="User Avatar">
            <h2>Nguyễn Văn A</h2>
            <form>
                <label for="fullName">Họ và tên</label>
                <input type="text" id="fullName" value="Nguyễn Văn A" disabled>
                <label for="email">Email</label>
                <input type="email" id="email" value="nguyenvana@example.com" disabled>
                <label for="phone">Số điện thoại</label>
                <input type="tel" id="phone" value="0123456789" disabled>
                <label for="address">Địa chỉ</label>
                <input type="text" id="address" value="123 Đường ABC, TP. Hồ Chí Minh" disabled>
                <button type="button" id="updateButton" onclick="enableEditMode()">Cập nhật thông tin</button>
                <button type="button" id="saveButton" style="display:none;" onclick="saveUserInfo()">Xác nhận</button>
            </form>
        </div>

        <!-- Phần bên phải -->
        <div class="main-content">
            <!-- Đơn hàng đã đặt -->
            <section class="order-list">
                <h2>Đơn Hàng Đã Đặt</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Mã đơn hàng</th>
                            <th>Ngày đặt</th>
                            <th>Tổng tiền</th>
                            <th>Trạng thái</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>DH001</td>
                            <td>20/11/2024</td>
                            <td>500,000 VND</td>
                            <td>Đã giao</td>
                        </tr>
                        <tr>
                            <td>DH002</td>
                            <td>21/11/2024</td>
                            <td>300,000 VND</td>
                            <td>Đang xử lý</td>
                        </tr>
                    </tbody>
                </table>
            </section>

            <!-- Nến thơm yêu thích -->
            <section class="favorites">
                <h2>Nến Thơm Yêu Thích</h2>
                <div class="favorites-grid">
                    <div class="favorite-item">
                        <img src="https://vdff.com.vn/UserUpload/Editor/tinhdauchonenthom%20(1).png" alt="Nến Thơm 1">
                        <h3>Nến Thơm Cam</h3>
                    </div>
                    <div class="favorite-item">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSskzAuBmnhYmmd6O_-BHO61J_jv4oII8ZiMQ&s" alt="Nến Thơm 2">
                        <h3>Nến Thơm Lavender</h3>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>
