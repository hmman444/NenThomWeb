<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Up | Nến Thơm</title>
<link rel="stylesheet" href="<c:url value='/css/styles_Login.css'/>">
<link rel="stylesheet"
	href="<c:url value='/css/styles_header_footer.css'/>">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
</head>
<body class="bg-light-cream">

	<!-- Register Form -->
	<section class="login-section">
		<div class="container">
			<div class="login-form">
				<h2 id="form-title">Sign Up</h2>

				<!-- Check if there is a message attribute to display -->
				<% if (request.getAttribute("message") != null) { %>
				<script type="text/javascript">
                        var message = "<%= request.getAttribute("message") %>";
                        var error = <%= request.getAttribute("error") %>;

                        if (error) {
                            toastr.error(message, "Lỗi");
                        } else {
                            toastr.success(message, "Thành công");
                        }
                    </script>
				<% } %>
				<%
				    String code = (String) session.getAttribute("authCode");
				%>
				<form id="auth-form" action="../servlets/Register_Servlet"
					method="post">
					<div class="form-group">
						<label for="username">Username</label> <input type="text"
							id="username" name="username" placeholder="Enter your username"
							required>
					</div>
					<div class="form-group">
						<label for="password">Password</label> 
						<input type="password"
							id="password" name="password" placeholder="Enter your password"
							oninput="validatePassword()"
							required>
						<small id="pw-msg" style="color: red;"></small>
							
					</div>
					<div class="form-group">
						<label for="confirm-password">Confirm Password</label> 
						<input
							type="password" id="confirm-password" name="confirm-password"
							placeholder="Confirm your password" oninput="validatePassword()" required>
						<small id="pw-msg" style="color: red;"></small>
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
					<span>Already have an account?</span> <a href="javascript:void(0)"
						onclick="toggleForm()">Login</a>
				</p>
			</div>
		</div>
	</section>

	<%@ include file="footer.jsp"%>

	<script>
        function toggleForm() {
        	window.location.href = "/NenthomWeb/servlets/Login_Servlet";
        }
        function validatePassword() {
            const password = document.getElementById("password").value;
            const message = document.getElementById("pw-msg");
            const strongRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!]).{8,}$/;

            if (!strongRegex.test(password)) {
                message.innerText = "Mật khẩu phải có ít nhất 8 ký tự, bao gồm chữ hoa, chữ thường, số và ký tự đặc biệt.";
            } else {
                message.innerText = "";
            }
        }
    </script>
</body>
</html>
