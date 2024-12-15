/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.CommonFeature;

import dal.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.Account;

/**
 *
 * @author Admin
 */
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fullname = request.getParameter("personName");
        String phone = request.getParameter("phone");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String dobString = request.getParameter("dob");
        Date dob = null;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {
            dob = sdf.parse(dobString);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        String address = request.getParameter("address");
        int personId = Integer.parseInt(request.getParameter("personId"));

        AccountDAO accDB = new AccountDAO();

        accDB.updateProfile(fullname, phone, gender, dob, address, personId);
        request.setAttribute("ms", "Update profile successful!");
        HttpSession session = request.getSession();
        Account oldAcc = (Account) session.getAttribute("account");
        String email = oldAcc.getEmail();
        String password = oldAcc.getPassword();
        Account account = accDB.getAccountByEmailAndPassword(email, password);
        session.setAttribute("account", account);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);

    }

}
