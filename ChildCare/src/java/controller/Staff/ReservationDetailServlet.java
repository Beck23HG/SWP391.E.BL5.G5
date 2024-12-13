package controller.Staff;

import dal.ReservationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Reservation;
import model.Service;

/**
 *
 * @author fpt
 */
public class ReservationDetailServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReservationDetailServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReservationDetailServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy parameter từ request
        String reservationIdParam = request.getParameter("id");
        if (reservationIdParam == null || reservationIdParam.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Reservation ID is required.");
            return;
        }

        try {
            int reservationId = Integer.parseInt(reservationIdParam);

            ReservationDAO reservationDAO = new ReservationDAO();

            // Lấy thông tin Reservation chi tiết
            Reservation reservationDetail = reservationDAO.getReservationDetail(reservationId);
            if (reservationDetail == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Reservation not found.");
                return;
            }

            // Lấy danh sách các dịch vụ trong Reservation
            List<Service> reservedServices = reservationDAO.getReservedServices(reservationId);

            // Tính tổng chi phí của tất cả các dịch vụ
            float totalCost = 0;
            for (Service service : reservedServices) {
                totalCost += service.getPrice();
            }

            // Đưa dữ liệu vào request attribute
            request.setAttribute("reservationDetail", reservationDetail);
            request.setAttribute("reservedServices", reservedServices);
            request.setAttribute("totalCost", totalCost); // Truyền tổng chi phí sang JSP

            request.getRequestDispatcher("/Staff/reservation-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Reservation ID.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy dữ liệu từ form
            String reservationIdParam = request.getParameter("reservationId");
            String statusParam = request.getParameter("status");

            // Kiểm tra dữ liệu đầu vào
            if (reservationIdParam == null || statusParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input. Reservation ID and Status are required.");
                return;
            }

            int reservationId = Integer.parseInt(reservationIdParam);
            int status = Integer.parseInt(statusParam);

            ReservationDAO reservationDAO = new ReservationDAO();
            boolean updateResult = reservationDAO.updateReservationStatus(reservationId, status);

            if (updateResult) {
                request.setAttribute("successMessage", "Reservation status updated successfully.");
            } else {
                request.setAttribute("errorMessage", "Failed to update reservation status. Please try again.");
            }

            // Lấy lại thông tin chi tiết reservation để hiển thị sau khi cập nhật
            Reservation reservationDetail = reservationDAO.getReservationDetail(reservationId);
            List<Service> reservedServices = reservationDAO.getReservedServices(reservationId);

            // Đưa dữ liệu vào request attribute để truyền sang JSP
            request.setAttribute("reservationDetail", reservationDetail);
            request.setAttribute("reservedServices", reservedServices);

            request.getRequestDispatcher("/Staff/reservation-detail.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input format.");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing the request.");
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
