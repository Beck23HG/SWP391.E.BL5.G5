<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reservation Confirmed - Children Care System</title>
        <meta name="description" content="Your healthcare service reservation has been confirmed">

        <!-- Standard head includes -->
        <link rel="icon" type="image/x-icon" href="assets/images/favicon.ico">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    </head>

    <body>
        <!-- Include Header -->
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
            <!-- Success Hero Section -->
            <section class="success-hero">
                <div class="container">
                    <div class="success-animation">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <h1 class="display-4 fw-bold text-center mb-4">Reservation Confirmed!</h1>
                    <p class="lead text-center mb-0">Your reservation has been successfully submitted.</p>
                </div>
            </section>

            <!-- Success Content -->
            <section class="success-content py-5">
                <div class="container">
                    <div class="row">
                        <!-- Main Content -->
                        <div class="col-lg-12">
                            <!-- Reservation Details -->
                            <div class="content-card mb-4">
                                <h2>Reservation Details</h2>
                                <div class="reservation-info mt-4">
                                    <div class="row g-4">
                                        <!-- Doctor Information -->
                                        <div class="col-md-6">
                                            <h5>Assigned Healthcare Team</h5>
                                            <div class="team-info">
                                                <div class="doctor-info mb-3">
                                                    <p class="mb-1"><strong>Doctor:</strong></p>
                                                    <div class="d-flex align-items-center">
                                                        <img src="${doctor.image}" alt="Doctor" class="team-member-avatar me-2" style="width: 60px; height: 60px; object-fit: cover;">
                                                        <div>
                                                            <p class="mb-0 fw-bold">${doctor.personName}</p>
                                                            <small class="text-muted">${doctor.email}</small>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <h5>Customer Information</h5>
                                            <ul class="list-unstyled contact-details">
                                                <li><i class="fas fa-user me-2"></i><span id="customerName"></span></li>
                                                <li><i class="fas fa-envelope me-2"></i><span id="customerEmail"></span>
                                                </li>
                                                <li><i class="fas fa-phone me-2"></i><span id="customerPhone"></span></li>
                                                <li><i class="fas fa-map-marker-alt me-2"></i><span id="customerAddress"></span></li>
                                            </ul>
                                        </div>

                                        <!-- Services List -->
                                        <div class="col-md-12 mt-4">
                                            <h5>Selected Services</h5>
                                            <div class="table-responsive">
                                                <table class="table">
                                                    <thead>
                                                        <tr>
                                                            <th>Image</th>
                                                            <th>Service ID</th>
                                                            <th>Service Name</th>
                                                            <th>Price</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach items="${serviceList}" var="service">
                                                            <tr>
                                                                <td>
                                                                    <img src="${service.image}" alt="${service.serviceName}" class="img-fluid rounded" style="width: 150px; height: 150px; object-fit: cover;">
                                                                </td>
                                                                <td>#${service.serviceId}</td>
                                                                <td>${service.serviceName}</td>
                                                                <td class="fw-bold">$${service.price}</td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                    <tfoot>
                                                        <tr>
                                                            <td colspan="3" class="text-end fw-bold">Total Amount:</td>
                                                            <td class="fw-bold">
                                                                $
                                                                <c:set var="total" value="0" />
                                                                <c:forEach items="${serviceList}" var="service">
                                                                    <c:set var="total" value="${total + service.price}" />
                                                                </c:forEach>
                                                                ${total}
                                                            </td>
                                                        </tr>
                                                    </tfoot>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Payment Instructions -->


                        </div>

                        <!-- Sidebar -->

                    </div>
                </div>
            </section>
        </main>

        <!-- Footer -->


        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Get reservation details from localStorage and parse URL-encoded string
            const reservationDetailStr = localStorage.getItem('reservationDeatail');
            const services = JSON.parse(localStorage.getItem('serviceList') || '[]');

            if (reservationDetailStr) {
                // Convert URL-encoded string to URLSearchParams object
                const reservationDetail = new URLSearchParams(reservationDetailStr);

                // Update customer information
                document.getElementById('customerName').textContent = reservationDetail.get('fullName');
                document.getElementById('customerEmail').textContent = reservationDetail.get('email');
                document.getElementById('customerPhone').textContent = reservationDetail.get('mobile');
                document.getElementById('customerAddress').textContent = reservationDetail.get('address');

                // Parse services JSON string from URLSearchParams
                const servicesData = JSON.parse(decodeURIComponent(reservationDetail.get('services')));

                // Display selected services
                const servicesContainer = document.createElement('div');
                servicesContainer.className = 'selected-services mt-4';

               
                // Insert services container into the page
                document.querySelector('.reservation-info').appendChild(servicesContainer);

                // Display reservation date
                const reservationDate = new Date(reservationDetail.get('reservationDate'));
                const formattedDate = reservationDate.toLocaleDateString('en-US', {
                    weekday: 'long',
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                });
                // Add this element to your HTML where you want to display the date
                if (document.getElementById('reservationDate')) {
                    document.getElementById('reservationDate').textContent = formattedDate;
                }
            }

            // Generate a random reservation ID
            const reservationId = 'RES-' + new Date().getFullYear() + '-' +
                    Math.floor(Math.random() * 1000).toString().padStart(3, '0');
            document.getElementById('reservationId').textContent = reservationId;
            document.getElementById('paymentRefId').textContent = reservationId;

            // Clear localStorage after displaying
            localStorage.removeItem('serviceList');
        </script>
    </body>

</html>