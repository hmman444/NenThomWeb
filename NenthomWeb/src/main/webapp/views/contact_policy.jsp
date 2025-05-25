<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact and Policy | Nến Thơm</title>
<link rel="stylesheet" href="<c:url value='/css/contact_policy.css'/>">
<link rel="stylesheet" href="<c:url value='/css/styles_header_footer.css'/>">
<link rel="stylesheet" href="<c:url value='/css/all.min.css'/>">
</head>
<body class="bg-light-cream">
<%
    String csrfToken = (String) request.getAttribute("csrfToken");
%>

	<!-- Header -->
	<%@ include file="header.jsp"%>

	<!-- Main Content -->
	<section class="contact-policy">
		<div class="container">
			<div class="row">
				<!-- Contact Information -->
				<div class="contact-info">
					<h3>Thông Tin Liên Hệ</h3>
					<p>
						<strong>Số điện thoại:</strong> 0862267674
					</p>
					<p>
						<strong>Email:</strong> luandophu8114@gmail.com
					</p>
					<p>
						<strong>Địa chỉ:</strong> 123 Đường ABC, TP. Hồ Chí Minh
					</p>
					<p>
						<strong>Website:</strong> <a href="http://example.com">www.NenThomWeb.com</a>
					</p>
				</div>

				<!-- Policies -->
				<div class="policies">
					<h3>Chính Sách và Điều Khoản</h3>
					<p>
						<strong>Chính sách bảo mật:</strong> Chúng tôi cam kết bảo mật
						thông tin cá nhân của bạn.
					</p>
					<p>
						<strong>Điều khoản sử dụng:</strong> Bằng việc truy cập và sử dụng
						website, bạn đồng ý tuân thủ các điều khoản.
					</p>
				</div>
			</div>

			<!-- Support Form -->
			<div class="support-form">
				<h3>Gửi Yêu Cầu Hỗ Trợ</h3>
				<form action="submitSupportRequest.jsp" method="post">
					<input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
					<div class="form-group">
						<label for="name">Tên *</label> <input type="text" id="name"
							name="name" placeholder="Nhập tên của bạn" required>
					</div>
					<div class="form-group">
						<label for="email">Email *</label> <input type="email" id="email"
							name="email" placeholder="example@example.com" required>
					</div>
					<div class="form-group">
						<label for="subject">Chủ đề *</label> <input type="text"
							id="subject" name="subject" placeholder="Nhập chủ đề" required>
					</div>
					<div class="form-group">
						<label for="message">Nội dung *</label>
						<textarea id="message" name="message"
							placeholder="Nhập nội dung câu hỏi" rows="5" required></textarea>
					</div>
					<button type="submit" class="submit-button">Gửi</button>
				</form>
			</div>
		</div>
	</section>

	<!-- Footer -->
	<%@ include file="footer.jsp"%>
</body>
</html>
