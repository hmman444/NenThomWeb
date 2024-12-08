<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	table, td,th {
		border: solid 1px black;
	}
</style>
</head>
<body>
	<form action="/laptrinh/ds" method="get" id="loc">
		<select name="locid" onchange="submitForm()">
			<option value="Tất cả" >Tất cả</option>
			<c:forEach var="th" items="${thuongHieu}">
				<option value="${th.thuongHieuId}" ${th.thuongHieuId == kq ? 'selected' : ''}>${th.tenThuongHieu}</option>
			</c:forEach>
		</select><br>
	</form>
	<table>
		<thead>
			<tr>
				<th>stt</th>
				<th>Mã xe</th>
				<th>Thương hiệu</th>
				<th>Giá bán</th>
				<th>Năm xuất xưởng</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${list}" >
				<tr>
					<td>1</td>
					<td>${item.maXH}</td>
					<td>${item.thuongHieu.tenThuongHieu}</td>
					<td>${item.giaBan}</td>
					<td>${item.namXX}</td>
					<td><a href="/laptrinh/sua?maXH=${item.maXH}">sua</a>/<a href="/laptrinh/xoa?maXH=${item.maXH}" onclick="return deleteConf()">xoa</a></td>
				</tr>
			</c:forEach>		
		</tbody>
	</table>
	<script type="text/javascript">
		function deleteConf(){
			return confirm("bạn có chắc xóa");
		}	
		function submitForm() {
	        document.getElementById("loc").submit();
	    }
	</script>
</body>
</html>