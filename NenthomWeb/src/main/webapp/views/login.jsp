<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Nến Thơm</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_Login.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <!-- Font Awesome từ WebJars -->
	<link rel="stylesheet" href="<c:url value='/webjars/font-awesome/6.0.0/css/all.min.css'/>">
	
	<!-- Toastr từ WebJars -->
	<link rel="stylesheet" href="<c:url value='/webjars/toastr/2.1.4/toastr.min.css'/>">
	<script src="<c:url value='/webjars/jquery/3.6.0/jquery.min.js'/>"></script>
	<script src="<c:url value='/webjars/toastr/2.1.4/toastr.min.js'/>"></script>

</head>
<body class="bg-light-cream">

    <section class="login-section">
        <div class="container">
            <div class="login-form">
                <h2 id="form-title">Login</h2>

                <!-- Check if there is a logout message -->
                <% 
                    String logoutMessage = (String) request.getAttribute("logoutMessage");
                    if (logoutMessage != null) {
                %>
                    <script type="text/javascript">
                        // Hiển thị thông báo toast logout thành công
                        toastr.success('<%= logoutMessage %>');
                    </script>
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
                    <a href="javascript:void(0)" onclick="toggleForm()">Sign up</a>
                </p>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script>
        function toggleForm() {
            window.location.href = "/NenthomWeb/views/register.jsp"; 
        }
    </script>
</body>
</html>
