<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users Management - Healthcare Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/users.css">
    <style>
        .new-user-form {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 24px;
            margin-top: 24px;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
        }

        .new-user-form h2 {
            color: #2c3e50;
            font-size: 22px;
            margin-bottom: 20px;
            text-align: center;
        }

        .new-user-form .form-group {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .new-user-form .form-group div {
            display: flex;
            flex-direction: column;
        }

        .new-user-form .form-group label {
            color: #34495e;
            font-weight: 600;
            margin-bottom: 8px;
            font-size: 14px;
        }

        .new-user-form .form-group input,
        .new-user-form .form-group select {
            padding: 12px;
            border: 1.5px solid #bdc3c7;
            border-radius: 5px;
            transition: border-color 0.3s ease;
            font-size: 14px;
        }

        .new-user-form .form-group input:focus,
        .new-user-form .form-group select:focus {
            outline: none;
            border-color: #3498db;
        }

        .new-user-form .avatar-upload {
            grid-column: 1 / -1;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .new-user-form .avatar-upload input[type="file"] {
            display: none;
        }

        .new-user-form .avatar-upload label {
            background-color: #3498db;
            color: white;
            padding: 12px 18px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .new-user-form .avatar-upload label:hover {
            background-color: #2980b9;
        }

        .new-user-form .avatar-preview {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background-color: #ecf0f1;
            display: flex;
            justify-content: center;
            align-items: center;
            overflow: hidden;
            margin-left: 20px;
        }

        .new-user-form .avatar-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }

        .new-user-form .submit-btn {
            grid-column: 1 / -1;
            padding: 14px;
            background-color: #2ecc71;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-size: 16px;
        }

        .new-user-form .submit-btn:hover {
            background-color: #27ae60;
        }

        @media (max-width: 600px) {
            .new-user-form .form-group {
                grid-template-columns: 1fr;
            }

            .new-user-form .avatar-upload {
                flex-direction: column;
                align-items: flex-start;
            }

            .new-user-form .avatar-preview {
                margin-top: 16px;
            }
        }
    </style>
</head>
<body>
    <nav class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">HealthCare Admin</div>
        </div>

        <div class="nav-section">
            <div class="nav-section-title">Administration</div>
            <a href="index.html" class="nav-item">
                <i class="fas fa-chart-line"></i>
                <span>Dashboard</span>
            </a>
            <a href="userlist" class="nav-item">
                <i class="fas fa-user-shield"></i>
                <span>Users Management</span>
            </a>
        </div>
    </nav>

    <div class="main-content">
        <div class="top-nav">
            <div class="menu-toggle">
                <span></span>
                <span></span>
                <span></span>
            </div>
            <div class="search-bar">
                <i class="fas fa-search"></i>
                <input type="text" placeholder="Search...">
            </div>
                        <div class="user-menu">
                <div class="notifications-wrapper">
                    <div class="notifications">
                        <i class="fas fa-bell"></i>
                        <span class="notifications-count">3</span>
                    </div>
                    <div class="notifications-dropdown">
                        <div class="notifications-header">
                            <span class="notifications-title">Notifications</span>
                            <span class="mark-all-read">Mark all as read</span>
                        </div>
                        <div class="notification-list">
                            <div class="notification-item unread">
                                <div class="notification-icon">
                                    <i class="fas fa-calendar"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-text">New appointment request from Sarah Johnson</div>
                                    <div class="notification-time">5 minutes ago</div>
                                </div>
                            </div>
                            <div class="notification-item unread">
                                <div class="notification-icon">
                                    <i class="fas fa-user-plus"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-text">New patient registration: Michael Brown</div>
                                    <div class="notification-time">2 hours ago</div>
                                </div>
                            </div>
                            <div class="notification-item">
                                <div class="notification-icon">
                                    <i class="fas fa-comment-medical"></i>
                                </div>
                                <div class="notification-content">
                                    <div class="notification-text">New feedback received for Dr. Smith</div>
                                    <div class="notification-time">1 day ago</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="user-profile-wrapper">
                    <div class="user-profile">
                        <div class="user-avatar">
                            <i class="fas fa-user"></i>
                        </div>
                        <div class="user-info">
                            <span class="user-name">John Doe</span>
                            <span class="user-role">Administrator</span>
                        </div>
                    </div>
                    <div class="user-dropdown">
                        <div class="user-dropdown-header">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="user-name">John Doe</div>
                            <div class="user-role">Administrator</div>
                        </div>
                        <a href="#" class="user-dropdown-item">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Sign Out</span>
                        </a>
                    </div>
                </div>
                <div class="theme-toggle" title="Toggle theme"></div>
            </div>
        </div>

        <div class="page-header">
            <div class="header-content">
                <h1>Users Management</h1>
            </div>
        </div>

        <div class="new-user-form">
            <h2>New User Registration</h2>
            <form method="POST" action="adduser" enctype="multipart/form-data" onsubmit="return validateForm()">
                <div class="avatar-upload">
                    <input type="file" id="avatar" name="avatar" accept="image/*" required onchange="previewImage(event)">
                    <label for="avatar">Upload Avatar</label>
                    <div class="avatar-preview">
                        <img src="#" alt="User Avatar" id="avatarPreview" style="display: none;">
                    </div>
                </div>

                <div class="form-group">
                    <div>
                        <label for="fullName">Full Name</label>
                        <input type="text" id="fullName" name="fullName" required>
                    </div>
                    <div>
                        <label for="gender">Gender</label>
                        <select id="gender" name="gender" required>
                            <option value="1">Male</option>
                            <option value="0">Female</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div>
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div>
                        <label for="mobile">Mobile Number</label>
                        <input type="tel" id="mobile" name="mobile" required>
                    </div>
                </div>

                <div class="form-group">
                    <div>
                        <label for="dob">Date of Birth</label>
                        <input type="date" id="dob" name="dob" required>
                    </div>
                    <div>
                        <label for="role">Role</label>
                        <select id="role" name="role" required>
                            <option value="1">Customer</option>
                            <option value="2">Staff</option>
                            <option value="3">Manager</option>
                            <option value="4">Admin</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div>
                        <label for="status">Status</label>
                        <select id="status" name="status" required>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div>
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" required>
                    </div>
                </div>

                <button type="button" class="submit-btn" onclick="window.location.href='userlist'">Back to User List</button>
                <button type="submit" class="submit-btn">Create User</button>
            </form>
        </div>
    </div>
    <script>
        
        function validateForm() {
            const fullName = document.getElementById("fullName").value;
            const mobile = document.getElementById("mobile").value;

            // Kiểm tra fullname chỉ chứa chữ cái
            const fullNameRegex = /^[a-zA-Z\s]+$/;
            if (!fullNameRegex.test(fullName)) {
                alert("Full Name must only contain letters and spaces.");
                return false;
            }

            // Kiểm tra mobile chỉ chứa số và có độ dài từ 6 đến 11
            const mobileRegex = /^[0-9]{6,11}$/;
            if (!mobileRegex.test(mobile)) {
                alert("Mobile Number must contain 6-11 digits and only numbers.");
                return false;
            }

            return true;
        }
        
        function previewImage(event) {
            const input = event.target; // Input file element
            const preview = document.getElementById('avatarPreview'); // Image element

            // Kiểm tra nếu có file được chọn
            if (input.files && input.files[0]) {
                const reader = new FileReader(); // Đối tượng đọc file

                // Khi file được load, hiển thị ảnh
                reader.onload = function (e) {
                    preview.src = e.target.result; // Set đường dẫn ảnh
                    preview.style.display = 'block'; // Hiển thị ảnh
                };

                // Đọc nội dung file
                reader.readAsDataURL(input.files[0]);
            } else {
                // Không có file nào được chọn, ẩn ảnh
                preview.style.display = 'none';
            }
        }
    </script>
    
    <!-- Hiển thị alert nếu email bị trùng -->
    <c:if test="${not empty errorMessage}">
        <script>
            alert("${errorMessage}");
        </script>
    </c:if>
        
    <script src="${pageContext.request.contextPath}/Dashboard/assets/js/main.js"></script>
</body>
</html>