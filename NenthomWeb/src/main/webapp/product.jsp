<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scented Bliss - Shop Products</title>
    <link rel="stylesheet" href="styles_product.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-light-cream">
    <!-- Header -->
    <header class="header">
        <div class="container">
            <img src="images/logo.jpg" alt="Logo" class="logo">
            <nav>
                <a href="/NenthomWeb/TrangChu.jsp">Home</a>
                <a href="/NenthomWeb/product.jsp">Products</a>
                <a href="#">Collections</a>
                <a href="#">About Us</a>
                <a href="#">Contact</a>
            </nav>
            <div class="icons">
                <button><i class="fas fa-search"></i></button>
                <button><i class="fas fa-shopping-cart"></i></button>
                <button><i class="fas fa-user"></i></button>
            </div>
        </div>
    </header>

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
		        <div class="product-card" >
		                <div class="product-image">
		                    <img src="images/anhSanPham.jpg" alt="Vanilla Dream Candle">
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
		                    <img src="images/anhSanPham.jpg" alt="Vanilla Dream Candle">
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
		                    <img src="images/anhSanPham.jpg" alt="Vanilla Dream Candle">
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
		                    <img src="images/anhSanPham.jpg" alt="Vanilla Dream Candle">
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
		                    <img src="images/anhSanPham.jpg" alt="Vanilla Dream Candle">
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
	                    <img src="images/anhSanPham.jpg" alt="Lavender Bliss Candle">
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
    <footer class="footer">
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
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-pinterest"></i></a>
                </div>
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
