<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Chỉnh sửa thông tin xe</title>
<style>
    /* Định dạng toàn bộ trang */
    body {
        font-family: Arial, sans-serif;
        background-color: #f0f0f0;
        color: #333;
        max-width: 600px;
        margin: 20px auto;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        color: #007BFF;
    }

    /* Định dạng bảng */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    td {
        padding: 10px;
    }

    label {
        font-weight: bold;
    }

    input[type="text"], select {
        width: 100%;
        padding: 8px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    /* Định dạng nút */
    button {
        padding: 10px 20px;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-weight: bold;
    }

    button[type="submit"] {
        background-color: #28a745;
        color: #fff;
    }

    button[type="button"] {
        background-color: #dc3545;
        color: #fff;
    }

    button:hover {
        opacity: 0.9;
    }

    .button-container {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
    }
</style>
</head>
<body>
    <h2>Chỉnh sửa thông tin xe</h2>
    <form action="/22110377_HuynhMinhMan/suaThongTinXe" method="post" onsubmit="return isInputEmpty()">
        <table>
            <tr>
                <td><label for="maXeHoi">Mã xe:</label></td>
                <td><input type="text" id="maXeHoi" name="maXH" value="${xh.maXH}" required></td>
            </tr>
            <tr>
                <td><label for="thuongHieuId">Thương hiệu:</label></td>
                <td>
                    <select name="thuongHieuId" id="thuongHieuId" required>
                        <c:forEach var="th" items="${listTH}">
                            <option value="${th.thuongHieuId}" ${th.thuongHieuId == item.thuongHieu.thuongHieuId ? 'selected' : ''}>
                                ${th.tenThuongHieu}
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="giaBan">Giá bán:</label></td>
                <td><input type="text" id="giaBan" name="giaBan" value="${xh.giaBan}" required></td>
            </tr>
            <tr>
                <td><label for="namXX">Năm xuất xưởng:</label></td>
                <td><input type="text" id="namXX" name="namXX" value="${xh.namXX}" required></td>
            </tr>
        </table>

        <div class="button-container">
            <button type="submit">Lưu</button>
            <a href="/22110377_HuynhMinhMan/danhSachXH">
                <button type="button">Hủy</button>
            </a>
        </div>
    </form>

    <script type="text/javascript">
        function isInputEmpty() {
            const maXeHoi = document.getElementById('maXeHoi').value.trim();
            const giaBan = document.getElementById('giaBan').value.trim();
            const namXX = document.getElementById('namXX').value.trim();
            if (maXeHoi === "" || giaBan === "" || namXX === "") {
                alert("Không được để trống các trường thông tin!");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
