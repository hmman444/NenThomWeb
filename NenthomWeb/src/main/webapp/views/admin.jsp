<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Management Dashboard</title>
	<link rel="stylesheet" href="<c:url value='/css/all.min.css'/>">
	<script src="https://cdn.tailwindcss.com"></script>
	<%-- <link rel="stylesheet" href="<c:url value='/css/tailwindcss.css'/>"> --%>
    <link rel="stylesheet" href="<c:url value='/css/styles_admin.css'/>">
</head>
<body class="bg-gray-100">
<%
    String csrfToken = (String) request.getAttribute("csrfToken");
%>

    <div class="flex">
        <!-- Sidebar -->
        <div id="sidebar" class="sidebar">
            <div class="sidebar-header">
                <button id="toggleSidebar" onclick="toggleSidebar()" class="sidebar-toggle-button">
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
                <a href="/NenthomWeb/servlets/Logout_Servlet" id="logoutLink" class="sidebar-link">
		            <i class="fas fa-sign-out-alt mr-2"></i>
		            <span class="nav-text">Logout</span>
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
						<img src="<c:url value='/images/anhSanPham.jpg' />" alt="Product" class="product-image">
						<h3 class="product-name">
							<c:out value="${product.name}"/>
						</h3>
						<p class="product-description">
							<c:out value="${product.description}"/>
						</p>
						<div class="product-footer">
							<span class="product-price">$<c:out value="${product.price}"/></span>
							<span class="product-stock">Stock: <c:out value="${product.stock}"/></span>  <!-- Hiển thị số lượng sản phẩm -->
							<div class="product-actions">
								<button onclick="showEditModal(this)" class="edit-button">
									<i class="fas fa-edit"></i>
								</button>
								<form action="/NenthomWeb/servlets/DeleteProduct_Servlet" method="POST" 
									  onsubmit="return confirm('Are you sure you want to delete this product?');">
				                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>">
									<input type="hidden" name="productName" value="<c:out value='${product.name}'/>" />
									<button type="submit" class="delete-button">
										<i class="fas fa-trash"></i>
									</button>
								</form>
								<button onclick="showCategoryModal(<c:out value='${product.productID}'/>)" class="delete-button">
									<i class="fas fa-plus-circle"></i>
								</button>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
			<!-- Modal Chọn danh mục -->
			<!-- Category Modal -->
			<div id="categoryModal" class="modal hidden">
				<div class="modal-dialog modal-dialog-centered modal-lg">
					<div class="modal-content rounded-3 shadow p-4">
						<!-- Modal Header -->
						<div class="modal-header border-bottom pb-2 mb-3">
							<h3 class="modal-title fs-4 fw-semibold">Assign Categories to Product</h3>
							<button type="button" class="btn-close" onclick="hideCategoryModal()"></button>
						</div>

						<!-- Form chọn danh mục -->
						<form id="categoryForm" action="/NenthomWeb/servlets/SaveCategory_Servlet" method="POST" class="d-flex flex-column gap-4">
			            	<input type="hidden" name="csrfToken" value="<%= csrfToken %>">
							<input type="hidden" id="productID" name="productID" />

							<!-- Danh sách danh mục -->
							<div class="row">
								<div class="col-12">
									<label for="categories" class="form-label fw-medium">Available Categories</label>
									<select id="categories" name="categoryIDs[]" multiple class="form-select" style="min-height: 150px;">
										<c:forEach var="category" items="${categories}">
											<option value="<c:out value='${category.categoryID}'/>">
												<c:out value="${category.name}" />
											</option>
										</c:forEach>
									</select>
								</div>
							</div>

							<!-- Nút Save -->
							<div class="text-end">
								<button type="submit" class="btn text-white px-4 py-2" style="background-color: #8b5e3c;">
									Save Categories
								</button>
							</div>
						</form>
					</div>
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
                    <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
                        <div class="form-group">
			                <label class="form-label">Product Name</label>
			                <input type="text" class="form-input" name="name" required maxlength="100">
			            </div>
			            <div class="form-group">
			                <label class="form-label">Price</label>
			                <input type="number" class="form-input" name="price" required maxlength="10">
			            </div>
			            <div class="form-group">
			                <label class="form-label">Description</label>
			                <textarea class="form-input" name="description" required maxlength="1000"></textarea>
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
			        	<input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
			            <input type="hidden" name="productName" id="editProductName">
			            <div class="form-group">
			                <label class="form-label">Product Name</label>
			                <input type="text" class="form-input" name="name" id="editProductNameField" placeholder="Enter product name" disabled maxlength="100">
			            </div>
			            <div class="form-group">
			                <label class="form-label">Price</label>
			                <input type="number" class="form-input" name="price" id="editPrice" placeholder="Enter product price" required maxlength="10">
			            </div>
			            <div class="form-group">
			                <label class="form-label">Description</label>
			                <textarea class="form-input" name="description" id="editDescription" placeholder="Enter product description" required maxlength="1000"></textarea>
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
		                                <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
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
		            <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
		            <input type="hidden" name="categoryID" id="editCategoryID"> <!-- Hidden input để lưu ID -->
		            <div class="form-group">
		                <label class="form-label">Category Name</label>
		                <input type="text" class="form-input" name="name" id="editCategoryName" required maxlength="50">
		            </div>
		            <div class="form-group">
		                <label class="form-label">Category Description</label>
		                <textarea class="form-input" name="description" id="editCategoryDescription" required maxlength="1000"></textarea>
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
			            <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
			            <div class="form-group">
			                <label class="form-label">Category Name</label>
			                <input type="text" class="form-input" name="name" required maxlength="50">
			            </div>
			            <div class="form-group">
			                <label class="form-label">Description</label>
			                <input type="text" class="form-input" name="description" required maxlength="1000">
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
		                                <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
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
			            <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
			            <div class="form-group">
			                <label class="form-label">Discount Name</label>
			                <input type="text" class="form-input" name="discountName" required maxlength="255">
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
			                <input type="number" class="form-input" name="discountValue" required maxlength="10">
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
			            <input type="hidden" name="csrfToken" value="<%= csrfToken %>" />
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
			console.log(`Moving category from ${fromId} to ${toId}`);
			const fromList = document.getElementById(fromId);
			const toList = document.getElementById(toId);
			const selectedOptions = Array.from(fromList.selectedOptions);
			selectedOptions.forEach(option => {
				toList.appendChild(option);
				console.log(`Moved option: ${option.value}`);
			});
		}

		function showCategoryModal(productID) {
			console.log(`Showing category modal for product ID: ${productID}`);
			document.getElementById('productID').value = productID;
			document.getElementById('categoryModal').classList.remove('hidden');
		}

		function hideCategoryModal() {
			console.log("Hiding category modal");
			document.getElementById('categoryModal').classList.add('hidden');
		}

		function showAddCategoryModal() {
			console.log("Showing Add Category Modal");
			document.getElementById("addCategoryModal").classList.remove("hidden");
		}

		function hideAddCategoryModal() {
			console.log("Hiding Add Category Modal");
			document.getElementById("addCategoryModal").classList.add("hidden");
		}

		function showEditCategoryModal(button) {
			console.log("Showing Edit Category Modal");
			const categoryID = button.getAttribute("data-id");
			const categoryName = button.getAttribute("data-name");
			const categoryDescription = button.getAttribute("data-description");

			console.log(`Category Info: ID=${categoryID}, Name=${categoryName}, Description=${categoryDescription}`);

			document.getElementById("editCategoryID").value = categoryID;
			document.getElementById("editCategoryName").value = categoryName;
			document.getElementById("editCategoryDescription").value = categoryDescription;
			document.getElementById("editCategoryModal").classList.remove("hidden");
		}

		function hideEditCategoryModal() {
			console.log("Hiding Edit Category Modal");
			document.getElementById("editCategoryModal").classList.add("hidden");
		}

		function closeModal() {
			console.log("Closing modal");
			document.getElementById("editCategoryModal").classList.add("hidden");
		}

		function showAddDiscountModal() {
			console.log("Showing Add Discount Modal");
			document.getElementById("addDiscountModal").classList.remove("hidden");
		}

		function hideAddDiscountModal() {
			console.log("Hiding Add Discount Modal");
			document.getElementById("addDiscountModal").classList.add("hidden");
		}

		document.querySelectorAll(".edit-btn").forEach(button => {
			button.addEventListener("click", function () {
				const discountID = this.getAttribute("data-id");
				const discountName = this.getAttribute("data-name");
				const discountType = this.getAttribute("data-type");
				const discountValue = this.getAttribute("data-value");
				const startDate = this.getAttribute("data-start");
				const endDate = this.getAttribute("data-end");

				console.log(`Editing Discount ID=${discountID}, Name=${discountName}, Type=${discountType}, Value=${discountValue}, Start=${startDate}, End=${endDate}`);

				document.getElementById("editDiscountID").value = discountID;
				document.getElementById("editDiscountName").value = discountName;
				document.getElementById("editDiscountType").value = discountType;
				document.getElementById("editDiscountValue").value = discountValue;
				document.getElementById("editStartDate").value = startDate;
				document.getElementById("editEndDate").value = endDate;
				document.getElementById("editDiscountModal").classList.remove("hidden");
			});
		});

		function hideEditDiscountModal() {
			console.log("Hiding Edit Discount Modal");
			document.getElementById("editDiscountModal").classList.add("hidden");
		}

		function viewOrderDetails(orderID) {
			console.log(`Viewing order details for orderID: ${orderID}`);
			window.location.href = "/NenthomWeb/servlets/OrderDetails_Servlet?orderID=" + orderID;
		}

		// Khi người dùng click vào các tab, hiển thị phần tương ứng và cập nhật action
	    document.getElementById("productsLink").addEventListener("click", function(event) {
	        event.preventDefault();  // Ngừng hành động mặc định của thẻ <a>
	        document.getElementById("invoicesSection").style.display = 'none';
	        document.getElementById("productsSection").style.display = 'block';
	        document.getElementById("discountsSection").style.display = 'none';
	        document.getElementById("categoriesSection").style.display = 'none';
	        currentAction = 'product'; // Cập nhật trạng thái
	        setActionInURL('product'); // Gọi hàm cập nhật URL

			// Remove hidden class for id productsSection
			document.getElementById("productsSection").classList.remove("hidden");
	    });

	    document.getElementById("invoicesLink").addEventListener("click", function(event) {
	        event.preventDefault();
	        document.getElementById("invoicesSection").style.display = 'block';
	        document.getElementById("productsSection").style.display = 'none';
	        document.getElementById("discountsSection").style.display = 'none';
	        document.getElementById("categoriesSection").style.display = 'none';
	        currentAction = 'invoice'; // Cập nhật trạng thái
	        setActionInURL('invoice'); // Gọi hàm cập nhật URL

			// Remove hidden class for id invoicesSection
			document.getElementById("invoicesSection").classList.remove("hidden");
	    });

	    document.getElementById("discountsLink").addEventListener("click", function(event) {
	        event.preventDefault();
	        document.getElementById("invoicesSection").style.display = 'none';
	        document.getElementById("productsSection").style.display = 'none';
	        document.getElementById("discountsSection").style.display = 'block';
	        document.getElementById("categoriesSection").style.display = 'none';

	        currentAction = 'discount'; // Cập nhật trạng thái
	        setActionInURL('discount'); // Gọi hàm cập nhật URL

			// Remove hidden class for id discountsSection
			document.getElementById("discountsSection").classList.remove("hidden");
	    });
	    
	    document.getElementById("categoriesLink").addEventListener("click", function(event) {
	        event.preventDefault();
	        document.getElementById("invoicesSection").style.display = 'none';
	        document.getElementById("productsSection").style.display = 'none';
	        document.getElementById("discountsSection").style.display = 'none';
	        document.getElementById("categoriesSection").style.display = 'block';
	        
	        currentAction = 'category'; // Cập nhật trạng thái
	        setActionInURL('category'); // Gọi hàm cập nhật URL

			// Remove 'hidden' class for id categoriesSection
			document.getElementById("categoriesSection").classList.remove("hidden");
	    });

		function setActionInURL(action) {
			const url = new URL(window.location.href);
			url.searchParams.set('action', action);
			history.pushState(null, '', url.toString());
			console.log(`Set action in URL: ${action}`);
		}

		window.onload = function () {
			const url = new URL(window.location.href);
			const action = url.searchParams.get('action') || 'product';
			console.log(`Page loaded. Showing section: ${action}`);
			document.getElementById("invoicesSection").style.display = (action === 'invoice') ? 'block' : 'none';
			document.getElementById("productsSection").style.display = (action === 'product') ? 'block' : 'none';
			document.getElementById("discountsSection").style.display = (action === 'discount') ? 'block' : 'none';
			document.getElementById("categoriesSection").style.display = (action === 'category') ? 'block' : 'none';
		}

		document.getElementById("editProductForm").addEventListener("submit", function (event) {
			event.preventDefault();
			const fileInput = document.getElementById("editImage");
			const file = fileInput.files[0];
			console.log("Submitting edit form. Image file selected:", file ? file.name : "None");

			if (file) {
				const reader = new FileReader();
				reader.onload = function (e) {
					const base64Image = e.target.result.split(",")[1];
					const hiddenInput = document.createElement("input");
					hiddenInput.type = "hidden";
					hiddenInput.name = "imageBase64";
					hiddenInput.value = base64Image;
					document.getElementById("editProductForm").appendChild(hiddenInput);
					console.log("Base64 image processed. Submitting form.");
					document.getElementById("editProductForm").submit();
				};
				reader.readAsDataURL(file);
			} else {
				console.log("No new image selected. Submitting form directly.");
				document.getElementById("editProductForm").submit();
			}
		});

		function toggleSidebar() {
			console.log("Toggling sidebar");
			const sidebar = document.getElementById("sidebar");
			const dashboardText = document.getElementById("dashboardText");
			const navTexts = document.querySelectorAll(".nav-text");
			const toggleButton = document.querySelector(".fa-bars").parentElement;

			sidebar.classList.toggle("w-16");
			sidebar.classList.toggle("w-1/4");
			toggleButton.classList.toggle("rotate-180");

			if (sidebar.classList.contains("w-16")) {
				console.log("Sidebar collapsed");
				dashboardText.style.opacity = "0";
				dashboardText.style.transform = "translateX(-20px)";
				navTexts.forEach(text => {
					text.style.opacity = "0";
					text.style.transform = "translateX(-20px)";
					setTimeout(() => { text.style.display = "none"; }, 300);
				});
			} else {
				console.log("Sidebar expanded");
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
			console.log("Showing Add Product Modal");
			document.getElementById("addModal").classList.remove("hidden");
		}

		function hideAddModal() {
			console.log("Hiding Add Product Modal");
			document.getElementById("addModal").classList.add("hidden");
		}

		function showEditModal(button) {
			console.log("Showing Edit Product Modal");
			const productCard = button.closest(".product-card");
			const productName = productCard.querySelector(".product-name").textContent;
			const price = productCard.querySelector(".product-price").textContent.replace('$', '');
			let priceInt = parseInt(price, 10);
			const description = productCard.querySelector(".product-description").textContent;
			const stock = productCard.querySelector(".product-stock").textContent.replace('Stock: ', '');
			const currentImage = productCard.querySelector(".product-image").src;

			document.getElementById("editProductNameField").value = productName;
			document.getElementById("editPrice").value = priceInt;
			document.getElementById("editDescription").value = description;
			document.getElementById("editStock").value = stock;
			document.getElementById("editCurrentImage").src = currentImage;
			document.getElementById("editProductName").value = productName;
			document.getElementById("editModal").classList.remove("hidden");
		}

		function previewEditImage(event) {
			const file = event.target.files[0];
			const preview = document.getElementById("editCurrentImage");

			if (file) {
				console.log(`Previewing new image: ${file.name}`);
				const reader = new FileReader();
				reader.onload = function (e) {
					preview.src = e.target.result;
				};
				reader.readAsDataURL(file);
			} else {
				console.log("Image preview reset");
				preview.src = "";
			}
		}

		function hideEditModal() {
			console.log("Hiding Edit Product Modal");
			document.getElementById("editModal").classList.add("hidden");
		}

		document.getElementById("editProductForm").addEventListener("submit", function(event) {
			event.preventDefault();
			const updatedName = document.getElementById("editProductName").value;
			const updatedPrice = document.getElementById("editPrice").value;
			const updatedDescription = document.getElementById("editDescription").value;
			const updatedImage = document.getElementById("editImage").files[0];
			console.log("Product Updated:", { updatedName, updatedPrice, updatedDescription, updatedImage });
			hideEditModal();
		});

    </script>
	<script>
		// Hiển thị modal chỉnh sửa và điền dữ liệu
		document.querySelectorAll('.edit-btn').forEach(button => {
		  button.addEventListener('click', () => {
			// Lấy dữ liệu từ thuộc tính data- của button
			const categoryId = button.getAttribute('data-id');
			const categoryName = button.getAttribute('data-name');
			const categoryDescription = button.getAttribute('data-type');
	  
			// Set dữ liệu vào form trong modal
			document.getElementById('editCategoryID').value = categoryId;
			document.getElementById('editCategoryName').value = categoryName;
			document.getElementById('editCategoryDescription').value = categoryDescription;
	  
			// Hiện modal
			document.getElementById('editCategoryModal').classList.remove('hidden');
		  });
		});
	  
		// Ẩn modal chỉnh sửa
		function hideEditCategoryModal() {
		  document.getElementById('editCategoryModal').classList.add('hidden');
		}
	  
		// Tương tự nếu bạn muốn modal Thêm Category hoạt động
		function showAddCategoryModal() {
		  document.getElementById('addCategoryModal').classList.remove('hidden');
		}
		function hideAddCategoryModal() {
		  document.getElementById('addCategoryModal').classList.add('hidden');
		}
	  </script>
	  
</body>
</html>
