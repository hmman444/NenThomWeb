<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Thêm bạn bè mới</title>
<style>
    /* Định dạng toàn bộ trang */
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        color: #333;
        max-width: 500px;
        margin: 20px auto;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    }

    h1 {
        text-align: center;
        color: #007BFF;
    }

    form {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    label {
        font-weight: bold;
    }

    input[type="text"],
    input[type="email"] {
        padding: 10px;
        border-radius: 5px;
        border: 1px solid #ccc;
        width: 100%;
    }

    button {
        padding: 10px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
    }

    button:hover {
        background-color: #218838;
    }

    .back-link {
        text-align: center;
        margin-top: 20px;
    }

    .back-link a {
        text-decoration: none;
        color: #007BFF;
        font-weight: bold;
    }

    .back-link a:hover {
        color: #0056b3;
    }
</style>
</head>
<body>
    <h1>Thêm Bạn Bè Mới</h1>

    <form action="${pageContext.request.contextPath}/AddServlet" method="post">
        <label for="name">Tên:</label>
        <input type="text" id="name" name="name" placeholder="Nhập tên bạn bè" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" placeholder="Nhập email" required>

        <label for="phone">Số điện thoại:</label>
        <input type="text" id="phone" name="phone" placeholder="Nhập số điện thoại" required>

        <button type="submit">Thêm bạn bè</button>
    </form>

    <div class="back-link">
        <a href="${pageContext.request.contextPath}/list">Quay lại danh sách</a>
    </div>
</body>
</html>
