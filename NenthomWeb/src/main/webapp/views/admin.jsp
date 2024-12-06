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
                <h1 id="dashboardText" class="sidebar-title">Management</h1>
            </div>
            <nav class="sidebar-nav">
                <a  id="productsLink"  class="sidebar-link">
                    <i class="fas fa-boxes mr-2"></i>
                    <span class="nav-text">Products</span>
                </a>
                <a  id="invoicesLink"  class="sidebar-link">
                    <i class="fas fa-file-invoice-dollar mr-2"></i>
                    <span class="nav-text">Invoices</span>
                </a>
                <a  id="discountsLink"  class="sidebar-link">
                    <i class="fas fa-tag mr-2"></i>
                    <span class="nav-text">Discounts</span>
                </a>
                <a  id="categoriesLink"  class="sidebar-link">
                    <i class="fas fa-th-large mr-2"></i>
                    <span class="nav-text">Categories</span>
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
				                <button onclick="showCategoryModal(${product.productID})" class="delete-button">
		                            <i class="fas fa-plus-circle"></i>
		                        </button>
			                </div>
			            </div>
			        </div>
			    </c:forEach>
			</div>
			<!-- Modal Chọn danh mục -->
			<div id="categoryModal" class="modal hidden">
			    <div class="modal-content" style="background-color: #fff; border-radius: 12px; padding: 20px; width: 60%; max-width: 800px; box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);">
			        <div class="modal-header" style="display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px;">
			            <h3 class="modal-title" style="font-size: 1.5rem; font-weight: 600;">Assign Categories to Product</h3>
			            <button onclick="hideCategoryModal()" class="close-button" style="background: none; border: none; font-size: 1.5rem; color: #888;">
			                <i class="fas fa-times"></i>
			            </button>
			        </div>
			
			        <!-- Form chọn danh mục -->
			        <form id="categoryForm" action="/NenthomWeb/servlets/SaveCategory_Servlet" method="POST" style="display: flex; flex-direction: column; gap: 15px;">
			            <input type="hidden" id="productID" name="productID">
			
			            <!-- Hai cột danh mục: Danh mục đã chọn và danh mục chưa chọn -->
			            <div style="display: flex; justify-content: space-between; gap: 20px;">
			                <!-- Danh sách danh mục chưa liên kết -->
			                <div style="flex: 1;">
			                    <label for="availableCategories" class="form-label" style="font-size: 1rem; font-weight: 500;">Available Categories</label>
			                    <select id="availableCategories" name="availableCategories[]" multiple class="form-input" style="padding: 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 1rem; min-height: 150px;">
			                        <c:forEach var="category" items="${categoriesNotLinked}">
			                            <option value="${category.categoryID}">${category.name}</option>
			                        </c:forEach>
			                    </select>
			                </div>
			
			                <!-- Các nút chuyển giữa hai danh sách -->
			                <div style="display: flex; flex-direction: column; justify-content: center; align-items: center; gap: 10px;">
			                    <button type="button" id="addCategory" class="move-button" onclick="moveCategory('availableCategories', 'selectedCategories')">
			                        <i class="fas fa-arrow-right"></i>
			                    </button>
			                    <button type="button" id="removeCategory" class="move-button" onclick="moveCategory('selectedCategories', 'availableCategories')">
			                        <i class="fas fa-arrow-left"></i>
			                    </button>
			                </div>
			
			                <!-- Danh sách danh mục đã liên kết -->
			                <div style="flex: 1;">
			                    <label for="selectedCategories" class="form-label" style="font-size: 1rem; font-weight: 500;">Selected Categories</label>
			                    <select id="selectedCategories" name="categoryIDs[]" multiple class="form-input" style="padding: 10px; border-radius: 6px; border: 1px solid #ccc; font-size: 1rem; min-height: 150px;">
			                        <c:forEach var="category" items="${categoriesLinked}">
			                            <option value="${category.categoryID}">${category.name}</option>
			                        </c:forEach>
			                    </select>
			                </div>
			            </div>
			
			            <!-- Nút Save -->
			            <button type="submit" class="submit-button" style="align-self: flex-end; padding: 8px 16px; font-size: 1rem; border-radius: 8px; color: white; background-color: #8b5e3c; border: none; cursor: pointer;">
			                Save Categories
			            </button>
			        </form>
			    </div>
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
		                </tr>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
		<div id="categoriesSection" class="categories-section main-content hidden">
		    <div class="products-header">
		        <h2 class="products-title">Categories</h2>
		        <button onclick="showAddCategoryModal()" class="add-product-button">
		            <i class="fas fa-plus mr-2"></i>Add Category
		        </button>
		    </div>
		    <table class="table-auto w-full text-left border-collapse">
		        <thead>
		            <tr>
		                <th class="px-4 py-2">Category ID</th>
		                <th class="px-4 py-2">Name</th>
		                <th class="px-4 py-2">Description</th>
		                <th class="px-4 py-2">Actions</th> <!-- Thêm cột Actions -->
		            </tr>
		        </thead>
		        <tbody>
		            <c:forEach var="categorie" items="${categories}">
		                <tr>
		                    <td class="border px-4 py-2">${categorie.categoryID}</td>
		                    <td class="border px-4 py-2">${categorie.name}</td>
		                    <td class="border px-4 py-2">${categorie.description}</td>
		                    <td class="border px-4 py-2">
		                            <button 
					                    class="text-blue-500 hover:underline edit-btn" 
					                    data-id="${categorie.categoryID}" 
					                    data-name="${categorie.name}" 
					                    data-type="${categorie.description}" >
					                    Edit
					                </button>
		                            <form action="/NenthomWeb/servlets/DeleteCategory_Servlet" method="POST" onsubmit="return confirm('Are you sure you want to delete this category?');">
		                                <input type="hidden" name="categoryID" value="${categorie.categoryID}" />
		                                <button type="submit" class="text-red-500 hover:underline">
		                                    Delete
		                                </button>
		                            </form>
		                        </td>
		                </tr>
		            </c:forEach>
		        </tbody>
		    </table>
		</div>
		<!-- Modal chỉnh sửa Category -->
		<div id="editCategoryModal" class="modal hidden">
		    <div class="modal-content">
		        <div class="modal-header">
		            <h3 class="modal-title">Edit Category</h3>
		            <button onclick="hideEditCategoryModal()" class="close-button">
		                <i class="fas fa-times"></i>
		            </button>
		        </div>
		        <form class="modal-form" action="/NenthomWeb/servlets/EditCategory_Servlet" method="POST">
		            <input type="hidden" name="categoryID" id="editCategoryID"> <!-- Hidden input để lưu ID -->
		            <div class="form-group">
		                <label class="form-label">Category Name</label>
		                <input type="text" class="form-input" name="name" id="editCategoryName" required>
		            </div>
		            <div class="form-group">
		                <label class="form-label">Category Description</label>
		                <textarea class="form-input" name="description" id="editCategoryDescription" required></textarea>
		            </div>
		            <button type="submit" class="submit-button">Save Changes</button>
		        </form>
		    </div>
		</div>
		<!-- Add Category Modal -->
		<div id="addCategoryModal" class="modal hidden">
		    <div class="modal-content">
		        <div class="modal-header">
			            <h3 class="modal-title">Add New Category</h3>
			            <button onclick="hideAddCategoryModal()" class="close-button">
			                <i class="fas fa-times"></i>
			            </button>
			        </div>
		        
		        <!-- Form thêm danh mục -->
		        <form class="modal-form" action="/NenthomWeb/servlets/AddCategory_Servlet" method="POST">
			            <div class="form-group">
			                <label class="form-label">Category Name</label>
			                <input type="text" class="form-input" name="name" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Description</label>
			                <input type="text" class="form-input" name="description" required>
			            </div>
			            <button type="submit" class="submit-button">Add Category</button>
			        </form>
		    </div>
		</div>

	
        <!-- Discounts Section -->
		<div id="discountsSection" class="discounts-section main-content hidden">
		    <div class="products-header">
		        <h2 class="products-title">Discounts</h2>
		        <button onclick="showAddDiscountModal()" class="add-product-button">
		            <i class="fas fa-plus mr-2"></i>Add Discount
		        </button>
		    </div>
		
		    <!-- Discounts Table -->
		    <div class="discounts-table">
		        <table class="table-auto w-full text-left border-collapse">
		            <thead>
		                <tr>
		                	<th class="px-4 py-2">Discount ID</th>
		                    <th class="px-4 py-2">Discount Name</th>
		                    <th class="px-4 py-2">Discount Type</th>
		                    <th class="px-4 py-2">Value</th>
		                    <th class="px-4 py-2">Start Date</th>
		                    <th class="px-4 py-2">End Date</th>
		                    <th class="px-4 py-2">Actions</th>
		                </tr>
		            </thead>
		            <tbody>
		                <c:forEach var="discount" items="${discounts}">
		                    <tr>
		                    	<td class="border px-4 py-2">${discount.discountID}</td>
		                        <td class="border px-4 py-2">${discount.discountName}</td>
		                        <td class="border px-4 py-2">${discount.discountType}</td>
		                        <td class="border px-4 py-2">${discount.discountValue}</td>
		                        <td class="border px-4 py-2">${discount.startDate}</td>
		                        <td class="border px-4 py-2">${discount.endDate}</td>
		                        <td class="border px-4 py-2">
		                            <button 
					                    class="text-blue-500 hover:underline edit-btn" 
					                    data-id="${discount.discountID}" 
					                    data-name="${discount.discountName}" 
					                    data-type="${discount.discountType}" 
					                    data-value="${discount.discountValue}" 
					                    data-start="${discount.startDate}" 
					                    data-end="${discount.endDate}">
					                    Edit
					                </button>
		                            <form action="/NenthomWeb/servlets/DeleteDiscount_Servlet" method="POST" onsubmit="return confirm('Are you sure you want to delete this discount?');">
		                                <input type="hidden" name="discountID" value="${discount.discountID}" />
		                                <button type="submit" class="text-red-500 hover:underline">
		                                    Delete
		                                </button>
		                            </form>
		                        </td>
		                    </tr>
		                </c:forEach>
		            </tbody>
		        </table>
		    </div>
		    <!-- Add Discount Modal -->
			<div id="addDiscountModal" class="modal hidden">
			    <div class="modal-content">
			        <div class="modal-header">
			            <h3 class="modal-title">Add New Discount</h3>
			            <button onclick="hideAddDiscountModal()" class="close-button">
			                <i class="fas fa-times"></i>
			            </button>
			        </div>
			        <form class="modal-form" action="/NenthomWeb/servlets/AddDiscount_Servlet" method="POST">
			            <div class="form-group">
			                <label class="form-label">Discount Name</label>
			                <input type="text" class="form-input" name="discountName" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Discount Type</label>
			                <select class="form-input" name="discountType" required>
			                    <option value="percentage">Percentage</option>
			                    <option value="fixed">Fixed Amount</option>
			                </select>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Discount Value</label>
			                <input type="number" class="form-input" name="discountValue" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Start Date</label>
			                <input type="date" class="form-input" name="startDate" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">End Date</label>
			                <input type="date" class="form-input" name="endDate" required>
			            </div>
			            <button type="submit" class="submit-button">Add Discount</button>
			        </form>
			    </div>
			</div>
			<!-- Edit Discount Modal -->
			<div id="editDiscountModal" class="modal hidden">
			    <div class="modal-content">
			        <div class="modal-header">
			            <h3 class="modal-title">Edit Discount</h3>
			            <button onclick="hideEditDiscountModal()" class="close-button">
			                <i class="fas fa-times"></i>
			            </button>
			        </div>
			        <form class="modal-form" action="/NenthomWeb/servlets/UpdateDiscount_Servlet" method="POST">
			            <div class="form-group">
			                <label class="form-label">Discount ID</label>
			                <input type="text" class="form-input" name="discountID" id="editDiscountID" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Discount Name</label>
			                <input type="text" class="form-input" name="discountName" id="editDiscountName" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Discount Type</label>
			                <select class="form-input" name="discountType" id="editDiscountType" required>
			                    <option value="percentage">Percentage</option>
			                    <option value="fixed">Fixed Amount</option>
			                </select>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Discount Value</label>
			                <input type="number" class="form-input" name="discountValue" id="editDiscountValue" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">Start Date</label>
			                <input type="date" class="form-input" name="startDate" id="editStartDate" required>
			            </div>
			            <div class="form-group">
			                <label class="form-label">End Date</label>
			                <input type="date" class="form-input" name="endDate" id="editEndDate" required>
			            </div>
			            <button type="submit" class="submit-button">Update Discount</button>
			        </form>
			    </div>
			</div>
			
					    
		</div>
    </div>



    <script>
	    function moveCategory(fromId, toId) {
	        const fromList = document.getElementById(fromId);
	        const toList = document.getElementById(toId);
	
	        // Lấy danh mục được chọn từ list nguồn
	        const selectedOptions = Array.from(fromList.selectedOptions);
	        
	        selectedOptions.forEach(option => {
	            // Thêm vào list đích
	            toList.appendChild(option);
	        });
	    }
		function showCategoryModal(productID) {
		    document.getElementById('productID').value = productID; // Gán ProductID cho form
		    document.getElementById('categoryModal').classList.remove('hidden');
		}
		
		// Ẩn modal
		function hideCategoryModal() {
		    document.getElementById('categoryModal').classList.add('hidden');
		}
	
	    function showAddCategoryModal() {
	        document.getElementById("addCategoryModal").classList.remove("hidden");
	    }
	
	    // Hide Add Category Modal
	    function hideAddCategoryModal() {
	        document.getElementById("addCategoryModal").classList.add("hidden");
	    }

	    function showEditCategoryModal(button) {
	        // Lấy thông tin từ các thuộc tính data-* trong nút Edit
	        const categoryID = button.getAttribute("data-id");
	        const categoryName = button.getAttribute("data-name");
	        const categoryDescription = button.getAttribute("data-description");
	
	        // Điền thông tin vào các trường trong modal
	        document.getElementById("editCategoryID").value = categoryID;
	        document.getElementById("editCategoryName").value = categoryName;
	        document.getElementById("editCategoryDescription").value = categoryDescription;
	
	        // Hiển thị modal
	        document.getElementById("editCategoryModal").classList.remove("hidden");
	    }
	
	    // Ẩn modal chỉnh sửa
	    function hideEditCategoryModal() {
	        document.getElementById("editCategoryModal").classList.add("hidden");
	    }
	
	    // Gắn sự kiện cho các nút Edit
	    document.querySelectorAll(".edit-btn").forEach(button => {
	        button.addEventListener("click", function() {
	            showEditCategoryModal(this);
	        });
	    });
	
	    // Hàm này giúp đóng modal khi bấm nút đóng
	    function closeModal() {
	        document.getElementById("editCategoryModal").classList.add("hidden");
	    }
	    function showAddDiscountModal() {
	        document.getElementById("addDiscountModal").classList.remove("hidden");
	    }
	
	    // Hide Add Discount Modal
	    function hideAddDiscountModal() {
	        document.getElementById("addDiscountModal").classList.add("hidden");
	    }
	
	 	// Thêm sự kiện cho nút Edit
	    document.querySelectorAll(".edit-btn").forEach(button => {
		    button.addEventListener("click", function() {
		        // Lấy thông tin từ các thuộc tính data-*
		        const discountID = this.getAttribute("data-id");
		        const discountName = this.getAttribute("data-name");
		        const discountType = this.getAttribute("data-type");
		        const discountValue = this.getAttribute("data-value");
		        const startDate = this.getAttribute("data-start");
		        const endDate = this.getAttribute("data-end");
		
		        // Điền thông tin vào modal
		        document.getElementById("editDiscountID").value = discountID;
		        document.getElementById("editDiscountName").value = discountName;
		        document.getElementById("editDiscountType").value = discountType;
		        document.getElementById("editDiscountValue").value = discountValue;
		        document.getElementById("editStartDate").value = startDate;
		        document.getElementById("editEndDate").value = endDate;
		
		        // Hiển thị modal
		        document.getElementById("editDiscountModal").classList.remove("hidden");
		    });
		});
	    // Hide Edit Discount Modal
	    function hideEditDiscountModal() {
	        document.getElementById("editDiscountModal").classList.add("hidden");
	    }

	    function viewOrderDetails(orderID) {
	        // Gửi yêu cầu AJAX hoặc chuyển hướng đến trang chi tiết của đơn hàng
	        window.location.href = "/NenthomWeb/servlets/OrderDetails_Servlet?orderID=" + orderID;
	    }
	    let currentAction = 'product'; // Biến lưu trạng thái hiện tại, mặc định là 'product'

	    // Khi người dùng click vào các tab, hiển thị phần tương ứng và cập nhật action
	    document.getElementById("productsLink").addEventListener("click", function(event) {
	        event.preventDefault();  // Ngừng hành động mặc định của thẻ <a>
	        document.getElementById("invoicesSection").style.display = 'none';
	        document.getElementById("productsSection").style.display = 'block';
	        document.getElementById("discountsSection").style.display = 'none';
	        document.getElementById("categoriesSection").style.display = 'none';
	        currentAction = 'product'; // Cập nhật trạng thái
	        setActionInURL('product'); // Gọi hàm cập nhật URL
	    });

	    document.getElementById("invoicesLink").addEventListener("click", function(event) {
	        event.preventDefault();
	        document.getElementById("invoicesSection").style.display = 'block';
	        document.getElementById("productsSection").style.display = 'none';
	        document.getElementById("discountsSection").style.display = 'none';
	        document.getElementById("categoriesSection").style.display = 'none';
	        currentAction = 'invoice'; // Cập nhật trạng thái
	        setActionInURL('invoice'); // Gọi hàm cập nhật URL
	    });

	    document.getElementById("discountsLink").addEventListener("click", function(event) {
	        event.preventDefault();
	        document.getElementById("invoicesSection").style.display = 'none';
	        document.getElementById("productsSection").style.display = 'none';
	        document.getElementById("discountsSection").style.display = 'block';
	        document.getElementById("categoriesSection").style.display = 'none';

	        currentAction = 'discount'; // Cập nhật trạng thái
	        setActionInURL('discount'); // Gọi hàm cập nhật URL
	    });
	    
	    document.getElementById("categoriesLink").addEventListener("click", function(event) {
	        event.preventDefault();
	        document.getElementById("invoicesSection").style.display = 'none';
	        document.getElementById("productsSection").style.display = 'none';
	        document.getElementById("discountsSection").style.display = 'none';
	        document.getElementById("categoriesSection").style.display = 'block';
	        
	        currentAction = 'category'; // Cập nhật trạng thái
	        setActionInURL('category'); // Gọi hàm cập nhật URL
	    });

	    // Hàm cập nhật action vào URL (giữ trạng thái khi tải lại trang)
	    function setActionInURL(action) {
	        const url = new URL(window.location.href);
	        url.searchParams.set('action', action); // Cập nhật tham số action
	        history.pushState(null, '', url.toString()); // Cập nhật URL mà không tải lại trang
	    }

	    // Khi tải trang, tự động hiển thị tab theo giá trị action trong URL
	    window.onload = function() {
	        const url = new URL(window.location.href);
	        const action = url.searchParams.get('action') || 'product'; // Mặc định là 'product' nếu không có action

	        if (action === 'discount') {
	            document.getElementById("invoicesSection").style.display = 'none';
	            document.getElementById("productsSection").style.display = 'none';
	            document.getElementById("discountsSection").style.display = 'block';
	            document.getElementById("categoriesSection").style.display = 'none';
	        } else if (action === 'invoice') {
	            document.getElementById("invoicesSection").style.display = 'block';
	            document.getElementById("productsSection").style.display = 'none';
	            document.getElementById("discountsSection").style.display = 'none';
	            document.getElementById("categoriesSection").style.display = 'none';
	        } else if (action === 'category') {
	            document.getElementById("invoicesSection").style.display = 'none';
	            document.getElementById("productsSection").style.display = 'none';
	            document.getElementById("discountsSection").style.display = 'none';
	            document.getElementById("categoriesSection").style.display = 'block';
	        } else {
	            document.getElementById("invoicesSection").style.display = 'none';
	            document.getElementById("productsSection").style.display = 'block';
	            document.getElementById("discountsSection").style.display = 'none';
	            document.getElementById("categoriesSection").style.display = 'none';
	        }
	    };


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
