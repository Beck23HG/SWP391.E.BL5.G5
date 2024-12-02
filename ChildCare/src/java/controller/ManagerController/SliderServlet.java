/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ManagerController;

import dal.SliderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Slider;

/**
 *
 * @author Admin
 */
public class SliderServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        SliderDAO sliderDAO = new SliderDAO();
        List<Slider> sliders = new ArrayList<>();
        String title = "";
        
        if(request.getParameter("title")!=null || request.getParameter("status") != null){
            if(request.getParameter("title")!=null){
                title = request.getParameter("title");
            }
            String status = request.getParameter("status");
            sliders = sliderDAO.searchSliders(title, status);
        }
        else{
            sliders = sliderDAO.getAllSliders();
        }
        request.setAttribute("sliderList", sliders);
        int totalSlider = sliders.size();
        request.setAttribute("totalSlider", totalSlider);
        request.getRequestDispatcher("Manager/Dashboard/SliderList.jsp").forward(request, response);
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
