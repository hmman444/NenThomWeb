<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scented Bliss - Product Detail</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_product_detail.css'/>">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-[#faf7f2]">
<%
    String csrfToken = (String) request.getAttribute("csrfToken");
%>

    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Main Section -->
    <main class="main-content">
        <div class="container grid">
            <!-- Product Images -->
            <div class="product-images">
                <div class="main-image">
                    <img src="../images/anhSanPham.jpg" alt="Luxury Vanilla Candle">
                    <!-- <div class="discount-tag">20% OFF</div> -->
                </div>
            </div>

            <!-- Product Info -->
            <div class="product-info">
                <!-- Product Name -->
                <h1>${product.name}</h1>  <!-- Sử dụng EL để hiển thị tên sản phẩm -->

                <div class="product-rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span class="reviews">(124 reviews)</span>
                </div>
                
                <!-- Product Price -->
                <div class="price">
                    <span class="current">$${product.price}</span>  <!-- Sử dụng EL để hiển thị giá sản phẩm -->
                    <span class="original">$29.99</span>
                </div>
                
                <p class="availability">In Stock - Ships within 24 hours</p>
                <div class="options">
                    <h3>Quantity</h3>
                    <div class="quantity">
                        <button class="quantity-btn" onclick="decrement()">-</button>
                        <span class="quantity-value" id="quantityValue">1</span>
                        <button class="quantity-btn" onclick="increment()">+</button>
                    </div>
                </div>
                
                <div class="button-container">
                	<form action="/NenthomWeb/servlets/AddToCart_Servlet" method="POST">
                		<input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
					    <input type="hidden" name="productID" value="${product.productID}">
					    <input type="hidden" name="quantity" id="hiddenQuantity" value="1"> <!-- Thêm trường ẩn cho quantity -->
					    <button type="submit" class="styled-button">Add to Cart</button>
					</form>
                </div>
                
                <div class="description">
                    <h3>Product Description</h3>
                    <p>Immerse yourself in the luxurious scent of vanilla with our premium handcrafted candle...</p>
                </div>
                
                <div class="share">
                    <button class="action-btn"><i class="fas fa-share-alt"></i> Share</button>
                    <button class="action-btn"><i class="far fa-heart"></i> Wishlist</button>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>
    
    <script>
    let quantity = 1;

    function increment() {
        quantity++; // Tăng số lượng
        document.getElementById("quantityValue").textContent = quantity; // Cập nhật giá trị hiển thị
        document.getElementById("hiddenQuantity").value = quantity; // Cập nhật giá trị quantity trong trường ẩn
    }

    function decrement() {
        if (quantity > 1) { // Đảm bảo không giảm xuống dưới 1
            quantity--; // Giảm số lượng
            document.getElementById("quantityValue").textContent = quantity; // Cập nhật giá trị hiển thị
            document.getElementById("hiddenQuantity").value = quantity; // Cập nhật giá trị quantity trong trường ẩn
        }
    }
    </script>
</body>
</html>
