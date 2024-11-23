<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scented Bliss - Product Detail</title>
    <link rel="stylesheet" href="../css/styles_header_footer.css">
    <link rel="stylesheet" href="../css/styles_product_detail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-[#faf7f2]">
    <!-- Header -->
    <header class="header">
        <div class="container">
            <img src="../images/logo.jpg" alt="Logo" class="logo">
            <nav>
                <a href="/NenthomWeb/views/TrangChu.jsp">Home</a>
                <a href="/NenthomWeb/views/product.jsp">Products</a>
                <a href="#">Collections</a>
                <a href="#">About Us</a>
                <a href="#">Contact</a>
            </nav>
            <div class="icons">
                <button><i class="fas fa-search"></i></button>
                <button onclick="window.location.href='cart.jsp';">
                	<i class="fas fa-shopping-cart"></i></button>
                <button><i class="fas fa-user"></i></button>
            </div>
        </div>
    </header>

    <!-- Main Section -->
    <main class="main-content">
        <div class="container grid">
            <!-- Product Images -->
            <div class="product-images">
                <div class="main-image">
                    <img src="../images/anhNen.jpg" alt="Luxury Vanilla Candle">
                    <!-- <div class="discount-tag">20% OFF</div> -->
                </div>

            </div>

            <!-- Product Info -->
            <div class="product-info">
                <h1>Luxury Vanilla Dream Candle</h1>
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
                <div class="price">
                    <span class="current">$24.99</span>
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
				    <button class="styled-button">Add to Cart</button>
				    <button class="styled-button">Buy Now</button>
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
    <script>
        let quantity = 1;

        function increment() {
            quantity++; // Tăng số lượng
            document.getElementById("quantityValue").textContent = quantity; // Cập nhật giá trị hiển thị
        }

        function decrement() {
            if (quantity > 1) { // Đảm bảo không giảm xuống dưới 1
                quantity--; // Giảm số lượng
                document.getElementById("quantityValue").textContent = quantity; // Cập nhật giá trị hiển thị
            }
        }
    </script>
</body>
</html>
