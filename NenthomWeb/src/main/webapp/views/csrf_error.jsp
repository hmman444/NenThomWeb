<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lỗi bảo mật - CSRF</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #faf7f2;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .error-container {
            background-color: white;
            border-radius: 16px;
            padding: 40px 60px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
        }

        .error-title {
            font-size: 28px;
            font-weight: bold;
            color: #b53e3e;
            margin-bottom: 20px;
        }

        .error-message {
            font-size: 18px;
            color: #444;
            margin-bottom: 30px;
        }

        .back-button {
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #8b5e3c;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
        }

        .back-button:hover {
            background-color: #734b2f;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1 class="error-title">Lỗi bảo mật</h1>
        <p class="error-message">Yêu cầu bị từ chối do token CSRF không hợp lệ hoặc đã hết hạn.<br>
        Vui lòng thử lại thao tác từ trang chính.</p>
        <a href="/NenthomWeb/login" class="back-button">Quay về trang đăng nhập</a>
    </div>
</body>
</html>
