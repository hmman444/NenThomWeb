<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Môn Học</title>
</head>
<body>
    <h2 style="text-align: center;">Danh Sách Môn Học</h2>

    <!-- Dropdown chọn Tên Môn Học -->
    <form id="filterForm" action="FilterController" method="GET">
        <div class="mb-3">
            <label for="maMH" class="form-label">Chọn Tên Môn Học:</label>
            <select class="form-control" id="maMH" name="maMH" required onchange="document.getElementById('filterForm').submit();">
                <option value="">Tất cả</option>
                <c:forEach var="mh" items="${ListTenMH}">
                    <option value="${mh.maMH}" ${param.maMH == mh.maMH ? 'selected' : ''}>${mh.tenMH}</option>
                </c:forEach>
            </select>
        </div>
    </form>

    <!-- Bảng hiển thị thông tin Môn Học -->
    <table border="1" cellspacing="0" cellpadding="5" style="width: 100%; margin-top: 10px;">
        <tr>
            <th>STT</th>
            <th>Mã Môn Học</th>
            <th>Tên Môn Học</th>
            <th>Khoa Phụ Trách</th>
            <th>Số Tín Chỉ</th>
            <th>Action</th>
        </tr>
        <c:forEach var="mh" items="${ListMH}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${mh.maMH}</td>
                <td>${mh.tenMH}</td>
                <td>${mh.tenKhoa}</td>
                <td>${mh.soTC}</td>
                <td><a href="EditController?maMH=${mh.maMH}">Sửa</a> /
                    <a href="javascript:void(0);" onclick="confirmDelete('${mh.maMH}');">Xóa</a></td>
            </tr>
        </c:forEach>
    </table>

    <script>
        // Lắng nghe sự kiện thay đổi trên dropdown
        document.getElementById("maMH").addEventListener("change", function() {
            const maMH = this.value;
            if (maMH !== "") {
                window.location.href = `FilterController?maMH=${maMH}`;
            } else {
                window.location.href = "MonHocController";
            }
        });

        // Hàm xác nhận xóa
        function confirmDelete(maMH) {
            if (confirm("Bạn chắc chắn muốn xóa môn học này?")) {
                const form = document.createElement('form');
                form.method = 'POST';
                form.action = 'DeleteController';

                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'maMH';
                input.value = maMH;

                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }
    </script>
</body>
</html>
