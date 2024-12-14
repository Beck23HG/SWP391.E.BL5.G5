<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Complete Your Reservation - Children Care System</title>
            <meta name="description" content="Complete your healthcare service reservation">

            <!-- Standard head includes -->
            <link rel="icon" type="image/x-icon" href="assets/images/favicon.ico">
            <link rel="stylesheet" href="assets/css/style.css">
            <link rel="stylesheet" href="assets/css/responsive.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
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

            <main id="main-content">
                <!-- Reservation Contact Hero -->
                <section class="reservation-contact-hero">
                    <div class="container">
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/">Home</a></li>
                                <li class="breadcrumb-item"><a href="/services">Services</a></li>
                                <li class="breadcrumb-item"><a href="/reservation-detail">Reservation Details</a></li>
                                <li class="breadcrumb-item active">Contact Information</li>
                            </ol>
                        </nav>
                        <h1 class="display-4 fw-bold mb-4">Complete Your Reservation</h1>
                    </div>
                </section>

                <!-- Reservation Contact Content -->
                <section class="reservation-contact-content py-5">
                    <div class="container">
                        <div class="row">
                            <!-- Main Content -->
                            <div class="col-lg-12">
                                <!-- Selected Services Summary -->
                                <div class="content-card mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h2>Selected Services</h2>
                                        <a href="/ChildCare/reservationView" class="btn btn-outline-primary">
                                            <i class="fas fa-edit me-2"></i>Change Services
                                        </a>
                                    </div>
                                    <div class="selected-services" id="selectedServices">
                                        <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Imagine</th>
                                                        <th>ID</th>
                                                        <th>Service</th>
                                                        <th>Price</th>
                                                        <th class="text-center">Quantity</th>
                                                        <th></th>
                                                    </tr>
                                                </thead>
                                                <tbody id="servicesTableBody">

                                                </tbody>
                                                <tfoot>
                                                    <tr>
                                                        <td colspan="5" class="text-end fw-bold">Subtotal:</td>
                                                        <td id="subtotal">$0.00</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5" class="text-end fw-bold">Tax (10%):</td>
                                                        <td id="tax">$0.00</td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5" class="text-end fw-bold">Total:</td>
                                                        <td id="total" class="fw-bold text-primary">$0.00</td>
                                                    </tr>
                                                </tfoot>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    const services = JSON.parse(localStorage.getItem('serviceList')) || [];
                                    const tbody = document.getElementById('servicesTableBody');
                                    services.forEach(service => {
                                        tbody.innerHTML += `
                                <tr class="align-middle">
                                    <td>
                                        <img src="\${service.image}" 
                                             alt="Service" 
                                             class="img-fluid rounded shadow-sm" 
                                             style="width: 60px; height: 60px; object-fit: cover;">
                                    </td>
                                    <td class="fw-medium text-secondary">#\${service.id}</td>
                                    <td class="fw-semibold text-primary">\${service.name}</td>
                                    <td class="fw-bold text-success">\${service.price}</td>
                                    <td class="text-center fw-medium">
                                        <span class="badge bg-light text-dark px-3 py-2">1</span>
                                    </td>
                                </tr>
                            `;
                                    });
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
                                </script>
                                <!-- Contact Information Form -->
                                <div class="content-card">
                                    <h2 class="mb-4">Contact Information</h2>
                                    <form id="contactForm" class="needs-validation" novalidate>
                                        <div class="row g-4">
                                            <div class="col-md-6">
                                                <label class="form-label">Full Name</label>
                                                <c:if test="${account != null}">
                                                    <input type="text" class="form-control" id="fullName" value="${account.person.personName}" readonly required>
                                                </c:if>
                                                <c:if test="${account == null}">
                                                    <input type="text" class="form-control" id="fullName" required>
                                                </c:if>
                                                <div class="invalid-feedback">Please enter your full name</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Gender</label>
                                                <c:if test="${account != null}">
                                                    <select class="form-select" id="gender" disabled required>
                                                    <option value="male" ${account.person.gender ? 'selected' : ''}>Male</option>
                                                    <option value="female" ${!account.person.gender ? 'selected' : ''}>Female</option>
                                                    <option value="other">Other</option>
                                                </select>
                                                </c:if>
                                                <c:if test="${account == null}">
                                                    <select class="form-select" id="gender" required>
                                                    <option value="">Select gender</option>
                                                    <option value="male">Male</option>
                                                    <option value="female">Female</option>
                                                    <option value="other">Other</option>
                                                </select>
                                                </c:if>
                                                <div class="invalid-feedback">Please select your gender</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Email Address</label>
                                                <c:if test="${account != null}">
                                                    <input type="email" class="form-control" id="email" value="${account.person.email}" readonly required>
                                                </c:if>
                                                <c:if test="${account == null}">
                                                    <input type="email" class="form-control" id="email" required>
                                                </c:if>
                                                <div class="invalid-feedback">Please enter a valid email address</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Mobile Number</label>
                                                <c:if test="${account != null}">
                                                    <input type="tel" class="form-control" id="mobile" value="${account.person.phone}" readonly required>
                                                </c:if>
                                                <c:if test="${account == null}">
                                                    <input type="tel" class="form-control" id="mobile" required>
                                                </c:if>
                                                <div class="invalid-feedback">Please enter your mobile number</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Reservation Date</label>
                                                <input type="date" class="form-control" id="reservationDate" required min="${LocalDate.now()}">
                                                <div class="invalid-feedback">Please select a valid reservation date</div>
                                            </div>
                                            <div class="col-md-6">
                                                <label class="form-label">Select Doctor</label>
                                                <select class="form-select" id="doctorSelect" required>
                                                <option value="">Choose a doctor</option>
                                                <c:forEach items="${doctorList}" var="doctor">
                                                    <option value="${doctor.personId}" 
                                                            data-image="${doctor.image}"
                                                            data-email="${doctor.email}">
                                                        ${doctor.personName}
                                                    </option>
                                                </c:forEach>
                                            </select>
                                                <div class="doctor-preview mt-2 d-none">
                                                    <div class="d-flex align-items-center">
                                                        <img src="" alt="Doctor" class="doctor-image rounded-circle me-2" style="width: 40px; height: 40px; object-fit: cover;">
                                                        <div>
                                                            <div class="doctor-name fw-medium"></div>
                                                            <div class="doctor-email small text-muted"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <script>
                                                    // Show doctor preview when selected
                                                    document.getElementById('doctorSelect').addEventListener('change', function() {
                                                        const preview = document.querySelector('.doctor-preview');
                                                        if (this.value) {
                                                            const option = this.options[this.selectedIndex];
                                                            preview.querySelector('img').src = option.dataset.image;
                                                            preview.querySelector('.doctor-name').textContent = option.text;
                                                            preview.querySelector('.doctor-email').textContent = option.dataset.email;
                                                            preview.classList.remove('d-none');
                                                        } else {
                                                            preview.classList.add('d-none');
                                                        }
                                                    });
                                                </script>

                                            </div>
                                        </div>
                                        <div class="invalid-feedback">Please select a doctor</div>

                                        <div class="col-12">
                                            <label class="form-label">Address</label>
                                            <c:if test="${account != null}">
                                                <textarea class="form-control" id="address" rows="3" readonly required>${account.person.address}</textarea>
                                            </c:if>
                                            <c:if test="${account == null}">
                                                <textarea class="form-control" id="address" rows="3" required>${account != null ? account.person.address : ''}</textarea>
                                            </c:if>
                                            <div class="invalid-feedback">Please enter your address</div>
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Additional Notes</label>
                                            <textarea class="form-control" id="notes" rows="3"></textarea>
                                        </div>
                                        <div class="col-12">
                                            <div class="form-check">
                                                <input class="form-check-input" type="checkbox" id="termsCheck" required>
                                                <label class="form-check-label" for="termsCheck">
                                                I agree to the <a href="/terms">Terms of Service</a> and
                                                <a href="/privacy">Privacy Policy</a>
                                            </label>
                                                <div class="invalid-feedback">
                                                    You must agree before submitting
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 text-end">
                                            <button type="button" class="btn btn-outline-secondary me-2" onclick="window.location.href = 'reservationView'">
                                            Back to Details
                                        </button>
                                            <button id="submit" type="submit" class="btn btn-primary">
                                            <span class="btn-text">
                                                <i class="fas fa-check me-2"></i>Submit Reservation
                                            </span>
                                            <span class="btn-loader d-none">
                                                <i class="fas fa-circle-notch fa-spin"></i>
                                            </span>
                                        </button>
                                        </div>

                                    </form>
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

            <!-- Scripts -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
            <script src="assets/js/reservation-contact.js"></script>
            <script>
                document.getElementById('contactForm').addEventListener('submit', function(e) {
                    e.preventDefault();
                    // Validate form
                    if (!this.checkValidity()) {
                        e.stopPropagation();
                        this.classList.add('was-validated');
                        return;
                    }

                    // Check services
                    const services = JSON.parse(localStorage.getItem('serviceList') || '[]');
                    if (services.length === 0) {
                        alert('Please select at least one service');
                        return;
                    }

                    // Show loading state - Fixed button selection
                    const submitBtn = document.getElementById('submit'); // Changed to getElementById
                    if (submitBtn) {
                        submitBtn.disabled = true;
                        const btnText = submitBtn.querySelector('.btn-text');
                        const btnLoader = submitBtn.querySelector('.btn-loader');
                        if (btnText) btnText.classList.add('d-none');
                        if (btnLoader) btnLoader.classList.remove('d-none');
                    }

                    // Prepare form data
                    const formData = new URLSearchParams();
                    formData.append('fullName', document.getElementById('fullName').value);
                    formData.append('gender', document.getElementById('gender').value === 'male');
                    formData.append('email', document.getElementById('email').value);
                    formData.append('mobile', document.getElementById('mobile').value);
                    formData.append('address', document.getElementById('address').value);
                    formData.append('notes', document.getElementById('notes').value);
                    formData.append('services', JSON.stringify(services));
                    formData.append('reservationDate', document.getElementById('reservationDate').value);
                    formData.append('doctorSelect', document.getElementById('doctorSelect').value);
                    // Add accountId if account exists
                    <c:if test = "${account != null}" >
                        formData.append('accountId', '${account.accountId}');
                    formData.append('personId', '${account.personId}'); 
                    </c:if>

                    // Submit form
                    fetch('reservationAddCustomer', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: formData
                        })
                        .then(response => {
                            if (!response.ok) {
                                throw new Error('Network response was not ok');
                            }
                            return response.json();
                        })
                        .then(data => {
                            if (data.success) {
                                // Send confirmation email
                                return fetch('sendEmail', {
                                        method: 'POST',
                                        headers: {
                                            'Content-Type': 'application/x-www-form-urlencoded',
                                        },
                                        body: new URLSearchParams({
                                            email: document.getElementById('email').value,
                                            customerName: document.getElementById('fullName').value,
                                            reservationId: data.reservationId,
                                            reservationDate: document.getElementById('reservationDate').value,
                                            doctorName: document.getElementById('doctorSelect').options[document.getElementById('doctorSelect').selectedIndex].text,
                                            totalAmount: document.getElementById('total').textContent
                                        })
                                    })
                                    .then(response => response.json())
                                    .then(emailData => {
                                        if (emailData.success) {
                                            localStorage.removeItem('serviceList');
                                            alert('Reservation created and confirmation email sent successfully!');
                                            window.location.href = '/ChildCare/reservationAddCustomer?reservationId=' + data.reservationId;
                                        } else {
                                            throw new Error('Failed to send confirmation email: ' + emailData.message);
                                        }
                                    });
                            } else {
                                throw new Error(data.message || 'Failed to create reservation');
                            }
                        })

                    .catch(error => {
                            console.error('Error:', error);
                            alert('An error occurred: ' + error.message);
                        })
                        .finally(() => {
                            // Reset button state
                            submitBtn.disabled = false;
                            submitBtn.querySelector('.btn-text').classList.remove('d-none');
                            submitBtn.querySelector('.btn-loader').classList.add('d-none');
                        });
                });
                // Set minimum date for reservation
                const today = new Date().toISOString().split('T')[0];
                document.getElementById('reservationDate').min = today;



                document.addEventListener('DOMContentLoaded', function() {
                    // Get form elements
                    const form = document.getElementById('contactForm');
                    const mobileInput = document.getElementById('mobile');
                    const emailInput = document.getElementById('email');

                    // Validate mobile number
                    function validateMobile(mobile) {
                        const mobileRegex = /^0\d{9}$/; // Starts with 0, followed by 9 digits
                        return mobileRegex.test(mobile);
                    }

                    // Validate email
                    function validateEmail(email) {
                        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        return emailRegex.test(email);
                    }

                    // Add input event listeners for real-time validation
                    mobileInput.addEventListener('input', function() {
                        if (!validateMobile(this.value)) {
                            this.classList.add('is-invalid');
                            this.classList.remove('is-valid');
                            this.nextElementSibling.textContent = 'Phone number must be 10 digits and start with 0';
                        } else {
                            this.classList.remove('is-invalid');
                            this.classList.add('is-valid');
                        }
                    });

                    emailInput.addEventListener('input', function() {
                        if (!validateEmail(this.value)) {
                            this.classList.add('is-invalid');
                            this.classList.remove('is-valid');
                            this.nextElementSibling.textContent = 'Please enter a valid email address (must contain @)';
                        } else {
                            this.classList.remove('is-invalid');
                            this.classList.add('is-valid');
                        }
                    });

                    // Override default Bootstrap validation
                    form.addEventListener('submit', function(e) {
                        e.preventDefault(); // Prevent default form submission
                        e.stopPropagation(); // Stop event propagation

                        let isValid = true;

                        // Validate mobile
                        if (!validateMobile(mobileInput.value)) {
                            mobileInput.classList.add('is-invalid');
                            mobileInput.classList.remove('is-valid');
                            isValid = false;
                        } else {
                            mobileInput.classList.add('is-valid');
                            mobileInput.classList.remove('is-invalid');
                        }

                        // Validate email
                        if (!validateEmail(emailInput.value)) {
                            emailInput.classList.add('is-invalid');
                            emailInput.classList.remove('is-valid');
                            isValid = false;
                        } else {
                            emailInput.classList.add('is-valid');
                            emailInput.classList.remove('is-invalid');
                        }

                        // Add was-validated class to form for Bootstrap validation styles
                        form.classList.add('was-validated');

                        // If all validations pass, submit the form
                        if (isValid) {
                            // Your existing form submission code here
                            const submitBtn = document.getElementById('submit');
                            if (submitBtn) {
                                submitBtn.disabled = true;
                                const btnText = submitBtn.querySelector('.btn-text');
                                const btnLoader = submitBtn.querySelector('.btn-loader');
                                if (btnText) btnText.classList.add('d-none');
                                if (btnLoader) btnLoader.classList.remove('d-none');
                            }

                            // Continue with your form submission logic...
                            form.submit();
                        }
                    });
                });
            </script>
        </body>

        </html>