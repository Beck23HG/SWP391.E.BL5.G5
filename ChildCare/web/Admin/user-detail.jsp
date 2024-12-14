<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Users Management - Healthcare Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/assets/css/style.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/Admin/assets/css/users.css">
        <style>
            .user-details-container {
                display: flex;
                justify-content: center;
                margin: 30px auto;
                max-width: 800px;
                background: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .user-avatar {
                flex: 1;
                text-align: center;
                padding: 20px;
                border-right: 1px solid #f0f0f0;
            }

            .user-avatar img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid #3498db;
            }

            .user-info {
                flex: 2;
                padding: 20px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
                margin-bottom: 15px;
            }

            .form-group label {
                font-size: 14px;
                font-weight: 600;
                color: #2c3e50;
                margin-bottom: 8px;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                padding: 10px;
                font-size: 14px;
                border: 1.5px solid #bdc3c7;
                border-radius: 5px;
                transition: border-color 0.3s;
            }

            .form-group input:focus,
            .form-group select:focus,
            .form-group textarea:focus {
                outline: none;
                border-color: #3498db;
            }

            .form-group textarea {
                resize: none;
            }

            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            .btn {
                padding: 10px 20px;
                font-size: 14px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            .btn-primary {
                background-color: #2ecc71;
                color: #fff;
            }

            .btn-primary:hover {
                background-color: #27ae60;
            }

            .btn-secondary {
                background-color: #e74c3c;
                color: #fff;
            }

            .btn-secondary:hover {
                background-color: #c0392b;
            }

            @media (max-width: 600px) {
                .user-details-container {
                    flex-direction: column;
                }

                .user-avatar {
                    border-right: none;
                    border-bottom: 1px solid #f0f0f0;
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
                    <div class="user-profile-wrapper">
                        <div class="user-profile">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="user-info">
                                <span class="user-name">${sessionScope.account.person.personName}</span>
                                <span class="user-role">Admin</span>
                            </div>
                        </div>

                    </div>
                    <div class="user-profile">
                        <a href="../logout" style="padding: 10% 0">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Sign Out</span>
                        </a>
                    </div>
                    <div class="theme-toggle" title="Toggle theme">
                    </div>
                </div>
            </div>

            <div class="page-header">
                <div class="header-content">
                    <h1>User Details</h1>
                </div>
            </div>

            <div class="user-details-container">
                <div class="user-avatar">
                    <img src="${pageContext.request.contextPath}/assets/images/Profile/${person.image}" alt="User Avatar">
                </div>
                <div class="user-info">
                    <form action="edituser" method="post">
                        <!-- Hidden field for personId -->
                        <input type="hidden" name="personId" value="${person.personId}">

                        <div class="form-group">
                            <label for="fullName">Full Name</label>
                            <input type="text" id="fullName" value="${person.personName}" disabled>
                        </div>
                        <div class="form-group">
                            <label for="dob">Date of Birth</label>
                            <input type="date" id="dob" value="${person.dateOfBirth}" disabled>
                        </div>
                        <div class="form-group">
                            <label for="gender">Gender</label>
                            <input type="text" id="gender" value="${person.gender ? 'Male' : 'Female'}" disabled>
                        </div>
                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" value="${person.email}" disabled>
                        </div>
                        <div class="form-group">
                            <label for="mobile">Mobile</label>
                            <input type="tel" id="mobile" value="${person.phone}" disabled>
                        </div>
                        <div class="form-group">
                            <label for="role">Role</label>
                            <select id="role" name="roleId" required>
                                <option value="1" ${person.account.roleId == 1 ? 'selected' : ''}>Customer</option>
                                <option value="2" ${person.account.roleId == 2 ? 'selected' : ''}>Staff</option>
                                <option value="3" ${person.account.roleId == 3 ? 'selected' : ''}>Manager</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="address">Address</label>
                            <textarea id="address" rows="3" disabled>${person.address}</textarea>
                        </div>
                        <div class="form-group">
                            <label for="status">Status</label>
                            <select id="status" name="status">
                                <option value="1" ${person.account.status == 1 ? 'selected' : ''}>Active</option>
                                <option value="0" ${person.account.status == 0 ? 'selected' : ''}>Inactive</option>
                            </select>
                        </div>
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">Save</button>
                            <button type="button" class="btn btn-secondary" onclick="window.location.href = 'userlist'">Cancel</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="${pageContext.request.contextPath}/Dashboard/assets/js/main.js"></script>
    </body>
</html>
