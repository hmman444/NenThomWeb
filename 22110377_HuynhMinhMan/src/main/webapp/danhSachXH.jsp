<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<title>Danh sách xe hơi</title>
<style>
    /* Định dạng toàn bộ trang */
    body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        color: #333;
        max-width: 800px;
        margin: 20px auto;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    }

    h1 {
        text-align: center;
        color: #007BFF;
    }

    /* Định dạng form */
    form {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
    }

    label {
        margin-right: 10px;
        font-weight: bold;
    }

    select {
        padding: 5px;
        border-radius: 5px;
        border: 1px solid #ccc;
    }

    /* Định dạng bảng */
    table {
        width: 100%;
        border-collapse: collapse;
        background-color: #fff;
    }

    th, td {
        padding: 12px;
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #007BFF;
        color: #fff;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    /* Định dạng liên kết */
    a {
        text-decoration: none;
        color: #007BFF;
        font-weight: bold;
    }

    a:hover {
        color: #0056b3;
    }

    /* Định dạng nút */
    .action-link {
        margin: 0 5px;
    }
</style>
</head>
<body>
    <h1>Danh Sách Xe Hơi</h1>

    <form action="/22110377_HuynhMinhMan/danhSachXH" method="get" id="loc">
        <label for="locid">Chọn thương hiệu:</label>
        <select name="locid" id="locid" onchange="submitForm()">
            <option value="Tất cả">Tất cả</option>
            <c:forEach var="th" items="${thuongHieu}">
                <option value="${th.thuongHieuId}" ${th.thuongHieuId == kq ? 'selected' : ''}>
                    ${th.tenThuongHieu}
                </option>
            </c:forEach>
        </select>
    </form>

    <table>
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
                    <td>
                        <a class="action-link" href="/22110377_HuynhMinhMan/suaThongTinXe?maXH=${item.maXH}">Sửa</a> |
                        <a class="action-link" href="/22110377_HuynhMinhMan/xoa?maXH=${item.maXH}" onclick="return deleteConf()">Xóa</a>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <script>
        // Xác nhận xóa
        function deleteConf() {
            return confirm("Bạn có chắc chắn muốn xóa?");
        }

        // Tự động gửi form khi chọn thương hiệu
        function submitForm() {
            document.getElementById("loc").submit();
        }
    </script>
</body>
</html>
