<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My Profile - Children Care System</title>
        <meta name="description" content="Manage your profile information">

        <!-- Favicon -->
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
            <!-- Profile Hero Section -->
            <section class="profile-hero">
                <div class="container">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="home">Home</a></li>
                            <li class="breadcrumb-item active">My Profile</li>
                        </ol>
                    </nav>
                </div>
            </section>

            <!-- Profile Content -->
            <section class="profile-content py-5">
                <div class="container">
                    <div class="row">
                        <!-- Sidebar Navigation -->
                        <div class="col-lg-3">
                            <div class="profile-sidebar rounded-4 shadow-sm p-4">
                                <div class="user-info text-center mb-4">
                                    <div class="avatar-wrapper position-relative">
                                        <img src="assets/images/Profile/${sessionScope.account.person.image}" alt="Profile Avatar" id="userAvatar" class="profile-avatar rounded-circle shadow-sm">

                                        <form action="uploadImage" method="post" id="uploadForm">
                                            <input type="text" name="personId" value="${sessionScope.account.person.personId}" hidden="">
                                            <label for="avatarUpload" class="avatar-upload-btn position-absolute">
                                                <i class="fas fa-camera"></i>
                                                <span class="upload-tooltip">Change Photo</span>
                                            </label>
                                            <input type="file" name="image" id="avatarUpload" accept="image/*" class="d-none">
                                        </form>

                                    </div>
                                    <h4 class="user-name mt-3 mb-1 fw-semibold" id="sidebarUserName">${sessionScope.account.person.personName}</h4>
                                    <p class="user-email text-muted small mb-0" id="sidebarUserEmail">${sessionScope.account.email}</p>
                                </div>

                                <div class="profile-nav d-flex flex-column gap-2">
                                    <a href="userProfile" class="nav-link rounded-3 p-3 d-flex align-items-center active" data-tab="profileInformation">
                                        <i class="fas fa-user me-3"></i>Profile Information
                                        <i class="fas fa-chevron-right ms-auto"></i>
                                    </a>
                                    <a href="changePassword" class="nav-link rounded-3 p-3 d-flex align-items-center" data-tab="changePassword">
                                        <i class="fas fa-lock me-3"></i>Change Password
                                        <i class="fas fa-chevron-right ms-auto"></i>
                                    </a>
                                    <a href="myReservation" class="nav-link rounded-3 p-3 d-flex align-items-center" data-tab="myReservations">
                                        <i class="fas fa-calendar-check me-3"></i>My Reservations
                                        <i class="fas fa-chevron-right ms-auto"></i>
                                    </a>
                                </div>
                            </div>
                        </div>

                        <!-- Main Content -->
                        <div class="col-lg-9">
                            <!-- Profile Information Tab -->
                            <div class="content-card bg-white rounded-4 shadow-sm p-4 tab-content active" id="profileInformationContent">
                                <div class="d-flex justify-content-between align-items-center mb-4">
                                    <h2 class="h3 fw-semibold mb-0">Profile Information</h2>
                                </div>

                                <form action="userProfile" method="post" id="profileForm" onsubmit="showAlert();">
                                    <input type="text" name="personId" value="${sessionScope.account.person.personId}" hidden="">
                                    <div class="row g-4">
                                        <!-- Personal Information -->
                                        <div class="col-md-12">
                                            <label class="form-label">Full Name</label>
                                            <input type="text" name="personName" class="form-control" value="${sessionScope.account.person.personName}" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Email Address</label>
                                            <input type="email" class="form-control" value="${sessionScope.account.email}" id="email" readonly>
                                            <small class="text-muted">Email cannot be changed</small>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Phone Number</label>
                                            <input type="tel" name="phone" class="form-control" value="${sessionScope.account.person.phone}" id="phone" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Gender</label>
                                            <select name="gender" class="form-select" id="gender" required>
                                                <option value="true" ${sessionScope.account.person.gender ? 'selected' : ''}>Male</option>
                                                <option value="false" ${!sessionScope.account.person.gender ? 'selected' : ''}>Female</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label class="form-label">Date of Birth</label>
                                            <input type="date" name="dob" value="${sessionScope.account.person.dateOfBirth}" class="form-control" id="birthDate">
                                        </div>
                                        <div class="col-12">
                                            <label class="form-label">Address</label>
                                            <textarea name="address" class="form-control" id="address" rows="3" required>${sessionScope.account.person.address}</textarea>
                                        </div>

                                        <!-- Form Actions -->
                                        <div class="col-12 text-end">
                                            <button type="submit" class="btn btn-primary">
                                                <span class="btn-text">
                                                    <i class="fas fa-save me-2"></i>Save Changes
                                                </span>
                                                <span class="btn-loader d-none">
                                                    <i class="fas fa-circle-notch fa-spin"></i>
                                                </span>
                                            </button>
                                        </div>
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
                    <p class="mb-0">� 2024 Children Care. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Scripts -->
        <script>
            document.getElementById("avatarUpload").addEventListener("change", function() {
                const form = document.getElementById("uploadForm");
                if (this.files && this.files.length > 0) {
                    form.submit();
                }
            });
        </script>

        <script>
            window.onload = function() {
                var message = '<%= request.getAttribute("ms") != null ? request.getAttribute("ms") : "" %>';
                if (message) {
                    alert(message);

                    window.location.href = "userProfile";
                }
            };
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            document.getElementById('profileForm').addEventListener('submit', function(event) {
                event.preventDefault();

                // Get form fields
                let fullName = document.querySelector('input[name="personName"]').value.trim();
                let phone = document.querySelector('input[name="phone"]').value.trim();
                let address = document.querySelector('textarea[name="address"]').value.trim();
                let birthDate = document.getElementById('birthDate').value;

                // Validate full name
                if (fullName === '') {
                    alert('Full Name cannot be empty');
                    return;
                }

                // Validate phone number (10 digits starting with 0)
                const phoneRegex = /^0\d{9}$/;
                if (!phoneRegex.test(phone)) {
                    alert('Phone Number must be 10 digits and start with 0');
                    return;
                }

                // Validate address
                if (address === '') {
                    alert('Address cannot be empty');
                    return;
                }

                // Validate birth date
                if (birthDate === '') {
                    alert('Date of Birth cannot be empty');
                    return;
                }

                const selectedDate = new Date(birthDate);
                const currentDate = new Date();

                if (selectedDate > currentDate) {
                    alert('Date of Birth cannot be in the future');
                    return;
                }

                // Update trimmed values back to form
                document.querySelector('input[name="personName"]').value = fullName;
                document.querySelector('input[name="phone"]').value = phone;
                document.querySelector('textarea[name="address"]').value = address;

                // If all validations pass, submit the form
                this.submit();
            });
        </script>
    </body>

    </html>