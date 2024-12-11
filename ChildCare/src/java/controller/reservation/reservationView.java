/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.reservation;

import dal.ReservationViewDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Service;
import model.Person;
import jakarta.servlet.http.HttpSession;
import model.Account;

/**
 *
 * @author admin
 */
@WebServlet(name="reservationView", urlPatterns={"/reservationView"})
public class reservationView extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    } 

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Check if this is a modalOpen update request

        ReservationViewDAO dao = new ReservationViewDAO();
        String keyword = request.getParameter("keyword");
        List<Service> serviceList;
        boolean modalOpen = false;
        
        if (keyword != null && !keyword.trim().isEmpty()&& !keyword.equals("")) {
            serviceList = dao.searchServices(keyword);
            modalOpen = true;
        } else {
            serviceList = dao.getAllService();
        }
        
        request.setAttribute("modalOpen", modalOpen);
        request.setAttribute("serviceList", serviceList);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("reservation-detail.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         ReservationViewDAO  dao = new ReservationViewDAO();
        List<Service> serviceList = dao.getAllService();
        request.setAttribute("serviceList", serviceList);
        HttpSession session = request.getSession();
        if(session.getAttribute("account") != null){
            Account account = (Account) session.getAttribute("account");
            request.setAttribute("account", account);
        }
        List <Person> DoctorList = dao.getDoctorsIsActive();
        request.setAttribute("doctorList",DoctorList);
        request.getRequestDispatcher("reservation-contact.jsp").forward(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
