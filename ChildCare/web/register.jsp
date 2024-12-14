<%-- 
    Document   : register
    Created on : Nov 30, 2024, 10:31:23 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register - Children Care System</title>
        <meta name="description" content="Create your account - Join Children Care System">

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

        <script>
            window.onload = function () {
                var message = '<%= request.getAttribute("ms") != null ? request.getAttribute("ms") : "" %>';
                if (message) {
                    alert(message);

                    window.location.href = "home";
                }
            };
        </script>
    </head>

    <body class="auth-page">
        <!-- Header Section -->
        <header class="auth-header">
            <nav class="navbar navbar-light">
                <div class="container">
                    <a class="navbar-brand" href="home">
                        <img src="assets/images/children-care-logo-removebg.png" alt="Children Care Logo" class="logo">
                    </a>
                    <a href="home" class="btn btn-outline-primary btn-sm rounded-pill">
                        <i class="fas fa-home me-2"></i>Back to Home
                    </a>
                </div>
            </nav>
        </header>

        <!-- Main Content Area -->
        <main class="auth-main">
            <div class="container">
                <div class="row justify-content-center align-items-center min-vh-100">
                    <div class="col-md-8 col-lg-6">
                        <div class="auth-card">
                            <div class="auth-header text-center mb-4">
                                <div class="auth-logo mb-3">
                                    <div class="logo-circle">
                                        <i class="fas fa-user-plus fa-3x"></i>
                                    </div>
                                </div>
                                <h2 class="fw-bold gradient-text mb-2">Create Account</h2>
                                <p class="text-muted">Join our healthcare community</p>
                            </div>

                            <form action="register" method="post" id="registerForm" class="auth-form" onsubmit="showAlert();">
                                <!-- Email -->
                                <div class="mb-4">
                                    <label for="email" class="form-label">Email address</label>
                                    <div class="input-group auth-input">
                                        <span class="input-group-text">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email"
                                               required>
                                    </div>
                                </div>

                                <!-- Password -->
                                <div class="row">
                                    <div class="mb-4">
                                        <label for="password" class="form-label">Password</label>
                                        <div class="input-group auth-input">
                                            <span class="input-group-text">
                                                <i class="fas fa-lock"></i>
                                            </span>
                                            <input type="password" name="password" class="form-control" id="password"
                                                   placeholder="Create password" required>
                                            <button class="btn btn-link password-toggle" type="button" id="togglePassword">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <!-- Phone -->
                                <div class="mb-4">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <div class="input-group auth-input">
                                        <span class="input-group-text">
                                            <i class="fas fa-phone"></i>
                                        </span>
                                        <input type="tel" name="phone" class="form-control" id="phone" placeholder="Enter phone number"
                                               required>
                                    </div>
                                </div>

                                <!-- Name -->
                                <div class="mb-4">
                                    <label for="phone" class="form-label">Full name</label>
                                    <div class="input-group auth-input">
                                        <span class="input-group-text">
                                            <i class="fas fa-user"></i>
                                        </span>
                                        <input type="tel" name="fullName" class="form-control" id="fullName" placeholder="Enter full name"
                                               required>
                                    </div>
                                </div>

                                <!-- Date of Birth -->
                                <div class="mb-4">
                                    <label for="dob" class="form-label">Date of Birth</label>
                                    <div class="input-group auth-input">
                                        <span class="input-group-text">
                                            <i class="fas fa-calendar-alt"></i>
                                        </span>
                                        <input type="date" name="DOB" class="form-control" id="dob" required>
                                    </div>
                                </div>

                                <!-- Gender -->
                                <div class="mb-4">
                                    <label for="gender" class="form-label">Gender</label><br>
                                    <div class="d-flex align-items-center">
                                        <!-- Male -->
                                        <label class="me-4 d-flex align-items-center">
                                            <i class="fas fa-male text-primary me-2"></i>
                                            <input type="radio" name="gender" value="true" checked="true"> Male
                                        </label>
                                        <!-- Female -->
                                        <label class="d-flex align-items-center">
                                            <i class="fas fa-female text-danger me-2"></i>
                                            <input type="radio" name="gender" value="false"> Female
                                        </label>
                                    </div>
                                </div>

                                <!-- Role -->
                                <div class="mb-4">
                                    <label for="roleId" class="form-label">Role</label><br>
                                    <div class="d-flex align-items-center">
                                        <!-- Customer -->
                                        <label class="me-4 d-flex align-items-center">
                                            <i class="fas fa-user text-primary me-2"></i>
                                            <input type="radio" name="roleId" value="1" checked="true"> Customer
                                        </label>
                                        <!-- Staff -->
                                        <label class="d-flex align-items-center">
                                            <i class="fas fa-user-tie text-warning me-2"></i>
                                            <input type="radio" name="roleId" value="2"> Staff
                                        </label>
                                    </div>
                                </div>

                                <!-- Register Button -->
                                <button type="submit" class="btn btn-primary w-100 mb-4">
                                    <span class="btn-text">
                                        <i class="fas fa-user-plus me-2"></i>Create Account
                                    </span>
                                    <span class="btn-loader d-none">
                                        <i class="fas fa-circle-notch fa-spin"></i>
                                    </span>
                                </button>

                                <!-- Login Link -->
                                <div class="text-center mb-4">
                                    <p class="mb-0">Already have an account?
                                        <a href="login" class="text-primary fw-bold">Login</a>
                                    </p>
                                </div>

                                <!-- Security Badge -->
                                <div class="auth-footer text-center">
                                    <div class="security-badges mb-3">
                                        <i class="fas fa-shield-alt text-primary me-2"></i>
                                        <span class="small text-muted">Secure Registration</span>
                                    </div>
                                    <p class="text-muted small mb-0">
                                        Protected by reCAPTCHA and subject to the
                                        <a href="#">Privacy Policy</a> and
                                        <a href="#">Terms of Service</a>
                                    </p>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <!-- Decorative Elements -->
        <div class="auth-decorative-elements">
            <div class="floating-gradient gradient-1"></div>
            <div class="floating-gradient gradient-2"></div>
        </div>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                document.getElementById('togglePassword').addEventListener('click', function () {
                                    const passwordInput = document.getElementById('password');
                                    const icon = this.querySelector('i');

                                    if (passwordInput.type === 'password') {
                                        passwordInput.type = 'text';
                                        icon.classList.remove('fa-eye');
                                        icon.classList.add('fa-eye-slash');
                                    } else {
                                        passwordInput.type = 'password';
                                        icon.classList.remove('fa-eye-slash');
                                        icon.classList.add('fa-eye');
                                    }
                                });
        </script>
        <script>
            document.getElementById('registerForm').addEventListener('submit', function (event) {
                event.preventDefault(); // Ngăn chặn form submit mặc định

                // Lấy giá trị từ các trường trong form
                let phone = document.querySelector('input[name="phone"]').value.trim();

                // Biểu thức chính quy kiểm tra số điện thoại (10 chữ số bắt đầu bằng số 0)
                const phoneRegex = /^0\d{9}$/;

                if (!phoneRegex.test(phone)) {
                    alert('Phone Number must be exactly 10 digits and start with 0');
                    return; // Dừng lại nếu không hợp lệ
                }

                // Nếu hợp lệ, cho phép submit form
                alert('Phone number is valid!'); // Test xem có hợp lệ không
                this.submit();
            });

        </script>
    </body>

</html>
