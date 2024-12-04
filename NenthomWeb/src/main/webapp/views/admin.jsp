<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../css/styles_admin.css"> <!-- Link đến file CSS -->
</head>
<body class="bg-gray-100">
    <div class="flex">
        <!-- Sidebar -->
        <div id="sidebar" class="sidebar">
            <div class="sidebar-header">
                <button onclick="toggleSidebar()" class="sidebar-toggle-button">
                    <i class="fas fa-bars"></i>
                </button>
                <h1 id="dashboardText" class="sidebar-title">Dashboard</h1>
            </div>
            <nav class="sidebar-nav">
                <a  id="productsLink"  class="sidebar-link">
                    <i class="fas fa-box mr-2"></i>
                    <span class="nav-text">Products</span>
                </a>
                <a  id="invoicesLink"  class="sidebar-link">
                    <i class="fas fa-file-invoice mr-2"></i>
                    <span class="nav-text">Invoices</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div id="productsSection" class="main-content">
            <!-- Products Section -->
            <div class="products-header">
                <h2 class="products-title">Products</h2>
                <button onclick="showAddModal()" class="add-product-button">
                    <i class="fas fa-plus mr-2"></i>Add Product
                </button>
            </div>

            <!-- Product Grid -->
            <div class="product-grid">
			    <c:forEach var="product" items="${products}">
			        <div class="product-card">
			            <img src="data:image/jpeg;base64,${product.imageBase64}" alt="Product" class="product-image">
			            <h3 class="product-name">${product.name}</h3>
			            <p class="product-description">${product.description}</p>
			            <div class="product-footer">
			                <span class="product-price">$${product.price}</span>
			                <span class="product-stock">Stock: ${product.stock}</span>  <!-- Hiển thị số lượng sản phẩm -->
			                <div class="product-actions">
			                    <button onclick="showEditModal(this)" class="edit-button"><i class="fas fa-edit"></i></button>
			                    <form action="/NenthomWeb/servlets/DeleteProduct_Servlet" method="POST" onsubmit="return confirm('Are you sure you want to delete this product?');">
				                    <input type="hidden" name="productName" value="${product.name}" />
				                    <button type="submit" class="delete-button">
				                        <i class="fas fa-trash"></i>
				                    </button>
				                </form>
			                </div>
			            </div>
			        </div>
			    </c:forEach>
			</div>

            <!-- Add Product Modal -->
            <div id="addModal" class="modal hidden">
                <div class="modal-content" style="max-height: 90%; overflow-y: auto;">
                    <div class="modal-header">
                        <h3 class="modal-title">Add New Product</h3>
                        <button onclick="hideAddModal()" class="close-button">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <form class="modal-form" action="/NenthomWeb/servlets/AddProduct_Servlet" method="POST">
                        <div class="form-group">
			                <label class="form-label">Product Name</label>
			                <input type="text" class="form-input" name="name" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Price</label>
			                <input type="number" class="form-input" name="price" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Description</label>
			                <textarea class="form-input" name="description" required></textarea>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Stock</label>
			                <input type="number" class="form-input" name="stock" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Image</label>
			                <input type="file" class="form-input" name="image" accept="image/*" required>
			            </div>
			            <button type="submit" class="submit-button">Add Product</button>
                    </form>
                </div>
            </div>

            <!-- Edit Product Modal -->
			<div id="editModal" class="modal hidden">
			    <div class="modal-content" style="max-height: 90%; overflow-y: auto;">
			        <div class="modal-header">
			            <h3 class="modal-title">Edit Product</h3>
			            <button onclick="hideEditModal()" class="close-button">
			                <i class="fas fa-times"></i>
			            </button>
			        </div>
			        <form id="editProductForm" class="modal-form" action="/NenthomWeb/servlets/EditProduct_Servlet" method="POST" >
			            <input type="hidden" name="productName" id="editProductName">
			            <div class="form-group">
			                <label class="form-label">Product Name</label>
			                <input type="text" class="form-input" name="name" id="editProductNameField" placeholder="Enter product name" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Price</label>
			                <input type="number" class="form-input" name="price" id="editPrice" placeholder="Enter product price" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Description</label>
			                <textarea class="form-input" name="description" id="editDescription" placeholder="Enter product description" required></textarea>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Stock</label>
			                <input type="number" class="form-input" name="stock" id="editStock" placeholder="Enter product stock" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Image</label>
			                <input type="file" class="form-input" name="image" id="editImage" accept="image/*" onchange="previewEditImage(event)">
			                <img id="editCurrentImage" src="" alt="Current Product Image" class="w-full h-32 object-cover rounded-lg mb-2">
			            </div>
			            <button type="submit" class="submit-button">Update Product</button>
			        </form>
			    </div>
			</div>

        </div>
        <!-- Invoices Section (Hiện ra khi nhấn vào "Invoices" trong Sidebar) -->
		<div id="invoicesSection" class="invoices-section main-content hidden">
		    <h2 class="products-title">Invoices</h2>
		    <table class="table-auto w-full text-left border-collapse">
		        <thead>
		            <tr>
		                <th class="px-4 py-2">Order ID</th>
		                <th class="px-4 py-2">User ID</th>
		                <th class="px-4 py-2">Total Price</th>
		                <th class="px-4 py-2">Order Status</th>
		                <th class="px-4 py-2">Shipping Address</th>
		                <th class="px-4 py-2">Create At</th>
		                <th class="px-4 py-2">Actions</th> <!-- Thêm cột Actions -->
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="order" items="${orders}">
		                <tr>
		                    <td class="border px-4 py-2">${order.orderID}</td>
		                    <td class="border px-4 py-2">${order.userID}</td>
		                    <td class="border px-4 py-2">${order.totalPrice}</td>
		                    <td class="border px-4 py-2">${order.orderStatus}</td>
		                    <td class="border px-4 py-2">${order.shippingAddress}</td>
		                    <td class="border px-4 py-2">${order.createdAt}</td>
		                    <td class="border px-4 py-2">
		                        <button onclick="viewOrderDetails(${order.orderID})" class="text-blue-500 hover:underline">View Details</button>
		                    </td>
		                </tr>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
        
    </div>

    <script>
	    function viewOrderDetails(orderID) {
	        // Gửi yêu cầu AJAX hoặc chuyển hướng đến trang chi tiết của đơn hàng
	        window.location.href = "/NenthomWeb/servlets/OrderDetails_Servlet?orderID=" + orderID;
	    }
	    document.getElementById("productsLink").addEventListener("click", function(event) {
	    	event.preventDefault();
	    	document.getElementById("invoicesSection").classList.add("hidden");
	        document.getElementById("productsSection").classList.remove("hidden");
	        
	        //window.location.href = "/NenthomWeb/servlets/DSProduct_Servlet?page=admin";
	    });

	    document.getElementById("invoicesLink").addEventListener("click", function(event) {
	    	event.preventDefault();
	    	document.getElementById("productsSection").classList.add("hidden");
	        document.getElementById("invoicesSection").classList.remove("hidden");
	        
	        //window.location.href = "/NenthomWeb/servlets/DSOrder_Servlet";
	    });


	 	// Chuyển đổi file ảnh thành chuỗi Base64
	    document.getElementById("editProductForm").addEventListener("submit", function (event) {
		    event.preventDefault(); // Dừng hành động mặc định của form
		
		    const fileInput = document.getElementById("editImage"); // Trường nhập file
		    const file = fileInput.files[0]; // Lấy file đã chọn
		
		    if (file) {
		        const reader = new FileReader();
		        reader.onload = function (e) {
		            const base64Image = e.target.result.split(",")[1]; // Lấy phần Base64 từ DataURL
		            const hiddenInput = document.createElement("input"); // Tạo input ẩn để lưu Base64
		            hiddenInput.type = "hidden";
		            hiddenInput.name = "imageBase64";
		            hiddenInput.value = base64Image;
		
		            // Thêm input ẩn vào form
		            document.getElementById("editProductForm").appendChild(hiddenInput);
		
		            // Gửi form sau khi xử lý xong
		            document.getElementById("editProductForm").submit();
		        };
		        reader.readAsDataURL(file); // Đọc file dưới dạng Base64
		    } else {
		        // Gửi form nếu không có file mới
		        document.getElementById("editProductForm").submit();
		    }
		});

        function toggleSidebar() {
            const sidebar = document.getElementById("sidebar");
            const dashboardText = document.getElementById("dashboardText");
            const navTexts = document.querySelectorAll(".nav-text");
            const toggleButton = document.querySelector(".fa-bars").parentElement;
            
            sidebar.classList.toggle("w-16");
            sidebar.classList.toggle("w-1/4");
            toggleButton.classList.toggle("rotate-180");
            
            if (sidebar.classList.contains("w-16")) {
                dashboardText.style.opacity = "0";
                dashboardText.style.transform = "translateX(-20px)";
                navTexts.forEach(text => {
                    text.style.opacity = "0";
                    text.style.transform = "translateX(-20px)";
                    setTimeout(() => {
                        text.style.display = "none";
                    }, 300);
                });
            } else {
                dashboardText.style.opacity = "1";
                dashboardText.style.transform = "translateX(0)";
                navTexts.forEach(text => {
                    text.style.display = "inline";
                    setTimeout(() => {
                        text.style.opacity = "1";
                        text.style.transform = "translateX(0)";
                    }, 50);
                });
            }
        }

        function showAddModal() {
            document.getElementById("addModal").classList.remove("hidden");
        }

        function hideAddModal() {
            document.getElementById("addModal").classList.add("hidden");
        }

        function showEditModal(button) {
            const productCard = button.closest(".product-card"); // Tìm thẻ div chứa sản phẩm
            const productName = productCard.querySelector(".product-name").textContent; // Lấy tên sản phẩm
            const price = productCard.querySelector(".product-price").textContent.replace('$', ''); // Lấy giá sản phẩm
            let priceInt = parseInt(price, 10);
            const description = productCard.querySelector(".product-description").textContent; // Lấy mô tả sản phẩm
            const stock = productCard.querySelector(".product-stock").textContent.replace('Stock: ', ''); // Lấy số lượng sản phẩm
            const currentImage = productCard.querySelector(".product-image").src; // Lấy ảnh sản phẩm

            // Điền thông tin vào form sửa
            document.getElementById("editProductNameField").value = productName;
            document.getElementById("editPrice").value = priceInt;
            document.getElementById("editDescription").value = description;
            document.getElementById("editStock").value = stock;
            document.getElementById("editCurrentImage").src = currentImage; // Cập nhật ảnh xem trước

            // Điền tên sản phẩm vào hidden field (chắc chắn khi submit, tên sản phẩm sẽ được gửi lên)
            document.getElementById("editProductName").value = productName;

            // Hiển thị modal sửa
            document.getElementById("editModal").classList.remove("hidden");
        }

        function previewEditImage(event) {
            const file = event.target.files[0]; // Lấy file ảnh từ input
            const preview = document.getElementById("editCurrentImage"); // Lấy thẻ img để hiển thị ảnh

            if (file) {
                const reader = new FileReader(); // Tạo đối tượng FileReader để đọc file
                reader.onload = function (e) {
                    preview.src = e.target.result; // Gán ảnh xem trước vào thẻ img
                };
                reader.readAsDataURL(file); // Đọc file dưới dạng DataURL (Base64)
            } else {
                preview.src = ""; // Nếu không chọn file, xóa ảnh xem trước
            }
        }


        function hideEditModal() {
            document.getElementById("editModal").classList.add("hidden");
        }
        document.getElementById("editProductForm").addEventListener("submit", function(event) {
            event.preventDefault(); // Ngừng hành động mặc định của form

            // Lấy các giá trị trong form
            const updatedName = document.getElementById("editProductName").value;
            const updatedPrice = document.getElementById("editPrice").value;
            const updatedDescription = document.getElementById("editDescription").value;
            const updatedImage = document.getElementById("editImage").files[0]; // Lấy ảnh mới (nếu có)

            // Xử lý việc cập nhật sản phẩm (Bạn có thể gửi dữ liệu này qua AJAX hoặc API nếu cần)
            console.log("Updated Product:", updatedName, updatedPrice, updatedDescription, updatedImage);

            // Ẩn modal sau khi sửa xong
            hideEditModal();
        });
    </script>
</body>
</html>
