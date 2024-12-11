/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ManagerController;

import dal.PersonDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Person;

/**
 *
 * @author fpt
 */
public class CustomerListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CustomerListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CustomerListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int page = 1; // Trang mặc định
        String pageParam = request.getParameter("page");
        if (pageParam != null) {
            page = Integer.parseInt(pageParam);
        }

        String statusParam = request.getParameter("status");
        Integer status = statusParam != null && !statusParam.isEmpty() ? Integer.parseInt(statusParam) : null;

        String search = request.getParameter("search");

        PersonDAO personDAO = new PersonDAO();

        // Lấy danh sách customer
        List<Person> customers = personDAO.getCustomers(page, status, search);
        int totalCustomers = personDAO.getTotalCustomers(status, search);
        int totalPages = (int) Math.ceil((double) totalCustomers / 5); // Số trang

        // Gửi dữ liệu đến JSP
        request.setAttribute("customers", customers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("search", search);
        request.setAttribute("status", status);

        request.getRequestDispatcher("Manager/Dashboard/customer-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        PersonDAO personDAO = new PersonDAO();

        if ("toggleStatus".equals(action)) {
            int personId = Integer.parseInt(request.getParameter("personId"));
            boolean success = personDAO.toggleCustomerStatus(personId);

            // Thông báo thành công/thất bại
            if (success) {
                request.setAttribute("message", "Status updated successfully.");
            } else {
                request.setAttribute("error", "Failed to update status.");
            }
        }

        // Chuyển hướng lại danh sách khách hàng
        doGet(request, response);
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
