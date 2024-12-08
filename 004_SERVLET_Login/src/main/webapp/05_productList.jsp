<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "beans.Products" %>
<%@page import = "servlets._05_ListProductServlets" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách sản phẩm</title>
</head>
<body>
	<h3>Danh sách sản phẩm</h3>
	<p style ="color:red;">${errorString}</p>
	<table border = "1" cellpadding = "5" cellspacing ="1">
		<tr>
			<th>Id</th>
			<th>Tên sách</th>
			<th>Giá</th>
			<th></th>
		</tr>
		<c:forEach items = "${productList}" var ="book">
			<tr>
				<td>${book.code}</td>
				<td>${book.description}</td>
				<td>${book.price}</td>
				<td><a href="addToCart?id=${book.code}">Thêm vào giỏ hàng</a>
			</tr>
		</c:forEach>
	</table>
	<jsp:include page="_footer.jsp"></jsp:include>
</body>
</html>