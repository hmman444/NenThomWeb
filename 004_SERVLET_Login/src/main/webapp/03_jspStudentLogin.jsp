<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login page</title>
<script type="text/javascript">
	function validateForm(){
		var uName = document.forms["frmLogin"]["username"].value;
		var pWord = document.frmLogin.password.value;
		if(uName == ""){
			alert("Vui long nhap username");
			return false;
		}
		if(pWord == ""){
			alert("Vui long nhap password");
			return false;
		}
		return true;
	}
</script>
</head>
<body>
	<h2>Login</h2>
    <form action="CheckUserNamePasswordServlet" method="post" name = "frmLogin" onsubmit = "return validateForm()">
        <label for="username">Username:</label>
        <input type="text" id="username" name="username" ><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password"><br><br>

        <input type="submit" value="Login">
    </form>
</body>
</html>