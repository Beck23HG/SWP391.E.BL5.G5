/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.ManagerController;

import dal.BlogDAO;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Blog;
import model.Category;
import model.Person;

/**
 *
 * @author Admin
 */
@WebServlet(name = "PostServlet", urlPatterns = {"/post"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class PostServlet extends HttpServlet {

    private static final String IMAGE_UPLOAD_PATH = "D:\\Clone\\SWP391_BL5\\ChildCare\\web\\Manager\\Dashboard\\assets\\images\\blog";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            BlogDAO blogDao = new BlogDAO();
            List<Blog> blogs = blogDao.getAllBlogList(1, 10);
            List<Person> authors = blogDao.getPersonOfBlog();
            List<Category> categories = blogDao.getAllCategories();

            request.setAttribute("blogs", blogs);
            request.setAttribute("authors", authors);
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("post-list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        String categoryId = request.getParameter("categoryId");
        String authorId = request.getParameter("authorId");

        BlogDAO blogDao = new BlogDAO();

        try {
            List<Blog> blogs;
            if (keyword != null && !keyword.trim().isEmpty()) {
                blogs = blogDao.searchBlogs(keyword.trim());
                request.setAttribute("keyword", keyword);
            } else if ((categoryId != null && !categoryId.isEmpty())
                    || (authorId != null && !authorId.isEmpty())) {
                blogs = blogDao.filterBlogs(categoryId, authorId);
            } else {
                blogs = blogDao.getAllBlogList(1, 5);
            }

            List<Person> authors = blogDao.getPersonOfBlog();
            List<Category> categories = blogDao.getAllCategories();

            request.setAttribute("blogs", blogs);
            request.setAttribute("authors", authors);
            request.setAttribute("categories", categories);
            request.setAttribute("selectedCategoryId", categoryId);
            request.setAttribute("selectedAuthorId", authorId);

            request.getRequestDispatcher("post-list.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                createBlog(request, response);
            } else if ("edit".equals(action)) {
                updateBlog(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred: " + e.getMessage());
            processRequest(request, response);
        }
    }

    private void createBlog(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            // Get form data
            //HTTP session get personID --------------
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String description = request.getParameter("description");
            String categoryIdStr = request.getParameter("categoryId");

            // Validate required fields
            if (title == null || title.trim().isEmpty()
                    || content == null || content.trim().isEmpty()
                    || categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Title, content and category are required.");
                processRequest(request, response);
                return;
            }

            // Handle image upload
            Part imagePart = request.getPart("image");
            String fileName = null;

            if (imagePart != null && imagePart.getSize() > 0) {
                // Generate unique filename using timestamp
                fileName = System.currentTimeMillis() + "_" + getFileName(imagePart);

                // Create upload directory if it doesn't exist
                File uploadDir = new File(IMAGE_UPLOAD_PATH);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Write file to disk
                imagePart.write(IMAGE_UPLOAD_PATH + File.separator + fileName);
            } else {
                request.setAttribute("errorMessage", "Image is required.");
                processRequest(request, response);
                return;
            }

            // Create Blog object
            Blog blog = new Blog();
            blog.setTitle(title.trim());
            blog.setContent(content.trim());
            blog.setDescription(description != null ? description.trim() : "");
            blog.setImage(fileName);
            blog.setPersonId(3);

            // Set category
            Category category = new Category();
            category.setCategoryId(Integer.parseInt(categoryIdStr));
            blog.setCategory(category);

            // Set author from session
//            Person author = (Person) request.getSession().getAttribute("user");
//            blog.setPerson(author);
            // Save to database
            BlogDAO blogDao = new BlogDAO();
            blogDao.createBlog(blog);

            // Redirect back to post list
            processRequest(request, response);

        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid category ID format.");
            processRequest(request, response);
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Error creating blog: " + e.getMessage());
            processRequest(request, response);
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");

        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return "";
    }

    private void updateBlog(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        try {
            int blogId = Integer.parseInt(request.getParameter("blogId"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String description = request.getParameter("description");
            int categoryId = Integer.parseInt(request.getParameter("categoryId"));
            String oldImagePath = request.getParameter("oldImagePath");

            Part imagePart = request.getPart("image");
            String newImagePath = null;

            if (imagePart != null && imagePart.getSize() > 0) {
                if (oldImagePath != null && !oldImagePath.isEmpty()) {
                    File oldFile = new File(IMAGE_UPLOAD_PATH + File.separator + oldImagePath);
                    if (oldFile.exists()) {
                        oldFile.delete();
                    }
                }

                String fileName = blogId + getFileName(imagePart);
                File uploadDir = new File(IMAGE_UPLOAD_PATH);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                imagePart.write(IMAGE_UPLOAD_PATH + File.separator + fileName);
                newImagePath = fileName;
            }

            Blog blog = new Blog();
            blog.setBlogId(blogId);
            blog.setTitle(title);
            blog.setContent(content);
            blog.setDescription(description);

            Category category = new Category();
            category.setCategoryId(categoryId);
            blog.setCategory(category);

            if (newImagePath != null) {
                blog.setImage(newImagePath);
            } else if (oldImagePath != null && !oldImagePath.isEmpty()) {
                blog.setImage(oldImagePath);
            }

            BlogDAO blogDao = new BlogDAO();
            blogDao.updateBlog(blog);

            processRequest(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred: " + e.getMessage());
            processRequest(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Post Management Servlet";
    }
}
