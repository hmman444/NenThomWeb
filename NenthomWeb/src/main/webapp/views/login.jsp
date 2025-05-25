<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- <meta http-equiv="Content-Security-Policy"
      content="default-src 'self';
               form-action 'self';
               style-src 'self' https://cdnjs.cloudflare.com;
               script-src 'self' https://cdnjs.cloudflare.com;"> -->
    <title>Login | Nến Thơm</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_login.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/all.min.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/toastr.min.css'/>">
	<script src="<c:url value='/js/jquery.min.js'/>"></script>
	<script src="<c:url value='/js/toastr.min.js'/>"></script>

</head>
<body class="bg-light-cream">
    <section class="login-section">
        <div class="container">
            <div class="login-form">
                <h2 id="form-title">Login</h2>

                <% String logoutMessage = (String) request.getAttribute("logoutMessage");
                   if (logoutMessage != null) { %>
                    <div id="logout-message-data" data-message="<%= logoutMessage %>" style="display:none;"></div>
                <% } %>

                <form id="auth-form" action="/NenthomWeb/login" method="post">
                    <input type="hidden" name="csrfToken" value="<%= request.getAttribute("csrfToken") %>"/>

                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" placeholder="Enter your username" required>
                    </div>

                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>

                    <button type="submit" class="login-page-button">Login</button>
                </form>

                <p class="signup-link">
                    <span>Don't have an account?</span>
                    <a href="/NenthomWeb/views/register.jsp">Sign up</a>
                </p>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>
    <script src="<c:url value='/js/login.js'/>"></script>
</body>
</html>
