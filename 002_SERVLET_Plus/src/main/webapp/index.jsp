<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Plus</title>
<script type=text/javascript>
	function validateForm(){
		var x = document.forms["Cong2So"]["txtSo1"].value;
		var y = document.forms["Cong2So"]["txtSo2"].value;
		if (x == "" || y == ""){
			alert("Enter number please:");
			return false;
		}
		if(!Number(x)){
			alert("Only number!!!");
			return false;
		}
		return true;
	}
</script>
</head>
<body>

<p><i>${message}</i></p>
<form action="req_resp_servlet" name ="Cong2So "method="post" onsubmit = "return validateForm()">

<label class = "pad_top" >First number: </label>
<input type = "text" name = "txtSo1"><br>

<label class = "pad_top" >Second number: </label>
<input type = "text" name = "txtSo2"><br>

<input type = "submit" class = "margin_left">
</form>
</body>
</html>