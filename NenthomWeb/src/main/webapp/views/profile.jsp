<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <style>
        /* Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Toàn bộ trang */
        body {
            font-family: 'Arial', sans-serif;
            background: #f3f4f6;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            width: 100%;
            display: flex;
            gap: 20px;
        }

        /* Phần thông tin người dùng */
        .user-info {
            width: 30%;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
        }

        .user-info img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            margin-bottom: 15px;
        }

        .user-info h2 {
            font-size: 20px;
            color: #1e90ff;
            margin-bottom: 10px;
        }

        .user-info form {
            text-align: left;
        }

        .user-info form label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }

        .user-info form input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            margin-bottom: 15px;
            background: #f9f9f9;
            pointer-events: none; /* Mặc định không thể chỉnh sửa */
        }

        .user-info button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #1e90ff;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .user-info button:hover {
            background-color: #187bcd;
        }

        /* Phần bên phải */
        .main-content {
            width: 70%;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* Đơn hàng */
        .order-list {
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .order-list h2 {
            font-size: 18px;
            margin-bottom: 15px;
            color: #1e90ff;
        }

        .order-list table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-list th, .order-list td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }

        .order-list th {
            background: #f9f9f9;
        }

        .order-list tr:nth-child(even) {
            background: #f5f5f5;
        }

        /* Nến thơm yêu thích */
        .favorites {
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        .favorites h2 {
            font-size: 18px;
            margin-bottom: 15px;
            color: #1e90ff;
        }

        .favorites-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
        }

        .favorite-item {
            background: #f9f9f9;
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
            padding: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .favorite-item img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .favorite-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
        }

        .favorite-item h3 {
            margin-top: 10px;
            font-size: 16px;
            color: #333;
        }
    </style>
    <script>
        function enableEditMode() {
            const inputs = document.querySelectorAll('.user-info form input');
            inputs.forEach(input => input.removeAttribute('disabled')); // Bật chế độ chỉnh sửa
            document.getElementById('updateButton').style.display = 'none';
            document.getElementById('saveButton').style.display = 'block';
        }

        function saveUserInfo() {
            const inputs = document.querySelectorAll('.user-info form input');
            inputs.forEach(input => input.setAttribute('disabled', true)); // Vô hiệu hóa chỉnh sửa
            document.getElementById('updateButton').style.display = 'block';
            document.getElementById('saveButton').style.display = 'none';

            alert('Thông tin đã được cập nhật!');
        }
    </script>
</head>
<body>
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
                        <img src="https://vdff.com.vn/UserUpload/Editor/tinhdauchonenthom%20(1).png" alt="Nến thơm 1">
                        <h3>Nến Thơm Hoa Hồng</h3>
                    </div>
                    <div class="favorite-item">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSskzAuBmnhYmmd6O_-BHO61J_jv4oII8ZiMQ&s" alt="Nến thơm 2">
                        <h3>Nến Thơm Oải Hương</h3>
                    </div>
                    <div class="favorite-item">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTTZ_wcscgPQhf4TIMa67hOy8B3Nj_h6KB3Bw&s" alt="Nến thơm 3">
                        <h3>Nến Thơm Sả Chanh</h3>
                    </div>
                </div>
            </section>
        </div>
    </div>
</body>
</html>
