/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

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
public class UserListServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UserListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
// Lấy thông tin phân trang và các tham số tìm kiếm
        int page = 1; // Mặc định trang đầu tiên
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                // Nếu không thể chuyển đổi sang số, giữ nguyên giá trị mặc định
            }
        }

        // Lấy các tham số tìm kiếm (nếu có)
        String genderParam = request.getParameter("gender");
        Integer gender = (genderParam != null && !genderParam.isEmpty()) ? Integer.parseInt(genderParam) : null;

        String roleParam = request.getParameter("role");
        Integer role = (roleParam != null && !roleParam.isEmpty()) ? Integer.parseInt(roleParam) : null;

        String statusParam = request.getParameter("status");
        Integer status = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : null;

        String searchParam = request.getParameter("search");
        String search = searchParam != null ? searchParam : "";

        // Tạo đối tượng PersonDAO để truy vấn dữ liệu
        PersonDAO personDAO = new PersonDAO();
        List<Person> persons = personDAO.getAllPersons(page, gender, role, status, search);

        // Truyền danh sách persons vào request để JSP có thể sử dụng
        request.setAttribute("persons", persons);

        // Tính tổng số trang (totalPages) để phân trang
        int totalRecords = personDAO.getTotalCount(gender, role, status, search);
        int totalPages = (int) Math.ceil((double) totalRecords / 10); // Số bản ghi mỗi trang
        request.setAttribute("totalPages", totalPages);

        // Chuyển hướng đến trang users.jsp
        request.getRequestDispatcher("/Admin/users.jsp").forward(request, response);
    }

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
