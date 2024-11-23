<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Trang chủ | Nến thơm</title>
<link rel="stylesheet" href="../css/styles_TrangChu.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light-cream">
	<!-- Header -->
	<header class="header">
		<div class="container">
			<img src="../images/logo.jpg" alt="Logo" class="logo">
			<nav>
				<a href="/NenthomWeb/views/TrangChu.jsp">Home</a> <a
					href="/NenthomWeb/views/product.jsp">Products</a> <a href="#">Collections</a>
				<a href="/NenthomWeb/views/contact_policy.jsp">Contact and
					Policy</a>
			</nav>
			<div class="icons">
				<button>
					<i class="fas fa-search"></i>
				</button>
				<button>
					<i class="fas fa-shopping-cart"></i>
				</button>
				<button>
					<i class="fas fa-user"></i>
				</button>
			</div>
			<!-- Thêm button Login -->
			<a href="login.jsp" class="login-button">Login</a>
		</div>
	</header>


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
	<footer>
		<div class="container footer-grid">
			<div>
				<h4>About Us</h4>
				<p>Crafting premium scented candles for your perfect ambiance.</p>
			</div>
			<div>
				<h4>Quick Links</h4>
				<ul>
					<li><a href="#">FAQs</a></li>
					<li><a href="#">Shipping Info</a></li>
					<li><a href="#">Returns</a></li>
				</ul>
			</div>
			<div>
				<h4>Connect</h4>
				<a href="#"><i class="fab fa-facebook"></i></a> <a href="#"><i
					class="fab fa-instagram"></i></a> <a href="#"><i
					class="fab fa-pinterest"></i></a>
			</div>
			<div>
				<h4>Newsletter</h4>
				<form>
					<input type="email" placeholder="Your email">
					<button>→</button>
				</form>
			</div>
		</div>
	</footer>
</body>
</html>
