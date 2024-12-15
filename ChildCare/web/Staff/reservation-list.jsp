<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback Management - Healthcare Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link href="../Admin/assets/css/style.css" rel="stylesheet" type="text/css"/>
        <link href="../Admin/assets/css/feedbacks.css" rel="stylesheet" type="text/css"/>
        <link href="../Admin/assets/css/reservation.css" rel="stylesheet" type="text/css"/>
        <style>
            /* Button Apply Filters */
            .filters-section .filter-actions .btn-filter {
                padding: 10px 20px;
                background-color: #3498db; /* Màu xanh dương */
                color: white; /* Màu chữ */
                font-size: 14px;
                font-weight: bold;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s ease;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Hiệu ứng nổi */
                margin-left: 15px; /* Khoảng cách giữa button và filter bên cạnh */
            }

            .filters-section .filter-actions .btn-filter:hover {
                background-color: #2980b9; /* Màu đậm hơn khi hover */
                transform: translateY(-2px); /* Hiệu ứng nổi */
                box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15); /* Tăng hiệu ứng bóng */
            }

            .filters-section .filter-actions .btn-filter:active {
                background-color: #1c598a; /* Màu tối hơn khi click */
                transform: translateY(0); /* Quay lại vị trí gốc */
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* Giảm hiệu ứng bóng */
            }

            /* Căn chỉnh button ngang hàng */
            .filters-section .filter-group {
                display: flex;
                align-items: center;
                gap: 15px; /* Khoảng cách giữa các filter */
            }
            /* Add this to your CSS */
            .reservations-table th:nth-child(1), /* Target the Reservation ID column header */
            .reservations-table td:nth-child(1) /* Target the Reservation ID column cells */ {
                width: 100px; /* Adjust width as necessary */
                text-align: center; /* Center align the content */
                white-space: nowrap; /* Prevent wrapping */
            }
        </style>
    </head>

    <body>
        <nav class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">HealthCare Admin</div>
            </div>

            <!-- Staff Section -->
            <div class="nav-section">
                <div class="nav-section-title">Staff Management</div>
                <a href="reservationlist" class="nav-item">
                    <i class="fas fa-calendar-check"></i>
                    <span>Reservations</span>
                </a>
                <a href="medicalexamination" class="nav-item">
                    <i class="fas fa-stethoscope"></i>
                    <span>Medical Examinations</span>
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
                                <span class="user-role">Staff ID${sessionScope.account.person.personId}</span>
                            </div>
                        </div>

                    </div>
                    <div class="user-profile">
                        <a href="../logout" style="padding: 10% 0">
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
                    <h1>Reservation Management</h1>
                </div>

                <!-- Advanced Filters Section -->
                <div class="filters-section">
                    <form method="get" action="reservationlist">
                        <div class="search-filter">
                            <!-- Search Bar -->
                            <div class="search-bar"> 
                                <input type="text" name="search" placeholder="Search by reservation ID or customer name..."
                                       value="${search}">
                            </div>

                            <div class="filter-group">
                                <!-- Date Range Filter -->
                                <div class="date-range-filter">
                                    <label>Reservation Date:</label>
                                    <input type="date" name="dateFrom" value="${dateFrom}" placeholder="From">
                                    <input type="date" name="dateTo" value="${dateTo}" placeholder="To">
                                </div>

                                <!-- Status Filter -->
                                <div class="status-filter">
                                    <label>Status:</label>
                                    <select name="status" class="filter-select">
                                        <option value="" ${status == null ? "selected" : ""}>All Status</option>
                                        <option value="1" ${status == 1 ? "selected" : ""}>Confirmed</option>
                                        <option value="2" ${status == 2 ? "selected" : ""}>Pending</option>
                                        <option value="3" ${status == 3 ? "selected" : ""}>Completed</option>
                                        <option value="4" ${status == 4 ? "selected" : ""}>Cancelled</option>
                                    </select>
                                </div>

                                <!-- Apply Filters Button -->
                                <div class="filter-actions">
                                    <button type="submit" class="btn-filter">Apply Filters</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

            </div>

            <!-- Reservations Table -->
            <div class="reservations-table-wrapper">
                <table class="reservations-table">
                    <thead>
                        <tr>
                            <th class="sortable" data-sort="id">Reservation ID <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="date">Form Creation Date <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="customer">Customer Name <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="service">Service <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="cost">Total Cost <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="status">Status <i class="fas fa-sort"></i></th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="reservation" items="${reservations}" varStatus ="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>${reservation.created_Date}</td>
                                <td>${reservation.customer.personName}</td>
                                <td>${reservation.service.serviceName}</td> 
                                <td class="total-cost">${reservation.service.price}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${reservation.status == 1}">Confirmed</c:when>
                                        <c:when test="${reservation.status == 2}">Pending</c:when>
                                        <c:when test="${reservation.status == 3}">Completed</c:when>
                                        <c:when test="${reservation.status == 4}">Cancelled</c:when>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="reservationdetail?id=${reservation.reservationId}" class="btn-action">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <div class="pagination-info">
                </div>
                <div class="pagination-controls">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage - 1}" class="btn-icon">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>
                    <c:forEach begin="1" end="${totalPages}" var="pageNum">
                        <a href="?page=${pageNum}" class="btn-icon ${pageNum == currentPage ? 'active' : ''}">
                            ${pageNum}
                        </a>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage + 1}" class="btn-icon">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
                <div class="items-per-page">
                </div>
            </div>
        </div>

        <script>
            document.querySelector('form').addEventListener('submit', function (event) {
                const dateFrom = document.querySelector('input[name="dateFrom"]').value;
                const dateTo = document.querySelector('input[name="dateTo"]').value;

                // Kiểm tra nếu cả hai ngày được nhập
                if (dateFrom && dateTo) {
                    const fromDate = new Date(dateFrom);
                    const toDate = new Date(dateTo);

                    // Kiểm tra nếu ngày bắt đầu lớn hơn ngày kết thúc
                    if (fromDate > toDate) {
                        event.preventDefault(); // Ngăn chặn form được submit
                        alert('Start date must be less than or equal to the end date. Please correct the dates.');
                    }
                }
            });
        </script>

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Lấy tất cả các ô trong cột Total Cost
                const totalCostCells = document.querySelectorAll(".reservations-table td.total-cost");

                totalCostCells.forEach(cell => {
                    const value = parseFloat(cell.textContent.trim());
                    if (!isNaN(value)) {
                        // Kiểm tra nếu số sau dấu chấm là 0, thì xóa số 0 và dấu chấm
                        if (value % 1 === 0) {
                            cell.textContent = value.toFixed(0); // Xóa dấu chấm và số 0
                        } else {
                            cell.textContent = value.toFixed(2); // Giữ nguyên nếu khác không
                        }
                    }
                });
            });
        </script>
        <script>
            window.onload = function () {
            var message = '<%= session.getAttribute("notificationErr") != null ? session.getAttribute("notificationErr") : "" %>';
                if (message) {
                    alert(message);

                    window.location.href = "ClearSessionNotificationServlet";
                }
            };
        </script>
    </body>
</html>