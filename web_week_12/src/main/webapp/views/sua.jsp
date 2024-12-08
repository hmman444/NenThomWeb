<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="/laptrinh/sua" method="post" onsubmit="return isInputEmpty()">
		<label>Mã xe</label>
		<input type="text" id="maXeHoi" name="maXH" value="${item.maXH}"><br>
		<label>Thương hiệu</label>
		<select name="thuongHieuId">
			<c:forEach var="th" items="${list}">
				<option value="${th.thuongHieuId}"  ${th.thuongHieuId == item.thuongHieu.thuongHieuId ? 'selected' : ''}>${th.tenThuongHieu}</option>
			</c:forEach>
		</select><br>
		<label>Giá bán</label>
		<input type="text" id="giaBan" name="giaBan" value="${item.giaBan}"><br>
		<label>Năm xuất xưởng</label>
		<input type="text" id="namXX" name="namXX" value="${item.namXX}"><br>
		<button type="submit">Save</button>
	</form>
	<a href="/laptrinh/ds">
		<button>Hủy</button>
	</a>
	<script type="text/javascript">
		function isInputEmpty() {
		    const maXeHoi = document.getElementById('maXeHoi').value.trim();
		    const giaBan = document.getElementById('giaBan').value.trim();
		    const namXX = document.getElementById('namXX').value.trim();
		    if( maXeHoi === "" || giaBan===""|| namXX===""){
		    	alert("Không để rỗng input!");
		    	return false;
		    }
		    return true;
		}	
	</script>
</body>
</html>