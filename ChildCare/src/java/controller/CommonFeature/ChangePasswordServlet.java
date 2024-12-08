/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.CommonFeature;

import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class ChangePasswordServlet extends HttpServlet {

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
        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String realPass = request.getParameter("realPassword");
        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        if (!realPass.equals(currentPass)) {
            request.setAttribute("ms", "Current password is incorrect!");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } else if (currentPass == null || currentPass.isEmpty() || newPass == null || newPass.isEmpty()) {
            request.setAttribute("ms", "Invalid password");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } else if (!newPass.equals(confirmPass)) {
            request.setAttribute("ms", "Confirm password does not match");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
        } else {
            try {
                AccountDAO accDao = new AccountDAO();
                int id = Integer.parseInt(request.getParameter("accountId"));
                accDao.updatePassword(newPass, id);
                // Gửi phản hồi cho người dùng
                request.setAttribute("msSuccess", "Change password successful!");

                HttpSession session = request.getSession();
                session.invalidate();

                request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}
