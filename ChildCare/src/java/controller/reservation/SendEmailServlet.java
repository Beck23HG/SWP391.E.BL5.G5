package controller.reservation;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import EmailService.EmailUtil;

@WebServlet(name = "SendEmailServlet", urlPatterns = {"/sendEmail"})
public class SendEmailServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");

        try {
            // Get parameters
            String toEmail = request.getParameter("email");
            String customerName = request.getParameter("customerName");
            String reservationId = request.getParameter("reservationId");
            String reservationDate = request.getParameter("reservationDate");
            String doctorName = request.getParameter("doctorName");
            String totalAmount = request.getParameter("totalAmount");

            // Create email content
            String subject = "Reservation Confirmation #" + reservationId;
            String body = "<div style='font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;'>"
                    + "<h2 style='color: #4a90e2;'>Reservation Confirmation</h2>"
                    + "<p>Dear " + customerName + ",</p>"
                    + "<p>Your reservation has been confirmed. Here are the details:</p>"
                    + "<ul>"
                    + "<li><strong>Reservation ID:</strong> " + reservationId + "</li>"
                    + "<li><strong>Date:</strong> " + reservationDate + "</li>"
                    + "<li><strong>Doctor:</strong> " + doctorName + "</li>"
                    + "<li><strong>Total Amount:</strong> " + totalAmount + "</li>"
                    + "</ul>"
                    + "<p>Thank you for choosing our services.</p>"
                    + "</div>";

            // Send confirmation email
            EmailUtil.sendEmail(toEmail, subject, body);

            // Send success response with properly escaped JSON
            String jsonResponse = "{\"success\": true, \"message\": \"Email sent successfully\"}";
            response.getWriter().write(jsonResponse);

        } catch (Exception e) {
            e.printStackTrace();
            // Escape any special characters in the error message
            String errorMessage = e.getMessage().replace("\"", "\\\"");
            String jsonError = "{\"success\": false, \"message\": \"" + errorMessage + "\"}";
            response.getWriter().write(jsonError);
        }
    }
}