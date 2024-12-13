/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.BlogDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Blog;

/**
 *
 * @author admin
 */
public class BlogServlet extends HttpServlet {
   
  
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        BlogDAO blogDAO = new BlogDAO();
        
        // Lấy tham số page từ request
        int page = 1;
        int pageSize = 4; // Số blog hiển thị trên mỗi trang
        
        String pageStr = request.getParameter("page");
        if(pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if(page < 1) page = 1;
            } catch(NumberFormatException e) {
                page = 1;
            }
        }
        
        // Lấy tổng số blog
        int totalBlogs = blogDAO.getTotalBlogs();
        int totalPages = (int) Math.ceil((double) totalBlogs / pageSize);
        
        // Đảm bảo page không vượt quá totalPages
        if(page > totalPages) page = totalPages;
        
        // Lấy danh sách blog cho trang hiện tại
        List<Blog> blogs = blogDAO.getAllBlogList(page, pageSize);
        
        request.setAttribute("blogs", blogs);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        
        request.getRequestDispatcher("blogs.jsp").forward(request, response);
    } 

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
