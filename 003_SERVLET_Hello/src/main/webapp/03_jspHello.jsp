<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import = "beans.StudentBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login thanh cong</title>
</head>
<body>
	<%
	StudentBean bean = (StudentBean)request.getAttribute("bean");
	out.print("Xin chao: <b>" + bean.getUname());
	%>
	<p> Xin chao (EL): ${bean.uname}
</body>
</html>