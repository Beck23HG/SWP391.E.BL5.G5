package controller.admin;

import dal.PersonDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Person;

/**
 *
 * @author fpt
 */
public class EditUserServlet extends HttpServlet {
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditUserServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditUserServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 
    
    private PersonDAO personDAO;

    @Override
    public void init() {
        personDAO = new PersonDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int personId = Integer.parseInt(request.getParameter("personId"));
            Person person = personDAO.getPersonDetailsById(personId);

            if (person != null) {
                request.setAttribute("person", person);
                request.getRequestDispatcher("/Admin/user-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("userlist");
            }
        } catch (NumberFormatException | IOException e) {
            e.printStackTrace();
            response.sendRedirect("userlist");
        }
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            int personId = Integer.parseInt(request.getParameter("personId"));
            int roleId = Integer.parseInt(request.getParameter("roleId"));
            int status = Integer.parseInt(request.getParameter("status"));

            boolean isUpdated = personDAO.updateUserRoleAndStatus(personId, roleId, status);
            if (isUpdated) {
                response.sendRedirect("userlist");
            } else {
                request.setAttribute("error", "Failed to update user details.");
                doGet(request, response);
            }
        } catch (NumberFormatException | IOException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input data.");
            doGet(request, response);
        }
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
