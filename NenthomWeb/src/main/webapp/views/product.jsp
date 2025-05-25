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
	<link rel="stylesheet" href="<c:url value='/css/styles_product.css'/>">
	<link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.11.2/toastify.min.css" rel="stylesheet">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body class="bg-light-cream">
<%
    String csrfToken = (String) request.getAttribute("csrfToken");
%>

	<!-- Header -->
	<%@ include file="header.jsp"%>

	<!-- Search and Filter Section -->
	<section class="search-filter">
	    <div class="container">
	        <div class="search-filter-content d-flex justify-content-between align-items-center flex-wrap">
	            <!-- Thanh tìm kiếm -->
	            <div style="display:flex;" class="d-flex gap-2 w-75 mb-2 mb-md-0">
	                <!-- Form chứa ô nhập tìm kiếm -->
	                <form action="SearchProduct_Servlet" method="get" id="search-input-form" class="d-flex">
	                    <input type="text" class="form-control" name="search" placeholder="Search products..." onchange="this.form.submit()">
	                </form>
	
	                <!-- Form chứa nút tìm kiếm -->
	                <form action="SearchProduct_Servlet" method="get" id="search-button-form" class="d-flex">
	                    <button type="submit" class="btn btn-outline-primary ms-2"><i class="fas fa-search"></i> Search</button>
	                </form>
	            </div>
	            
	            <!-- Bộ lọc -->
	            <div class="filters d-flex gap-2">
	                <form action="SearchProduct_Servlet" method="get" class="d-flex gap-2">
	                    <select name="category" class="form-select" onchange="this.form.submit()">
	                        <option>Categories</option>
	                        <c:forEach var="category" items="${categories}">
	                            <option value="${category.categoryID}">${category.name}</option>
	                        </c:forEach>
	                        <option value="all">All Products</option>
	                    </select>
	                    <select name="price" class="form-select" onchange="this.form.submit()">
	                        <option>Price</option>
	                        <option value="1">Under $10</option>
	                        <option value="2">$11 - $25</option>
	                        <option value="3">$26 - $49</option>
	                        <option value="4">Over $50</option>
	                        <option value="all">All Products</option>
	                    </select>
	                </form>
	            </div>
	        </div>
	    </div>
	</section>

	<!-- Product Grid -->
	<section class="products">
		<div class="container">
			<div class="grid">
				<!-- Loop through products -->
				<c:forEach var="product" items="${products}">
					<div class="product-card" onclick="ProductDetail(${product.productID})">
						<div class="product-image">
							<img src="../images/anhSanPham.jpg" alt="${product.name}">
						</div>
						<div class="product-info">
							<h3 class="product-name">${product.name}</h3>
							<p class="product-price">$${product.price}</p>
							<div class="product-rating">
								<span class="stars">★★★★☆</span> <span class="reviews">(24 reviews)</span>
							</div>
							
							<!-- Add to Cart Form -->
							<form action="/NenthomWeb/servlets/AddToCart_Servlet" method="POST">
								<input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
								<input type="hidden" name="productID" value="${product.productID}">
								<input type="hidden" name="quantity" id="hiddenQuantity" value="1">
								<button type="submit" class="add-to-cart">Add to Cart</button>
							</form>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>


	<!-- Footer -->
	<%@ include file="footer.jsp"%>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastify-js/1.11.2/toastify.min.js"></script>

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

        // Gán productID vào input hidden trong form
        document.getElementById('productID_' + productID).value = productID;

        // Submit form
        document.getElementById('addToCartForm').submit();
    }
    
    const successMessage = '<%= request.getAttribute("successMessage") != null ? request.getAttribute("successMessage") : "" %>';
	const errorMessage ='<%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>'; 
    if (successMessage) {
        // Hiển thị Toast notification
        Toastify({
            text: successMessage,
            duration: 3000, // 3 seconds
            gravity: "top", // Top of the screen
            position: "right", // Right side of the screen
            backgroundColor: "green", // Green color for success
        }).showToast();
    }
    if(errorMessage) {
    	Toastify({
            text: errorMessage,
            duration: 3000, // 3 seconds
            gravity: "top", // Top of the screen
            position: "right", // Right side of the screen
            backgroundColor: "red", // Green color for success
        }).showToast();
    }
    function ProductDetail(productID) {
        window.location.href = "/NenthomWeb/servlets/ProductDetail_Servlet?productID=" + productID;
    }
	</script>
</body>
</html>
