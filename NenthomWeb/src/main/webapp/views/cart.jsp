<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scented Bliss - Shopping Cart</title>
    <link rel="stylesheet" href="../css/styles_header_footer.css">
    <link rel="stylesheet" href="../css/styles_cart.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-faf7f2">
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
                        <c:forEach var="product" items="${productList}">
                            <c:if test="${product.productID == cart.productID}">
                                <div class="cart-item">
                                    <!-- Hiển thị hình ảnh sản phẩm -->
                                    <img src="../images/anhSanPham.jpg" alt="Product Image" class="cart-item-image" />
                                    
                                    <div class="cart-item-details">
                                        <!-- Hiển thị tên sản phẩm -->
                                        <h2>${product.name}</h2>
                                        <p class="in-stock">In Stock</p>
                                        
                                        <div class="quantity-controls">
                                            <!-- Điều khiển tăng/giảm số lượng -->
                                            <button class="quantity-btn" onclick="decrement(event)">-</button>
                                            <span class="quantity-value">${cart.quantity}</span>
                                            <button class="quantity-btn" onclick="increment(event)">+</button>
                                        </div>
                                    </div>
                                    
                                    <!-- Hiển thị giá sản phẩm -->
                                    <div class="cart-item-price">$${product.price}</div>
                                    <!-- Nút xóa sản phẩm khỏi giỏ hàng -->
                                    <button class="delete-btn"><i class="fas fa-trash"></i></button>
                                </div>
                            </c:if>
                        </c:forEach>
                    </c:forEach>
                </div>

                <!-- Order Summary -->
                <div class="order-summary">
                    <h2>Order Summary</h2>
                    <div class="summary-detail">
                        <p>Subtotal:</p>
                        <p>${subtotal}</p> <!-- Hiển thị tổng giá trị các sản phẩm -->
                    </div>
                    <div class="summary-detail">
                        <p>Shipping:</p>
                        <p>${shippingCost}</p> <!-- Hiển thị phí vận chuyển -->
                    </div>
                    <div class="promo-code">
                        <input type="text" placeholder="Enter discount code" class="promo-input" />
                        <button onclick="applyCode()" class="promo-btn">Apply</button>
                    </div>
                    <div class="summary-total">
                        <p>Total:</p>
                        <p>${totalAmount}</p> <!-- Hiển thị tổng tiền (Subtotal + Shipping) -->
                    </div>
                    <button class="checkout-btn" onclick="toggleModal()">Proceed to Checkout</button>
                </div>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

    <script>
        function toggleModal() {
        	window.location.href = "/NenthomWeb/views/checkout.jsp";
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
