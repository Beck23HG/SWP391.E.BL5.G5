<!DOCTYPE html>
<html lang="en">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Essential Vitamins for Child Growth - Children Care Blog</title>
            <meta name="description" content="Learn about the vital vitamins and minerals that support your child's healthy development">

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
                <!-- Blog Hero Section -->
                <section class="blog-detail-hero">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-10">
                                <div class="blog-meta text-center mb-3">
                                    <span><i class="far fa-calendar me-2"></i>
                                <fmt:formatDate value="${blog.created_Date}" pattern="MMM dd, yyyy"/>
                            </span>
                                    <span><i class="far fa-clock me-2"></i>5 min read</span>
                                    <span><i class="far fa-folder me-2"></i>Health Tips</span>
                                </div>
                                <h1 class="blog-title text-center mb-4">${blog.title}</h1>
                                <div class="author-info text-center mb-4">
                                    <img src="assets/images/doctor-1.jpg" alt="Dr. Emily Johnson" class="author-avatar">
                                    <div class="author-details">
                                        <h5 class="mb-0">${blog.person.personName}</h5>
                                        <span class="text-muted">Senior Pediatrician</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Blog Content -->
                <section class="blog-content py-5">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-8">
                                <!-- Featured Image -->
                                <div class="blog-featured-image mb-4">
                                    <img src="${pageContext.request.contextPath}/Manager/Dashboard/assets/images/blog/${blog.image}"  style="max-width: 300px; max-height: 300px;" alt="${blog.title}" class="img-fluid rounded-4">
                                </div>

                                <!-- Article Content -->
                                <article class="blog-article">
                                    <div class="article-content">
                                        <h3>Title: ${blog.title}</h3>
                                        <h2>Content: ${blog.content}</h2>
                                        <p>Description: ${blog.description}</p>
                                    </div>

                                    <!-- Article Footer -->
                                    <div class="article-footer mt-5">
                                        <div class="row align-items-center">
                                            <div class="col-md-6">
                                                <div class="tags">
                                                    <span class="me-2">Tags:</span>
                                                    <a href="#" class="tag">${blog.category.categoryName}</a>
                                                    <a href="#" class="tag">Child Health</a>
                                                    <a href="#" class="tag">Nutrition</a>
                                                </div>
                                            </div>
                                            <div class="col-md-6 text-md-end mt-3 mt-md-0">
                                                <div class="share-buttons">
                                                    <span class="me-2">Share:</span>
                                                    <a href="#" class="btn btn-light btn-sm"><i
                                                    class="fab fa-facebook-f"></i></a>
                                                    <a href="#" class="btn btn-light btn-sm"><i class="fab fa-twitter"></i></a>
                                                    <a href="#" class="btn btn-light btn-sm"><i
                                                    class="fab fa-linkedin-in"></i></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </article>

                                <!-- Author Box -->
                                <div class="author-box mt-5">
                                    <div class="row align-items-center">
                                        <div class="col-md-3">
                                            <img src="assets/images/doctor-1.jpg" alt="Dr. Emily Johnson" class="img-fluid rounded-circle">
                                        </div>
                                        <div class="col-md-9">
                                            <h4>${blog.person.personName}</h4>
                                            <p class="text-muted mb-2">Senior Pediatrician</p>
                                            <p>${blog.person.personName} has over 15 years of experience in pediatric care and specializes in child nutrition and development.</p>
                                            <div class="social-links">
                                                <a href="#"><i class="fab fa-linkedin-in"></i></a>
                                                <a href="#"><i class="fab fa-twitter"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Related Articles -->
                                <div class="related-articles mt-5">
                                    <!--<h3 class="section-title mb-4">Related Articles</h3>-->

                                    <!--                                    <div class="row g-4">
                                         Related article cards will be loaded dynamically 
                                    </div>-->
                                </div>
                            </div>

                            <!-- Sidebar -->
                            <div class="col-lg-4">
                                <div class="blog-sidebar">
                                    <!-- Table of Contents -->
                                    <div class="sidebar-widget toc-widget">
                                        <h4>Table of Contents</h4>
                                        <nav id="toc" class="toc-nav">
                                            <ul class="nav flex-column">
                                                <!-- TOC items will be generated dynamically -->
                                            </ul>
                                        </nav>
                                    </div>

                                    <!-- Popular Posts -->
<!--                                    <div class="sidebar-widget">
                                        <h4>Popular Posts</h4>
                                        <div class="popular-posts">
                                             Popular post items will be loaded dynamically 
                                        </div>
                                    </div>-->

                                    <!-- Categories -->
                                    <div class="sidebar-widget">
                                        <h4>Categories</h4>
                                        <ul class="category-list">
                                            <li><a href="#">Health Tips <span>(15)</span></a></li>
                                            <li><a href="#">Nutrition <span>(8)</span></a></li>
                                            <li><a href="#">Child Development <span>(12)</span></a></li>
                                            <li><a href="#">Parenting <span>(10)</span></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <!-- Newsletter Section -->
                <section class="newsletter-section py-5 bg-primary-soft">
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-6 text-center">
                                <h3 class="mb-4">Subscribe to Our Newsletter</h3>
                                <p class="mb-4">Get the latest health tips and insights delivered to your inbox.</p>
                                <form class="newsletter-form">
                                    <div class="input-group">
                                        <input type="email" class="form-control" placeholder="Enter your email">
                                        <button class="btn btn-primary" type="submit">Subscribe</button>
                                    </div>
                                </form>
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
                    <p class="mb-0">� 2024 Children Care. All rights reserved.</p>
                </div>
            </div>
        </footer>

            <!-- Scripts -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="assets/js/blog-detail.js"></script>
        </body>

</html>