<%-- 
    Document   : PostList
    Created on : Nov 26, 2024, 5:22:37 PM
    Author     : Admin
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <title>Post Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-4">
    <h1 class="text-center">Manage Posts</h1>

    <!-- Filters and Search -->
    <form method="get" action="PostList.jsp" class="row g-3 mb-4">
        <div class="col-md-3">
            <input type="text" name="search" class="form-control" placeholder="Search by title" value="<%= request.getParameter("search") %>">
        </div>
        <div class="col-md-2">
            <select name="category" class="form-select">
                <option value="">All Categories</option>
                <option value="news">News</option>
                <option value="blog">Blog</option>
                <!-- Add more categories as needed -->
            </select>
        </div>
        <div class="col-md-2">
            <select name="author" class="form-select">
                <option value="">All Authors</option>
                <option value="Admin">Admin</option>
                <option value="Manager">Manager</option>
                <!-- Add more authors dynamically -->
            </select>
        </div>
        <div class="col-md-2">
            <select name="status" class="form-select">
                <option value="">All Statuses</option>
                <option value="published">Published</option>
                <option value="draft">Draft</option>
            </select>
        </div>
        <div class="col-md-3">
            <button type="submit" class="btn btn-primary w-100">Filter</button>
        </div>
    </form>

    <!-- Add New Post -->
    <a href="PostDetail.jsp?action=new" class="btn btn-success mb-3">Add New Post</a>

    <!-- Post List -->
    <table class="table table-striped">
        <thead class="table-dark">
            <tr>
                <th><a href="?sort=id">ID</a></th>
                <th>Thumbnail</th>
                <th><a href="?sort=title">Title</a></th>
                <th><a href="?sort=category">Category</a></th>
                <th><a href="?sort=author">Author</a></th>
                <th><a href="?sort=featured">Featured</a></th>
                <th><a href="?sort=status">Status</a></th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Dummy data for demonstration; replace with dynamic data fetching
                List<String[]> posts = new ArrayList<>();
                posts.add(new String[]{"1", "thumb1.jpg", "First Post", "News", "Admin", "Yes", "Published"});
                posts.add(new String[]{"2", "thumb2.jpg", "Second Post", "Blog", "Manager", "No", "Draft"});

                for (String[] post : posts) {
            %>
            <tr>
                <td><%= post[0] %></td>
                <td><img src="<%= post[1] %>" alt="Thumbnail" style="width: 50px; height: auto;"></td>
                <td><%= post[2] %></td>
                <td><%= post[3] %></td>
                <td><%= post[4] %></td>
                <td><%= post[5] %></td>
                <td><%= post[6] %></td>
                <td>
                    <a href="PostDetail.jsp?id=<%= post[0] %>" class="btn btn-info btn-sm">View</a>
                    <a href="EditPost.jsp?id=<%= post[0] %>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="HidePostServlet?id=<%= post[0] %>" class="btn btn-secondary btn-sm">Hide</a>
                    <a href="ShowPostServlet?id=<%= post[0] %>" class="btn btn-success btn-sm">Show</a>
                </td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <!-- Pagination -->
    <nav>
        <ul class="pagination justify-content-center">
            <li class="page-item"><a class="page-link" href="?page=1">1</a></li>
            <li class="page-item"><a class="page-link" href="?page=2">2</a></li>
            <li class="page-item"><a class="page-link" href="?page=3">3</a></li>
            <!-- Add more pagination links dynamically -->
        </ul>
    </nav>
</div>
</body>
</html>
