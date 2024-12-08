<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Danh sách bạn bè</title>
<style>
    /* Định dạng toàn bộ trang */
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        color: #333;
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    }

    h1 {
        text-align: center;
        color: #007BFF;
    }

    /* Định dạng nút thêm bạn bè */
    .add-button {
        display: flex;
        justify-content: flex-end;
        margin-bottom: 20px;
    }

    .add-button button {
        padding: 10px 20px;
        background-color: #28a745;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
    }

    .add-button button:hover {
        background-color: #218838;
    }

    /* Định dạng bảng */
    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
    }

    th, td {
        padding: 12px;
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #007BFF;
        color: #fff;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }
</style>
</head>
<body>
    <h1>Danh Sách Bạn Bè</h1>

    <!-- Nút Thêm bạn bè ở góc trên bên phải -->
    <div class="add-button">
        <form action="${pageContext.request.contextPath}/add.jsp" method="post">
            <button type="submit">➕ Thêm bạn bè</button>
        </form>
    </div>

    <!-- Bảng hiển thị danh sách bạn bè -->
    <table>
        <thead>
            <tr>
                <th>STT</th>
                <th>Tên</th>
                <th>Email</th>
                <th>Số điện thoại</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="friend" items="${friends}" varStatus="status">
                <tr>
                    <td>${status.index + 1}</td>
                    <td>${friend.name}</td>
                    <td>${friend.email}</td>
                    <td>${friend.numberphone}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
