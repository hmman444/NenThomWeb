<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lỗi bảo mật - XSS</title>
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
        <p class="error-message">
            <c:choose>
                <c:when test="${not empty errorMessage}">
                    ${errorMessage}
                </c:when>
                <c:otherwise>
                    Hệ thống phát hiện nội dung không hợp lệ hoặc có thể chứa mã độc.
                </c:otherwise>
            </c:choose>
        </p>
        <a href="/NenthomWeb/views/admin.jsp" class="back-button">Quay lại trang sản phẩm</a>
    </div>
</body>
</html>
