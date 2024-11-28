<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
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
    <%@ include file="header.jsp" %>

    <!-- Cart Section -->
    <main class="cart-section">
        <div class="container">
            <h1 class="cart-title">Shopping Cart</h1>
            <div class="cart-content">
                <!-- Cart Items -->
                <div class="cart-items">
                    <c:forEach var="cart" items="${cartList}">
                        <div class="cart-item">
                            <img src="../images/anhSanPham.jpg" alt="Product Image" class="cart-item-image" />
                            <div class="cart-item-details">
                                <h2>Product ID: ${cart.productId}</h2>
                                <p class="in-stock">In Stock</p>
                                <div class="quantity-controls">
                                    <button class="quantity-btn" onclick="decrement(event)">-</button>
                                    <span class="quantity-value">${cart.quantity}</span>
                                    <button class="quantity-btn" onclick="increment(event)">+</button>
                                </div>
                            </div>
                            <div class="cart-item-price">$${cart.price}</div>
                            <button class="delete-btn"><i class="fas fa-trash"></i></button>
                        </div>
                    </c:forEach>
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
                        <button onclick="applyCode()" class="promo-btn">Apply</button>
                    </div>
                    <div class="summary-total">
                        <p>Total:</p>
                        <p>$76.96</p>
                    </div>
                    <button class="checkout-btn" onclick="toggleModal()">Proceed to Checkout</button>
                </div>
            </div>
        </div>
    </main>

    <!-- Checkout Modal -->
    <div id="checkoutModal" class="custom-modal-overlay custom-modal-hidden">
        <div class="custom-modal-content">
            <div class="custom-modal-header">
                <h2>Checkout Information</h2>
                <button onclick="toggleModal()" class="custom-modal-close">
                    <i class="fas fa-times"></i>
                </button>
            </div>
            <form class="custom-modal-form">
                <!-- Shipping Information -->
                <div>
                    <h3>Shipping Information</h3>
                    <div class="custom-form-grid">
                        <div>
                            <label>First Name</label>
                            <input type="text" class="custom-input">
                        </div>
                        <div>
                            <label>Last Name</label>
                            <input type="text" class="custom-input">
                        </div>
                        <div class="custom-form-full-width">
                            <label>Address</label>
                            <input type="text" class="custom-input">
                        </div>
                        <div>
                            <label>City</label>
                            <input type="text" class="custom-input">
                        </div>
                        <div>
                            <label>Postal Code</label>
                            <input type="text" class="custom-input">
                        </div>
                    </div>
                </div>

                <!-- Payment Information -->
                <div>
                    <h3>Payment Information</h3>
                    <div class="custom-form-group">
                        <div>
                            <label>Card Number</label>
                            <input type="text" class="custom-input custom-card-number" placeholder="**** **** **** ****">
                        </div>
                        <div class="custom-form-grid">
                            <div>
                                <label>Expiry Date</label>
                                <input type="text" class="custom-input" placeholder="MM/YY">
                            </div>
                            <div>
                                <label>CVV</label>
                                <input type="text" class="custom-input" placeholder="***">
                            </div>
                        </div>
                    </div>
                </div>

                <button type="submit" class="custom-submit-button">Complete Purchase</button>
            </form>
        </div>
    </div>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <script>
        function toggleModal() {
            const modal = document.getElementById('checkoutModal');
            modal.classList.toggle('custom-modal-hidden');
        }

        function increment(event) {
            const quantityElement = event.target.closest('.quantity-controls').querySelector('.quantity-value');
            let quantity = parseInt(quantityElement.textContent, 10);
            quantity++;
            quantityElement.textContent = quantity;
        }

        function decrement(event) {
            const quantityElement = event.target.closest('.quantity-controls').querySelector('.quantity-value');
            let quantity = parseInt(quantityElement.textContent, 10);
            if (quantity > 1) {
                quantity--;
                quantityElement.textContent = quantity;
            }
        }


        function applyCode() {
            const promoInput = document.querySelector('.promo-input').value.trim();
            if (promoInput === "") {
                alert("Please enter a promo code!");
            } else {
                alert(`Promo code "${promoInput}" applied successfully!`);
            }
        }
    </script>
</body>
</html>
