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

/**
 *
 * @author Admin
 */
public class AddServiceServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("/Manager/Dashboard/AddService.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String name = request.getParameter("serviceName");
        float price = Float.parseFloat(request.getParameter("price"));
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String image = request.getParameter("image");
        String duration = request.getParameter("duration");
        String detail = request.getParameter("detail");
        int id = Integer.parseInt(request.getParameter("id"));
        
        ServiceDAO sdao = new ServiceDAO();
        sdao.createService(name, price, description, status, image, duration, detail, id);
        request.setAttribute("ms", "Create service successful!");
        response.sendRedirect("ListService");
    }

}
