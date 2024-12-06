<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Nến Thơm</title>
    <link rel="stylesheet" href="../css/styles_Login.css">
    <link rel="stylesheet" href="../css/styles_header_footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body class="bg-light-cream">
    <%@ include file="header.jsp" %>

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

                <form id="auth-form" action="../servlets/Login_Servlet" method="post">
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
            window.location.href = "register.jsp"; 
        }
    </script>
</body>
</html>
