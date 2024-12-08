/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.CommonFeature;

import dal.AccountDAO;
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
@WebServlet(name = "UploadImageServlet", urlPatterns = {"/uploadImage"})
public class UploadImageServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String image = request.getParameter("image");
        int personId = Integer.parseInt(request.getParameter("personId"));
        AccountDAO accDao = new AccountDAO();
        accDao.updateImage(image, personId);

        HttpSession session = request.getSession();
        Account oldAcc = (Account) session.getAttribute("account");
        String email = oldAcc.getEmail();
        String password = oldAcc.getPassword();
        Account account = accDao.getAccountByEmailAndPassword(email, password);
        session.setAttribute("account", account);
        request.getRequestDispatcher("userProfile.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
