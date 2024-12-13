<%-- 
    Document   : serviceDetail
    Created on : Dec 10, 2024, 2:20:38 AM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pediatric Consultation - Children Care System</title>
        <meta name="description" content="Comprehensive pediatric consultation services for your child's health">

        <!-- Standard head includes (CSS, Fonts, etc.) -->
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
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">

    </head>

    <body>
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

        <main id="main-content">
            <!-- Service Detail Hero -->
            <section class="service-detail-hero">
                <div class="container">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                            <li class="breadcrumb-item"><a href="services">Services</a></li>
                            <li class="breadcrumb-item active">${service.serviceName}</li>
                        </ol>
                    </nav>
                </div>
            </section>

            <!-- Service Content -->
            <section class="service-detail-content py-5">
                <div class="container">
                    <div class="row">
                        <!-- Main Content -->
                        <div class="col-lg-12">
                            <!-- Service Images Gallery -->
                            <div class="service-gallery mb-4">
                                <div class="main-image">
                                    <img src="${service.image}" alt="${service.serviceName}" class="img-fluid rounded-4" id="mainImage">
                                </div>
                                <div class="thumbnail-images mt-3">
                                    <div class="row g-2" id="imageGallery">
                                        <!-- Thumbnail images will be loaded dynamically -->
                                    </div>
                                </div>
                            </div>

                            <!-- Service Header -->
                            <div class="service-header mb-4">
                                <div class="d-flex justify-content-between align-items-start">
                                    <div>
                                        <span class="service-category badge bg-primary-soft mb-2">${service.serviceName}</span>
                                        <h1 class="service-title mb-2">${service.serviceName}</h1>
                                        <div class="service-meta">
                                            <span class="service-rating">
                                                <c:forEach var="i" begin="1" end="5">
                                                    <c:choose>
                                                        <c:when test="${i <= Math.floor(starRating)}">
                                                            <i class="fas fa-star text-warning"></i>
                                                        </c:when>

                                                        <c:when test="${i == Math.floor(starRating) + 1 && (starRating % 1) >= 0.5}">
                                                            <i class="fas fa-star-half-alt text-warning"></i>
                                                        </c:when>

                                                        <c:otherwise>
                                                            <i class="far fa-star"></i>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </c:forEach>
                                                <span class="ms-2">(${starRating}/5 - ${totalRating} Reviews)</span>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="service-price text-end">
                                        <div class="sale-price text-primary h3 mb-0">$${service.price}</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Service Description -->
                            <div class="service-description mb-4">
                                <h2>Service Overview</h2>
                                <p class="lead">${service.description}</p>

                                <div class="service-highlights my-4">
                                    <div class="row g-4">
                                        <div class="col-md-6">
                                            <div class="highlight-card">
                                                <i class="fas fa-clock text-primary"></i>
                                                <h4>Duration</h4>
                                                <p>${service.duration}</p>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="highlight-card">
                                                <i class="fas fa-user-md text-primary"></i>
                                                <h4>Expert Care</h4>
                                                <p>Board-certified pediatricians</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <h3>What's Included</h3>
                                ${service.detail}
                            </div>

                            <!-- Booking Section -->
                            <div class="booking-section">
                                <div class="card">
                                    <div class="card-body">
                                        <h3>Book This Service</h3>
                                        <div class="row align-items-center">
                                            <div class="col-md-2">
                                                <button class="btn btn-primary btn-lg w-100" onclick="addToCartx('${service.serviceId}', '${service.serviceName}', '${service.price}', '${service.image}')">
                                                    <i class="fas fa-shopping-cart me-2"></i>Add to Cart
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Reviews Section -->
                            <div class="reviews-section mt-5">
                                <h3>Patient Reviews</h3>
                                <div class="reviews-container" id="reviewsContainer">
                                    <!-- Reviews will be loaded dynamically -->
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>
        </main>

        <!-- Footer -->
        <footer class="footer bg-light py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-lg-4">
                        <h5 class="fw-bold mb-4">About Children Care</h5>
                        <p class="text-muted">Providing comprehensive healthcare services for children with care, compassion, and expertise.</p>
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
                            <li><a href="services">Services</a></li>
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
        <script>


            function addToCartx(id, name, price, image) {
                if (!localStorage.getItem('serviceList')) {
                    localStorage.setItem('serviceList', JSON.stringify([]));
                }
                let serviceList = JSON.parse(localStorage.getItem('serviceList'));
                const existingService = serviceList.find(service => service.id === id);
                if (existingService) {
                    alert("This service has already been added !");
                    return;
                }
                const service = {
                    id: id,
                    name: name,
                    price: price,
                    image: image
                };
                serviceList.push(service);
                localStorage.setItem('serviceList', JSON.stringify(serviceList));
                const serviceElement = document.getElementById("service-" + id);
                alert("Add service successfully !");


            }
        </script>
        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>