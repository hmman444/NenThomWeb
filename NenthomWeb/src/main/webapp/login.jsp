<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login & Register</title>
    <style>
        /* Reset mặc định */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Toàn bộ trang */
        body {
            font-family: 'Arial', sans-serif;
            background: #f0f8ff;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            min-height: 100vh;
            position: relative;
            overflow: hidden;
        }

        /* Nền hình ảnh */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://photo.znews.vn/w660/Uploaded/moguvt/2022_12_25/scented_candle_0.jpg') no-repeat center center fixed; /* Thay bằng URL hình ảnh của bạn */
            background-size: cover;
            opacity: 0.6; /* Độ mờ */
            z-index: -1; /* Đặt phía dưới các phần tử khác */
        }

        /* Header */
        header {
            background: #2c2c2c; /* Graphite */
            color: white;
            padding: 15px 20px;
            text-align: center;
        }
        header h1 {
            font-size: 24px;
            font-weight: bold;
        }
        header nav {
            margin-top: 10px;
        }
        header nav a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
            font-size: 14px;
            font-weight: 500;
        }
        header nav a:hover {
            text-decoration: underline;
        }

        /* Footer */
        footer {
            background: rgba(30, 144, 255, 0.9); /* Nền trong suốt */
            color: white;
            text-align: center;
            padding: 10px 20px;
            font-size: 14px;
        }
        footer a {
            color: white;
            text-decoration: none;
            margin: 0 10px;
        }
        footer a:hover {
            text-decoration: underline;
        }

        /* Container chính */
        .container {
            width: 400px;
            background: rgba(255, 255, 255, 0.9); /* Nền trong suốt */
            border-radius: 10px;
            box-shadow: 0px 10px 20px rgba(0, 0, 0, 0.1);
            padding: 20px 30px;
            margin: 30px auto;
        }
        .container h2 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }

        /* Form */
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-size: 14px;
            color: #555;
            margin-bottom: 5px;
        }
        .form-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        .form-group input:focus {
            border-color: #1e90ff;
            box-shadow: 0px 0px 5px rgba(30, 144, 255, 0.5);
            outline: none;
        }
        .form-group input::placeholder {
            color: #aaa;
        }

        /* Button */
        .button-group {
            text-align: center;
        }
        .button-group button {
            width: 100%;
            padding: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            background-color: #1e90ff;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .button-group button:hover {
            background-color: #187bcd;
        }

        /* Liên kết chuyển đổi */
        .toggle-link {
            text-align: center;
            margin-top: 10px;
            font-size: 14px;
            color: #333;
        }
        .toggle-link span {
            color: #1e90ff;
            cursor: pointer;
            transition: color 0.3s ease;
        }
        .toggle-link span:hover {
            color: #187bcd;
            text-decoration: underline;
        }

        /* Thông báo lỗi */
        .error-message {
            color: red;
            font-size: 14px;
            margin-bottom: 10px;
            text-align: center;
            display: none;
        }
    </style>
    <script>
        function toggleForm(showLogin) {
            const loginForm = document.getElementById('loginForm');
            const registerForm = document.getElementById('registerForm');
            const errorMessage = document.querySelectorAll('.error-message');

            errorMessage.forEach(msg => msg.style.display = 'none'); // Ẩn thông báo lỗi

            if (showLogin) {
                loginForm.style.display = 'block';
                registerForm.style.display = 'none';
            } else {
                loginForm.style.display = 'none';
                registerForm.style.display = 'block';
            }
        }

        function handleLogin() {
            const username = document.getElementById('loginUsername').value.trim();
            const password = document.getElementById('loginPassword').value.trim();
            const errorMessage = document.getElementById('loginError');

            if (!username || !password) {
                errorMessage.style.display = 'block';
                errorMessage.innerText = 'Vui lòng điền đầy đủ tài khoản và mật khẩu!';
                return;
            }

            alert('Đăng nhập thành công!');
        }

        function handleRegister() {
            const username = document.getElementById('registerUsername').value.trim();
            const password = document.getElementById('registerPassword').value.trim();
            const confirmPassword = document.getElementById('registerConfirmPassword').value.trim();
            const errorMessage = document.getElementById('registerError');

            if (!username || !password || !confirmPassword) {
                errorMessage.style.display = 'block';
                errorMessage.innerText = 'Vui lòng điền đầy đủ thông tin!';
                return;
            }
            if (password !== confirmPassword) {
                errorMessage.style.display = 'block';
                errorMessage.innerText = 'Mật khẩu và xác nhận mật khẩu không khớp!';
                return;
            }

            alert('Đăng ký thành công!');
            toggleForm(true);
        }
    </script>
</head>
<body>
    <!-- Header -->
    <header>
        <h1>5 CON CHIM</h1>
        <nav>
            <a href="#">Trang chủ</a>
            <a href="#">Sản phẩm</a>
            <a href="#">Liên hệ</a>
        </nav>
    </header>

    <!-- Container Chính -->
    <div class="container">
        <!-- Form Đăng nhập -->
        <div id="loginForm">
            <h2>Đăng Nhập</h2>
            <div id="loginError" class="error-message"></div>
            <div class="form-group">
                <label for="loginUsername">Tài khoản</label>
                <input type="text" id="loginUsername" placeholder="Nhập tài khoản">
            </div>
            <div class="form-group">
                <label for="loginPassword">Mật khẩu</label>
                <input type="password" id="loginPassword" placeholder="Nhập mật khẩu">
            </div>
            <div class="button-group">
                <button type="button" onclick="handleLogin()">Đăng nhập</button>
            </div>
            <div class="toggle-link">
                Chưa có tài khoản? <span onclick="toggleForm(false)">Đăng ký ngay</span>
            </div>
        </div>

        <!-- Form Đăng ký -->
        <div id="registerForm" style="display: none;">
            <h2>Đăng Ký</h2>
            <div id="registerError" class="error-message"></div>
            <div class="form-group">
                <label for="registerUsername">Tài khoản</label>
                <input type="text" id="registerUsername" placeholder="Nhập tài khoản">
            </div>
            <div class="form-group">
                <label for="registerPassword">Mật khẩu</label>
                <input type="password" id="registerPassword" placeholder="Nhập mật khẩu">
            </div>
            <div class="form-group">
                <label for="registerConfirmPassword">Xác nhận mật khẩu</label>
                <input type="password" id="registerConfirmPassword" placeholder="Xác nhận mật khẩu">
            </div>
            <div class="button-group">
                <button type="button" onclick="handleRegister()">Đăng ký</button>
            </div>
            <div class="toggle-link">
                Đã có tài khoản? <span onclick="toggleForm(true)">Đăng nhập</span>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer>
        © 2024 My Website. All Rights Reserved.
        <br>
        <a href="#">Chính sách bảo mật</a>
        <a href="#">Điều khoản sử dụng</a>
    </footer>
</body>
</html>
