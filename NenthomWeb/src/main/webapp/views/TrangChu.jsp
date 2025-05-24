<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ | Nến thơm</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_TrangChu.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/all.min.css'/>">
</head>
<body class="bg-light-cream">
    <!-- Header -->
    <%@ include file="header.jsp" %>


	<!-- Hero Section -->
	<section class="hero">
		<img src="../images/anhNen.jpg" alt="Luxury Candle">
		<div class="overlay">
			<div class="hero-content">
				<h1>Illuminate Your Space</h1>
				<p>Bring sweet fragrance into your living space</p>
				<button>Shop Now</button>
			</div>
		</div>
	</section>

	<!-- Categories -->
	<section class="categories">
		<h2>Our Collections</h2>
		<div class="grid">
			<div class="category-item">
				<img src="../images/anhSanPham.jpg" alt="Fragrance Candles">
				<div>
					<h3>Fragrance Candles</h3>
					<button>View Collection →</button>
				</div>
			</div>
			<div class="category-item">
				<img src="../images/anhSanPham.jpg" alt="Decorative Candles">
				<div>
					<h3>Decorative Candles</h3>
					<button>View Collection →</button>
				</div>
			</div>
			<div class="category-item">
				<img src="../images/anhSanPham.jpg" alt="Gift Sets">
				<div>
					<h3>Gift Sets</h3>
					<button>View Collection →</button>
				</div>
			</div>
		</div>
	</section>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
</body>
</html>
