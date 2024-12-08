<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
	uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="ten_bien" value="Xin chao" scope="application"/>
	<center>
		<h1>
			<c:out value="${ten_bien }"></c:out>
		</h1>
	</center>
	<p>Các số chẵn từ 1 đến 20</p>
	<c:forEach var="number" begin="1" end="20">
		<c:if test="${number % 2 == 0}">
			<c:out value="${number}"/>
		</c:if>
	</c:forEach>
	<p>Màu sắc</p>
	<c:set var="colors" scope="page" value="Xanh, Đỏ, Tím, Vàng"/>
	<c:forEach var="color" items="${pageScope.colors}">
		<c:out value="${color}"/>
	</c:forEach>
</body>
</html>