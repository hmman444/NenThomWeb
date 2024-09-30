<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<p><i>${message}</i></p>
<form action="req_resp_servlet" method="post">

<label class = "pad_top" >What is your name?</label>
<input type = "text" name = "txtName"><br>

<input type = "submit" class = "margin_left">
</form>
</body>
</html>