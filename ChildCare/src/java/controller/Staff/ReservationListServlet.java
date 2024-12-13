package controller.Staff;

import dal.ReservationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Account;
import model.Reservation;

/**
 *
 * @author fpt
 */
public class ReservationListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ReservationListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ReservationListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo");
        String statusParam = request.getParameter("status");
        String pageParam = request.getParameter("page");

        Integer status = null;
        if (statusParam != null && !statusParam.isEmpty()) {
            status = Integer.parseInt(statusParam);
        }

        int page = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        int pageSize = 10;

        // Lấy Account từ session và sau đó lấy PersonId
        Account account = (Account) request.getSession().getAttribute("account");
        if (account == null || account.getPerson() == null) {
            response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User is not logged in or session expired.");
            return;
        }
        int staffId = account.getPerson().getPersonId(); // Lấy PersonId từ Account

        ReservationDAO reservationDAO = new ReservationDAO();
        List<Reservation> reservations = reservationDAO.getReservations(search, dateFrom, dateTo, status, staffId, page, pageSize);
        int totalReservations = reservationDAO.getReservationCount(search, dateFrom, dateTo, status);

        int totalPages = (int) Math.ceil((double) totalReservations / pageSize);

        request.setAttribute("reservations", reservations);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("dateFrom", dateFrom);
        request.setAttribute("dateTo", dateTo);
        request.setAttribute("status", status);

        request.getRequestDispatcher("/Staff/reservation-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
