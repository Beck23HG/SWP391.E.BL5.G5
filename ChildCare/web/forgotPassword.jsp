<%-- 
    Document   : forgotPassword
    Created on : Dec 5, 2024, 7:43:32 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reset Password - Children Care System</title>
        <meta name="description" content="Reset your password - Children Care System">

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
                    <a class="navbar-brand" href="/">
                        <img src="assets/images/children-care-logo-removebg.png" alt="Children Care Logo" class="logo">
                    </a>
                    <a href="login" class="btn btn-outline-primary btn-sm rounded-pill">
                        <i class="fas fa-arrow-left me-2"></i>Back to Login
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
                            <!-- Step 1: Email Form -->
                            <div id="emailStep" class="auth-step ${sessionScope.step eq 1 ? 'active' : 'd-none'}">
                                <div class="auth-header text-center mb-4">
                                    <div class="auth-logo mb-3">
                                        <div class="logo-circle">
                                            <i class="fas fa-key fa-3x"></i>
                                        </div>
                                    </div>
                                    <h2 class="fw-bold gradient-text mb-2">Reset Password</h2>
                                    <p class="text-muted">Enter your email to receive a OTP</p>
                                </div>

                                <form action="forgotPassword" method="post"  onsubmit="showAlert();">
                                    <div class="mb-4">
                                        <label for="email" class="form-label">Email address</label>
                                        <div class="input-group auth-input">
                                            <span class="input-group-text">
                                                <i class="fas fa-envelope"></i>
                                            </span>
                                            <input type="email" name="email" class="form-control" id="email"
                                                   placeholder="Enter your email" required>
                                        </div>
                                        <div class="form-text">
                                            We'll send a One-Time Password to this email
                                        </div>
                                    </div>
                                    <input type="hidden" name="action" value="sendEmail">
                                    <button type="submit" class="btn btn-primary w-100 mb-4">
                                        <span class="btn-text">
                                            <i class="fas fa-paper-plane me-2"></i>Send OTP
                                        </span>
                                        <span class="btn-loader d-none">
                                            <i class="fas fa-circle-notch fa-spin"></i>
                                        </span>
                                    </button>
                                </form>
                            </div>

                            <!-- Step 2: OTP -->
                            <div id="successStep" class="auth-step ${sessionScope.step eq 2 ? 'active' : 'd-none'}">
                                <div class="text-center mb-4">
                                    <div class="success-animation mb-4">
                                        <i class="fas fa-envelope-open-text fa-4x text-primary"></i>
                                    </div>
                                    <h3 class="fw-bold mb-3">Check Your Email</h3>
                                    <p class="text-muted mb-4">
                                        We've sent a OTP to your email address.
                                        Please check your inbox and fill in the OTP below.
                                    </p>
                                    <div class="d-grid gap-2">

                                        <form action="forgotPassword" method="post"  onsubmit="showAlert();">
                                            <div class="col-md-12">
                                                <div>
                                                    <label for="otp" class="form-label">OTP</label>
                                                    <div class="input-group">
                                                        <input type="text" name="otp" class="form-control" placeholder="Enter your OTP" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <input type="hidden" name="action" value="verifyOtp">
                                            <button type="submit" class="btn btn-primary w-20 mb-4 mt-4">
                                                <span class="btn-text">
                                                    <i class="fas fa-paper-plane me-2"></i>Submit
                                                </span>
                                                <span class="btn-loader d-none">
                                                    <i class="fas fa-circle-notch fa-spin"></i>
                                                </span>
                                            </button>
                                        </form>

                                    </div>
                                </div>
                            </div>

                            <!-- Step 3: Change pass -->
                            <div id="successStep" class="auth-step ${sessionScope.step eq 3 ? 'active' : 'd-none'}">
                                <div class="text-center mb-4">
                                    <div class="success-animation mb-4">
                                        <i class="fas fa-envelope-open-text fa-4x text-primary"></i>
                                    </div>
                                    <h3 class="fw-bold mb-3">Change password</h3>
                                    <p class="text-muted mb-4">
                                    </p>
                                    <div class="d-grid gap-2">

                                        <form action="forgotPassword" method="post"  onsubmit="showAlert();">
                                            <input type="hidden" name="action" value="changePassword">
                                            <div class="col-md-12">
                                                <label class="form-label">New Password</label>
                                                <div class="input-group">
                                                    <input type="password" name="newPassword" class="form-control" id="newPassword" required>
                                                    <button class="btn btn-outline-secondary toggle-password" type="button">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="col-md-12 mt-4">
                                                <label class="form-label">Confirm New Password</label>
                                                <div class="input-group">
                                                    <input type="password" name="confirmPassword" class="form-control" id="confirmPassword" required>
                                                    <button class="btn btn-outline-secondary toggle-password" type="button">
                                                        <i class="fas fa-eye"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <div class="col-12 mt-4">
                                                <button type="submit" class="btn btn-primary">
                                                    <span class="btn-text">
                                                        <i class="fas fa-key me-2"></i>Update Password
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

                            <!-- Security Badge -->
                            <div class="auth-footer text-center mt-4">
                                <div class="security-badges mb-3">
                                    <i class="fas fa-shield-alt text-primary me-2"></i>
                                    <span class="small text-muted">Secure Password Reset</span>
                                </div>
                            </div>
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
        <script>
            document.querySelectorAll(".toggle-password").forEach(function (button) {
                button.addEventListener("click", function () {
                    const passwordInput = this.previousElementSibling;
                    const icon = this.querySelector("i");

                    if (passwordInput.type === "password") {
                        passwordInput.type = "text";
                        icon.classList.remove("fa-eye");
                        icon.classList.add("fa-eye-slash");
                    } else {
                        passwordInput.type = "password";
                        icon.classList.remove("fa-eye-slash");
                        icon.classList.add("fa-eye");
                    }
                });
            });
        </script>

        <script>
            window.onload = function () {
                var message = '<%= request.getAttribute("ms") != null ? request.getAttribute("ms") : "" %>';
                var messageSuccess = '<%= request.getAttribute("msSuccess") != null ? request.getAttribute("msSuccess") : "" %>';

                if (message) {
                    alert(message);
                } else if (messageSuccess) {
                    alert(messageSuccess);
                    window.location.href = "login";
                }
            };
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>

</html>
