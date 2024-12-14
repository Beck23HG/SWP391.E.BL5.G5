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
                background-color: #007bff; /* Màu nền nút */
                color: white;              /* Màu chữ */
                font-size: 16px;           /* Kích thước chữ */
                border: none;              /* Không viền */
                padding: 10px 20px;        /* Khoảng cách trong nút */
                border-radius: 25px;       /* Bo góc tròn */
                cursor: pointer;          /* Con trỏ chuột khi di chuyển qua nút */
                transition: background-color 0.3s, transform 0.3s; /* Hiệu ứng chuyển màu và phóng to */
            }

            .search-button:hover {
                background-color: #0056b3; /* Màu nền khi hover */
                transform: scale(1.05);     /* Phóng to khi hover */
            }

            .search-button:active {
                background-color: #004085; /* Màu nền khi nhấn */
            }
            .view-button{
                text-decoration: none; /* Loại bỏ underline */
                color: inherit; /* Giữ màu sắc của text giống như các nút khác */
            }
            .view-button:hover{
                text-decoration: none;
            }
            td[data-detail] {
                max-width: 500px; /* Độ rộng tối đa của ô */
                display: -webkit-box; /* Sử dụng box layout */
                -webkit-box-orient: vertical; /* Hướng của box */
                -webkit-line-clamp: 2; /* Giới hạn 2 dòng */
                overflow: hidden; /* Ẩn nội dung thừa */
                text-overflow: ellipsis; /* Hiển thị dấu ba chấm */
                line-height: 2.2em; /* Chiều cao dòng */
                height: calc(3em * 2); /* Chiều cao cho 2 dòng */
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
                    <a href="addService" class="btn-primary view-button">
                        <i class="fas fa-plus"></i>
                        New Service
                    </a>
                </div>

                <!-- Filter Section -->
                <form action="ListService" method="get">
                    <div class="filters-section">
                        <div class="search-filters">
                            <div class="search-bar">
                                <i class="fas fa-search"></i>
                                <input type="text" name="serviceName" placeholder="Search by name...">
                            </div>
                            <div class="filter-group">
                                <select name="personName" class="filter-select" id="statusFilter">
                                    <option value="">All manager</option>
                                    <c:forEach items="${names}" var="s">
                                        <option value="${s}">${s}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="filter-group">
                                <select name="status" class="filter-select" id="statusFilter">
                                    <option value="">All Status</option>
                                    <option value="1">Active</option>
                                    <option value="0">Inactive</option>
                                </select>
                            </div>
                            <div>
                                <input type="submit" value="Search" class="search-button">
                            </div>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Services Table -->
            <div class="services-table">
                <table>
                    <thead>
                        <tr>
                            <th class="sortable" data-sort="id">ID <i class="fas fa-sort"></i></th>
                            <th>Service Name</th>
                            <th class="sortable" data-sort="title">Price <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="category">Description <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="listPrice">Image<i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="salePrice">Duration<i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="featured">What Include<i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="status">Added By <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="status">Status <i class="fas fa-sort"></i></th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${services}" var="s">
                            <tr>
                                <td>${s.serviceId}</td>
                                <td>${s.serviceName}</td>
                                <td data-price>$${s.price}</td>
                                <td>${s.description}</td>
                                <td>
                                    <img src="assets/images/Service/${s.image}" 
                                         alt="${s.serviceName}"
                                         class="service-thumbnail">
                                </td>
                                <td>${s.duration}</td>
                                <td data-detail>${s.detail}</td>
                                <td>${s.person.personName}</td>
                                <td>
                                    <span class="status-badge ${s.status == 1 ? 'active' : 'hidden'}">
                                        ${s.status == 1 ? 'Active' : 'Inactive'}
                                    </span>
                                </td>
                                <td class="table-actions">
                                    <form action="DetailService" method="get" >
                                        <input type="hidden" name="id" value="${s.serviceId}">
                                        <button class="btn-icon" title="View Details" onclick="this.closest('form').submit(); return false;">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </form>
                                    <form action="editService" method="get" >
                                        <input type="hidden" name="id" value="${s.serviceId}">
                                        <button class="btn-icon" title="Edit" onclick="this.closest('form').submit(); return false;">
                                            <i class="fas fa-edit"></i>
                                        </button>
                                    </form>
                                    <form action="deleteService" method="post" >
                                        <input type="hidden" name="id" value="${s.serviceId}">
                                        <button class="btn-icon" title="Edit" onclick="this.closest('form').submit(); return false;">
                                            <i class="fas fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div class="pagination">
                <div class="pagination-info">
                    Showing <span>${start}-${end}</span> of <span>${totalProduct}</span> services
                </div>
                <div class="pagination-controls">
                    <!-- Prev button -->
                    <button class="btn-icon" ${indexx == 1 ? 'disabled' : ''} onclick="window.location = '?serviceName=${param.serviceName}&personName=${param.personName}&status=${param.status}&index=${indexx - 1}'">
                        <i class="fas fa-chevron-left"></i>
                    </button>

                    <!-- Page Numbers -->
                    <div class="page-numbers">
                        <c:forEach var="i" begin="1" end="${endPage}">
                            <button class="${i == indexx ? 'active' : ''}" onclick="window.location = '?serviceName=${param.serviceName}&personName=${param.personName}&status=${param.status}&index=${i}'">${i}</button>
                        </c:forEach>
                    </div>

                    <!-- Next button -->
                    <button class="btn-icon" ${indexx == endPage ? 'disabled' : ''} onclick="window.location = '?serviceName=${param.serviceName}&personName=${param.personName}&status=${param.status}&index=${indexx + 1}'">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
        </div>

        <script src="${pageContext.request.contextPath}/Manager/Dashboard/assets/js/main.js"></script>
    </body>

</html>
