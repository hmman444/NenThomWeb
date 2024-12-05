<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Scented Bliss</title>
    <link rel="stylesheet" href="../css/styles_header_footer.css">
    <link rel="stylesheet" href="../css/styles_checkout.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-faf7f2">

    <!-- Header -->
    <%@ include file="header.jsp" %>

    <!-- Checkout Section -->
	<main class="checkout-section">
	    <div class="container">
	        <h1 class="checkout-title">THANH TOÁN HÓA ĐƠN</h1>
	        
	        <form class="checkout-form" action="processCheckout.jsp" method="POST">
	            <div class="section shipping-information">
	                <h3>Shipping Information</h3>
	                <div class="input-grid">
					    <div>
					        <label for="name">Full Name</label>
	                        <input type="text" id="name" name="name" class="input-field" required>
					    </div>
					    <div>
					        <label for="phone">Phone Number</label>
					        <input type="text" id="phone" name="phone" class="input-field" value="${user.phoneNumber}" readonly>
					    </div>
					    <div class="full-width">
					        <label for="address">Address</label>
					        <input type="text" id="address" name="address" class="input-field" value="${user.address}" readonly>
					    </div>
					</div>
	            </div>
	
	            <div class="section payment-information">
	                <h3>Payment Information</h3>
	                <div class="input-grid">
	                    <div>
	                        <label for="cardNumber">Card Number</label>
	                        <input type="text" id="cardNumber" name="cardNumber" class="input-field" placeholder="**** **** **** ****" required>
	                    </div>
	                    <div>
	                        <label for="expiryDate">Expiry Date</label>
	                        <input type="text" id="expiryDate" name="expiryDate" class="input-field" placeholder="MM/YY" required>
	                    </div>
	                    <div>
	                        <label for="cvv">CVV</label>
	                        <input type="text" id="cvv" name="cvv" class="input-field" placeholder="***" required>
	                    </div>
	                </div>
	            </div>
	
	            <!-- Gom Order Summary và Payment Methods thành 1 dòng -->
	            <div class="checkout-content">
	                <div class="order-summary">
	                    <h3>Order Summary</h3>
	                    <p>Subtotal: $${subtotal}</p>
	                    <p>Shipping: $${shippingCost}</p>	
	                    <p>Discount: ${selectedDiscount.discountName}</p>                    
	                    <p>Total: $${totalAmount}</p>
	                </div>
	
	                <div class="payment-methods">
	                    <h3>Select Payment Method</h3>
	                    <!-- Thêm lớp "payment-option-group" để chia thành 2 hàng -->
	                    <div class="payment-option-group">
	                        <div class="payment-option">
	                            <input type="radio" id="paypal" name="paymentMethod" value="PayPal" required>
	                            <label for="paypal">
	                                <img src="https://www.paypalobjects.com/webstatic/icon/pp258.png" alt="PayPal">
	                                Pay with PayPal
	                            </label>
	                        </div>
	                        <div class="payment-option">
	                            <input type="radio" id="stripe" name="paymentMethod" value="Stripe">
	                            <label for="stripe">
	                                <img src="https://stripe.com/img/v3/home/twitter.png" alt="Stripe">
	                                Pay with Stripe
	                            </label>
	                        </div>
	                    </div>
	                    <div class="payment-option-group">
	                        <div class="payment-option">
	                            <input type="radio" id="vnpay" name="paymentMethod" value="VNPAY">
	                            <label for="vnpay">
	                                <img src="https://admin.softmaster.vn/_default_upload_bucket/154573132_152687123342645_1913382004205201124_n.png" alt="VNPAY">
	                                Pay with VNPAY
	                            </label>
	                        </div>
	                        <div class="payment-option">
	                            <input type="radio" id="momo" name="paymentMethod" value="Momo">
	                            <label for="momo">
	                                <img src="https://upload.wikimedia.org/wikipedia/vi/f/fe/MoMo_Logo.png" alt="Momo">
	                                Pay with Momo
	                            </label>
	                        </div>
	                    </div>
	                </div>
	            </div>		           
	        </form>
	        <!-- Form thanh toán -->
			<form action="Checkout_Servlet" method="post">
			    <input type="hidden" name="totalAmount" value="${totalAmount}">
			    <input type="hidden" name="address" value="${user.address}">
			    <button type="submit" class="submit-button">Thanh toán</button>
			</form>
	    </div>
	</main>

    <!-- Footer -->
    <%@ include file="footer.jsp" %>

</body>
</html>
