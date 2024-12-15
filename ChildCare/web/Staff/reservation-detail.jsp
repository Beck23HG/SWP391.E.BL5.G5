<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reservation Details - Healthcare Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="../Admin/assets/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="../Admin/assets/css/feedbacks.css" rel="stylesheet" type="text/css"/>
    <link href="../Admin/assets/css/reservation.css" rel="stylesheet" type="text/css"/>
    <link href="assetsStaff/reservation-detail.css" rel="stylesheet" type="text/css"/>
<!--    style cho Notification Messages-->
    <style>
        .notification-container {
            margin: 20px 0;
        }

        .alert {
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 14px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            color: #721c24;
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
        }

        .alert i {
            font-size: 18px;
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
            <a href="reservationlist" class="nav-item active">
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
        <!-- Top Navigation -->
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
                        <a href="../logout" style="padding: 10% 0">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Sign Out</span>
                        </a>
                    </div>
                    <div class="theme-toggle" title="Toggle theme">
                    </div>
                </div>
            </div>

        <!-- Reservation Details Content -->
        <div class="page-container">
            <div class="page-header">
                <h1>Reservation Details</h1>
                <div class="action-buttons">
                    <a href="reservationlist" class="btn btn-back">
                        <i class="fas fa-arrow-left"></i> Back to Reservation Management
                    </a>
                </div>
            </div>
            
            <!-- Notification Messages -->
            <div class="notification-container">
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> ${successMessage}
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i> ${errorMessage}
                    </div>
                </c:if>
            </div>
            
            <div class="reservation-details-container">
                <!-- Reservation Basic Information -->
                <div class="details-section">
                    <h2>Reservation Information</h2>
                    <div class="details-grid">
                        <div class="detail-item">
                            <label>Reservation ID</label>
                            <span>${reservationDetail.reservationId}</span>
                        </div>
                        <div class="detail-item">
                            <label>Customer Name</label>
                            <span>${reservationDetail.customer.personName}</span>
                        </div>
                        <div class="detail-item">
                            <label>Email</label>
                            <span>${reservationDetail.customer.email}</span>
                        </div>
                        <div class="detail-item">
                            <label>Mobile</label>
                            <span>${reservationDetail.customer.phone}</span>
                        </div>
                        <div class="detail-item">
                            <label>Reservation Date</label>
                            <span>${reservationDetail.reservationDate}</span>
                        </div>
                        <div class="detail-item">
                            <label>Total Cost</label>
                            <span>$<fmt:formatNumber value="${totalCost}" type="number" minFractionDigits="0" maxFractionDigits="2" /></span>
                        </div>
                        <div class="detail-item">
                            <label>Reservation Name</label>
                            <span>${reservationDetail.note}</span>
                        </div>
                        <div class="detail-item">
                            <label>Status:</label>
                            <form method="post" action="reservationdetail">
                                <select name="status" class="filter-select">
                                    <option value="1" ${reservationDetail.status == 1 ? "selected" : ""}>Confirmed</option>
                                    <option value="2" ${reservationDetail.status == 2 ? "selected" : ""}>Pending</option>
                                    <option value="3" ${reservationDetail.status == 3 ? "selected" : ""}>Completed</option>
                                    <option value="4" ${reservationDetail.status == 4 ? "selected" : ""}>Cancelled</option>
                                </select>
                                <input type="hidden" name="reservationId" value="${reservationDetail.reservationId}">
                                <button type="submit" class="btn btn-primary">Save</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Receiver Information -->
                <div class="details-section">
                    <h2>Receiver Information</h2>
                    <div class="details-grid">
                        <div class="detail-item">
                            <label>Full Name</label>
                            <span>${reservationDetail.customer.personName}</span>
                        </div>
                        <div class="detail-item">
                            <label>Gender</label>
                            <span>${reservationDetail.customer.gender ? "Male" : "Female"}</span>
                        </div>
                        <div class="detail-item">
                            <label>Email</label>
                            <span>${reservationDetail.customer.email}</span>
                        </div>
                        <div class="detail-item">
                            <label>Mobile</label>
                            <span>${reservationDetail.customer.phone}</span>
                        </div>
                        <div class="detail-item full-width">
                            <label>Address</label>
                            <span>${reservationDetail.customer.address}</span>
                        </div>
                    </div>
                </div>

                <!-- Reserved Services -->
                <div class="details-section">
                    <h2>Reserved Services</h2>
                    <c:forEach var="service" items="${reservedServices}">
                        <div class="service-item single-service">
                            <div class="service-thumbnail">
                                <img src="${pageContext.request.contextPath}/assets/images/Service/${service.image}" alt="Service Thumbnail">
                            </div>
                            <div class="service-details">
                                <h3>${service.serviceName}</h3>
                                <div class="service-meta">
                                    <div class="service-info">
                                        <span class="service-category">
                                            <i class="fas fa-tag"></i> Medical Examination
                                        </span>
                                    </div>
                                    <div class="service-pricing">
                                        <!-- Format giá trị để xóa số 0 thừa sau dấu chấm -->
                                        <span class="service-cost">
                                            $<fmt:formatNumber value="${service.price}" type="number" minFractionDigits="0" maxFractionDigits="2" />
                                        </span>
                                    </div>
                                </div>
                                <div class="service-description">
                                    ${service.description}
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
</body>
</html>