<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginPage</title>
<script>
	function validateForm()
	{
        var username = document.getElementById("username").value;
        var password = document.getElementById("password").value;

        if (username === "" || password === "") {
            alert("Username and password cannot be empty.");
            return false; // Ngăn không cho form submit
        }
        return true; // Cho phép form submit nếu dữ liệu hợp lệ
	}
	
</script>
</head>
<body>
	<form action ="servlet_login" method="post">
		<label for="username">Username:</label><br>
        <input type="text" id="username" name="username"><br><br>

        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password"><br><br>

        <input type="submit" value="Login">
	</form>
</body>
</html>