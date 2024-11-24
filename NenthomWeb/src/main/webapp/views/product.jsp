<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scented Bliss - Shop Products</title>
    <link rel="stylesheet" href="../css/styles_product.css">
    <link rel="stylesheet" href="../css/styles_header_footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light-cream">
    <!-- Header -->
    <%@ include file="header.jsp" %>


    <!-- Search and Filter Section -->
    <section class="search-filter">
        <div class="container">
            <div class="search-filter-content">
                <div class="search-bar">
                    <input type="text" placeholder="Search products...">
                    <button><i class="fas fa-search"></i></button>
                </div>
                <div class="filters">
                    <select>
                        <option>All Categories</option>
                        <option>Fragrance Candles</option>
                        <option>Decorative Candles</option>
                        <option>Gift Sets</option>
                    </select>
                    <select>
                        <option>Price Range</option>
                        <option>Under $25</option>
                        <option>$25 - $50</option>
                        <option>Over $50</option>
                    </select>
                    <select>
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
		        <div class="product-card" onclick="redirectToDetail('1')">
		                <div class="product-image">
		                    <img src="../images/anhSanPham.jpg" alt="Vanilla Dream Candle">
		                </div>
		                <div class="product-info">
		                    <h3 class="product-name">Vanilla Dream</h3>
		                    <p class="product-price">$24.99</p>
		                    <div class="product-rating">
		                        <span class="stars">★★★★☆</span>
		                        <span class="reviews">(24 reviews)</span>
		                    </div>
		                    <button class="add-to-cart">Add to Cart</button>
		                </div>
		            </div>
		        <div class="product-card">
		                <div class="product-image">
		                    <img src="../images/anhSanPham.jpg" alt="Vanilla Dream Candle">
		                </div>
		                <div class="product-info">
		                    <h3 class="product-name">Vanilla Dream</h3>
		                    <p class="product-price">$24.99</p>
		                    <div class="product-rating">
		                        <span class="stars">★★★★☆</span>
		                        <span class="reviews">(24 reviews)</span>
		                    </div>
		                    <button class="add-to-cart">Add to Cart</button>
		                </div>
		            </div>
		        <div class="product-card">
		                <div class="product-image">
		                    <img src="../images/anhSanPham.jpg" alt="Vanilla Dream Candle">
		                </div>
		                <div class="product-info">
		                    <h3 class="product-name">Vanilla Dream</h3>
		                    <p class="product-price">$24.99</p>
		                    <div class="product-rating">
		                        <span class="stars">★★★★☆</span>
		                        <span class="reviews">(24 reviews)</span>
		                    </div>
		                    <button class="add-to-cart">Add to Cart</button>
		                </div>
		            </div>
		        <div class="product-card">
		                <div class="product-image">
		                    <img src="../images/anhSanPham.jpg" alt="Vanilla Dream Candle">
		                </div>
		                <div class="product-info">
		                    <h3 class="product-name">Vanilla Dream</h3>
		                    <p class="product-price">$24.99</p>
		                    <div class="product-rating">
		                        <span class="stars">★★★★☆</span>
		                        <span class="reviews">(24 reviews)</span>
		                    </div>
		                    <button class="add-to-cart">Add to Cart</button>
		                </div>
		            </div>
		        <div class="product-card">
		                <div class="product-image">
		                    <img src="../images/anhSanPham.jpg" alt="Vanilla Dream Candle">
		                </div>
		                <div class="product-info">
		                    <h3 class="product-name">Vanilla Dream</h3>
		                    <p class="product-price">$24.99</p>
		                    <div class="product-rating">
		                        <span class="stars">★★★★☆</span>
		                        <span class="reviews">(24 reviews)</span>
		                    </div>
		                    <button class="add-to-cart">Add to Cart</button>
		                </div>
		            </div>
		        <div class="product-card">
	                <div class="product-image">
	                    <img src="../images/anhSanPham.jpg" alt="Lavender Bliss Candle">
	                </div>
	                <div class="product-info">
	                    <h3 class="product-name">Lavender Bliss</h3>
	                    <p class="product-price">$29.99</p>
	                    <div class="product-rating">
	                        <span class="stars">★★★★★</span>
	                        <span class="reviews">(32 reviews)</span>
	                    </div>
	                    <button class="add-to-cart">Add to Cart</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</section>


    <!-- Footer -->
    <%@ include file="footer.jsp" %>
    <script>
	    function redirectToDetail(productId) {
	        // Điều hướng đến product_detail.jsp với ID sản phẩm
	        window.location.href = `/NenthomWeb/views/product_detail.jsp?id=${productId}`;
	    }
	</script>
</body>
</html>
