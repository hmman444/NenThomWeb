<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scented Bliss - Shopping Cart</title>
    <link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/styles_cart.css'/>">
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
					
					                    <!-- Form để gửi dữ liệu tăng/giảm số lượng -->
					                    <form action="/NenthomWeb/servlets/UpdateCart_Servlet" method="POST">
					                        <!-- Lưu thông tin sản phẩm và hành động (tăng/giảm) -->
					                        <input type="hidden" name="productId" value="${product.productID}" />
					                        <input type="hidden" name="action" value="decrement" id="action-decrement-${product.productID}" />
					                        
					                        <div class="quantity-controls">
					                            <!-- Điều khiển giảm số lượng -->
					                            <button type="submit" class="quantity-btn" onclick="setAction(event, 'decrement', ${product.productID})">-</button>
					                            <span class="quantity-value">${cart.quantity}</span>
					                            <!-- Điều khiển tăng số lượng -->
					                            <button type="submit" class="quantity-btn" onclick="setAction(event, 'increment', ${product.productID})">+</button>
					                        </div>
					                    </form>
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
                        <input type="text" id="promo-input" placeholder="No discount selected" class="promo-input" disabled value="${selectedDiscount != null ? selectedDiscount.discountName : ''}" />
                    </div>
                    <div class="summary-total">
                        <p>Total:</p>
                        <p id="totalAmount">${totalAmount}</p> <!-- Hiển thị tổng tiền (Subtotal + Shipping) -->
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
                            <div class="discount-item" onclick="selectDiscount(${discount.discountID}, '${discount.discountName}', ${discount.discountValue}, '${discount.discountType}')">
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
	    	const { discountID, discountName, discountValue, discountType } = window.selectedDiscount;	            
            window.location.href = "/NenthomWeb/servlets/LoadInfoCheckout_Servlet?discountID=" + discountID;
	    }

        function setAction(event, action, productId) {
            // Lấy form chứa nút vừa được click
            const form = event.target.closest('form');
            
            // Cập nhật giá trị của action trong form
            form.querySelector('input[name="action"]').value = action;
        }

        function applyCode() {
            document.getElementById('promoModal').classList.remove('custom-modal-hidden');
        }

        function closeModal() {
            document.getElementById('promoModal').classList.add('custom-modal-hidden');
        }

        function selectDiscount(discountID, discountName, discountValue, discountType) {
            // Lưu thông tin ưu đãi vào các biến global
            window.selectedDiscount = {
                discountID: discountID,
                discountName: discountName,
                discountValue: discountValue,
                discountType: discountType
            };

            // Cập nhật lại giá trị input
            document.getElementById('promo-input').value = discountName;

            // Xóa lớp 'selected' khỏi tất cả các discount items
            const discountItems = document.querySelectorAll('.discount-item');
            discountItems.forEach(item => {
                item.classList.remove('selected');
            });

            // Thêm lớp 'selected' vào discount item được chọn
            const selectedItem = event.target.closest('.discount-item');
            selectedItem.classList.add('selected');
        }


        function applyPromoCode() {
            if (window.selectedDiscount) {
                const { discountID, discountName, discountValue, discountType } = window.selectedDiscount;
                console.log(discountID);
                let subtotal = parseFloat('${subtotal}');
                let shippingCost = parseFloat('${shippingCost}');
                let totalAmount = subtotal + shippingCost;

                // Tính lại tổng tiền sau khi áp dụng ưu đãi
                if (discountType === 'percentage') {
                    totalAmount -= (totalAmount * discountValue / 100);
                } else {
                    totalAmount -= discountValue;
                }

                // Cập nhật lại tổng tiền trong giao diện
                document.getElementById('totalAmount').textContent = totalAmount.toFixed(2);
                closeModal();
            } else {
                alert('Please select a discount!');
            }
        }
    </script>
</body>
</html>
