<%-- 
    Document   : ServicesList
    Created on : Dec 11, 2024, 4:37:39 AM
    Author     : Admin
--%>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8"%>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Services Management - Healthcare Manager</title>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/Manager/Dashboard/assets/css/style.css">
                <link rel="stylesheet" href="${pageContext.request.contextPath}/Manager/Dashboard/assets/css/services.css">
                <style>
                    .search-button {
                        background-color: #007bff;
                        /* Màu nền nút */
                        color: white;
                        /* Màu chữ */
                        font-size: 16px;
                        /* Kích thước chữ */
                        border: none;
                        /* Không viền */
                        padding: 10px 20px;
                        /* Khoảng cách trong nút */
                        border-radius: 25px;
                        /* Bo góc tròn */
                        cursor: pointer;
                        /* Con trỏ chuột khi di chuyển qua nút */
                        transition: background-color 0.3s, transform 0.3s;
                        /* Hiệu ứng chuyển màu và phóng to */
                    }
                    
                    .search-button:hover {
                        background-color: #0056b3;
                        /* Màu nền khi hover */
                        transform: scale(1.05);
                        /* Phóng to khi hover */
                    }
                    
                    .search-button:active {
                        background-color: #004085;
                        /* Màu nền khi nhấn */
                    }
                    
                    .view-button {
                        text-decoration: none;
                        /* Loại bỏ underline */
                        color: inherit;
                        /* Giữ màu sắc của text giống như các nút khác */
                    }
                    
                    .view-button:hover {
                        text-decoration: none;
                    }
                    
                    td[data-detail] {
                        max-width: 500px;
                        /* Độ rộng tối đa của ô */
                        display: -webkit-box;
                        /* Sử dụng box layout */
                        -webkit-box-orient: vertical;
                        /* Hướng của box */
                        -webkit-line-clamp: 2;
                        /* Giới hạn 2 dòng */
                        overflow: hidden;
                        /* Ẩn nội dung thừa */
                        text-overflow: ellipsis;
                        /* Hiển thị d���u ba chấm */
                        line-height: 2.2em;
                        /* Chiều cao dòng */
                        height: calc(3em * 2);
                        /* Chiều cao cho 2 dòng */
                    }
                    
                    .status-badge {
                        font-weight: bold;
                        padding: 5px 10px;
                        border-radius: 5px;
                    }
                    
                    .status-badge.active {
                        color: green;
                    }
                    
                    .status-badge.hidden {
                        color: red;
                    }
                    /* Container for centering buttons */
                    
                    .button-container {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        gap: 1rem;
                        /* Khoảng cách giữa các nút */
                        margin-top: 2rem;
                    }
                    /* Button styling */
                    
                    .action-btn {
                        display: flex;
                        justify-content: center;
                        align-items: center;
                        width: 150px;
                        /* Chiều rộng cố định */
                        height: 40px;
                        /* Chiều cao cố định */
                        text-align: center;
                        text-decoration: none;
                        font-size: 1rem;
                        font-weight: bold;
                        color: #fff;
                        background-color: #007bff;
                        border-radius: 8px;
                        transition: background-color 0.3s;
                        border: none;
                    }
                    
                    .action-btn:hover {
                        background-color: #0056b3;
                    }
                    
                    .action-btn i {
                        margin-right: 0.5rem;
                        /* Khoảng cách giữa icon và chữ */
                        font-size: 1.2rem;
                    }
                    /* Form container */
                    
                    .service-form {
                        width: 100%;
                        max-width: 750px;
                        /* Chiều rộng tối đa gọn hơn */
                        margin: 0 auto;
                        /* Căn giữa form */
                        padding: 1.5rem;
                        /* Giảm padding */
                        border: 1px solid #ddd;
                        /* Viền nhẹ */
                        border-radius: 8px;
                        /* Bo góc */
                        background-color: #ffffff;
                        /* Nền trắng */
                        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                        /* Shadow nhẹ */
                    }
                    /* Form group */
                    
                    .form-group {
                        margin-bottom: 1.2rem;
                        /* Khoảng cách giữa các nhóm nhỏ hơn */
                    }
                    /* Labels */
                    
                    .form-group label {
                        display: block;
                        font-size: 0.9rem;
                        /* Giảm kích thước font */
                        font-weight: 600;
                        margin-bottom: 0.3rem;
                        /* Khoảng cách nhỏ hơn */
                        color: #444;
                        /* Màu chữ tối hơn nhẹ */
                    }
                    /* Inputs and textareas */
                    
                    .service-form input[type="text"],
                    .service-form input[type="number"],
                    .service-form input[type="file"],
                    .service-form textarea,
                    .service-form select {
                        width: 100%;
                        padding: 0.7rem;
                        /* Giảm padding để nhỏ gọn */
                        font-size: 0.9rem;
                        /* Giảm kích thước font */
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        /* Bo góc nhẹ hơn */
                        background-color: #f9f9f9;
                        /* Nền sáng nhẹ */
                        color: #333;
                        transition: border-color 0.3s ease, box-shadow 0.3s ease;
                        box-sizing: border-box;
                    }
                    /* Input focus effect */
                    
                    .service-form input:focus,
                    .service-form textarea:focus,
                    .service-form select:focus {
                        border-color: #007bff;
                        outline: none;
                        box-shadow: 0 0 4px rgba(0, 123, 255, 0.3);
                        /* Shadow nhẹ */
                    }
                    /* Textarea styling */
                    
                    .service-form textarea {
                        resize: vertical;
                        min-height: 100px;
                        /* Chiều cao tối thiểu nhỏ hơn */
                    }
                    /* Form row */
                    
                    .form-row {
                        display: flex;
                        gap: 1rem;
                        /* Khoảng cách giữa các cột */
                    }
                    
                    .form-row .form-group {
                        flex: 1;
                    }
                    /* File input */
                    
                    .service-form input[type="file"] {
                        padding: 0.5rem;
                        font-size: 0.9rem;
                        border: none;
                        background-color: transparent;
                        cursor: pointer;
                    }
                    
                    .checkbox-group {
                        display: flex;
                        flex-wrap: wrap;
                        gap: 10px;
                    }
                    /* Individual checkbox item */
                    
                    .checkbox-item {
                        display: flex;
                        align-items: center;
                        gap: 5px;
                    }
                    /* Style for the checkbox input */
                    
                    .checkbox-item input[type="checkbox"] {
                        accent-color: #007BFF;
                        /* Màu xanh dương cho checkbox */
                        width: 18px;
                        height: 18px;
                    }
                    /* Label styling */
                    
                    .checkbox-item label {
                        font-size: 1rem;
                        color: #333;
                    }
                </style>
            </head>

            <body>
                <nav class="sidebar">
                    <div class="sidebar-header">
                        <div class="sidebar-logo">HealthCare Manager</div>
                    </div>

                    <!-- Manager Section -->
                    <div class="nav-section">
                        <div class="nav-section-title">Manager Tools</div>
                        <a href="Manager/Dashboard/postList" class="nav-item">
                            <i class="fas fa-newspaper"></i>
                            <span>Posts</span>
                        </a>
                        <a href="sliderList" class="nav-item">
                            <i class="fas fa-images"></i>
                            <span>Sliders</span>
                        </a>
                        <a href="ListService" class="nav-item">
                            <i class="fas fa-list"></i>
                            <span>Services List</span>
                        </a>
                        <a href="customerList" class="nav-item">
                            <i class="fas fa-users"></i>
                            <span>Customer List</span>
                        </a>
                    </div>

                </nav>

                <div class="main-content">
                    <div class="top-nav">
                        <div class="menu-toggle">
                            <span></span>
                            <span></span>
                            <span></span>
                        </div>
                        <div class="search-bar">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search...">
                        </div>
                        <div class="user-menu">
                            <div class="user-profile-wrapper">
                                <div class="user-profile">
                                    <div class="user-avatar">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="user-info">
                                        <span class="user-name">${sessionScope.account.person.personName}</span>
                                        <span class="user-role">Manager</span>
                                    </div>
                                </div>

                            </div>
                            <div class="user-profile">
                                <a href="logout" style="padding: 10% 0">
                                    <i class="fas fa-sign-out-alt"></i>
                                    <span>Sign Out</span>
                                </a>
                            </div>
                            <div class="theme-toggle" title="Toggle theme">
                            </div>
                        </div>
                    </div>

                    <div class="page-header">
                        <div class="header-content">
                            <h1>Services Management</h1>
                        </div>
                        <div>
                            <div></div>
                            <div>
                                <div>
                                    <h2 style="text-align: center; margin-bottom: 2%">Add Service</h2>
                                </div>
                                <div>
                                    <form action="addService" method="post" class="service-form" onsubmit="return validateServiceForm();">
                                        <input type="hidden" name="id" value="${sessionScope.account.person.personId}">

                                        <div class="form-group">
                                            <label for="serviceTitle">Service Name</label>
                                            <input type="text" name="serviceName" required>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="listPrice">Price</label>
                                                <input type="number" name="price" min="0" step="10" required>
                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label for="serviceDescription">Description</label>
                                            <input type="text" name="description" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="serviceDetail">Detail information</label>
                                            <textarea name="detail" rows="6" required></textarea>
                                        </div>

                                        <div class="form-group">
                                            <label for="serviceImage">Image</label>
                                            <div class="image-preview">
                                                <img id="preview" src="" alt="Preview Image" style="object-fit: cover;">
                                            </div>
                                            <input type="file" name="image" id="serviceImage" accept="image/*" onchange="showPreview(event)">
                                        </div>

                                        <div class="form-group">
                                            <label for="serviceDetail">Duration</label>
                                            <input type="text" name="duration" required>
                                        </div>

                                        <div class="form-group">
                                            <label for="staffs">Assign Staff</label>
                                            <div id="staffs" class="checkbox-group">
                                                <c:forEach var="staff" items="${staffs}">
                                                    <div class="checkbox-item">
                                                        <input type="checkbox" name="staffs" id="staff-${staff.personId}" value="${staff.personId}">
                                                        <label for="staff-${staff.personId}">${staff.personName}</label>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                        </div>

                                        <div class="form-row">
                                            <div class="form-group">
                                                <label for="serviceStatus">Status</label>
                                                <select id="serviceStatus" name="status" required>
                                            <option value="1">Active</option>
                                            <option value="0">Inactive</option>
                                        </select>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                            <a class="action-btn edit" href="ListService">
                                                <i class="fas fa-arrow-left"></i> Back to list
                                            </a>
                                            <button type="submit" class="action-btn edit" data-action="save">Add Service</button>
                                        </div>
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>

                </div>

                <script src="${pageContext.request.contextPath}/Manager/Dashboard/assets/js/main.js"></script>
                <script>
                    function showPreview(event) {
                        const file = event.target.files[0]; // Lấy tệp được chọn
                        if (file) {
                            const reader = new FileReader();
                            reader.onload = function(e) {
                                document.getElementById('preview').src = e.target.result;
                            }
                            reader.readAsDataURL(file); // Đọc tệp dưới dạng URL
                        }
                    }
                </script>
                <script>
                    window.onload = function() {
                        var message = '<%= request.getAttribute("ms") != null ? request.getAttribute("ms") : "" %>';
                        if (message) {
                            alert(message);

                            window.location.href = "ListService";
                        }
                    };
                </script>
                <script>
                    function validateServiceForm() {
                        // Price validation (must be > 0)
                        const price = document.querySelector('input[name="price"]').value;
                        if (price <= 0) {
                            alert("Price must be greater than 0");
                            return false;
                        }

                        // Duration validation (must be number + " minute")
                        const duration = document.querySelector('input[name="duration"]').value;
                        const durationPattern = /^\d+\sminute$/;
                        if (!durationPattern.test(duration)) {
                            alert("Duration must be in format: number + ' minute' (e.g. 30 minute)");
                            return false;
                        }

                        return true;
                    }
                </script>
            </body>

            </html>