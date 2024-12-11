/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.reservation;

import dal.ReservationDAO;
import dal.ReservationViewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import model.Person;
import model.Reservation;

/**
 *
 * @author admin
 */
@WebServlet(name = "reservationAddCustomer", urlPatterns = {"/reservationAddCustomer"})
public class reservationAddCustomer extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet reservationAddCustomer</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet reservationAddCustomer at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("reservation-success.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Get form data
            String fullName = request.getParameter("fullName");
            boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
            String email = request.getParameter("email");
            String mobile = request.getParameter("mobile");
            String address = request.getParameter("address");
            String notes = request.getParameter("notes");
            String servicesJson = request.getParameter("services");
            String reservationDate = request.getParameter("reservationDate");
            String staffId = request.getParameter("doctorSelect");

            // Validate input
            if (fullName == null || fullName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || mobile == null || mobile.trim().isEmpty()
                    || address == null || address.trim().isEmpty()) {
                out.println("{\"success\": false, \"message\": \"Missing required fields\"}");
                return;
            }

            // Create Person object
            Person person = new Person();
            person.setPersonName(fullName);
            person.setGender(gender);
            person.setEmail(email);
            person.setPhone(mobile);
            person.setAddress(address);

            ReservationViewDAO dao = new ReservationViewDAO();

            // Create person and get ID
            int personId = dao.createPerson(person);

            if (personId > 0) {
                // Create reservation
                Reservation reservation = new Reservation();
                reservation.setCustomerId(personId);
                reservation.setNote(notes);

                // Convert string date to java.util.Date

                
                reservation.setStaffId(Integer.parseInt(staffId));

                int reservationId = dao.createReservation(reservation,reservationDate);

                if (reservationId > 0) {
                    // Parse services JSON manually
                    servicesJson = servicesJson.trim();
                    if (servicesJson.startsWith("[")) {
                        servicesJson = servicesJson.substring(1);
                    }
                    if (servicesJson.endsWith("]")) {
                        servicesJson = servicesJson.substring(0, servicesJson.length() - 1);
                    }

                    String[] serviceObjects = servicesJson.split("},\\s*\\{");

                    for (String serviceObj : serviceObjects) {
                        // Clean up the service object string
                        serviceObj = serviceObj.replaceAll("[{}\"]", "");
                        String[] pairs = serviceObj.split(",");

                        // Find the id field
                        for (String pair : pairs) {
                            String[] keyValue = pair.split(":");
                            if (keyValue.length == 2 && keyValue[0].trim().equals("id")) {
                                int serviceId = Integer.parseInt(keyValue[1].trim());

                                dao.createServiceReservation(serviceId, reservationId);
                                break;
                            }
                        }
                    }

                    out.println("{\"success\": true, \"message\": \"Reservation created successfully\"}");
                    return;
                }
            }

            out.println("{\"success\": false, \"message\": \"Failed to create reservation\"}");

        } catch (Exception e) {
            e.printStackTrace();
            out.println("{\"success\": false, \"message\": \"" + e.getMessage().replace("\"", "'") + "\"}");
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
