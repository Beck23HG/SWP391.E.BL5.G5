/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.CommonFeature;

import EmailService.EmailUtil;
import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Admin
 */
public class ForgotPassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        session.setAttribute("step", 1);
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        AccountDAO accDB = new AccountDAO();
        switch (action) {
            case "sendEmail":
                String email = request.getParameter("email");
                boolean exists = accDB.checkExistedEmail(email);
                if (exists) {
                    String verifyOTP = EmailUtil.getRandomCode();
                    EmailUtil.sendEmail(email, "", verifyOTP);
                    session.setAttribute("verifyOTP", verifyOTP);
                    session.setAttribute("emailRS", email);
                    session.setAttribute("step", 2);
                } else {
                    request.setAttribute("ms","Email is not registered in the system");
                }
                break;

            case "verifyOtp":
                String inputOTP = request.getParameter("otp");
                String verifyOTP = (String) session.getAttribute("verifyOTP");
                if (!verifyOTP.equals(inputOTP)) {
                    request.setAttribute("ms", "The inputted OTP is incorrect!");
                } else {
                    session.setAttribute("step", 3);
                }
                break;

            case "changePassword":
                String newPass = request.getParameter("newPassword");
                String confirmPass = request.getParameter("confirmPassword");
                if (!newPass.equals(confirmPass)) {
                    request.setAttribute("ms", "Confirm password does not match");
                    request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                } else {
                    try {
                        String emaill = (String) session.getAttribute("emailRS");
                        accDB.resetPassword(newPass, emaill);
                        // Gửi phản hồi cho người dùng
                        request.setAttribute("msSuccess", "Reset password successful!");
                        session.removeAttribute("verifyOTP");
                        session.removeAttribute("emailRS");
                        session.removeAttribute("step");
                        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                break;

            default:
                throw new AssertionError();
        }
        request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
    }
}
