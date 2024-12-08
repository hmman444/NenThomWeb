<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "beans.LoginBean" %>
<%@page import = "beans.StudentBean" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
        LoginBean bean = (LoginBean) request.getAttribute("bean");  // Nhận đúng loại bean
        if (bean != null) {
            out.print("Xin chào: <b>" + bean.getUname() + "</b>");
        }
    %>
    <p> Xin chao (EL): ${bean.uname} </p>
</body>
</html>