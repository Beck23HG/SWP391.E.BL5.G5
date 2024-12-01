/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Blogs;

import dal.BlogDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Blog;

/**
 *
 * @author admin
 */
@WebServlet(name="BlogDetailServlet", urlPatterns={"/blog-detail"})
public class BlogDetailServlet extends HttpServlet {
           
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         try {
            int blogId = Integer.parseInt(request.getParameter("id"));
            BlogDAO blogDAO = new BlogDAO();
            Blog blog = blogDAO.getBlogById(blogId);
            
            if (blog != null) {
                request.setAttribute("blog", blog);
                request.getRequestDispatcher("blog-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect("blogs");
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("blogs");
        }
    }
    

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
