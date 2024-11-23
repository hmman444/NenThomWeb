<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scented Bliss - Shopping Cart</title>
    <link rel="stylesheet" href="../css/styles_header_footer.css">
    <link rel="stylesheet" href="../css/styles_cart.css">
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
                <button><i class="fas fa-shopping-cart"></i></button>
                <button><i class="fas fa-user"></i></button>
            </div>
        </div>
    </header>

    <!-- Cart Section -->
    <main class="cart-section">
	  <div class="container">
	    <h1 class="cart-title">Shopping Cart</h1>
	    <div class="cart-content">
	      <!-- Cart Items -->
	      <div class="cart-items">
	        <div class="cart-item">
	          <img src="../images/anhSanPham.jpg" alt="Product Image" class="cart-item-image" />
	          <div class="cart-item-details">
	            <h2>Luxury Vanilla Dream Candle</h2>
	            <p class="in-stock">In Stock</p>
	            <div class="quantity-controls">
			        <button class="quantity-btn" onclick="decrement()">-</button>
			        <span id="quantityValue" class="quantity-value">1</span>
			        <button class="quantity-btn" onclick="increment()">+</button>
			    </div>
	          </div>
	          <div class="cart-item-price">$24.99</div>
	          <button class="delete-btn"><i class="fas fa-trash"></i></button>
	        </div>
	        <div class="cart-item">
	          <img src="../images/anhSanPham.jpg" alt="Product Image" class="cart-item-image" />
	          <div class="cart-item-details">
	            <h2>Luxury Vanilla Dream Candle</h2>
	            <p class="in-stock">In Stock</p>
	            <div class="quantity-controls">
			        <button class="quantity-btn" onclick="decrement()">-</button>
			        <span id="quantityValue" class="quantity-value">1</span>
			        <button class="quantity-btn" onclick="increment()">+</button>
			    </div>
	          </div>
	          <div class="cart-item-price">$24.99</div>
	          <button class="delete-btn"><i class="fas fa-trash"></i></button>
	        </div>

	      </div>
	      <!-- Order Summary -->
	      <div class="order-summary">
	        <h2>Order Summary</h2>
	        <div class="summary-detail">
	          <p>Subtotal:</p>
	          <p>$70.97</p>
	        </div>
	        <div class="summary-detail">
	          <p>Shipping:</p>
	          <p>$5.99</p>
	        </div>
	        <div class="promo-code">
		        <input type="text" placeholder="Enter discount code" class="promo-input" />
		        <button class="promo-btn">Apply</button>
		    </div>
	        <div class="summary-total">
	          <p>Total:</p>
	          <p>$76.96</p>
	        </div>
	        <button class="checkout-btn">Proceed to Checkout</button>
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
            quantity++;
            document.getElementById("quantityValue").textContent = quantity;
        }

        function decrement() {
            if (quantity > 1) {
                quantity--;
                document.getElementById("quantityValue").textContent = quantity;
            }
        }

        function applyCode() {
            const promoInput = document.querySelector('.promo-input').value;
            if (promoInput.trim() === "") {
                alert("Please enter a promo code!");
            } else {
                alert(`Promo code "${promoInput}" applied successfully!`);
            }
        }
    </script>
</body>
</html>
