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

/**
 *
 * @author Admin
 */
@WebServlet(name="ClearSessionNotificationServlet", urlPatterns={"/ClearSessionNotificationServlet"})
public class ClearSessionNotificationServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Xóa session attribute "notificationErr"
        HttpSession session = request.getSession();
        session.removeAttribute("notificationErr");

        // Chuyển hướng người dùng đến trang home hoặc trang bạn muốn
        response.sendRedirect("home");
    }
}