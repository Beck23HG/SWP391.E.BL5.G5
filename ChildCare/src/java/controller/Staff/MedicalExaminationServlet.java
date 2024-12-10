package controller.Staff;

import dal.MedicalDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.MedicalExamination;
import model.Medicine;
import model.Service;

/**
 *
 * @author fpt
 */
public class MedicalExaminationServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MedicalExaminationServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MedicalExaminationServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        MedicalDAO dao = new MedicalDAO();
        List<Service> services = dao.getAllServices();
        List<Medicine> medicines = dao.getAllMedicines();
        List<MedicalExamination> medicalHistory = dao.getMedicalHistory(null, null, null, null);

        request.setAttribute("services", services);
        request.setAttribute("medicines", medicines);
        request.setAttribute("medicalHistory", medicalHistory);

        request.getRequestDispatcher("/Staff/medical-examination.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        MedicalDAO dao = new MedicalDAO();

        if ("addMedicalExamination".equals(action)) {
            try {
                // Lấy dữ liệu từ form
                int reservationId = Integer.parseInt(request.getParameter("reservationId"));
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                int doctorId = Integer.parseInt(request.getParameter("doctorId"));
                int serviceId = Integer.parseInt(request.getParameter("serviceId")); // Thêm ServiceId
                String symptoms = request.getParameter("symptoms");
                String diagnosis = request.getParameter("diagnosis");
                String notes = request.getParameter("notes");
                float examinationFee = Float.parseFloat(request.getParameter("examinationFee"));
                int medicineId = Integer.parseInt(request.getParameter("medicineId"));
                String dosage = request.getParameter("dosage");
                String prescriptionNote = request.getParameter("prescriptionNote");
                float totalCost = Float.parseFloat(request.getParameter("totalCost"));

                // Thêm MedicalExamination, Prescription, và Persons_Services
                boolean success = dao.addMedicalExaminationAndPrescription(reservationId, customerId, staffId, symptoms, diagnosis, notes, examinationFee, medicineId, dosage, prescriptionNote, totalCost, doctorId, serviceId);

                // Xử lý kết quả
                if (success) {
                    request.setAttribute("message", "Medical examination and prescription added successfully!");
                } else {
                    request.setAttribute("error", "Failed to add medical examination and prescription. Please try again.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Invalid input data. Please check your form values.");
            }

            // Reload data
            List<Service> services = dao.getAllServices();
            List<Medicine> medicines = dao.getAllMedicines();
            List<MedicalExamination> medicalHistory = dao.getMedicalHistory(null, null, null, null);

            request.setAttribute("services", services);
            request.setAttribute("medicines", medicines);
            request.setAttribute("medicalHistory", medicalHistory);

            request.getRequestDispatcher("/Staff/medical-examination.jsp").forward(request, response);
        } else {
            // Xử lý lọc dữ liệu
            String serviceFilter = request.getParameter("serviceFilter");
            String dateFilter = request.getParameter("dateFilter");
            String medicineFilter = request.getParameter("medicineFilter");
            String patientNameFilter = request.getParameter("patientNameFilter");

            List<MedicalExamination> filteredHistory = dao.getMedicalHistory(serviceFilter, dateFilter, medicineFilter, patientNameFilter);

            request.setAttribute("medicalHistory", filteredHistory);
            request.setAttribute("services", dao.getAllServices());
            request.setAttribute("medicines", dao.getAllMedicines());

            request.getRequestDispatcher("/Staff/medical-examination.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
