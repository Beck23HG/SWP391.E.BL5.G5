/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.CommonFeature;

import EmailService.EmailUtil;
import dal.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class RegisterServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        AccountDAO AccDB = new AccountDAO();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        int status = 1;
        String fullname = request.getParameter("fullName");
        String dobString = request.getParameter("DOB");
        String genderParam = request.getParameter("gender");
        boolean gender = Boolean.parseBoolean(genderParam);
        String phone = request.getParameter("phone");
        
        Date dob = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            dob = sdf.parse(dobString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        if (AccDB.checkExistedEmail(email) == true) {
            String ms = "Email is already in use";
            request.setAttribute("ms", ms);
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            AccDB.createAccount(email, password, roleId, status, fullname, dob, gender, phone);
            String subject = "Registration Successful";
            String message = "Dear " + fullname + ",\n\nYour account in ChildCare website has been successfully created!";
            EmailUtil.sendEmail(email, subject, message);
            request.setAttribute("ms", "Account successfully created!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
    
}
