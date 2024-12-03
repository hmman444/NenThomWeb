<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="constant.SystemConstant" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Scented Bliss - Shop Products</title>
<link rel="stylesheet" href="../css/styles_product.css">
<link rel="stylesheet" href="../css/styles_header_footer.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light-cream">
	<!-- Header -->
	<%@ include file="header.jsp"%>


	<!-- Search and Filter Section -->
	<section class="search-filter">
		<div class="container">
			<div class="search-filter-content">
				<div class="search-bar">
					<input type="text" placeholder="Search products...">
					<button>
						<i class="fas fa-search"></i>
					</button>
				</div>
				<div class="filters">
					<select>
						<option>All Categories</option>
						<option>Fragrance Candles</option>
						<option>Decorative Candles</option>
						<option>Gift Sets</option>
					</select> <select>
						<option>Price Range</option>
						<option>Under $25</option>
						<option>$25 - $50</option>
						<option>Over $50</option>
					</select> <select>
						<option>Rating</option>
						<option>4+ Stars</option>
						<option>3+ Stars</option>
						<option>All Ratings</option>
					</select>
				</div>
			</div>
		</div>
	</section>

	<!-- Product Grid -->
	<section class="products">
		<div class="container">
			<div class="grid">
				<c:forEach var="product" items="${products}">
					<div class="product-card">
						<div class="product-image">
							<img src="../images/anhSanPham.jpg" alt="${product.name}">
						</div>
						<div class="product-info">
							<h3 class="product-name">${product.name}</h3>
							<p class="product-price">$${product.price}</p>
							<div class="product-rating">
								<span class="stars">★★★★☆</span> <span class="reviews">(24
									reviews)</span>
							</div>
							<button class="add-to-cart" onclick="addToCart(${product.productID})">Add to Cart</button>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>


	<!-- Footer -->
	<%@ include file="footer.jsp"%>

	<script>
    const userID = <%= SystemConstant.USERID %>; 

    function addToCart(productID) {
        console.log("addToCart function called with productID: " + productID);

        // Kiểm tra nếu userID không tồn tại
        if (!userID || userID === 0) {
            alert("You need to log in to add products to your cart.");
            window.location.href = '/NenthomWeb/views/login.jsp';
            return;
        }

        // Sử dụng fetch để gửi POST request với productID
        fetch("/NenthomWeb/servlets/AddToCart_Servlet", {
            method: 'POST',  // Đảm bảo dùng phương thức POST
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'  // Gửi dữ liệu ở dạng x-www-form-urlencoded
            },
            body: `productID=${productID}`  // Gửi productID trong body
        })
        .then(response => response.text())  // Nhận phản hồi từ servlet
        .then(data => {
            console.log(data);  // Hiển thị kết quả trong console
            alert(data);  // Hiển thị thông báo với kết quả trả về từ servlet
        })
        .catch(error => {
            console.error('Error:', error);
        });
    }
	</script>
</body>
</html>
