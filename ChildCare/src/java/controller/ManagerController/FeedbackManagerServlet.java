/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ManagerController;

import dal.FeedbackDAO;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import model.Feedback;
import model.Service;


/**
 *
 * @author admin
 */
public class FeedbackManagerServlet extends HttpServlet {
   
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy parameters
        String searchQuery = request.getParameter("search");
        String serviceIdStr = request.getParameter("serviceId");
        String ratingStr = request.getParameter("rating");
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");
        
        // Parse parameters
        Integer serviceId = (serviceIdStr != null && !serviceIdStr.isEmpty()) ? 
                Integer.parseInt(serviceIdStr) : null;
        Integer rating = (ratingStr != null && !ratingStr.isEmpty()) ? 
                Integer.parseInt(ratingStr) : null;
        int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
        int pageSize = pageSizeStr != null ? Integer.parseInt(pageSizeStr) : 10;
        
        FeedbackDAO feedbackDao = new FeedbackDAO();
        
        // Lấy tổng số feedback sau khi áp dụng bộ lọc
        int totalFeedbacks = feedbackDao.getTotalFeedbacks(searchQuery, serviceId, rating);
        int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);
        
        // Lấy danh sách feedback đã lọc và phân trang
        List<Feedback> feedbacks = feedbackDao.getFeedbacksWithPaging(
                page, pageSize, searchQuery, serviceId, rating, null, null);
        
        // Lấy danh sách services cho filter
        List<Service> services = feedbackDao.getAllServices();
        
        // Set attributes
        request.setAttribute("feedbacks", feedbacks);
        request.setAttribute("services", services);
        request.setAttribute("currentPage", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalFeedbacks", totalFeedbacks);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("selectedService", serviceId);
        request.setAttribute("selectedRating", rating);
        
        request.getRequestDispatcher("feedback.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
