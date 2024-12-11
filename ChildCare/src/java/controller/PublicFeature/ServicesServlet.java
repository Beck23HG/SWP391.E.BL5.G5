/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.PublicFeature;

import dal.ServiceDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Service;

/**
 *
 * @author Admin
 */
public class ServicesServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        ServiceDAO serviceDAO = new ServiceDAO();
        
        List<Service> services = new ArrayList<>();
        int price1, price2, endPage, totalProduct, index;
        String indexP;
        if(request.getParameter("serviceName") != null){
            String serviceName = request.getParameter("serviceName");
            totalProduct = serviceDAO.getTotalServiceWithName(serviceName);
            endPage = totalProduct/3;
            if(totalProduct % 3 != 0){
                endPage++;
            }
            indexP = request.getParameter("index");
            if(indexP == null){
                indexP = "1";
            }
            index = Integer.parseInt(indexP);
            services = serviceDAO.getServicesByName(serviceName, index);
        }
        else if (request.getParameter("price1") != null) {
            price1 = Integer.parseInt(request.getParameter("price1"));
            price2 = Integer.parseInt(request.getParameter("price2"));
            totalProduct = serviceDAO.getTotalServiceWithPrice(price1, price2);
            endPage = totalProduct / 3;
            if (totalProduct % 3 != 0) {
                endPage++;
            }
            indexP = request.getParameter("index");
            if (indexP == null) {
                indexP = "1";
            }
            index = Integer.parseInt(indexP);
            services = serviceDAO.getServicesByPrice(price1, price2, index);

        } else {
            totalProduct = serviceDAO.getTotalService();
            endPage = totalProduct / 3;
            if (totalProduct % 3 != 0) {
                endPage++;
            }
            indexP = request.getParameter("index");
            if (indexP == null) {
                indexP = "1";
            }
            index = Integer.parseInt(indexP);
            services = serviceDAO.getServices(index);
        }
        request.setAttribute("indexx", index);
        request.setAttribute("endPage", endPage);
        request.setAttribute("services", services);
        
        request.getRequestDispatcher("services.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
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
        processRequest(request, response);
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
