/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.ManagerController;

import dal.BlogDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Blog;

/**
 *
 * @author Admin
 */
public class PostServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            BlogDAO blogDao = new BlogDAO();
            List<Blog> blogs = blogDao.getAllBlogList();
            request.setAttribute("blogs", blogs);
            request.getRequestDispatcher("post-list.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String blogIdParam = request.getParameter("blogId");
        
        if (blogIdParam != null) {
            try {
                int blogId = Integer.parseInt(blogIdParam);
                BlogDAO blogDao = new BlogDAO();
                Blog blog = blogDao.getBlogById(blogId);
                
                if (blog != null) {
                    request.setAttribute("blog", blog);
                    request.getRequestDispatcher("post-list.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }
        
        // Hiển thị danh sách blog
        BlogDAO blogDao = new BlogDAO();
        List<Blog> blogs = blogDao.getAllBlogList();
        request.setAttribute("blogs", blogs);
        request.getRequestDispatcher("post-list.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
