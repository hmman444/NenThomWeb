<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                <a href="#" class="sidebar-link">
                    <i class="fas fa-box mr-2"></i>
                    <span class="nav-text">Products</span>
                </a>
                <a href="#" class="sidebar-link">
                    <i class="fas fa-file-invoice mr-2"></i>
                    <span class="nav-text">Invoices</span>
                </a>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Products Section -->
            <div class="products-header">
                <h2 class="products-title">Products</h2>
                <button onclick="showAddModal()" class="add-product-button">
                    <i class="fas fa-plus mr-2"></i>Add Product
                </button>
            </div>

            <!-- Product Grid -->
            <div class="product-grid">
                <!-- Product Card -->
                <div class="product-card">
                    <img src="../images/anhSanPham.jpg" alt="Product" class="product-image">
                    <h3 class="product-name">Vanilla Dream</h3>
                    <p class="product-description">...</p>
                    <div class="product-footer">
                        <span class="product-price">$24.99</span>
                        <div class="product-actions">
                            <button onclick="showEditModal(this)" class="edit-button"><i class="fas fa-edit"></i></button>
                            <button class="delete-button"><i class="fas fa-trash"></i></button>
                        </div>
                    </div>
                </div>
                
                
            </div>

            <!-- Add Product Modal -->
            <div id="addModal" class="modal hidden">
                <div class="modal-content">
                    <div class="modal-header">
                        <h3 class="modal-title">Add New Product</h3>
                        <button onclick="hideAddModal()" class="close-button">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                    <form class="modal-form">
                        <div class="form-group">
                            <label class="form-label">Product Name</label>
                            <input type="text" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Price</label>
                            <input type="number" class="form-input">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Description</label>
                            <textarea class="form-input"></textarea>
                        </div>
                        <div class="form-group">
                            <label class="form-label">Image</label>
                            <input type="file" class="form-input">
                        </div>
                        <button type="submit" class="submit-button">Add Product</button>
                    </form>
                </div>
            </div>

            <!-- Edit Product Modal -->
			<div id="editModal" class="hidden fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
			    <div class="bg-white rounded-lg p-8 w-full max-w-md">
			        <div class="flex justify-between items-center mb-6">
			            <h3 class="text-xl font-bold">Edit Product</h3>
			            <button onclick="hideEditModal()" class="text-gray-500 hover:text-gray-700">
			                <i class="fas fa-times"></i>
			            </button>
			        </div>
			        <form id="editProductForm" class="space-y-4">
			            <div>
			                <label class="block text-sm font-medium text-gray-700 mb-1">Product Name</label>
			                <input type="text" id="editProductName" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-[#8b5e3c] focus:border-[#8b5e3c]">
			            </div>
			            <div>
			                <label class="block text-sm font-medium text-gray-700 mb-1">Price</label>
			                <input type="number" id="editPrice" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-[#8b5e3c] focus:border-[#8b5e3c]">
			            </div>
			            <div>
			                <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
			                <textarea id="editDescription" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-[#8b5e3c] focus:border-[#8b5e3c]"></textarea>
			            </div>
			            <div>
			                <label class="block text-sm font-medium text-gray-700 mb-1">Current Image</label>
			                <img id="editCurrentImage" src="" alt="Current Product" class="w-full h-32 object-cover rounded-lg mb-2">
			                <label class="block text-sm font-medium text-gray-700 mb-1">Change Image</label>
			                <input type="file" id="editImage" class="w-full p-2 border rounded-lg focus:ring-2 focus:ring-[#8b5e3c] focus:border-[#8b5e3c]">
			            </div>
			            <button type="submit" class="w-full bg-[#8b5e3c] text-white py-2 rounded-lg hover:bg-[#a47851] transition duration-300">Update Product</button>
			        </form>
			    </div>
			</div>
			            
        </div>
    </div>

    <script>
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
            const productName = productCard.querySelector("h3").textContent; // Lấy tên sản phẩm
            const price = productCard.querySelector("span").textContent.replace("$", ""); // Lấy giá sản phẩm
            const description = productCard.querySelector("p").textContent; // Lấy mô tả sản phẩm
            const imageUrl = productCard.querySelector("img").src; // Lấy hình ảnh sản phẩm

            // Điền thông tin vào form sửa
            document.getElementById("editProductName").value = productName;
            document.getElementById("editPrice").value = price;
            document.getElementById("editDescription").value = description;
            document.getElementById("editCurrentImage").src = imageUrl; // Hiển thị ảnh hiện tại

            // Hiển thị modal sửa
            document.getElementById("editModal").classList.remove("hidden");
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
