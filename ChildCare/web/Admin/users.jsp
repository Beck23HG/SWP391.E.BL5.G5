<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Management - Healthcare Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/assets/css/users.css"> 
    <!-- CSS Styles for the buttons -->
    <style>
        /* Styling for the New User button */
        .btn-primary {
            background-color: #007bff; /* Blue background */
            color: white; /* White text */
            padding: 10px 20px; /* Padding for size */
            border: none;
            border-radius: 5px; /* Rounded corners */
            font-size: 16px; /* Font size */
            cursor: pointer; /* Pointer on hover */
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: background-color 0.3s ease; /* Smooth transition on hover */
        }

        .btn-primary:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        .btn-primary i {
            margin-right: 8px; /* Space between icon and text */
        }

        /* Styling for the Search input */
        .search-bar {
            display: flex;
            align-items: center;
            background-color: #f1f1f1;
            padding: 8px 12px;
            border-radius: 25px; /* Rounded corners for search bar */
            border: 1px solid #ccc;
            width: 300px;
            transition: border-color 0.3s ease;
        }

        .search-bar:hover {
            border-color: #007bff; /* Border changes color on hover */
        }

        .search-bar input {
            border: none;
            background: transparent;
            outline: none;
            padding-left: 8px;
            font-size: 14px;
            width: 100%;
        }

        .search-bar i {
            color: #007bff; /* Icon color */
            font-size: 20px;
        }

        .search-bar input::placeholder {
            color: #888; /* Lighter placeholder text */
        }

        /* Adjusting the button within the filter form */
        .filters-section button {
            background-color: #28a745; /* Green background */
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .filters-section button:hover {
            background-color: #218838; /* Darker green on hover */
        }
    </style>
</head>

<body>
    <nav class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">HealthCare Admin</div>
        </div>

        <!-- Admin Section -->
        <div class="nav-section">
            <div class="nav-section-title">Administration</div>
            <a href="index.html" class="nav-item">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>
            <a href="Admin/userlist" class="nav-item">
                <i class="fas fa-user-shield"></i>
                <span>Users Management</span>
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
                <input type="text" placeholder="Search...">
            </div>
            <div class="user-menu">
                <div class="notifications-wrapper">
                    <div class="notifications">
                        <i class="fas fa-bell"></i>
                        <span class="notifications-count">3</span>
                    </div>
                    <div class="notifications-dropdown">
                        <div class="notifications-header">
                            <span class="notifications-title">Notifications</span>
                            <span class="mark-all-read">Mark all as read</span>
                        </div>
                        <div class="notification-list">
                            <div class="notification-item unread">
                                <div class="notification-icon">
                                    <i class="fas fa-calendar"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-text">New appointment request from Sarah Johnson</div>
                                    <div class="notification-time">5 minutes ago</div>
                                </div>
                            </div>
                            <div class="notification-item unread">
                                <div class="notification-icon">
                                    <i class="fas fa-user-plus"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-text">New patient registration: Michael Brown</div>
                                    <div class="notification-time">2 hours ago</div>
                                </div>
                            </div>
                            <div class="notification-item">
                                <div class="notification-icon">
                                    <i class="fas fa-comment-medical"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-text">New feedback received for Dr. Smith</div>
                                    <div class="notification-time">1 day ago</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="user-profile-wrapper">
                    <div class="user-profile">
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="user-info">
                            <span class="user-name">John Doe</span>
                            <span class="user-role">Administrator</span>
                        </div>
                    </div>
                    <div class="user-dropdown">
                        <div class="user-dropdown-header">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="user-name">John Doe</div>
                            <div class="user-role">Administrator</div>
                        </div>
                        <a href="#" class="user-dropdown-item">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Sign Out</span>
                        </a>
                    </div>
                </div>
                <div class="theme-toggle" title="Toggle theme"></div>
            </div>
        </div>

        <div class="page-header">
            <div class="header-content">
                <h1>Users Management</h1>
                <button class="btn-primary" onclick="window.location.href='new-user.jsp'">
                    <i class="fas fa-plus"></i>
                    New User
                </button>
            </div>

            <!-- Filter Section -->
            <div class="filters-section">
                <form method="get" action="userlist">
                <div class="search-filters">
                    <div class="search-bar">
                        <input type="text" name="search" value="${param.search}" placeholder="Search by name, email, phone">
                    </div>
                    <div class="filter-group">
                        <select class="filter-select" id="genderFilter" name="gender">
                            <option value="">All Genders</option>
                            <option value="1" ${param.gender == '1' ? 'selected' : ''}>Male</option>
                            <option value="0" ${param.gender == '0' ? 'selected' : ''}>Female</option>
                        </select>

                        <select class="filter-select" id="roleFilter" name="role">
                            <option value="">All Roles</option>
                            <option value="1" ${param.role == '1' ? 'selected' : ''}>Customer</option>
                            <option value="2" ${param.role == '2' ? 'selected' : ''}>Staff</option>
                            <option value="3" ${param.role == '3' ? 'selected' : ''}>Manager</option>
                            <option value="4" ${param.role == '4' ? 'selected' : ''}>Admin</option>
                        </select>

                        <select class="filter-select" id="statusFilter" name="status">
                            <option value="">All Statuses</option>
                            <option value="1" ${param.status == '1' ? 'selected' : ''}>Active</option>
                            <option value="0" ${param.status == '0' ? 'selected' : ''}>Inactive</option>
                        </select>
                        
                        <button type="submit"> Search </button>
                    </div>
                </div>
                <div class="active-filters">
                    <!-- Active filters will be added here dynamically -->
                </div>
                </form>
            </div>
        </div>

        <!-- Users Table -->
        <div class="users-table">
            <table>
                <thead>
                    <tr>
                        <th class="sortable" data-sort="id">ID <i class="fas fa-sort"></i></th>
<!--                        <th>Avatar</th>-->
                        <th class="sortable" data-sort="fullName">Full Name <i class="fas fa-sort"></i></th>
                        <th class="sortable" data-sort="gender">Gender <i class="fas fa-sort"></i></th>
                        <th class="sortable" data-sort="email">Email <i class="fas fa-sort"></i></th>
                        <th class="sortable" data-sort="mobile">Mobile <i class="fas fa-sort"></i></th>
                        <th class="sortable" data-sort="role">Role <i class="fas fa-sort"></i></th>
                        <th class="sortable" data-sort="status">Status <i class="fas fa-sort"></i></th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="person" items="${persons}">
                        <tr>
                            <td>${person.personId}</td>
<!--                            <td><img src="${person.image}" alt="Avatar" width="50" height="50"></td>-->
                            <td>${person.personName}</td>
                            <td>${person.gender ? 'Male' : 'Female'}</td>
                            <td>${person.email}</td>
                            <td>${person.phone}</td>
                            <td>${person.role.roleName}</td>
                            <td>${person.account.status == 1 ? 'Active' : 'Inactive'}</td>
                            <td>
                                <a href="edituser?personId=${person.personId}" class="btn-primary">Edit</a>    
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${empty persons}">
                        <tr>
                            <td colspan="9">No users found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <div class="pagination-info">
            </div>
            <div class="pagination-controls">
                <button class="btn-icon">
                    <i class="fas fa-chevron-left"></i>
                </button>
                <div class="page-numbers">
                    <c:if test="${page > 1}">
                        <a href="?page=${page - 1}" class="btn-icon">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>
                    
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <a href="?page=${i}" class="${i == page ? 'active' : ''}">${i}</a>
                    </c:forEach>

                    <c:if test="${page < totalPages}">
                        <a href="?page=${page + 1}" class="btn-icon">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
                <button class="btn-icon">
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
            <div class="pagination-info">
            </div>
        </div>
    </div>
    <script src="${pageContext.request.contextPath}/Dashboard/assets/js/main.js"></script>
</body>
</html>
