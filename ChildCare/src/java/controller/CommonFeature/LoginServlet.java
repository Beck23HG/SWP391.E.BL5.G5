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
import model.Account;

/**
 *
 * @author Admin
 */
public class LoginServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        AccountDAO accDB = new AccountDAO();

        Account account = accDB.getAccountByEmailAndPassword(email, password);

        if (account != null) {
            HttpSession session = request.getSession();
            session.setAttribute("account", account);
            if(account.getRoleId()==1){
                response.sendRedirect("home");
            }
            else if(account.getRoleId()==2){
                request.getRequestDispatcher("Manager/Dashboard/PostList.jsp").forward(request, response);
            }
            else if(account.getRoleId()==3){
                request.getRequestDispatcher("Manager/Dashboard/PostList.jsp").forward(request, response);
            }
            else{
                request.getRequestDispatcher("Admin/users.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("ms", "Email or password is incorrect!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
