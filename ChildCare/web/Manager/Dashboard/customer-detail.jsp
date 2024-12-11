<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sliders Management - Healthcare Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Manager/Dashboard/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Manager/Dashboard/assets/css/sliders.css">
        <style>
            /* General Styling */
            body {
                font-family: Arial, sans-serif;
                background-color: #f9f9f9;
                margin: 0;
                padding: 20px;
            }

            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
            }

            /* Search and Filter Form */
            .filter-form {
                display: flex;
                justify-content: space-between; /* Kéo dài toàn bộ chiều ngang */
                align-items: center;
                padding: 15px;
                margin-bottom: 20px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .filter-form input[type="text"],
            .filter-form select {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 14px;
                width: 40%; /* Chiếm 40% chiều rộng */
            }

            .filter-form button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 20px;
                border-radius: 5px;
                font-size: 14px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .filter-form button:hover {
                background-color: #0056b3;
            }

            /* Table Styling */
            table {
                width: 100%; /* Kéo dài toàn bộ chiều ngang */
                border-collapse: collapse;
                background-color: #ffffff;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                border-radius: 10px;
                overflow: hidden;
            }

            table th,
            table td {
                padding: 15px 20px;
                text-align: center;
                border-bottom: 1px solid #e0e0e0;
            }

            table th {
                background-color: #007bff;
                color: white;
                text-transform: uppercase;
                font-size: 14px;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            table tr:hover {
                background-color: #e7f3ff;
            }

            table td {
                font-size: 14px;
                vertical-align: middle;
            }

            /* Actions Column Buttons */
            .actions a {
                text-decoration: none;
                padding: 8px 15px;
                border-radius: 5px;
                font-size: 13px;
                margin-right: 5px;
                display: inline-block;
            }

            .actions .btn-view {
                background-color: #28a745;
                color: white;
            }

            .actions .btn-view:hover {
                background-color: #218838;
            }

            .actions .btn-edit {
                background-color: #ffc107;
                color: white;
            }

            .actions .btn-edit:hover {
                background-color: #e0a800;
            }

            /* Pagination Styling */
            .pagination {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 10px;
                margin-top: 20px;
            }

            .pagination a {
                text-decoration: none;
                padding: 10px 15px;
                border-radius: 5px;
                border: 1px solid #ddd;
                background-color: white;
                color: #007bff;
                transition: background-color 0.3s ease, color 0.3s ease;
            }

            .pagination a.active {
                background-color: #007bff;
                color: white;
                font-weight: bold;
            }

            .pagination a:hover {
                background-color: #0056b3;
                color: white;
            }

            .pagination .btn-prev,
            .pagination .btn-next {
                padding: 10px 20px;
                border-radius: 5px;
                border: none;
                background-color: #007bff;
                color: white;
                cursor: pointer;
            }

            .pagination .btn-prev:hover,
            .pagination .btn-next:hover {
                background-color: #0056b3;
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
                <a href="postList" class="nav-item">
                    <i class="fas fa-newspaper"></i>
                    <span>Posts</span>
                </a>
                <a href="sliderList" class="nav-item">
                    <i class="fas fa-images"></i>
                    <span>Sliders</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-list"></i>
                    <span>Services List</span>
                </a>
                <a href="customerList" class="nav-item">
                    <i class="fas fa-list"></i>
                    <span>Customer List</span>
                </a>
            </div>

        </nav>

        <!-- Main Content Area -->
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
                    <h1>Customer Detail</h1>
                </div>
                    
                <!-- Table to Display Customer Data -->
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Full Name</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Mobile</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    
                </table>

            </div>

            <!-- Pagination -->
            <div class="pagination">
                <div class="pagination-info">
                </div>
                <div class="pagination">
                    <button class="btn-prev" ${currentPage == 1 ? 'disabled' : ''} 
                            onclick="window.location.href='customerList?page=${currentPage - 1}&search=${param.search}&status=${param.status}'">
                        Previous
                    </button>
                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="customerList?page=${i}&search=${param.search}&status=${param.status}" 
                           class="${i == currentPage ? 'active' : ''}">${i}</a>
                    </c:forEach>
                    <button class="btn-next" ${currentPage == totalPages ? 'disabled' : ''} 
                            onclick="window.location.href='customerList?page=${currentPage + 1}&search=${param.search}&status=${param.status}'">
                        Next
                    </button>
                </div>
                <div>
                </div>
                <div>
                </div>
            </div>
        </div>


        <script src="${pageContext.request.contextPath}/Manager/Dashboard/assets/js/main.js"></script>
    </body>

</html>
