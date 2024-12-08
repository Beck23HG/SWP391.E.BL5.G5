<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Our Services - Children Care System</title>
        <meta name="description"
              content="Comprehensive healthcare services for children - Pediatric care, vaccinations, and child development">

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
        <style>
            .service-image img {
                width: 100%;
                height: 200px;
                object-fit: cover;
                border-radius: 5px;
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
                                <a class="btn btn-primary rounded-pill px-4" href="#">
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

        <!-- Main Content -->
        <main id="main-content">
            <!-- Services Hero Section -->
            <section class="services-hero-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-8">
                            <h1 class="display-4 fw-bold mb-4">Our Services</h1>
                            <p class="lead mb-4">Discover our comprehensive range of pediatric healthcare services</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- Services Content -->
            <section class="services-content py-5">
                <div class="container">
                    <div class="row">
                        <!-- Main Content -->
                        <div class="col-lg-9">
                            <!-- Services Grid -->
                            <div class="row g-4">

                                <c:forEach items="${services}" var="s">
                                    <div class="service-card col-4">
                                        <div class="service-image">
                                            <img src="${s.image}">
                                        </div>
                                        <div class="service-content">
                                            <h3 class="service-title">
                                                ${s.serviceName}
                                            </h3>
                                            <p class="service-brief">${s.description}</p>
                                            <div class="service-price sale-price">
                                                ${s.price}$
                                            </div>
                                            <div class="service-actions">
                                                <button class="btn btn-primary">
                                                    <i class="fas fa-eye"></i>      
                                                    View detail
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>

                            </div>

                            <ul class="pagination">
                                <li class="page-item ${indexx == 1 ? 'disabled' : ''}">
                                    <a class="page-link" href="<c:choose>
                                           <c:when test="${not empty param.serviceName or not empty param.price1 or not empty param.price2}">
                                               <c:set var='urlParams' value='services' />
                                               <c:if test="${not empty param.serviceName}">
                                                   <c:set var="urlParams" value="${urlParams}?serviceName=${param.serviceName}" />
                                               </c:if>
                                               <c:if test="${not empty param.price1 and not empty param.price2}">
                                                   <c:set var="urlParams" value="${urlParams}?price1=${param.price1}&price2=${param.price2}" />
                                               </c:if>
                                               <c:set var="urlParams" value="${urlParams}&index=${indexx - 1}" />
                                               ${urlParams}
                                           </c:when>
                                           <c:otherwise>
                                               <c:set var="urlParams" value="services?index=${indexx - 1}" />
                                               ${urlParams}
                                           </c:otherwise>
                                       </c:choose>">Previous</a>
                                </li>


                                <c:forEach begin="1" end="${endPage}" var="i">
                                    <c:set var="urlParams" value="services" />

                                    <c:if test="${not empty param.serviceName}">
                                        <c:set var="urlParams" value="${urlParams}?serviceName=${param.serviceName}" />
                                    </c:if>

                                    <c:if test="${not empty param.price1 and not empty param.price2}">
                                        <c:set var="urlParams" value="${urlParams}?price1=${param.price1}&price2=${param.price2}" />
                                    </c:if>

                                    <c:choose>
                                        <c:when test="${empty param.serviceName and empty param.price1 and empty param.price2}">
                                            <c:set var="urlParams" value="${urlParams}?index=${i}" />
                                        </c:when>
                                        <c:otherwise>
                                            <c:set var="urlParams" value="${urlParams}&index=${i}" />
                                        </c:otherwise>
                                    </c:choose>

                                    <c:choose>
                                        <c:when test="${indexx == i}">
                                            <li class="page-item">
                                                <a class="page-link" href="${urlParams}" style="color: #FC354C">${i}</a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item">
                                                <a class="page-link" href="${urlParams}">${i}</a>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>


                                <li class="page-item ${indexx == endPage ? 'disabled' : ''}">
                                    <a class="page-link" href="<c:choose>
                                           <c:when test="${not empty param.serviceName or not empty param.price1 or not empty param.price2}">
                                               <c:set var='urlParams' value='services' />
                                               <c:if test="${not empty param.serviceName}">
                                                   <c:set var="urlParams" value="${urlParams}?serviceName=${param.serviceName}" />
                                               </c:if>
                                               <c:if test="${not empty param.price1 and not empty param.price2}">
                                                   <c:set var="urlParams" value="${urlParams}?price1=${param.price1}&price2=${param.price2}" />
                                               </c:if>
                                               <c:set var="urlParams" value="${urlParams}&index=${indexx + 1}" />
                                               ${urlParams}
                                           </c:when>
                                           <c:otherwise>
                                               <c:set var="urlParams" value="services?index=${indexx + 1}" />
                                               ${urlParams}
                                           </c:otherwise>
                                       </c:choose>">Next</a>
                                </li>
                            </ul>
                        </div>

                        <!-- Sidebar -->
                        <div class="col-lg-3">
                            <!-- Search Box -->
                            <div class="sidebar-card mb-4">
                                <h4>Search Services</h4>
                                <form>
                                    <div class="search-box">
                                        <input type="text" class="form-control" name="serviceName"
                                               placeholder="Search services...">
                                        <button class="btn btn-primary" type="submit">
                                            <i class="fas fa-search"></i>
                                        </button>
                                    </div>
                                </form>

                            </div>

                            <!-- Service Categories -->
                            <div class="sidebar-card mb-4">
                                <h4>Price Ranges</h4>
                                <ul class="category-list" id="priceRanges">
                                    <li>
                                        <form action="services" method="get">
                                            <input type="hidden" name="price1" value="0">
                                            <input type="hidden" name="price2" value="100">
                                            <button type="submit" class="btn btn-link text-start w-100">Under $100</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="services" method="get">
                                            <input type="hidden" name="price1" value="100">
                                            <input type="hidden" name="price2" value="150">
                                            <button type="submit" class="btn btn-link text-start w-100">$100 - $150</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="services" method="get">
                                            <input type="hidden" name="price1" value="150">
                                            <input type="hidden" name="price2" value="200">
                                            <button type="submit" class="btn btn-link text-start w-100">$150 - $200</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="services" method="get">
                                            <input type="hidden" name="price1" value="200">
                                            <input type="hidden" name="price2" value="250">
                                            <button type="submit" class="btn btn-link text-start w-100">$200 - $250</button>
                                        </form>
                                    </li>
                                    <li>
                                        <form action="services" method="get">
                                            <input type="hidden" name="price1" value="250">
                                            <input type="hidden" name="price2" value="300">
                                            <button type="submit" class="btn btn-link text-start w-100">$250 - $300</button>
                                        </form>
                                    </li>
                                </ul>
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

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>