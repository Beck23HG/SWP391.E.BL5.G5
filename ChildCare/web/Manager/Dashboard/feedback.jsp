<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback Management - Healthcare Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/feedbacks.css">
        <style>
            /* Search and Filter Styles */
            
            .filters-section {
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
            }
            
            .search-filters {
                display: flex;
                align-items: center;
                gap: 15px;
                width: 100%;
            }
            
            .search-group {
                display: flex;
                align-items: center;
                flex: 2;
                /* Chiếm 50% không gian */
                gap: 10px;
            }
            
            .search-bar {
                position: relative;
                width: 100%;
            }
            
            .search-bar input {
                width: 100%;
                padding: 12px 15px 12px 40px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                transition: border-color 0.3s ease;
            }
            
            .search-bar input:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
            }
            
            .search-bar i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: #6c757d;
            }
            
            .search-btn {
                padding: 12px 24px;
                background-color: #007bff;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                display: flex;
                align-items: center;
                gap: 8px;
                transition: all 0.3s ease;
                white-space: nowrap;
            }
            
            .search-btn:hover {
                background-color: #0056b3;
                transform: translateY(-1px);
            }
            
            .filter-select {
                flex: 1;
                /* Mỗi select chiếm 25% không gian */
                padding: 12px;
                border: 1px solid #ddd;
                border-radius: 5px;
                font-size: 14px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            
            .filter-select:focus {
                border-color: #007bff;
                outline: none;
                box-shadow: 0 0 0 2px rgba(0, 123, 255, 0.1);
            }
            /* Responsive Design */
            
            @media (max-width: 992px) {
                .search-filters {
                    flex-wrap: wrap;
                }
                .search-group {
                    flex: 100%;
                    margin-bottom: 10px;
                }
                .filter-select {
                    flex: 1;
                    min-width: 150px;
                }
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
                <a href="services.html" class="nav-item">
                    <i class="fas fa-list"></i>
                    <span>Services List</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-calendar-check"></i>
                    <span>Reservations</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-stethoscope"></i>
                    <span>Medical Examinations</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-users"></i>
                    <span>Customers</span>
                </a>
                <a href="feedbacks.html" class="nav-item">
                    <i class="fas fa-comments"></i>
                    <span>Feedbacks</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-prescription"></i>
                    <span>Prescriptions</span>
                </a>
            </div>

            <!-- Manager Section -->
            <div class="nav-section">
                <div class="nav-section-title">Manager Tools</div>
                <a href="#" class="nav-item">
                    <i class="fas fa-chart-line"></i>
                    <span>Dashboard</span>
                </a>
                <a href="posts.html" class="nav-item">
                    <i class="fas fa-newspaper"></i>
                    <span>Posts</span>
                </a>
                <a href="sliders.html" class="nav-item">
                    <i class="fas fa-images"></i>
                    <span>Sliders</span>
                </a>
            </div>

            <!-- Admin Section -->
            <div class="nav-section">
                <div class="nav-section-title">Administration</div>
                <a href="users.html" class="nav-item">
                    <i class="fas fa-user-shield"></i>
                    <span>Users Management</span>
                </a>
                <a href="#" class="nav-item">
                    <i class="fas fa-cog"></i>
                    <span>Settings</span>
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
                <!-- <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div> -->
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
                                <i class="fas fa-user-circle"></i>
                                <span>My Profile</span>
                            </a>
                            <a href="#" class="user-dropdown-item">
                                <i class="fas fa-cog"></i>
                                <span>Settings</span>
                            </a>
                            <a href="#" class="user-dropdown-item">
                                <i class="fas fa-question-circle"></i>
                                <span>Help Center</span>
                            </a>
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
                    <h1>Feedback Management</h1>
                </div>

                <!-- Filter Section -->
                <div class="filters-section">
                    <form action="" method="GET" id="filterForm">
                        <div class="search-filters">
                            <div class="search-group">
                                <div class="search-bar">
                                    <i class="fas fa-search"></i>
                                    <input type="text" name="search" value="${searchQuery}" placeholder="Search by name or feedback content...">
                                </div>
                                <button type="submit" class="btn btn-primary search-btn">
                                    <i class="fas fa-search"></i> Search
                                </button>
                            </div>
                            <select class="filter-select" name="serviceId">
                                <option value="">All Services</option>
                                <c:forEach items="${services}" var="service">
                                    <option value="${service.serviceId}" ${service.serviceId == selectedService ? 'selected' : ''}>
                                        ${service.serviceName}
                                    </option>
                                </c:forEach>
                            </select>
                            <select class="filter-select" name="rating">
                                <option value="">All Ratings</option>
                                <c:forEach begin="1" end="5" var="i">
                                    <option value="${i}" ${i == selectedRating ? 'selected' : ''}>
                                        ${i} Stars
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Feedback Table Section -->
            <div class="feedbacks-table-wrapper">
                <c:choose>
                    <c:when test="${empty feedbacks}">
                        <div class="no-results">
                            <i class="fas fa-search"></i>
                            <h3>No Results Found</h3>
                            <p>We couldn't find any feedbacks matching your search criteria.</p>
                            <a href="?page=1" class="btn btn-primary">Clear Filters</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="feedbacks-table">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Customer Name</th>
                                        <th>Service</th>
                                        <th>Rating</th>
                                        <th>Feedback</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${feedbacks}" var="feedback" varStatus="status">
                                        <tr>
                                            <td>${status.index + 1}</td>
                                            <td>${feedback.person.personName}</td>
                                            <td>${feedback.service.serviceName}</td>
                                            <td>${feedback.starRating}</td>
                                            <td>${feedback.content}</td>
                                            <td class="actions">
                                                <button class="btn-icon" title="View Details" onclick="viewFeedback(${feedback.feedbackId})">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn-icon" title="Respond" onclick="respondToFeedback(${feedback.feedbackId})">
                                                    <i class="fas fa-reply"></i>
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <div class="pagination-info">
                    Showing ${(currentPage-1)*pageSize + 1} to ${Math.min(currentPage*pageSize, totalFeedbacks)} of ${totalFeedbacks} feedbacks
                </div>
                <div class="pagination-controls">
                    <c:if test="${currentPage > 1}">
                        <a href="?page=${currentPage-1}&pageSize=${pageSize}&search=${searchQuery}&serviceId=${selectedService}&rating=${selectedRating}" class="btn-icon">
                            <i class="fas fa-chevron-left"></i>
                        </a>
                    </c:if>

                    <div class="page-numbers">
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <a href="?page=${i}&pageSize=${pageSize}&search=${searchQuery}&serviceId=${selectedService}&rating=${selectedRating}" class="btn ${currentPage == i ? 'active' : ''}">${i}</a>
                        </c:forEach>
                    </div>

                    <c:if test="${currentPage < totalPages}">
                        <a href="?page=${currentPage+1}&pageSize=${pageSize}&search=${searchQuery}&serviceId=${selectedService}&rating=${selectedRating}" class="btn-icon">
                            <i class="fas fa-chevron-right"></i>
                        </a>
                    </c:if>
                </div>
                <div class="items-per-page">
                    <select name="pageSize" onchange="window.location.href='?page=1&pageSize=' + this.value">
                        <option value="10" ${pageSize == 10 ? 'selected' : ''}>10 per page</option>
                        <option value="20" ${pageSize == 20 ? 'selected' : ''}>20 per page</option>
                        <option value="50" ${pageSize == 50 ? 'selected' : ''}>50 per page</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Feedback Details Modal -->
        <div class="modal" id="feedbackModal">
            <div class="modal-overlay"></div>
            <div class="modal-container">
                <div class="modal-header">
                    <h2 class="modal-title">Feedback Details</h2>
                    <button class="modal-close">
                    <i class="fas fa-times"></i>
                </button>
                </div>
                <div class="modal-content">
                    <div class="feedback-details">
                        <div class="customer-info">
                            <div class="customer-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="customer-details">
                                <h3 id="customerName"></h3>
                                <div class="service-name" id="serviceName"></div>
                                <div class="rating-display">
                                    <div class="stars" id="ratingStars"></div>
                                    <span class="rating-date" id="feedbackDate"></span>
                                </div>
                            </div>
                        </div>

                        <div class="feedback-content">
                            <h4>Customer Feedback</h4>
                            <p id="feedbackText"></p>
                        </div>

                        <div class="response-section">
                            <h4>Response</h4>
                            <div class="response-status">
                                <label>Status:</label>
                                <select id="feedbackStatus">
                                <option value="pending">Pending</option>
                                <option value="responded">Responded</option>
                                <option value="archived">Archived</option>
                            </select>
                            </div>
                            <div class="response-form">
                                <label>Response Message:</label>
                                <textarea id="responseText" rows="4" placeholder="Enter your response..."></textarea>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn-secondary" data-action="close">Close</button>
                    <button class="btn-primary" data-action="save">
                    <i class="fas fa-paper-plane"></i>
                    Send Response
                </button>
                </div>
            </div>
        </div>

        <script src="assets/js/main.js"></script>
        <script src="assets/js/feedbacks.js"></script>
        <script>
            function handleFilter(event) {
                event.preventDefault();

                const formData = {
                    search: document.getElementById('searchQuery').value,
                    serviceId: document.getElementById('serviceId').value,
                    rating: document.getElementById('rating').value
                };

                fetch('feedback', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify(formData)
                    })
                    .then(response => response.text())
                    .then(html => {
                        document.getElementById('feedbackResults').innerHTML = html;
                    })
                    .catch(error => console.error('Error:', error));

                return false;
            }

            // Thêm event listeners cho các select để tự động submit form khi thay đổi
            document.getElementById('serviceId').addEventListener('change', function() {
                document.getElementById('filterForm').dispatchEvent(new Event('submit'));
            });

            document.getElementById('rating').addEventListener('change', function() {
                document.getElementById('filterForm').dispatchEvent(new Event('submit'));
            });
        </script>
    </body>

    </html>