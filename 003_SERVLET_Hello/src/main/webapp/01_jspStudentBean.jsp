<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> <center> Thong tin sinh vien </center> </h1>
	<font size = "+1"><b>

<jsp:useBean id="student" class = "beans.StudentBean" scope = "page"></jsp:useBean>

<jsp:setProperty property="uname" name="student" value ="Chim Se"/>
<jsp:setProperty property="age" name="student" value ="20"/>

<p>Ten sinh vien: <jsp:getProperty property="uname" name="student"/> 
</p>
<p>Tuoi sinh vien: <jsp:getProperty property="age" name="student"/> 
</p>
</body>
</html>