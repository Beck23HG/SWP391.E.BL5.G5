<%-- 
    Document   : Login
    Created on : Nov 28, 2024, 1:57:16 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Children Care System</title>
        <meta name="description" content="Login to Children Care System - Access your healthcare dashboard">

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
                    <div class="col-md-6 col-lg-5">
                        <div class="auth-card">
                            <div class="auth-header text-center mb-4">
                                <div class="auth-logo mb-3">
                                    <div class="logo-circle">
                                        <i class="fas fa-user-circle fa-3x"></i>
                                    </div>
                                </div>
                                <h2 class="fw-bold gradient-text mb-2">Welcome Back!</h2>
                                <p class="text-muted">Access your healthcare dashboard</p>
                            </div>

                            <form action="login" method="post" id="loginForm" class="auth-form">
                                <!-- Email Input -->
                                <div class="form-group mb-4">
                                    <label for="email" class="form-label">Email address</label>
                                    <div class="input-group auth-input">
                                        <span class="input-group-text">
                                            <i class="fas fa-envelope"></i>
                                        </span>
                                        <input type="email" name="email" class="form-control" id="email" placeholder="Enter your email"
                                               required>
                                    </div>
                                </div>

                                <!-- Password Input -->
                                <div class="form-group mb-4">
                                    <div class="d-flex justify-content-between align-items-center mb-1">
                                        <label for="password" class="form-label">Password</label>
                                    </div>
                                    <div class="input-group auth-input">
                                        <span class="input-group-text">
                                            <i class="fas fa-lock"></i>
                                        </span>
                                        <input type="password" name="password" class="form-control" id="password"
                                               placeholder="Enter your password" required>
                                        <button class="btn btn-link password-toggle" type="button" id="togglePassword">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between align-items-center mb-4">

                                    <!-- Forgot Password -->
                                    <div class="text-center">
                                        <a href="forgotPassword" class="forgot-password">Forgot Password?</a>
                                    </div>
                                </div>

                                <div>
                                    <p style="color: red;">${ms}</p>
                                </div>

                                <!-- Login Button -->
                                <button type="submit" class="btn btn-primary w-100 mb-4">
                                    <span class="btn-text">
                                        <i class="fas fa-sign-in-alt me-2"></i>Login to Account
                                    </span>
                                    <span class="btn-loader d-none">
                                        <i class="fas fa-circle-notch fa-spin"></i>
                                    </span>
                                </button>

                                <!-- Register Link -->
                                <div class="text-center mb-4">
                                    <p class="mb-0">Don't have an account?
                                        <a href="register" class="text-primary fw-bold">Create Account</a>
                                    </p>
                                </div>

                                <!-- Security Badge -->
                                <div class="auth-footer text-center">
                                    <div class="security-badges mb-3">
                                        <i class="fas fa-shield-alt text-primary me-2"></i>
                                        <span class="small text-muted">Secure Login</span>
                                    </div>
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
    </body>

</html>