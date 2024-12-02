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
import model.Slider;

/**
 *
 * @author Admin
 */
public class EditSliderServlet extends HttpServlet {
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        SliderDAO sDao = new SliderDAO();
        int sliderId = Integer.parseInt(request.getParameter("sliderId"));
        Slider slider = sDao.getSliderById(sliderId);
        request.setAttribute("slider", slider);
        request.getRequestDispatcher("Manager/Dashboard/EditSlider.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        SliderDAO sDao = new SliderDAO();
        String title = request.getParameter("title");
        String image = request.getParameter("image");
        String backlink = request.getParameter("backlink");
        String description = request.getParameter("description");
        String status = request.getParameter("status");
        int sliderId = Integer.parseInt(request.getParameter("id"));
        
        sDao.updateSlider(title, image, backlink, description, status, sliderId);
        request.setAttribute("ms", "Update slider successful!");
        request.getRequestDispatcher("Manager/Dashboard/EditSlider.jsp").forward(request, response);
    }

}
