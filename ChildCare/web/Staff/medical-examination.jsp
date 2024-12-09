<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Examinations - Healthcare Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="../Admin/assets/css/style.css" rel="stylesheet" type="text/css"/>
    <link href="../Admin/assets/css/feedbacks.css" rel="stylesheet" type="text/css"/>
    <link href="../Admin/assets/css/reservation.css" rel="stylesheet" type="text/css"/>
    <link href="assetsStaff/medical-examination.css" rel="stylesheet" type="text/css"/>
    <style>
        /* Modal styles */
        #addPrescriptionModal {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            z-index: 1000;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            width: 40%;
            padding: 20px;
        }

        #addPrescriptionModal .modal-content h2 {
            margin-top: 0;
        }

        #addPrescriptionModal form div {
            margin-bottom: 15px;
        }

        #addPrescriptionModal form input, 
        #addPrescriptionModal form textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        #addPrescriptionModal form button {
            margin-top: 10px;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        #addPrescriptionModal form button[type="submit"] {
            background-color: #28a745;
            color: #fff;
        }

        #addPrescriptionModal form button[type="button"] {
            background-color: #dc3545;
            color: #fff;
        }

        #modal-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }
                /* CSS cho nút Apply Filter */
        .filter-section button[type="submit"] {
            background-color: #007bff; /* Màu nền xanh */
            color: #fff; /* Màu chữ trắng */
            padding: 10px 20px; /* Khoảng cách bên trong nút */
            font-size: 16px; /* Kích thước chữ */
            border: none; /* Xóa viền mặc định */
            border-radius: 5px; /* Góc bo tròn */
            cursor: pointer; /* Con trỏ dạng bàn tay */
            transition: background-color 0.3s ease; /* Hiệu ứng chuyển màu */
        }

        .filter-section button[type="submit"]:hover {
            background-color: #0056b3; /* Màu nền khi hover */
        }
        
    </style>
</head>

<body>
    <nav class="sidebar">
        <div class="sidebar-header">
            <div class="sidebar-logo">HealthCare Admin</div>
        </div>

        <!-- Staff Section (Same as previous HTML) -->
        <div class="nav-section">
            <div class="nav-section-title">Staff Management</div>
            <a href="services.html" class="nav-item">
                <i class="fas fa-list"></i>
                <span>Services List</span>
            </a>
            <a href="reservationlist" class="nav-item">
                <i class="fas fa-calendar-check"></i>
                <span>Reservations</span>
            </a>
            <a href="medical-examination.html" class="nav-item active">
                <i class="fas fa-stethoscope"></i>
                <span>Medical Examinations</span>
            </a>
            <a href="#" class="nav-item">
                <i class="fas fa-users"></i>
                <span>Customers</span>
            </a>
            <a href="feedbacks.html" class="nav-item">
                <i class="fas fa-comments"></i>
                <span>Feedbacks</span>
            </a>
            <a href="#" class="nav-item">
                <i class="fas fa-prescription"></i>
                <span>Prescriptions</span>
            </a>
        </div>
    </nav>

    <div class="main-content">
        <div class="top-nav">
            <!-- Top navigation from previous HTML -->
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
                </div>
            </div>
        </div>

        <div class="page-header">
            <div class="header-content">
                <h1>Medical Examinations</h1>
                <button onclick="openAddPrescriptionModal()" style="padding: 10px 20px; background-color: #007bff; color: white; border: none; border-radius: 5px; cursor: pointer;">
                    <i class="fas fa-plus"></i> Add New Prescription
                </button>
            </div>
        </div>

        <div class="medical-exam-container">
            <!-- Bộ lọc dữ liệu -->
            <div class="filter-section">
                <form action="medicalexamination" method="post">
                    <select name="serviceFilter">
                        <option value="">All Service</option>
                        <c:forEach var="service" items="${services}">
                            <option value="${service.serviceName}">${service.serviceName}</option>
                        </c:forEach>
                    </select>
                    <input type="date" name="dateFrom" placeholder="From Date">
                    <input type="date" name="dateTo" placeholder="To Date">
                    <input type="text" name="medicineName" placeholder="Medicine Name">
                    <input type="text" name="patientName" placeholder="Patient Name">
                    <button type="submit">Apply Filter</button>
                </form>
            </div>

            <!-- Bảng lịch sử khám bệnh -->
            <table class="medical-history-table">
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Patient Name</th>
                        <th>Services</th>
                        <th>Medicines Name</th>
                        <th>Symptoms</th>
                        <th>Diagnosis</th>
                        <th class="actions-column">Notes</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="history" items="${medicalHistory}">
                        <tr>
                            <td>${history.examinationDate}</td>
                            <td>${history.customer.personName}</td>
                            <td>${history.service.serviceName}</td>
                            <td>${history.medicine.name}</td>
                            <td>${history.symptoms}</td>
                            <td>${history.diagnosis}</td>
                            <td>${history.notes}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Modal chỉnh sửa -->
    <div id="addPrescriptionModal" style="display:none;">
        <div class="modal-content">
            <h2>Add New Prescription</h2>
            <form method="post" action="medicalexamination?action=addPrescription">
                <!-- Examination ID -->
                <div>
                    <label for="examinationId">Examination </label>
                    <input type="text" id="examinationId" name="examinationId" placeholder="Enter Examination " required>
                </div>

                <!-- Doctor ID -->
                <div>
                    <label for="doctorId">Doctor </label>
                    <input type="text" id="doctorId" name="doctorId" placeholder="Enter Doctor " required>
                </div>

                <!-- Customer ID -->
                <div>
                    <label for="customerId">Customer </label>
                    <input type="text" id="customerId" name="customerId" placeholder="Enter Customer " required>
                </div>

                <!-- Medicine ID -->
                <div>
                    <label for="medicineId">Medicine</label>
                    <select name="medicineFilter">
                        <c:forEach var="medicine" items="${medicines}">
                            <option value="${medicine.name}">${medicine.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <!-- Dosage -->
                <div>
                    <label for="dosage">Dosage</label>
                    <input type="text" id="dosage" name="dosage" placeholder="Enter Dosage" required>
                </div>

                <!-- Note -->
                <div>
                    <label for="note">Note</label>
                    <textarea id="note" name="note" placeholder="Enter Notes"></textarea>
                </div>

                <!-- Total Cost -->
                <div>
                    <label for="totalCost">Total Cost</label>
                    <input type="number" id="totalCost" name="totalCost" placeholder="Enter Total Cost" required>
                </div>

                <!-- Buttons -->
                <div style="margin-top: 20px;">
                    <button type="submit" style="background-color: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px;">Save</button>
                    <button type="button" onclick="closeAddPrescriptionModal()" style="background-color: #dc3545; color: white; padding: 10px 20px; border: none; border-radius: 5px;">Cancel</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        function openAddPrescriptionModal() {
            document.getElementById('addPrescriptionModal').style.display = 'block';
            document.getElementById('modal-overlay').style.display = 'block';
        }

        function closeAddPrescriptionModal() {
            document.getElementById('addPrescriptionModal').style.display = 'none';
            document.getElementById('modal-overlay').style.display = 'none';
        }
    </script>
</body>
</html>