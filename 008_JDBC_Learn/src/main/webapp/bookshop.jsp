<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
</head>
<body>
	<div id="book-list" class="screen">
        <center>
            <h1>Book List</h1>
            <table border="1" cellpadding="10" cellspacing="0">
                <thead>
                    <tr>
                        <th>Book Name</th>
                        <th>Price</th>
                        <th>Add to Cart</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Duyệt qua danh sách các sách -->
                    <c:forEach var="book" items="${books}">
                        <tr>
                            <td><c:out value="${book.getDescription()}" /></td>
                            <td>$<c:out value="${book.getPrice()}" /></td>
                            <td>
                                <form action="addToCart" method="post">
                                    <input type="hidden" name="bookId" value="${book.code}" />
                                    <button type="submit">Add to Cart</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                    
                </tbody>
            </table>
            <br/>
            <button onclick="showCart()">Go to Cart</button>
        </center>
	</div>
</body>
</html>