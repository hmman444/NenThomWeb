<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header class="header">
    <div class="container">
        <img src="<c:url value='/images/logo.jpg'/>" alt="Logo" class="logo">

        <nav>
            <a href="/NenthomWeb/views/TrangChu.jsp">Home</a>
            <a href="/NenthomWeb/servlets/DSProduct_Servlet?page=product">Products</a>
            <a href="/NenthomWeb/views/contact_policy.jsp">Contact and Policy</a>
            <a href="/NenthomWeb/servlets/Logout_Servlet">Logout</a>
        </nav>
        <div class="icons">
            <button onclick="window.location.href='/NenthomWeb/servlets/ListCart_Servlet';">
    			<i class="fas fa-shopping-cart"></i></button>
            <button onclick="window.location.href='/NenthomWeb/servlets/LoadProfile_Servlet';">
            	<i class="fas fa-user"></i></button>
        </div>
    </div>
</header>
