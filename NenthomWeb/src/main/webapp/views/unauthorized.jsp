<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>403 - Truy cập bị từ chối | Nến Thơm</title>

    <!-- CSS dùng chung -->
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- CSS riêng cho trang lỗi -->
    <link rel="stylesheet" href="<c:url value='/css/styles_Unauthorized.css'/>">
</head>
<body>

    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Nội dung lỗi -->
    <div class="error-container">
        <div class="error-icon">
            <i class="fas fa-ban"></i>
        </div>
        <h1>403</h1>
        <p>Bạn không có quyền truy cập vào trang này.</p>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>
