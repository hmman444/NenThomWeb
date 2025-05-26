<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
        <%
    String nonce = (String) request.getAttribute("cspNonce");
    if (nonce == null) {
        nonce = java.util.Base64.getEncoder().encodeToString(new java.security.SecureRandom().generateSeed(16));
        request.setAttribute("cspNonce", nonce);
    }
	%>
	<meta http-equiv="Content-Security-Policy"
	      content="default-src 'self';
	               style-src 'self';
	               script-src 'self' 'nonce-<%= nonce %>';
	               img-src 'self' data:;
	               font-src 'self';
	               form-action 'self';">
    <title>Lỗi bảo mật - CSRF</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/csrf_error.css'/>">
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
