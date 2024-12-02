/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ManagerController;

import dal.SliderDAO;
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
public class AddSliderServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("Manager/Dashboard/AddSlider.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String title = request.getParameter("title");
        String image = request.getParameter("image");
        String backlink = request.getParameter("backlink");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        int personId = Integer.parseInt(request.getParameter("personId"));
        
        SliderDAO sDao = new SliderDAO();
        sDao.createSlider(title, image, backlink, description, status, personId);
        request.setAttribute("ms", "Slider successfully created!");
        request.getRequestDispatcher("Manager/Dashboard/AddSlider.jsp").forward(request, response);
    }

}
