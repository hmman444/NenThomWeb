<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Chỉnh sửa thông tin xe</title>
</head>
<body>
    <h2>Chỉnh sửa thông tin xe</h2>
    <form action="/laptrinh/sua" method="post" onsubmit="return isInputEmpty()">
        <table>
            <tr>
                <td><label for="maXeHoi">Mã xe:</label></td>
                <td><input type="text" id="maXeHoi" name="maXH" value="${item.maXH}" readonly></td>
            </tr>
            <tr>
                <td><label>Thương hiệu:</label></td>
                <td><strong>${item.thuongHieu.tenThuongHieu}</strong></td>
                <input type="hidden" name="thuongHieuId" value="${item.thuongHieu.thuongHieuId}">
            </tr>
            <tr>
                <td><label for="giaBan">Giá bán:</label></td>
                <td><input type="text" id="giaBan" name="giaBan" value="${item.giaBan}"></td>
            </tr>
            <tr>
                <td><label for="namXX">Năm xuất xưởng:</label></td>
                <td><input type="text" id="namXX" name="namXX" value="${item.namXX}"></td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <button type="submit">Lưu</button>
                    <a href="/laptrinh/ds">
                        <button type="button">Hủy</button>
                    </a>
                </td>
            </tr>
        </table>
    </form>

    <script type="text/javascript">
        function isInputEmpty() {
            const maXeHoi = document.getElementById('maXeHoi').value.trim();
            const giaBan = document.getElementById('giaBan').value.trim();
            const namXX = document.getElementById('namXX').value.trim();
            if (maXeHoi === "" || giaBan === "" || namXX === "") {
                alert("Vui lòng nhập đầy đủ thông tin!");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
