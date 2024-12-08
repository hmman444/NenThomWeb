<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách xe hơi</title>
<style type="text/css">
table, td, th {
	border: solid 1px black;
}
</style>
</head>
<body>
	<h1>Danh Sách Xe Hơi</h1>
	<form action="/laptrinh/ds" method="get" id="loc">
		<label for="locid">Chọn thương hiệu:</label> <select name="locid"
			id="locid" onchange="submitForm()">
			<option value="Tất cả">Tất cả</option>
			<c:forEach var="th" items="${thuongHieu}">
				<option value="${th.thuongHieuId}"
					${th.thuongHieuId == kq ? 'selected' : ''}>${th.tenThuongHieu}</option>
			</c:forEach>
		</select> <br>
		<br>
	</form>

	<table cellpadding="10" cellspacing="0">
		<thead>
			<tr>
				<th>STT</th>
				<th>Mã xe</th>
				<th>Thương hiệu</th>
				<th>Giá bán</th>
				<th>Năm xuất xưởng</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${list}" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${item.maXH}</td>
					<td>${item.thuongHieu.tenThuongHieu}</td>
					<td>${item.giaBan}</td>
					<td>${item.namXX}</td>
					<td><a href="/laptrinh/sua?maXH=${item.maXH}">Sửa</a> | <a
						href="/laptrinh/xoa?maXH=${item.maXH}"
						onclick="return deleteConf()">Xóa</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<script type="text/javascript">
		function deleteConf() {
			return confirm("Bạn có chắc chắn muốn xóa?");
		}
		function submitForm() {
			document.getElementById("loc").submit();
		}
	</script>
</body>
</html>