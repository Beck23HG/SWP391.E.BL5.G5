/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.PublicFeature;

import dal.BlogDAO;
import dal.FeedbackDAO;
import dal.ServiceDAO;
import dal.SliderDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Blog;
import model.Feedback;
import model.Service;
import model.Slider;

/**
 *
 * @author Admin
 */
public class HomeServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        SliderDAO sliderDAO = new SliderDAO();
        List<Slider> sliders = sliderDAO.getAllSlidersActive();
        request.setAttribute("sliderList", sliders);
        BlogDAO blogDAO = new BlogDAO();
        List<Blog> blogs = blogDAO.getBlogList();
        request.setAttribute("blogs", blogs);
        ServiceDAO serviceDAO = new ServiceDAO();
        List<Service> services = serviceDAO.getThreeServicesActive();
        request.setAttribute("services", services);
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        List<Feedback> feedbacks = feedbackDAO.getSixFeedbacks();
        request.setAttribute("feedbacks", feedbacks);
        request.getRequestDispatcher("home.jsp").forward(request, response);
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
