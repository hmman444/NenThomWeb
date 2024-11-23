<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Liên Hệ và Chính Sách</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background: #f3f4f6;
            color: #333;
            margin: 0;
            padding: 20px;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            overflow-y: auto;
        }

        .container {
            max-width: 1200px;
            width: 100%;
            display: flex;
            flex-direction: column;
            gap: 20px;
            background: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            padding: 20px;
        }

        /* Phần trên: Chia làm 2 phần */
        .top-section {
            display: flex;
            gap: 20px;
        }

        .contact {
            flex: 1;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 10px;
        }

        .policy {
            flex: 2;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 10px;
        }

        .contact h2, .policy h2 {
            color: #1e90ff;
            margin-bottom: 15px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 5px;
        }

        .contact-info .info-text {
            font-size: 14px;
            color: #555;
            margin-bottom: 10px;
        }

        .contact-info .info-text span {
            font-weight: bold;
            color: #333;
        }

        .policy p {
            font-size: 14px;
            line-height: 1.8;
            color: #555;
        }

        .policy p strong {
            color: #333;
        }

        /* Phần dưới: Gửi yêu cầu support */
        .support-form {
            padding: 20px;
            background: #f9f9f9;
            border-radius: 10px;
        }

        .support-form h2 {
            color: #1e90ff;
            margin-bottom: 15px;
            border-bottom: 2px solid #ddd;
            padding-bottom: 5px;
        }

        .support-form form {
            display: grid;
            gap: 15px;
        }

        .support-form form label {
            font-size: 14px;
            margin-bottom: 5px;
            color: #555;
        }

        .support-form form input,
        .support-form form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }

        .support-form form textarea {
            resize: vertical;
            min-height: 100px;
        }

        .support-form .submit-btn {
            text-align: center;
        }

        .support-form .submit-btn button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background-color: #1e90ff;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .support-form .submit-btn button:hover {
            background-color: #187bcd;
        }

        .form-error {
            color: red;
            font-size: 14px;
            text-align: left;
            display: none; /* Ẩn mặc định */
        }

        .success-message {
            color: green;
            font-size: 16px;
            text-align: center;
            display: none; /* Ẩn mặc định */
        }
    </style>
    <script>
        function validateAndSubmitForm(event) {
            event.preventDefault(); // Ngăn trình duyệt reload trang

            // Lấy giá trị các trường nhập liệu
            const name = document.getElementById('name').value.trim();
            const email = document.getElementById('email').value.trim();
            const subject = document.getElementById('subject').value.trim();
            const message = document.getElementById('message').value.trim();

            // Lấy các phần tử thông báo lỗi và thành công
            const errorMessage = document.querySelector('.form-error');
            const successMessage = document.querySelector('.success-message');

            // Ẩn tất cả các thông báo
            errorMessage.style.display = 'none';
            successMessage.style.display = 'none';

            // Kiểm tra ràng buộc
            if (!name || !email || !subject || !message) {
                errorMessage.style.display = 'block';
                errorMessage.innerText = 'Vui lòng điền đầy đủ thông tin vào các trường bắt buộc.';
                return;
            }

            if (!isValidEmail(email)) {
                errorMessage.style.display = 'block';
                errorMessage.innerText = 'Email không đúng định dạng.';
                return;
            }

            // Nếu hợp lệ, hiển thị thông báo thành công
            successMessage.style.display = 'block';
            successMessage.innerText = 'Gửi yêu cầu thành công!';
        }

        function isValidEmail(email) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            return emailRegex.test(email);
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- Phần trên -->
        <div class="top-section">
            <!-- Thông tin liên hệ -->
            <div class="contact">
                <h2>Thông Tin Liên Hệ</h2>
                <div class="contact-info">
                    <div class="info-text">
                        <span>Số điện thoại:</span> 0123 456 789
                    </div>
                    <div class="info-text">
                        <span>Email:</span> support@example.com
                    </div>
                    <div class="info-text">
                        <span>Địa chỉ:</span> 123 Đường ABC, TP. Hồ Chí Minh
                    </div>
                    <div class="info-text">
                        <span>Website:</span> www.example.com
                    </div>
                </div>
            </div>

            <!-- Chính sách và điều khoản -->
            <div class="policy">
                <h2>Chính Sách và Điều Khoản</h2>
                <p>
                    <strong>Chính sách bảo mật:</strong> Chúng tôi cam kết bảo mật thông tin cá nhân của bạn.
                </p>
                <p>
                    <strong>Điều khoản sử dụng:</strong> Bằng việc truy cập và sử dụng website, bạn đồng ý tuân thủ các điều khoản.
                </p>
            </div>
        </div>

        <!-- Phần dưới -->
        <div class="support-form">
            <h2>Gửi Yêu Cầu Hỗ Trợ</h2>
            <form onsubmit="validateAndSubmitForm(event)">
                <div>
                    <label for="name">Tên *</label>
                    <input type="text" id="name" placeholder="Nhập tên của bạn">
                </div>
                <div>
                    <label for="email">Email *</label>
                    <input type="email" id="email" placeholder="example@example.com">
                </div>
                <div>
                    <label for="subject">Chủ đề *</label>
                    <input type="text" id="subject" placeholder="Nhập chủ đề">
                </div>
                <div>
                    <label for="message">Nội dung *</label>
                    <textarea id="message" placeholder="Nhập nội dung câu hỏi"></textarea>
                </div>
                <div class="form-error"></div>
                <div class="submit-btn">
                    <button type="submit">Gửi</button>
                </div>
                <div class="success-message"></div>
            </form>
        </div>
    </div>
</body>
</html>
