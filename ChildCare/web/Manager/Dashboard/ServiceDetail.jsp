<%-- 
    Document   : ServiceDetail
    Created on : Dec 12, 2024, 12:06:50 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Services Management - Healthcare Manager</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Manager/Dashboard/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Manager/Dashboard/assets/css/services.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
        <style>
            /* Base styling */
            .service-detail-content {
                background-color: #f9f9f9;
                padding: 2rem 0;
            }

            /* Container spacing */
            .service-detail-content .container {
                max-width: 1200px;
                margin: 0 auto;
            }

            /* Main image styling */
            .service-gallery .main-image img {
                max-width: 100%;
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Title and price section */
            .service-title {
                font-size: 1.8rem;
                font-weight: bold;
                margin-bottom: 0.5rem;
                color: #333;
            }
            .sale-price {
                font-size: 1.5rem;
                font-weight: bold;
                color: #007bff;
            }

            /* Description section */
            .service-description {
                padding: 1.5rem;
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                margin-bottom: 1.5rem;
            }

            .service-description h2 {
                font-size: 1.4rem;
                margin-top: 1rem;
                color: #555;
            }

            /* Highlights section */
            .service-highlights {
                border-top: 1px solid #ddd;
                padding-top: 1.5rem;
                margin-top: 1.5rem;
            }
            .service-highlights h2 {
                font-size: 1.2rem;
                color: #444;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }
            .service-highlights i {
                font-size: 1.4rem;
            }

            /* What's included section */
            .service-description h3 {
                font-size: 1.6rem;
                margin-top: 2rem;
                color: #333;
                display: inline-block;
            }

            .service-description p,
            .service-description li {
                font-size: 1rem;
                line-height: 1.8;
                color: #666;
            }

            /* Responsive design */
            @media (max-width: 768px) {
                .service-description {
                    padding: 1rem;
                }

                .service-title {
                    font-size: 1.5rem;
                }

                .sale-price {
                    font-size: 1.3rem;
                }

                .service-highlights h2 {
                    font-size: 1.1rem;
                }
            }
            /* Container for centering buttons */
            .button-container {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 1rem; /* Khoảng cách giữa các nút */
                margin-top: 2rem;
            }

            /* Button styling */
            .action-btn {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 150px; /* Chiều rộng cố định */
                height: 40px; /* Chiều cao cố định */
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
                margin-right: 0.5rem; /* Khoảng cách giữa icon và chữ */
                font-size: 1.2rem;
            }
            .button-container {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 1rem;
                margin-top: 2rem;
            }
            .staff-list {
                display: flex;
                flex-wrap: wrap;
                align-items: center;
                gap: 8px;
                margin-top: 10px;
            }

            .staff-title {
                font-size: 1.75rem; /* Tăng kích thước ngang với <h3> (thường là 1.75rem) */
                font-weight: bold;
                margin-right: 12px;
                color: #333; /* Màu sắc cho nổi bật */
            }

            .staff-item {
                display: inline-block;
                background-color: #f0f0f0;
                color: #333;
                padding: 4px 8px;
                border-radius: 5px;
                font-size: 14px;
                border: 1px solid #ddd;
                transition: background-color 0.3s ease, box-shadow 0.3s ease;
            }

            .staff-item:hover {
                background-color: #007bff;
                color: white;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
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

            <div class="header-content">
                <h1>Services Management</h1>
            </div>
            <section class="service-detail-content py-5">
                <div class="container">
                    <div class="row">
                        <!-- Main Content -->
                        <div class="col-lg-12">
                            <!-- Service Images Gallery -->
                            <div class="service-gallery mb-4">
                                <div class="main-image">
                                    <img src="${service.image}" alt="${service.serviceName}"
                                         class="img-fluid rounded-4" id="mainImage">
                                </div>
                            </div>


                            <!-- Service Description -->
                            <div class="service-description">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <h1 class="service-title">Service Name: ${service.serviceName}</h1>

                                    </div>
                                    <div>
                                        <div class="sale-price text-primary">Price: $${service.price}</div>
                                    </div>
                                </div>
                                <h2 class="service-title">Description: ${service.description}</h2>

                                <div class="service-highlights my-4">
                                    <div class="row g-4">
                                        <div class="col-md-2">
                                            <div>

                                                <h2 class="service-title"><i class="fas fa-clock text-primary"></i> Duration: ${service.duration}</h2>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <h3>What's Included</h3>
                                <p>${service.detail}</p>
                                <div class="staff-list">
                                    <span class="staff-title">Staff:</span>
                                    <c:forEach var="staff" items="${staffs}">
                                        <span class="staff-item">${staff.personName}</span>
                                    </c:forEach>
                                </div>
                            </div>
                        </div>
                        <div class="button-container">
                            <form action="editService" method="get">
                                <input type="hidden" name="id" value="${service.serviceId}">
                                <a class="action-btn edit" href="#" onclick="this.closest('form').submit(); return false;">
                                    <i class="fas fa-edit"></i>
                                    Edit
                                </a>
                            </form>
                            <form action="ListService" method="get">
                                <a class="action-btn edit" href="#" onclick="this.closest('form').submit(); return false;">
                                    <i class="fas fa-arrow-left"></i>
                                    Back to list
                                </a>
                            </form>
                        </div>
                    </div>
            </section>
        </div>
    </body>
</html>
