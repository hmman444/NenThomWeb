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
</head>
<body class="bg-light-cream">
    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Login / Sign Up Form -->
    <section class="login-section">
        <div class="container">
            <div class="login-form">
                <h2 id="form-title">Login</h2>
                <form id="auth-form" action="processLogin.jsp" method="post">
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
                    <!-- Confirm Password (hidden by default) -->
                    <div class="form-group" id="confirm-password-group" style="display: none;">
                        <label for="confirm-password">Confirm Password</label>
                        <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm your password">
                    </div>
                    <!-- Submit Button -->
                    <button type="submit" id="submit-button" class="login-button">Login</button>
                </form>
                <!-- Toggle between Login and Sign Up -->
                <p class="toggle-link">
                    <span id="toggle-text">Don't have an account?</span>
                    <a href="javascript:void(0)" onclick="toggleForm()">Sign up</a>
                </p>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <script>
        // Toggle between Login and Sign Up forms
        function toggleForm() {
            const formTitle = document.getElementById("form-title");
            const confirmPasswordGroup = document.getElementById("confirm-password-group");
            const submitButton = document.getElementById("submit-button");
            const toggleText = document.getElementById("toggle-text");
            const toggleLink = document.querySelector(".toggle-link a");

            if (formTitle.textContent === "Login") {
                // Switch to Sign Up form
                formTitle.textContent = "Sign Up";
                confirmPasswordGroup.style.display = "block";
                submitButton.textContent = "Sign Up";
                toggleText.textContent = "Already have an account?";
                toggleLink.textContent = "Login";
                document.getElementById("auth-form").action = "processSignup.jsp";
            } else {
                // Switch to Login form
                formTitle.textContent = "Login";
                confirmPasswordGroup.style.display = "none";
                submitButton.textContent = "Login";
                toggleText.textContent = "Don't have an account?";
                toggleLink.textContent = "Sign up";
                document.getElementById("auth-form").action = "processLogin.jsp";
            }
        }
    </script>
</body>
</html>
