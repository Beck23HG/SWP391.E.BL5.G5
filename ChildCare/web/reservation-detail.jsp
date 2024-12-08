<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reservation Details - Children Care System</title>
        <meta name="description" content="Review and modify your selected healthcare services">

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
        <!-- Include Header -->
        <header class="header fixed-top">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                    <a class="navbar-brand" href="/">
                        <img src="assets/images/children-care-logo-removebg.png" alt="Children Care Logo" class="logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto align-items-center">
                            <li class="nav-item">
                                <a class="nav-link active" href="/">Home</a>
                            </li>
                            <li class="nav-item dropdown">
                                <button class="nav-link dropdown-toggle btn btn-link" data-bs-toggle="dropdown">
                                    <a style="text-decoration: none; color: inherit;" href="/services">Services</a>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="/services/pediatric">Pediatric Care</a></li>
                                    <li><a class="dropdown-item" href="/services/vaccination">Vaccination</a></li>
                                    <li><a class="dropdown-item" href="/services/development">Child Development</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/doctors">Our Doctors</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/blogs">Blogs</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="/contact">Contact</a>
                            </li>
                            <li class="nav-item ms-lg-3">
                                <a class="btn btn-primary rounded-pill px-4" href="/appointment">
                                    <i class="fas fa-calendar-check me-2"></i>Book Appointment
                                </a>
                            </li>
                            <li class="nav-item ms-lg-2">
                                <a class="btn btn-outline-primary rounded-pill px-4" href="/login">
                                    <i class="fas fa-user me-2"></i>Login
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <!-- Main Content -->
        <main id="main-content">
            <!-- Reservation Hero Section -->
            <section class="reservation-hero">
                <div class="container">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="/">Home</a></li>
                            <li class="breadcrumb-item"><a href="/services">Services</a></li>
                            <li class="breadcrumb-item active">Reservation Details</li>
                        </ol>
                    </nav>
                    <h1 class="display-4 fw-bold mb-4">Your Reservation</h1>
                </div>
            </section>

            <!-- Reservation Content -->
            <section class="reservation-content py-5">
                <div class="container">
                    <div class="row">
                        <!-- Main Content -->
                        <div class="col-lg-12">
                            <!-- Services Cart -->
                            <div class="cart-container">
                                <!-- Cart Items -->
                                <div class="cart-items" id="cartItems">
                                    <!-- Move script to bottom of page and add necessary functions -->
                                </div>

                                <!-- Cart Summary -->
                                <div class="cart-summary mt-4">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <button type="button" class="btn btn-outline-primary" data-bs-toggle="modal" data-bs-target="#servicesModal">
                                                <i class="fas fa-plus me-2"></i>Choose More Services
                                            </button>
                                        </div>

                                        <!-- Services Modal -->
                                        <div class="modal fade" id="servicesModal" tabindex="-1" aria-labelledby="servicesModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-scrollable modal-xl">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h5 class="modal-title" id="servicesModalLabel">Choose Additional Services</h5>
                                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <!-- Search Form -->
                                                        <form action="reservationView" method="get" id="searchForm" class="mb-4">
                                                            <div class="input-group">
                                                                <span class="input-group-text">
                                                                    <i class="fas fa-search"></i>
                                                                </span>
                                                                <input type="text" class="form-control form-control-lg" id="serviceSearch" name="keyword" placeholder="Search services..." value="${searchKeyword}">
                                                                <button type="submit" class="btn btn-primary">
                                                                    <i class="fas fa-search me-2"></i>Search
                                                                </button>
                                                            </div>
                                                        </form>

                                                        <!-- Services Grid -->
                                                        <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-3" id="servicesList">
                                                            <c:forEach items="${serviceList}" var="service">
                                                                <div class="col service-item" id="service-${service.serviceId}">
                                                                    <div class="card h-100 shadow-sm">
                                                                        <div class="position-relative">
                                                                            <img src="${service.image}" class="card-img-top" alt="${service.serviceName}" style="height: 180px; object-fit: cover;">
                                                                            <div class="position-absolute top-0 end-0 p-2">
                                                                                <span class="badge bg-primary">$${service.price}</span>
                                                                            </div>
                                                                        </div>
                                                                        <div class="card-body d-flex flex-column">
                                                                            <h6 class="card-title mb-2" style="font-size: 16px; line-height: 1.4; height: 45px; overflow: hidden;">
                                                                                ${service.serviceName}
                                                                            </h6>
                                                                            <p class="text-muted small mb-3">ID: ${service.serviceId}</p>
                                                                            <button class="btn btn-primary mt-auto w-100" onclick="addToCart('${service.serviceId}', '${service.serviceName}', '${service.price}', '${service.image}')" id="addBtn-${service.serviceId}">
                                                                                <i class="fas fa-plus me-2"></i>Add to Cart
                                                                            </button>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <script>
                                            if (!localStorage.getItem('serviceList')) {
                                                localStorage.setItem('serviceList', JSON.stringify([]));
                                            }

                                            // Handle form submission
                                            document.getElementById('searchForm').addEventListener('submit', function (e) {
                                                e.preventDefault();

                                                const keyword = document.getElementById('serviceSearch').value.trim();
                                                const currentUrl = new URL(window.location.href);

                                                // Update URL with search parameter
                                                currentUrl.searchParams.set('keyword', keyword);

                                                // Reload page with search parameter
                                                window.location.href = currentUrl.toString();
                                            });

                                            // Hide services that are already in cart
                                            function hideAddedServices() {
                                                const serviceList = JSON.parse(localStorage.getItem('serviceList')) || [];
                                                serviceList.forEach(service => {
                                                    const serviceElement = document.getElementById(`service-\${service.id}`);
                                                    if (serviceElement) {
                                                        serviceElement.style.display = 'none';
                                                    }
                                                });
                                            }

                                            // Initialize when modal opens
                                            document.getElementById('servicesModal').addEventListener('show.bs.modal', hideAddedServices);

                                            // Initialize on page load
                                            document.addEventListener('DOMContentLoaded', hideAddedServices);

                                            function addToCart(id, name, price, image) {
                                                let serviceList = JSON.parse(localStorage.getItem('serviceList'));
                                                const service = {
                                                    id: id,
                                                    name: name,
                                                    price: price,
                                                    image: image
                                                };
                                                serviceList.push(service);
                                                localStorage.setItem('serviceList', JSON.stringify(serviceList));
                                                const serviceElement = document.getElementById("service-" + id);
                                                if (serviceElement) {
                                                    serviceElement.style.display = 'none';
                                                } else {
                                                    console.error(`Không tìm thấy service`);
                                                }

                                                const modal = bootstrap.Modal.getInstance(document.getElementById('servicesModal'));
                                                modal.hide();
                                                window.location.reload();
                                            }
                                        </script>

                                        <div class="col-md-6">
                                            <div class="summary-details">
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span>Subtotal:</span>
                                                    <span id="subtotal">$100.00</span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span>Tax (10%):</span>
                                                    <span id="tax">$10.00</span>
                                                </div>
                                                <div class="d-flex justify-content-between total-line">
                                                    <span class="fw-bold">Total:</span>
                                                    <span class="fw-bold" id="total">$110.00</span>
                                                </div>
                                                <form action="reservationView" method="post">
                                                    <button class="btn btn-primary w-100 mt-3">
                                                        Proceed to Checkout

                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
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
                    <div class="col-lg-2">
                        <h5 class="fw-bold mb-4">Quick Links</h5>
                        <ul class="list-unstyled footer-links">
                            <li><a href="/services">Services</a></li>
                            <li><a href="/blogs">Blogs</a></li>
                            <li><a href="/contact">Contact</a></li>
                            <li><a href="/about">About Us</a></li>
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
                    <div class="col-lg-3">
                        <h5 class="fw-bold mb-4">Newsletter</h5>
                        <p class="text-muted">Subscribe for health tips and updates</p>
                        <form class="newsletter-form">
                            <div class="input-group">
                                <input type="email" class="form-control" placeholder="Your email">
                                <button class="btn btn-primary" type="submit">Subscribe</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="footer-bottom text-center mt-5 pt-4 border-top">
                    <p class="mb-0">© 2024 Children Care. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <!--    <script src="assets/js/reservation.js"></script>-->
        <script>
                                            // Function to update cart display
                                            function updateCartDisplay() {
                                                const cartItems = document.getElementById('cartItems');
                                                const services = JSON.parse(localStorage.getItem('serviceList')) || [];
                                                console.log(services);
                                                // Clear existing items
                                                cartItems.innerHTML = '';

                                                // Generate cart items HTML
                                                services.forEach(service => {
                                                    console.log(service.id);
                                                    cartItems.innerHTML += `
                    <div class="cart-item p-4 mb-4 bg-white rounded-3 shadow-sm" data-service-id="\${service.id}">
                        <div class="row align-items-center">
                            <div class="col-md-2">
                                <img src="\${service.image}" alt="Service" class="img-fluid rounded-3 shadow-sm" style="object-fit: cover; height: 100px;">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label text-muted small mb-1">Service Name</label>
                                <h5 class="service-title fw-bold mb-0 text-primary">\${service.name}</h5>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label text-muted small mb-1">Service ID</label>
                                <p class="service-id mb-0 fw-medium">#\${service.id}</p>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label text-muted small mb-1 text-center w-100">Price</label>
                                <p class="service-price fw-bold mb-0 text-success fs-5 text-center">\${service.price}</p>
                            </div>
                            <div class="col-md-2">
                                <label class="form-label text-muted small mb-1 text-center w-100">Quantity</label>
                                <input type="number" class="form-control form-control-sm text-center fw-medium" value="1" min="1" max="1" readonly style="background-color: #f8f9fa; cursor: not-allowed;">
                            </div>
                            <div class="col-md-1">
                                <button type="button" class="btn btn-outline-danger btn-sm rounded-circle p-2" onclick="removeItem('\${service.id}')" title="Remove item">
                                    <i class="fas fa-trash-alt"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                `;
                                                });

                                                // Update totals
                                                updateTotals();
                                            }

                                            // Function to remove item from cart
                                            function removeItem(serviceId) {
                                                let services = JSON.parse(localStorage.getItem('serviceList')) || [];
                                                services = services.filter(service => service.id !== serviceId);
                                                localStorage.setItem('serviceList', JSON.stringify(services));
                                                updateCartDisplay();
                                            }

                                            // Function to update totals
                                            function updateTotals() {
                                                const services = JSON.parse(localStorage.getItem('serviceList')) || [];
                                                const subtotal = services.reduce((sum, service) => {
                                                    // Remove '$' and convert to float
                                                    const price = parseFloat(service.price.replace(/[^0-9.-]+/g, ''));
                                                    return sum + price;
                                                }, 0);

                                                // Calculate tax (10%) and total
                                                const tax = subtotal * 0.1;
                                                const total = subtotal + tax;

                                                // Update display with proper formatting
                                                document.getElementById('subtotal').textContent = "$" + subtotal.toFixed(2);
                                                document.getElementById('tax').textContent = "$" + tax.toFixed(2);
                                                document.getElementById('total').textContent = "$" + total.toFixed(2);
                                            }

                                            // Initial cart display
                                            document.addEventListener('DOMContentLoaded', () => {
                                                updateCartDisplay();
                                            });
        </script>
        <script>
            document.addEventListener('DOMContentLoaded', () => {
                updateCartDisplay();

                // Sửa cách lấy và so sánh giá trị modalOpen
                let isModalOpen = ${modalOpen};
                if (isModalOpen) {
                    const servicesModal = new bootstrap.Modal(document.getElementById('servicesModal'));
                    servicesModal.show();
                    // Clear search input
                    document.getElementById('serviceSearch').value = "";
                    // Remove search parameter from URL
                    const url = new URL(window.location.href);
                    url.searchParams.delete('keyword');
                    window.history.replaceState({}, '', url);
                }
            });
        </script>
    </body>

</html>