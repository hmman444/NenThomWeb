<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách thú cưng</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	background-color: #f9f9f9;
	font-family: 'Arial', sans-serif;
}

.container {
	margin-top: 50px;
	padding: 20px;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.table th {
	background-color: #007bff;
	color: #fff;
	text-align: center;
}

.table td {
	text-align: center;
	vertical-align: middle;
}

h2 {
	color: #007bff;
}

.btn-primary {
	background-color: #007bff;
	border: none;
}

.btn-primary:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<h2 class="text-center">Danh sách thú cưng</h2>
		<table class="table table-bordered table-hover mt-4">
			<thead>
				<tr>
					<th>ID</th>
					<th>Mã thú cưng</th>
					<th>Tên thú cưng</th>
					<th>Tuổi</th>
					<th>Công việc chăm sóc</th>
					<th>Ghi chú</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="item" items="${list}">
					<tr>
						<td>${item.id}</td>
						<td>${item.petCode}</td>
						<td>${item.petName}</td>
						<td>${item.age}</td>
						<td>${item.careTask}</td>
						<td>${item.notes}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<button type="button" class="btn btn-primary" data-bs-toggle="modal"
			data-bs-target="#addPetModal">Thêm thú cưng</button>
	</div>

	<!-- Modal thêm thú cưng -->
	<div class="modal fade" id="addPetModal" tabindex="-1"
		aria-labelledby="addPetModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="addPetModalLabel">Thêm thú cưng
						mới</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form action="/22110377_MinhMan/addPet" method="post">
						<div class="mb-3">
							<label for="petCode" class="form-label">Mã thú cưng</label> <input
								type="text" class="form-control" id="petCode" name="petCode"
								required>
						</div>
						<div class="mb-3">
							<label for="petName" class="form-label">Tên thú cưng</label> <input
								type="text" class="form-control" id="petName" name="petName"
								required>
						</div>
						<div class="mb-3">
							<label for="age" class="form-label">Tuổi</label> <input
								type="number" class="form-control" id="age" name="age" required>
						</div>
						<div class="mb-3">
							<label for="careTask" class="form-label">Công việc chăm
								sóc</label> <input type="text" class="form-control" id="careTask"
								name="careTask">
						</div>
						<div class="mb-3">
							<label for="notes" class="form-label">Ghi chú</label>
							<textarea class="form-control" id="notes" name="notes" rows="3"></textarea>
						</div>
						<button type="submit" class="btn btn-primary w-100">Lưu</button>
					</form>
				</div>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
