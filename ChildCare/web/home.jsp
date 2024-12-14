<%-- 
    Document   : home
    Created on : Nov 30, 2024, 11:35:18 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Slider" %>
<%
    List<Slider> sliderList = (List<Slider>) request.getAttribute("sliderList");
%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Children Care System - Professional Healthcare for Kids</title>
        <!-- Meta tags for SEO -->
        <meta name="description"
              content="Professional healthcare services designed specifically for children. Expert pediatric care with a gentle touch.">
        <meta name="keywords" content="children care, pediatric, healthcare, kids health, child development">

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/images/favicon.ico">

        <!-- CSS Files -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Google Fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&family=Bubblegum+Sans&display=swap"
            rel="stylesheet">

        <style>
            .carousel-control-prev,
            .carousel-control-next {
                background-color: rgba(0, 0, 0, 0.5); /* Màu nền */
                border-radius: 50%; /* Tạo hình tròn */
                width: 40px;
                height: 40px;
                display: flex;
                justify-content: center;
                align-items: center;
                position: absolute;
                top: 50%; /* Đưa nút vào giữa theo chiều dọc */
                transform: translateY(-50%); /* Điều chỉnh để nút chính xác ở giữa */
                z-index: 10; /* Đảm bảo nút nằm trên hình ảnh */
            }

            .carousel-control-prev:hover,
            .carousel-control-next:hover {
                background-color: rgba(0, 0, 0, 0.8); /* Màu nền khi hover */
            }

            .carousel-control-prev-icon,
            .carousel-control-next-icon {
                filter: invert(1); /* Đổi màu icon thành trắng */
                width: 20px;
                height: 20px;
            }

            .carousel-control-prev {
                left: 15px; /* Khoảng cách từ bên trái */
            }

            .carousel-control-next {
                right: 15px; /* Khoảng cách từ bên phải */
            }
            .service-image img {
                width: 100%; /* Chiều rộng chiếm toàn bộ container */
                height: 200px; /* Đặt chiều cao cố định */
                object-fit: cover; /* Đảm bảo hình ảnh vừa khít mà không bị méo */
                border-radius: 5px; /* Thêm góc bo (tuỳ chọn) */
            }
        </style>
    </head>

    <body>
        <!-- Top Bar -->
        <div class="top-bar py-2 d-none d-lg-block">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-8">
                        <div class="d-flex text-muted">
                            <div class="me-4">
                                <i class="fas fa-phone-alt me-2"></i>Emergency: +1 234 567 890
                            </div>
                            <div>
                                <i class="fas fa-clock me-2"></i>Opening Hours: Mon - Fri, 8AM - 9PM
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="social-links text-end">
                            <a href="#" class="me-3"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Header Section -->
        <header class="header">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                    <a class="navbar-brand" href="home">
                        <img src="assets/images/children-care-logo-removebg.png" alt="Children Care Logo" class="logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto align-items-center">
                            <li class="nav-item">
                                <a class="nav-link active" href="home">Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="services">Services</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Our Doctors</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="blog">Blogs</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="#">Contact</a>
                            </li>
                            <li class="nav-item ms-lg-3">
                                <a class="btn btn-primary rounded-pill px-4" href="reservationView">
                                    <i class="fas fa-calendar-check me-2"></i>Book Appointment
                                </a>
                            </li>

                            <c:choose>
                                <c:when test="${sessionScope.account == null}">
                                    <li class="nav-item ms-lg-2">
                                        <a class="btn btn-outline-primary rounded-pill px-4" href="login">
                                            <i class="fas fa-user me-2"></i>Login
                                        </a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item ms-lg-2">
                                        <a class="btn btn-outline-primary rounded-pill px-4" href="userProfile">
                                            <i class="fas fa-user me-2"></i>Profile
                                        </a>
                                    </li>
                                    <li class="nav-item ms-lg-2">
                                        <a class="btn btn-outline-danger rounded-pill px-4" href="logout">
                                            <i class="fas fa-sign-out-alt me-2"></i>Logout
                                        </a>
                                    </li>
                                </c:otherwise>
                            </c:choose>

                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <!-- Main Content Area -->
        <main id="main-content">
            <!-- Hero Section -->
            <section class="hero-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6 pe-lg-5">
                            <span class="badge bg-primary-soft mb-3">
                                <i class="fas fa-heart me-2"></i>Welcome to Children Care
                            </span>
                            <h1 class="display-4 fw-bold mb-4">Caring for Your Child's Health & Future</h1>
                            <p class="lead mb-4">Professional healthcare services designed specifically for children,
                                providing the best medical care with a gentle touch.</p>
                            <div class="hero-buttons">
                                <a href="reservationView" class="btn btn-primary btn-lg rounded-pill me-3">
                                    <i class="fas fa-calendar-check me-2"></i>Book Appointment
                                </a>
                                <a href="services.html" class="btn btn-outline-primary btn-lg rounded-pill">
                                    <i class="fas fa-stethoscope me-2"></i>Our Services
                                </a>
                            </div>
                            <div class="trust-indicators mt-5">
                                <div class="row g-4">
                                    <div class="col-4">
                                        <div class="trust-item">
                                            <i class="fas fa-user-md fa-2x text-primary mb-2"></i>
                                            <h5>Expert Doctors</h5>
                                            <p class="small">20+ Specialists</p>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="trust-item">
                                            <i class="fas fa-clock fa-2x text-primary mb-2"></i>
                                            <h5>24/7 Support</h5>
                                            <p class="small">Always Available</p>
                                        </div>
                                    </div>
                                    <div class="col-4">
                                        <div class="trust-item">
                                            <i class="fas fa-heart fa-2x text-primary mb-2"></i>
                                            <h5>Happy Kids</h5>
                                            <p class="small">1000+ Patients</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="decorative-elements">
                                <div class="decorative-circle decorative-circle-1"></div>
                                <div class="decorative-circle decorative-circle-2"></div>
                            </div>
                            <div class="floating-gradient gradient-1"></div>
                            <div class="floating-gradient gradient-2"></div>
                        </div>

                        <div class="col-lg-6">
                            <!-- Carousel -->
                            <div id="demo" class="carousel slide" data-bs-ride="carousel">

                                <!-- Indicators/dots -->
                                <div class="carousel-indicators">
                                    <%
                                        for (int i = 0; i < sliderList.size(); i++) {
                                    %>
                                    <button type="button" data-bs-target="#demo" data-bs-slide-to="<%= i %>" class="<%= (i == 0) ? "active" : "" %>"></button>
                                    <%
                                        }
                                    %>
                                </div>

                                <!-- The slideshow/carousel -->
                                <div class="carousel-inner">
                                    <%
                                        for (int i = 0; i < sliderList.size(); i++) {
                                            Slider slider = sliderList.get(i);
                                    %>
                                    <div class="carousel-item <%= (i == 0) ? "active" : "" %>">
                                        <a href="<%= slider.getBacklink() %>">
                                            <img src="assets/images/Slider/<%= slider.getImage() %>" alt="<%= slider.getTitle() %>" class="d-block w-100" style="object-fit: cover;
                                                 height: 400px;">
                                        </a>
                                        <div class="carousel-caption d-flex justify-content-center align-items-center">
                                            <h5 style="background: rgba(0, 0, 0, 0.5); color: #fff; padding: 10px; border-radius: 5px;">
                                                <%= slider.getTitle() %>
                                            </h5>
                                        </div>
                                    </div>

                                    <%
                                        }
                                    %>
                                </div>

                                <!-- Left and right controls/icons -->
                                <button class="carousel-control-prev" type="button" data-bs-target="#demo" data-bs-slide="prev">
                                    <span class="carousel-control-prev-icon"></span>
                                </button>
                                <button class="carousel-control-next" type="button" data-bs-target="#demo" data-bs-slide="next">
                                    <span class="carousel-control-next-icon"></span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Features Section -->
            <section class="features-section py-5">
                <div class="container">
                    <div class="row g-4">
                        <div class="col-lg-3 col-md-6">
                            <div class="feature-card">
                                <div class="icon-wrapper mb-4">
                                    <i class="fas fa-stethoscope"></i>
                                </div>
                                <h4>Expert Care</h4>
                                <p>Professional pediatric care from experienced doctors</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="feature-card">
                                <div class="icon-wrapper mb-4">
                                    <i class="fas fa-clock"></i>
                                </div>
                                <h4>24/7 Service</h4>
                                <p>Round-the-clock medical support for emergencies</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="feature-card">
                                <div class="icon-wrapper mb-4">
                                    <i class="fas fa-hospital"></i>
                                </div>
                                <h4>Modern Facility</h4>
                                <p>State-of-the-art medical equipment and facilities</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="feature-card">
                                <div class="icon-wrapper mb-4">
                                    <i class="fas fa-user-md"></i>
                                </div>
                                <h4>Qualified Doctors</h4>
                                <p>Team of certified and experienced pediatricians</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Why Choose Us Section -->
            <section class="why-choose-us py-5">
                <div class="container">
                    <div class="section-header text-center mb-5">
                        <span class="badge bg-primary-soft mb-3">Our Blogs</span>
                        <h2 class="display-5 fw-bold">Information For Your Child's Future</h2>
                        <p class="text-muted">Discover some information for children's health</p>
                    </div>
                    <div class="row g-4" id="blogContainer">
                        <c:forEach items="${blogs}" var="blog">
                            <div class="col-md-6 col-lg-4 blog-item">
                                <article class="blog-card featured">
                                    <div class="blog-card-image">
                                        <img src="${pageContext.request.contextPath}/Manager/Dashboard/assets/images/blog/${blog.image}" alt="${blog.title}" class="img-fluid">
                                        <span class="category-badge">Health Tips</span>
                                    </div>
                                    <div class="blog-card-content">
                                        <div class="blog-meta">
                                            <span><i class="far fa-calendar me-2"></i>
                                                <fmt:formatDate value="${blog.created_Date}" pattern="MMM dd, yyyy"/>
                                            </span>
                                            <span><i class="far fa-clock me-2"></i>5 min read</span>
                                        </div>
                                        <h3 class="blog-title">${blog.title}</h3>
                                        <p class="blog-excerpt">${blog.description}</p>
                                        <a href="blog-detail?id=${blog.blogId}" class="btn btn-link text-primary p-0">
                                            Read More <i class="fas fa-arrow-right ms-2"></i>
                                        </a>
                                    </div>
                                </article>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>

            <!-- Services Section -->
            <section class="services-section py-5">
                <div class="container">
                    <div class="section-header text-center mb-5">
                        <span class="badge bg-primary-soft mb-3">Our Services</span>
                        <h2 class="display-5 fw-bold gradient-text">Healthcare Services for Your Child</h2>
                        <p class="text-muted">Discover our comprehensive range of pediatric care services</p>
                    </div>
                    <div class="row g-4">

                        <c:forEach items="${services}" var="s">
                            <div class="service-card col-4">
                                <div class="service-image">
                                    <img src="assets/images/Service/${s.image}">
                                </div>
                                <div class="service-content">
                                    <h3 class="service-title">
                                        ${s.serviceName}
                                    </h3>
                                    <p class="service-brief">${s.description}</p>
                                    <div class="service-price sale-price">
                                        $${s.price}
                                    </div>
                                    <div class="service-actions">
                                        <a href="serviceDetail?id=${s.serviceId}"
                                           <button class="btn btn-primary">
                                            <i class="fas fa-eye"></i>      
                                            View detail
                                            </button>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>
                </div>
            </section>

            <!-- Testimonials Section -->
            <section class="testimonials-section py-5 bg-light">
                <div class="container">
                    <div class="section-header text-center mb-5">
                        <span class="badge bg-primary-soft mb-3">Testimonials</span>
                        <h2 class="display-5 fw-bold">What Parents Say</h2>
                        <p class="text-muted">Hear from our happy parents about their experience</p>
                    </div>
                    <div class="row testimonials-slider">

                        <c:forEach items="${feedbacks}" var="f">
                            <div class="col-lg-4">
                                <div class="testimonial-card">
                                    <div class="testimonial-content">
                                        <h4>Service: ${f.service.serviceName}</h4>
                                        <div class="rating mb-3">
                                            <c:forEach var="i" begin="1" end="5">
                                                <i class="fas fa-heart ${i <= f.starRating ? 'text-primary' : ''}"></i>
                                            </c:forEach>
                                        </div>
                                        <p class="mb-4">"${f.content}"</p>
                                        <div class="testimonial-author d-flex align-items-center">
                                            <img src="assets/images/Profile/${f.person.image}" alt="Parent" class="rounded-circle">
                                            <div class="ms-3">
                                                <h5 class="mb-1">${f.person.personName}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>

            <!-- Statistics Section -->
            <section class="statistics-section py-5">
                <div class="container">
                    <div class="row g-4 text-center">
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card">
                                <div class="stat-icon mb-3">
                                    <i class="fas fa-user-md"></i>
                                </div>
                                <h3 class="counter">50+</h3>
                                <p>Expert Doctors</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card">
                                <div class="stat-icon mb-3">
                                    <i class="fas fa-smile"></i>
                                </div>
                                <h3 class="counter">1000+</h3>
                                <p>Happy Patients</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card">
                                <div class="stat-icon mb-3">
                                    <i class="fas fa-certificate"></i>
                                </div>
                                <h3 class="counter">25+</h3>
                                <p>Years Experience</p>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6">
                            <div class="stat-card">
                                <div class="stat-icon mb-3">
                                    <i class="fas fa-hospital"></i>
                                </div>
                                <h3 class="counter">10+</h3>
                                <p>Medical Centers</p>
                            </div>
                        </div>
                    </div>
                </div>
            </section>

        </main>

        <!-- Footer Section -->
        <footer class="footer bg-light py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-lg-4">
                        <h5 class="fw-bold mb-4">About Children Care</h5>
                        <p class="text-muted">Providing comprehensive healthcare services for children with care,
                            compassion, and expertise.</p>
                        <div class="social-links mt-4">
                            <a href="#" class="me-3"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-1"></div>
                    <div class="col-lg-4">
                        <h5 class="fw-bold mb-4">Quick Links</h5>
                        <ul class="list-unstyled footer-links">
                            <li><a href="#">Services</a></li>
                            <li><a href="blog">Blogs</a></li>
                            <li><a href="#">Contact</a></li>
                            <li><a href="#">About Us</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3">
                        <h5 class="fw-bold mb-4">Contact Info</h5>
                        <ul class="list-unstyled contact-info">
                            <li><i class="fas fa-phone text-primary"></i> +1 234 567 890</li>
                            <li><i class="fas fa-envelope text-primary"></i> info@childrencare.com</li>
                            <li><i class="fas fa-location-dot text-primary"></i> 123 Healthcare St, Medical City</li>
                        </ul>
                    </div>
                </div>
                <div class="footer-bottom text-center mt-5 pt-4 border-top">
                    <p class="mb-0">© 2024 Children Care. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Back to Top Button -->
        <a href="#" class="back-to-top" id="backToTop">
            <i class="fas fa-arrow-up"></i>
        </a>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/main.js"></script>
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