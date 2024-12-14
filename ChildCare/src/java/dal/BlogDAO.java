/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import model.Account;
import model.Blog;
import model.Category;
import model.Person;
import model.Role;

/**
 *
 * @author admin
 */
public class BlogDAO extends DBContext {

    public List<Blog> getAllBlogList(int pageNumber, int pageSize) {
        List<Blog> blogs = new ArrayList<>();

        try {
            String sql = "SELECT DISTINCT b.[BlogId], b.[Title], b.[Content], b.[Created_Date], "
                    + "b.[Image], b.[Description], b.[PersonId], b.[CategoryId], "
                    + "p.[PersonName] as PersonName, c.[CategoryName] as CategoryName, "
                    + "COUNT(*) OVER() as TotalRecords "
                    + "FROM [dbo].[Blog] b "
                    + "INNER JOIN [dbo].[Person] p ON b.[PersonId] = p.[PersonId] "
                    + "INNER JOIN [dbo].[Category] c ON b.[CategoryId] = c.[CategoryId] "
                    + "INNER JOIN [dbo].[Account] a ON p.[PersonId] = a.[PersonId] "
                    + "INNER JOIN [dbo].[Role] r ON a.[RoleId] = r.[RoleId] "
                    + "WHERE r.[RoleId] = 3 "
                    + "ORDER BY b.[Created_Date] DESC "
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, (pageNumber - 1) * pageSize);
            statement.setInt(2, pageSize);
            
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

    public List<Person> getPersonOfBlog() {
        List<Person> authors = new ArrayList<>();
        try {
            String sql = "SELECT p.PersonId, p.PersonName FROM Person p\n"
                    + "  JOIN Account a ON a.PersonId = p.PersonId\n"
                    + "  JOIN Role r ON r.RoleId = a.RoleId\n"
                    + "  WHERE r.RoleId = 3";

            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                Person author = new Person();
                author.setPersonId(rs.getInt("PersonId"));
                author.setPersonName(rs.getString("PersonName"));

                authors.add(author);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return authors;
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

    public List<Blog> getBlogList() {
        List<Blog> blogs = new ArrayList<>();

        try {
            String sql = "SELECT top 3 b.[BlogId], b.[Title], b.[Content], b.[Created_Date], \n"
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

    public void updateBlog(Blog blog) throws SQLException {
        String sql = "UPDATE Blog SET Title=?, Content=?, Description=?, CategoryId=?";

        if (blog.getImage() != null && !blog.getImage().isEmpty()) {
            sql += ", Image=?";
        }

        sql += " WHERE BlogId=?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, blog.getTitle());
            st.setString(2, blog.getContent());
            st.setString(3, blog.getDescription());
            st.setInt(4, blog.getCategory().getCategoryId());

            int paramIndex = 5;
            if (blog.getImage() != null && !blog.getImage().isEmpty()) {
                st.setString(paramIndex++, blog.getImage());
            }

            st.setInt(paramIndex, blog.getBlogId());

            st.executeUpdate();
        }
    }

    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryId, CategoryName FROM Category";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Category category = new Category();
                category.setCategoryId(rs.getInt("CategoryId"));
                category.setCategoryName(rs.getString("CategoryName"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public void createServiceReservation(int serviceId, int reservationId) {
        String sql = "INSERT INTO Services_Reservations (ServiceId, ReservationId) VALUES (?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, serviceId);
            st.setInt(2, reservationId);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in createServiceReservation: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public void createBlog(Blog blog) {
        String sql = "INSERT INTO Blog (Title, Content, Description, CategoryId, PersonId, Image, Created_Date) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE())";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, blog.getTitle());
            st.setString(2, blog.getContent());
            st.setString(3, blog.getDescription());
            st.setInt(4, blog.getCategory().getCategoryId());
            st.setInt(5, 13);
            st.setString(6, blog.getImage());

            st.executeUpdate();

        } catch (SQLException e) {
            System.out.println("Error in createServiceReservation: " + e.getMessage());
            e.printStackTrace();
        }
    }
 public static void main(String[] args) {
        BlogDAO blogDao = new BlogDAO();

        // Test getAllBlogList() và in ra tên của Person cho mỗi blog
        List<Person> x = blogDao.getPersonOfBlog();
        System.out.println("=== Testing Person Names from Blogs ===");
        for (Person person : x) {
            System.out.println("Person Name: " + person.getPersonName());
        }
    }

//    public Blog getBlogById(int blogId) throws SQLException {
//        String sql = "SELECT b.*, c.CategoryName, p.PersonName "
//                + "FROM Blog b "
//                + "JOIN Category c ON b.CategoryId = c.CategoryId "
//                + "JOIN Person p ON b.PersonId = p.PersonId "
//                + "WHERE b.BlogId = ?";
//        
//        try (PreparedStatement st = connection.prepareStatement(sql)) {
//            st.setInt(1, blogId);
//            
//            try (ResultSet rs = st.executeQuery()) {
//                if (rs.next()) {
//                    return mapResultSetToBlog(rs);
//                }
//            }
//        }
//        return null;
//    }
    private Blog mapResultSetToBlog(ResultSet rs) throws SQLException {
        Blog blog = new Blog();
        blog.setBlogId(rs.getInt("BlogId"));
        blog.setTitle(rs.getString("Title"));
        blog.setContent(rs.getString("Content"));
        blog.setDescription(rs.getString("Description"));
        blog.setImage(rs.getString("Image"));

        Category category = new Category();
        category.setCategoryId(rs.getInt("CategoryId"));
        category.setCategoryName(rs.getString("CategoryName"));
        blog.setCategory(category);

        Person person = new Person();
        person.setPersonId(rs.getInt("PersonId"));
        person.setPersonName(rs.getString("PersonName"));
        blog.setPerson(person);

        return blog;
    }

   

    public List<Blog> searchBlogs(String keyword) {
        List<Blog> blogs = new ArrayList<>();
        
        try {
            String sql = "SELECT DISTINCT b.[BlogId], b.[Title], b.[Content], b.[Created_Date], "
                    + "b.[Image], b.[Description], b.[PersonId], b.[CategoryId], "
                    + "p.[PersonName] as PersonName, c.[CategoryName] as CategoryName "
                    + "FROM [dbo].[Blog] b "
                    + "INNER JOIN [dbo].[Person] p ON b.[PersonId] = p.[PersonId] "
                    + "INNER JOIN [dbo].[Category] c ON b.[CategoryId] = c.[CategoryId] "
                    + "INNER JOIN [dbo].[Account] a ON p.[PersonId] = a.[PersonId] "
                    + "INNER JOIN [dbo].[Role] r ON a.[RoleId] = r.[RoleId] "
                    + "WHERE (b.[Title] LIKE ? OR c.[CategoryName] LIKE ?) "
                    + "AND r.[RoleId] = 3";

            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, "%" + keyword + "%");
            statement.setString(2, "%" + keyword + "%");
            
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

    public List<Blog> filterBlogs(String categoryId, String authorId) {
        List<Blog> blogs = new ArrayList<>();
        
        try {
            StringBuilder sql = new StringBuilder(
                "SELECT DISTINCT b.[BlogId], b.[Title], b.[Content], b.[Created_Date], "
                + "b.[Image], b.[Description], b.[PersonId], b.[CategoryId], "
                + "p.[PersonName] as PersonName, c.[CategoryName] as CategoryName "
                + "FROM [dbo].[Blog] b "
                + "INNER JOIN [dbo].[Person] p ON b.[PersonId] = p.[PersonId] "
                + "INNER JOIN [dbo].[Category] c ON b.[CategoryId] = c.[CategoryId] "
                + "INNER JOIN [dbo].[Account] a ON p.[PersonId] = a.[PersonId] "
                + "INNER JOIN [dbo].[Role] r ON a.[RoleId] = r.[RoleId] "
                + "WHERE r.[RoleId] = 3"
            );
            
            List<Object> params = new ArrayList<>();
            
            if (categoryId != null && !categoryId.isEmpty()) {
                sql.append(" AND b.[CategoryId] = ?");
                params.add(Integer.parseInt(categoryId));
            }
            
            if (authorId != null && !authorId.isEmpty()) {
                sql.append(" AND b.[PersonId] = ?");
                params.add(Integer.parseInt(authorId));
            }
            
            PreparedStatement statement = connection.prepareStatement(sql.toString());
            
            // Set parameters
            for (int i = 0; i < params.size(); i++) {
                statement.setObject(i + 1, params.get(i));
            }
            
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

    public int getTotalBlogs() {
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM Blog b "
                    + "INNER JOIN Person p ON b.PersonId = p.PersonId "
                    + "INNER JOIN Account a ON p.PersonId = a.PersonId "
                    + "INNER JOIN Role r ON a.RoleId = r.RoleId "
                    + "WHERE r.RoleId = 3";
                    
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }

}
