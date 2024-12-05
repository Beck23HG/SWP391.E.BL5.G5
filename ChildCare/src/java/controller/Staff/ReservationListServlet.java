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
            out.println("<h1>Servlet ReservationListServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy các tham số từ request để lọc dữ liệu
        String search = request.getParameter("search"); 
        String dateFrom = request.getParameter("dateFrom");
        String dateTo = request.getParameter("dateTo"); 
        String statusParam = request.getParameter("status"); 
        String pageParam = request.getParameter("page"); 

        Integer status = null;
        if (statusParam != null && !statusParam.isEmpty()) {
            status = Integer.parseInt(statusParam); // Chuyển trạng thái sang Integer
        }

        int page = 1; // Mặc định là trang đầu tiên
        if (pageParam != null && !pageParam.isEmpty()) {
            page = Integer.parseInt(pageParam);
        }

        int pageSize = 2; // Số bản ghi trên mỗi trang

        // Tạo đối tượng DAO để lấy dữ liệu từ database
        ReservationDAO reservationDAO = new ReservationDAO();
        List<Reservation> reservations = reservationDAO.getReservations(search, dateFrom, dateTo, status, page, pageSize);
        int totalReservations = reservationDAO.getReservationCount(search, dateFrom, dateTo, status);

        // Tính tổng số trang
        int totalPages = (int) Math.ceil((double) totalReservations / pageSize);

        // Đặt các thuộc tính cho request để truyền đến JSP
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
