<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
    <title>Sign Up | Nến Thơm</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_login.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <!-- Font Awesome -->
	<link rel="stylesheet" href="<c:url value='/css/all.min.css'/>">
	
	<!-- Toastr -->
	<link rel="stylesheet" href="<c:url value='/css/toastr.min.css'/>">
	<script nonce="<%= nonce %>" src="<c:url value='/js/jquery.min.js'/>"></script>
	<script nonce="<%= nonce %>" src="<c:url value='/js/toastr.min.js'/>"></script>
	<script nonce="<%= nonce %>" src="<c:url value='/js/validateFunction.js'/>"></script>
	<script nonce="<%= nonce %>" src="<c:url value='/js/routeFunction.js'/>"></script>
</head>
<body class="bg-light-cream">
<%
    String csrfToken = (String) request.getAttribute("csrfToken");
%>

	<!-- Register Form -->
	<section class="login-section">
		<div class="container">
			<div class="login-form">
				<h2 id="form-title">Sign Up</h2>

				<%
				    String message = (String) request.getAttribute("message");
				    Boolean error = (Boolean) request.getAttribute("error");
				    if (message != null && error != null) {
				%>
				    <div class="<%= error ? "alert-danger" : "alert-success" %> alert-message">
				        <%= message %>
				    </div>
				<%
				    }
				%>


				<%
				    String code = (String) session.getAttribute("authCode");
				%>
				<form id="auth-form" action="../servlets/Register_Servlet" method="post">
					<input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
					<div class="form-group">
						<label for="username">Username</label> 
						<input type="text"
							id="username" name="username" placeholder="Enter your username"
							oninput="validateUsername()"
							required>
				        <small id="un-msg"></small>
					</div>
					<div class="form-group">
						<label for="password">Password</label> 
						<input type="password"
							id="password" name="password" placeholder="Enter your password"
							oninput="validatePassword()"
							required>
						<small id="pw-msg"></small>
							
					</div>
					<div class="form-group">
						<label for="confirm-password">Confirm Password</label> 
						<input
							type="password" id="confirm-password" name="confirm-password"
							placeholder="Confirm your password" oninput="validatePassword()" required>
						<small id="pw-msg"></small>
					</div>
					<div class="form-group">
						<label>Mã xác thực: <strong style="font-size: 18px;"><%= code %></strong></label>
						<input type="text" name="authCodeInput" required
							placeholder="Nhập mã xác thực">
					</div>
					<button type="submit" id="submit-button" class="login-page-button">Sign
						Up</button>
				</form>
				<p class="toggle-link">
					<span>Already have an account?</span> <a href="<c:url value='/login'/>">Login</a>
				</p>
			</div>
		</div>
	</section>
	<%@ include file="footer.jsp"%>
</body>
</html>
