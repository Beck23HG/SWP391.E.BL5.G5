/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Common;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ClearSessionNotificationServlet", urlPatterns = {"/ClearSessionNotificationServlet"})
public class ClearSessionNotificationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xóa session attribute "notificationErr"
        HttpSession session = request.getSession();
        session.removeAttribute("notificationErr");

        Account c = (Account) session.getAttribute("account");
        if (c == null || c.getRoleId() == 1) {
            response.sendRedirect("home");
        } else if (c.getRoleId() == 2) {
            response.sendRedirect("Staff/reservationlist");
        } else if (c.getRoleId() == 3) {
            response.sendRedirect("sliderList");
        } else if (c.getRoleId() == 4) {
            response.sendRedirect("Admin/userlist");
        }
    }
}
