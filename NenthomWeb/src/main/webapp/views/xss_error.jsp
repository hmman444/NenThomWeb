<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Lỗi bảo mật - XSS</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/xss_error.css'/>">
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
