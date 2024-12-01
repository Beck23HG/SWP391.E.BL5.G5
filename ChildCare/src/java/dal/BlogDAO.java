/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Blog;
import model.Category;
import model.Person;

/**
 *
 * @author admin
 */
public class BlogDAO extends DBContext {

    public List<Blog> getAllBlogList() {
        List<Blog> blogs = new ArrayList<>();

        try {
            String sql = "SELECT [BlogId], [Title], [Content], [Created_Date], [Image], [Description], [PersonId], [CategoryId] FROM [dbo].[Blog]";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("BlogId"));
                blog.setTitle(rs.getString("Title"));
                blog.setContent(rs.getString("Content"));
                blog.setCreated_Date(rs.getDate("Created_Date"));
                blog.setImage(rs.getString("Image"));
                blog.setDescription(rs.getString("Description"));

                Person person = new Person();
                person.setPersonId(rs.getInt("PersonId"));

                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                blogs.add(blog);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return blogs;
    }

    public Blog getBlogById(int blogId) {
        try {
            String sql = "SELECT [BlogId], [Title], [Content], [Created_Date], [Image], [Description], [PersonId], [CategoryId] "
                    + "FROM [dbo].[Blog] WHERE [BlogId] = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, blogId);
            ResultSet rs = statement.executeQuery();

            if (rs.next()) {
                Blog blog = new Blog();
                blog.setBlogId(rs.getInt("BlogId"));
                blog.setTitle(rs.getString("Title"));
                blog.setContent(rs.getString("Content"));
                blog.setCreated_Date(rs.getDate("Created_Date"));
                blog.setImage(rs.getString("Image"));
                blog.setDescription(rs.getString("Description"));
                blog.setPersonId(rs.getInt("PersonId"));
                blog.setCategoryId(rs.getInt("CategoryId"));
                return blog;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        BlogDAO blogDao = new BlogDAO();
        List<Blog> blogList = blogDao.getAllBlogList();
        for (Blog blog : blogList) {
            System.out.println(blog);
        }
    }

}
