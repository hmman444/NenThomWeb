<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <title>Login | Nến Thơm</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_login.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/all.min.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/toastr.min.css'/>">
	<script nonce="<%= nonce %>" src="<c:url value='/js/jquery.min.js'/>"></script>
	<script nonce="<%= nonce %>" src="<c:url value='/js/toastr.min.js'/>"></script>
	<script nonce="<%= nonce %>" src="<c:url value='/js/validateFunction.js'/>"></script>
	<script nonce="<%= nonce %>" src="<c:url value='/js/routeFunction.js'/>"></script>
	<script nonce="<%= nonce %>" src="<c:url value='/js/login.js'/>"></script>
</head>
<body class="bg-light-cream">
    <section class="login-section">
        <div class="container">
            <div class="login-form">
                <h2 id="form-title">Login</h2>

                <%  String logoutMessage = (String) request.getAttribute("logoutMessage");
				    String message = (String) request.getAttribute("message");
				    Boolean error = (Boolean) request.getAttribute("error");
				    if (message != null && error != null) {
					%>
					    <div class="<%= error ? "alert-danger" : "alert-success" %> alert-message">
					        <%= message %>
					    </div>
					<%
				    } 
				    else if (logoutMessage != null)
				    {
				%>
						<div class="alert-success">
							<%= logoutMessage %>
						</div>
                <% } %>

				<%
				    String code = (String) session.getAttribute("authCode");
				%>
				
				<form id="auth-form" action="<c:url value='/login'/>" method="post">
					<input type="hidden" name="csrfToken" value="<%= request.getAttribute("csrfToken") %>"/>
				    <!-- Username -->
				    <div class="form-group">
				        <label for="username">Username</label>
				        <input type="text" id="username" name="username" required>
				        <small id="un-msg"></small>
				    </div>
				
				    <!-- Password -->
				    <div class="form-group">
				        <label for="password">Password</label>
				        <input type="password" id="password" name="password" required>
				        <small id="pw-msg"></small>
				    </div>
				
				    <!-- Mã xác thực -->
				    <div class="form-group">
				        <label>Mã xác thực: <strong><%= code %></strong></label>
				        <input type="text" name="authCodeInput" required placeholder="Nhập mã xác thực">
				    </div>
				
				    <button type="submit" class="login-page-button">Login</button>
				</form>
                <p class="toggle-link">
                    <span id="toggle-text">Don't have an account?</span>
                    <a href="/NenthomWeb/servlets/Register_Servlet">Sign up</a>
                </p>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>
</body>
</html>
