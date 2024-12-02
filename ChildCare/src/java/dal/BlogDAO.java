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
            String sql = "SELECT b.[BlogId], b.[Title], b.[Content], b.[Created_Date], \n"
                    + "                    b.[Image], b.[Description], b.[PersonId], b.[CategoryId], \n"
                    + "                     p.[PersonName] as PersonName, c.[CategoryName] as CategoryName \n"
                    + "                     FROM [dbo].[Blog] b \n"
                    + "                     INNER JOIN [dbo].[Person] p ON b.[PersonId] = p.[PersonId] \n"
                    + "                     INNER JOIN [dbo].[Category] c ON b.[CategoryId] = c.[CategoryId]";

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
                person.setPersonName(rs.getString("PersonName"));
                blog.setPerson(person);

                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setCategoryName(rs.getString("CategoryName"));
                blog.setCategory(category);

                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public Blog getBlogById(int blogId) {
        if (blogId <= 0) {
            throw new IllegalArgumentException("BlogId must be positive");
        }
        String sql = "SELECT b.[BlogId], b.[Title], b.[Content], b.[Created_Date], "
                + "b.[Image], b.[Description], b.[PersonId], b.[CategoryId], "
                + "p.[PersonName] as PersonName, c.[CategoryName] as CategoryName "
                + "FROM [dbo].[Blog] b "
                + "INNER JOIN [dbo].[Person] p ON b.[PersonId] = p.[PersonId] "
                + "INNER JOIN [dbo].[Category] c ON b.[CategoryId] = c.[CategoryId] "
                + "WHERE b.[BlogId] = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, blogId);
            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    Blog blog = new Blog();
                    blog.setBlogId(rs.getInt("BlogId"));
                    blog.setTitle(rs.getString("Title"));
                    blog.setContent(rs.getString("Content"));
                    blog.setCreated_Date(rs.getDate("Created_Date"));
                    blog.setImage(rs.getString("Image"));
                    blog.setDescription(rs.getString("Description"));
                    
                    Person person = new Person();
                    person.setPersonId(rs.getInt("PersonId"));
                    person.setPersonName(rs.getString("PersonName"));
                    blog.setPerson(person);

                    Category category = new Category();
                    category.setCategoryId(rs.getInt("CategoryId"));
                    category.setCategoryName(rs.getString("CategoryName"));
                    blog.setCategory(category);
                    return blog;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Blog> getBlogByPerson(int personId) {
        List<Blog> blogs = new ArrayList<>();
        
        try {
            String sql = "SELECT b.[BlogId], b.[Title], b.[Content], b.[Created_Date], "
                    + "b.[Image], b.[Description], b.[PersonId], b.[CategoryId], "
                    + "p.[PersonName] as PersonName, c.[CategoryName] as CategoryName "
                    + "FROM [dbo].[Blog] b "
                    + "INNER JOIN [dbo].[Person] p ON b.[PersonId] = p.[PersonId] "
                    + "INNER JOIN [dbo].[Category] c ON b.[CategoryId] = c.[CategoryId] "
                    + "WHERE b.[PersonId] = ?";
                    
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, personId);
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
                person.setPersonName(rs.getString("PersonName"));
                blog.setPerson(person);

                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setCategoryName(rs.getString("CategoryName"));
                blog.setCategory(category);

                blogs.add(blog);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return blogs;
    }

    public static void main(String[] args) {
        BlogDAO blogDao = new BlogDAO();

        // Test getAllBlogList() và in ra tên của Person cho mỗi blog
        List<Blog> blogList = blogDao.getAllBlogList();
        System.out.println("=== Testing Person Names from Blogs ===");
        for (Blog blog : blogList) {
            System.out.println("Blog ID: " + blog.getBlogId());
            System.out.println("Person Name: " + blog.getPerson().getPersonName());
            System.out.println("--------------------");
        }
    }

}
