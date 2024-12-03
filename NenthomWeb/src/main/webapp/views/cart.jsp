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
                        <button onclick="applyCode()" class="promo-btn">Select discount</button>
                        <input type="text" id="promo-input" placeholder="No discount selected" class="promo-input" disabled />
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

    <!-- Promo Code Modal -->
	<div id="promoModal" class="custom-modal-overlay custom-modal-hidden">
	    <div class="custom-modal-content">
	        <div class="custom-modal-header">
	            <h2>Select Discount</h2>
	            <button onclick="closeModal()" class="custom-modal-close">&times;</button>
	        </div>
	        <div class="custom-modal-body">
	            <form>
	                <label for="promoCode">Select a discount</label>
	                <!-- Container for the discounts -->
	                <div class="discounts-container">
	                    <c:forEach var="discount" items="${activeDiscounts}">
	                        <div class="discount-item">
	                            <img src="https://img.lovepik.com/element/45004/0128.png_860.png" alt="Discount image" class="discount-image">
	                            <div class="discount-info">
	                                <h3 class="discount-name">${discount.discountName}</h3>
	                                <p class="discount-details">
	                                    <c:choose>
	                                        <c:when test="${discount.discountType == 'percentage'}">
	                                            ${discount.discountValue}% off
	                                        </c:when>
	                                        <c:otherwise>
	                                            ${discount.discountValue} off
	                                        </c:otherwise>
	                                    </c:choose>
	                                </p>
	                            </div>
	                        </div>
	                    </c:forEach>
	                </div>
	                <button type="button" class="custom-submit-button" onclick="applyPromoCode()">Apply Code</button>
	            </form>
	        </div>
	    </div>
	</div>

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
            document.getElementById('promoModal').classList.remove('custom-modal-hidden');
        }

        function closeModal() {
            document.getElementById('promoModal').classList.add('custom-modal-hidden');
        }

        function applyPromoCode() {
            const promoCode = document.getElementById('promoCode').value.trim();
            if (promoCode === "") {
                alert("Please enter a promo code!");
            } else {
                alert(`Promo code "${promoCode}" applied successfully!`);
                document.querySelector('.promo-input').value = promoCode; // Fill the input field with the promo code
                closeModal(); // Close the modal
            }
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            const discountItems = document.querySelectorAll('.discount-item');

            discountItems.forEach(function(item) {
                item.addEventListener('click', function() {
                    // Xóa dấu hiệu đã chọn khỏi tất cả các ưu đãi
                    discountItems.forEach(function(innerItem) {
                        innerItem.classList.remove('selected');
                    });

                    // Thêm dấu hiệu đã chọn vào ưu đãi được nhấp
                    item.classList.add('selected');
                });
            });
        });
    </script>
</body>
</html>
