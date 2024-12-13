/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.MedicalExamination;
import model.Medicine;
import model.Person;
import model.Service;

/**
 *
 * @author fpt
 */
public class MedicalDAO extends DBContext {

    public List<MedicalExamination> getMedicalHistory(String serviceFilter, String dateFilter, String medicineFilter, String patientNameFilter) {
        List<MedicalExamination> medicalHistory = new ArrayList<>();
        String sql = "SELECT me.ExaminationDate, p.PersonName AS PatientName, "
                + "s.ServiceName, m.Name AS MedicineName, me.Symptoms, me.Diagnosis, me.Notes "
                + "FROM MedicalExamination me "
                + "LEFT JOIN Persons_Services ps ON me.MEId = ps.ServiceId "
                + "LEFT JOIN Service s ON ps.ServiceId = s.ServiceId "
                + "LEFT JOIN Prescription pre ON me.MEId = pre.ExaminationId "
                + "LEFT JOIN Medicine m ON pre.MedicineId = m.MedicineId "
                + "LEFT JOIN Person p ON me.CustomerId = p.PersonId "
                + "WHERE (s.ServiceName LIKE ? OR ? IS NULL) "
                + "AND (me.ExaminationDate = ? OR ? IS NULL) "
                + "AND (m.Name LIKE ? OR ? IS NULL) "
                + "AND (p.PersonName LIKE ? OR ? IS NULL)";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, "%" + serviceFilter + "%");
            stm.setString(2, serviceFilter);
            stm.setString(3, dateFilter);
            stm.setString(4, dateFilter);
            stm.setString(5, "%" + medicineFilter + "%");
            stm.setString(6, medicineFilter);
            stm.setString(7, "%" + patientNameFilter + "%");
            stm.setString(8, patientNameFilter);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                MedicalExamination me = new MedicalExamination();
                me.setExaminationDate(rs.getDate("ExaminationDate"));
                Person patient = new Person();
                patient.setPersonName(rs.getString("PatientName"));
                me.setCustomer(patient);
                Service service = new Service();
                service.setServiceName(rs.getString("ServiceName"));
                me.setService(service);
                Medicine medicine = new Medicine();
                medicine.setName(rs.getString("MedicineName"));
                me.setMedicine(medicine);
                me.setSymptoms(rs.getString("Symptoms"));
                me.setDiagnosis(rs.getString("Diagnosis"));
                me.setNotes(rs.getString("Notes"));
                medicalHistory.add(me);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medicalHistory;
    }

    public boolean addMedicalExaminationAndPrescription(
            int reservationId,
            int customerId,
            int staffId,
            String symptoms,
            String diagnosis,
            String notes,
            float examinationFee,
            int medicineId,
            String dosage,
            String prescriptionNote,
            float totalCost,
            int doctorId,
            int serviceId
    ) {
        String insertMedicalExaminationSQL = "INSERT INTO MedicalExamination (ReservationId, CustomerId, StaffId, Symptoms, Diagnosis, Notes, ExaminationDate, ExaminationFee) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE(), ?)";
        String insertPrescriptionSQL = "INSERT INTO Prescription (ExaminationId, DoctorId, CustomerId, MedicineId, Dosage, Note, TotalCost) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";
        String insertPersonsServicesSQL = "INSERT INTO Persons_Services (PersonId, ServiceId) VALUES (?, ?)";

        try {
            connection.setAutoCommit(false); // Bắt đầu giao dịch

            // Thêm bản ghi vào bảng MedicalExamination
            PreparedStatement medicalStm = connection.prepareStatement(insertMedicalExaminationSQL, PreparedStatement.RETURN_GENERATED_KEYS);
            medicalStm.setInt(1, reservationId);
            medicalStm.setInt(2, customerId);
            medicalStm.setInt(3, staffId);
            medicalStm.setString(4, symptoms);
            medicalStm.setString(5, diagnosis);
            medicalStm.setString(6, notes);
            medicalStm.setFloat(7, examinationFee);
            medicalStm.executeUpdate();

            // Lấy ID của bản ghi vừa thêm vào bảng MedicalExamination
            ResultSet rs = medicalStm.getGeneratedKeys();
            int examinationId = -1;
            if (rs.next()) {
                examinationId = rs.getInt(1);
            }
            rs.close();
            medicalStm.close();

            if (examinationId == -1) {
                throw new SQLException("Failed to retrieve generated ExaminationId.");
            }

            // Thêm bản ghi vào bảng Prescription
            PreparedStatement prescriptionStm = connection.prepareStatement(insertPrescriptionSQL);
            prescriptionStm.setInt(1, examinationId);
            prescriptionStm.setInt(2, doctorId);
            prescriptionStm.setInt(3, customerId);
            prescriptionStm.setInt(4, medicineId);
            prescriptionStm.setString(5, dosage);
            prescriptionStm.setString(6, prescriptionNote);
            prescriptionStm.setFloat(7, totalCost);
            prescriptionStm.executeUpdate();
            prescriptionStm.close();

            // Thêm bản ghi vào bảng Persons_Services
            PreparedStatement personsServicesStm = connection.prepareStatement(insertPersonsServicesSQL);
            personsServicesStm.setInt(1, customerId);
            personsServicesStm.setInt(2, serviceId); // Liên kết với ServiceId
            personsServicesStm.executeUpdate();
            personsServicesStm.close();

            connection.commit(); // Xác nhận giao dịch
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback(); // Hoàn tác nếu xảy ra lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                connection.setAutoCommit(true); // Đặt lại trạng thái tự động commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return false; // Trả về false nếu xảy ra lỗi
    }

    // Lấy danh sách dịch vụ
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT ServiceId, ServiceName FROM Service WHERE Status = 1";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("ServiceId"));
                service.setServiceName(rs.getString("ServiceName"));
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    // Lấy danh sách thuốc
    public List<Medicine> getAllMedicines() {
        List<Medicine> medicines = new ArrayList<>();
        String sql = "SELECT MedicineId, Name FROM Medicine";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Medicine medicine = new Medicine();
                medicine.setMedicineId(rs.getInt("MedicineId"));
                medicine.setName(rs.getString("Name"));
                medicines.add(medicine);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return medicines;
    }

}
