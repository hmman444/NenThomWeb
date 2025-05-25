<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Security-Policy"
      content="default-src 'self';
               form-action 'self';
               style-src 'self' https://cdnjs.cloudflare.com;
               script-src 'self' https://cdnjs.cloudflare.com;">
    <title>Login | Nến Thơm</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_Login.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body class="bg-light-cream">

    <section class="login-section">
        <div class="container">
            <div class="login-form">
                <h2 id="form-title">Login</h2>

                <%
				    String logoutMessage = (String) request.getAttribute("logoutMessage");
				    if (logoutMessage != null) {
				%>
				    <div id="logout-message-data" data-message="<%= logoutMessage %>" style="display:none;"></div>
				<%
				    }
				%>



                <form id="auth-form" action="/NenthomWeb/servlets/Login_Servlet" method="post">
                    <!-- Username -->
                    <div class="form-group">
                        <label for="username">Username</label>
                        <input type="text" id="username" name="username" placeholder="Enter your username" required>
                    </div>
                    <!-- Password -->
                    <div class="form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" placeholder="Enter your password" required>
                    </div>
                    <!-- Submit Button -->
                    <button type="submit" id="submit-button" class="login-page-button">Login</button>
                </form>

                <p class="toggle-link">
                    <span id="toggle-text">Don't have an account?</span>
					<a href="#" id="go-to-signup">Sign up</a>
                </p>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script src="<c:url value='/js/login.js'/>"></script>

</body>
</html>
