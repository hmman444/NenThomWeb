<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scented Bliss - Product Detail</title>
    <link rel="stylesheet" href="styles_product_detail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-[#faf7f2]">
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="logo">Scented Bliss</div>
            <nav class="menu">
                <a href="#">Home</a>
                <a href="#">Products</a>
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

    <!-- Main Section -->
    <main class="main-content">
        <div class="container grid">
            <!-- Product Images -->
            <div class="product-images">
                <div class="main-image">
                    <img src="images.unsplash.com/photo-1602874801007-bd458bb1b8b6" alt="Luxury Vanilla Candle">
                    <div class="discount-tag">20% OFF</div>
                </div>
                <div class="thumbnail-grid">
                    <img src="images.unsplash.com/photo-1603006905003-be475563bc59" alt="Angle 1">
                    <img src="images.unsplash.com/photo-1599446794254-16ca27707b48" alt="Angle 2">
                    <img src="images.unsplash.com/photo-1605651202774-7d573fd3f12d" alt="Angle 3">
                    <img src="images.unsplash.com/photo-1596459045025-12eb00152d7c" alt="Angle 4">
                </div>
            </div>

            <!-- Product Info -->
            <div class="product-info">
                <h1>Luxury Vanilla Dream Candle</h1>
                <div class="rating">
                    <div class="stars">
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star"></i>
                        <i class="fas fa-star-half-alt"></i>
                    </div>
                    <span>(124 reviews)</span>
                </div>
                <div class="price">
                    <span class="current">$24.99</span>
                    <span class="original">$29.99</span>
                </div>
                <p class="availability">In Stock - Ships within 24 hours</p>
                <div class="options">
                    <h3>Size</h3>
                    <div class="size-options">
                        <button>Small</button>
                        <button>Medium</button>
                        <button>Large</button>
                    </div>
                    <h3>Quantity</h3>
                    <div class="quantity">
                        <button>-</button>
                        <span>1</span>
                        <button>+</button>
                    </div>
                </div>
                <div class="actions">
                    <button class="add-to-cart">Add to Cart</button>
                    <button class="buy-now">Buy Now</button>
                </div>
                <div class="description">
                    <h3>Product Description</h3>
                    <p>Immerse yourself in the luxurious scent of vanilla with our premium handcrafted candle...</p>
                </div>
                <div class="share">
                    <button><i class="fas fa-share-alt"></i> Share</button>
                    <button><i class="far fa-heart"></i> Wishlist</button>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <div class="about">
                <h4>About Us</h4>
                <p>Crafting premium scented candles for your perfect ambiance.</p>
            </div>
            <div class="links">
                <h4>Quick Links</h4>
                <ul>
                    <li><a href="#">FAQs</a></li>
                    <li><a href="#">Shipping Info</a></li>
                    <li><a href="#">Returns</a></li>
                </ul>
            </div>
            <div class="connect">
                <h4>Connect</h4>
                <div class="social-icons">
                    <a href="#"><i class="fab fa-facebook"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-pinterest"></i></a>
                </div>
            </div>
            <div class="newsletter">
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
