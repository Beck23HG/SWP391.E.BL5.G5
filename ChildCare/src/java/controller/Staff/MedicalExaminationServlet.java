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
        String serviceFilter = request.getParameter("serviceFilter");
        String dateFilter = request.getParameter("dateFilter");
        String medicineFilter = request.getParameter("medicineFilter");
        String patientNameFilter = request.getParameter("patientNameFilter");

        MedicalDAO dao = new MedicalDAO();
        List<MedicalExamination> filteredHistory = dao.getMedicalHistory(serviceFilter, dateFilter, medicineFilter, patientNameFilter);

        request.setAttribute("medicalHistory", filteredHistory);
        request.setAttribute("services", dao.getAllServices());
        request.setAttribute("medicines", dao.getAllMedicines());

        request.getRequestDispatcher("/Staff/medical-examination.jsp").forward(request, response);
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
