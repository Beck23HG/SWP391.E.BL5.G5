/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ManagerController;

import dal.ServiceDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Service;

/**
 *
 * @author Admin
 */
public class EditService extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        ServiceDAO sdao = new ServiceDAO();
        Service service = sdao.getServiceByID(id);
        request.setAttribute("service", service);
        request.getRequestDispatcher("/Manager/Dashboard/EditService.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ServiceDAO sdao = new ServiceDAO();
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("serviceName");
        float price = Float.parseFloat(request.getParameter("price"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String duration = request.getParameter("duration");
        String detail = request.getParameter("detail");
        sdao.updateService(name, price, description, status, duration, detail, id);
        request.setAttribute("ms", "Update service succesful!");
        request.getRequestDispatcher("/Manager/Dashboard/EditService.jsp").forward(request, response);
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
