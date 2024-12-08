<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thêm Môn Học</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
</head>
<body>
    <div class="container mt-4">
        <!-- Tiêu đề Form -->
        <h2 class="text-center">Thêm Môn Học</h2>

        <!-- Form Thêm Môn Học -->
        <form action="AddController" method="post">
            <!-- Mã Môn Học -->
            <div class="mb-3">
                <label for="maMH" class="form-label">Mã Môn Học</label>
                <input type="text" class="form-control" id="maMH" name="maMH" required>
            </div>

            <!-- Tên Môn Học -->
            <div class="mb-3">
                <label for="tenMH" class="form-label">Tên Môn Học</label>
                <input type="text" class="form-control" id="tenMH" name="tenMH" required>
            </div>

            <!-- Khoa Phụ Trách -->
            <div class="mb-3">
                <label for="maKhoa" class="form-label">Khoa Phụ Trách</label>
                <select class="form-control" id="maKhoa" name="maKhoa" required>
                    <option value="">Chọn Khoa</option>
                    <c:forEach var="khoa" items="${listKhoa}">
                        <option value="${khoa.maKhoa}">${khoa.tenKhoa}</option>
                    </c:forEach>
                </select>
            </div>

            <!-- Số Tín Chỉ -->
            <div class="mb-3">
                <label for="soTC" class="form-label">Số Tín Chỉ</label>
                <input type="number" class="form-control" id="soTC" name="soTC" required>
            </div>

            <!-- Nút Thêm -->
            <button type="submit" class="btn btn-primary">Thêm Môn Học</button>
        </form>
    </div>
</body>
</html>
