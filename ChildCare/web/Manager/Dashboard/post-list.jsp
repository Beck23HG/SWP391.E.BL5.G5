<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>

<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Posts Management - Healthcare Admin</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/posts.css">
    </head>

    <body>
        <nav class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">HealthCare Manager</div>
            </div>

            <!-- Manager Section -->
            <div class="nav-section">
                <div class="nav-section-title">Manager Tools</div>
                <a href="postList" class="nav-item">
                    <i class="fas fa-newspaper"></i>
                    <span>Posts</span>
                </a>
                <a href="sliderList" class="nav-item">
                    <i class="fas fa-images"></i>
                    <span>Sliders</span>
                </a>
                <a href="ListService" class="nav-item">
                    <i class="fas fa-list"></i>
                    <span>Services List</span>
                </a>
                <a href="customerList" class="nav-item">
                    <i class="fas fa-list"></i>
                    <span>Customer List</span>
                </a>
            </div>

        </nav>

        <!-- Main Content Area -->
        <div class="main-content">
            <div class="top-nav">
                <div class="menu-toggle">
                    <span></span>
                    <span></span>
                    <span></span>
                </div>
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" placeholder="Search...">
                </div>
                <div class="user-menu">
                    <div class="user-profile-wrapper">
                        <div class="user-profile">
                            <div class="user-avatar">
                                <i class="fas fa-user"></i>
                            </div>
                            <div class="user-info">
                                <span class="user-name">${sessionScope.account.person.personName}</span>
                                <span class="user-role">Manager</span>
                            </div>
                        </div>

                    </div>
                    <div class="user-profile">
                        <a href="logout" style="padding: 10% 0">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Sign Out</span>
                        </a>
                    </div>
                    <div class="theme-toggle" title="Toggle theme">
                    </div>
                </div>
            </div>

            <div class="page-header">
                <div class="header-content">
                    <h1>Posts Management</h1>
                    <button class="btn-primary" id="newPostButton">
                        <i class="fas fa-plus"></i>
                        New Post
                    </button>
                </div>

                <!-- Filter Section -->
                <div class="filters-section">
                    <div class="search-filters">
                        <div class="search-bar">
                            <i class="fas fa-search"></i>
                            <input type="text" placeholder="Search by title...">
                        </div>
                        <div class="filter-group">
                            <select class="filter-select" id="categoryFilter">
                                <option value="">All Categories</option>
                                <option value="news">News</option>
                                <option value="health">Health</option>
                                <option value="medical">Medical</option>
                                <option value="lifestyle">Lifestyle</option>
                            </select>
                            <select class="filter-select" id="authorFilter">
                                <option value="">All Authors</option>
                                <!-- Authors will be populated dynamically -->
                            </select>
                            <select class="filter-select" id="statusFilter">
                                <option value="">All Status</option>
                                <option value="published">Published</option>
                                <option value="draft">Draft</option>
                                <option value="archived">Archived</option>
                            </select>
                        </div>
                    </div>
                    <div class="active-filters">
                        <!-- Active filters will be added here dynamically -->
                    </div>
                </div>
            </div>

            <!-- Posts Table -->
            <div class="posts-table">
                <table>
                    <thead>
                        <tr>
                            <th class="sortable" data-sort="id">ID <i class="fas fa-sort"></i></th>
                            <th>Thumbnail</th>
                            <th class="sortable" data-sort="title">Title <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="category">Category <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="author">Author <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="featured">Featured <i class="fas fa-sort"></i></th>
                            <th class="sortable" data-sort="status">Status <i class="fas fa-sort"></i></th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${blogs}" var="blog" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <img src="${blog.image}" alt="${blog.title}" class="post-thumbnail">
                                </td>
                                <td>${blog.title}</td>
                                <td><span class="badge">${blog.category.categoryName}</span></td>
                                <td>${blog.person.personName}</td>
                                <td><i class="fas fa-star featured-badge"></i></td>
                                <td><span class="status-badge published">Published</span></td>
                                <td class="actions">
                                    <button class="btn-icon" title="View Details">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                    <button class="btn-icon" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </button>
                                    <button class="btn-icon delete" title="Delete">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <div class="pagination-info">
                    Showing <span>1-10</span> of <span>25</span> posts
                </div>
                <div class="pagination-controls">
                    <button class="btn-icon" disabled>
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <div class="page-numbers">
                        <button class="active">1</button>
                        <button>2</button>
                        <button>3</button>
                    </div>
                    <button class="btn-icon">
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
                <div class="items-per-page">
                    <select>
                        <option value="10">10 per page</option>
                        <option value="20">20 per page</option>
                        <option value="50">50 per page</option>
                    </select>
                </div>
            </div>
        </div>

        <!-- Post Edit Modal -->
        <div class="modal" id="postModal">
            <div class="modal-overlay"></div>
            <div class="modal-container">
                <div class="modal-header">
                    <h2 class="modal-title">Edit Post</h2>
                    <button class="modal-close">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-content">
                    <form id="postForm" class="post-form">
                        <div class="form-group">
                            <label for="postTitle">Title</label>
                            <input type="text" id="postTitle" name="title" required>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="postCategory">Category</label>
                                <select id="postCategory" name="category" required>
                                    <option value="news">News</option>
                                    <option value="health">Health</option>
                                    <option value="medical">Medical</option>
                                    <option value="lifestyle">Lifestyle</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="postAuthor">Author</label>
                                <select id="postAuthor" name="author" required>
                                    <!-- Authors will be populated dynamically -->
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="postBrief">Brief Information</label>
                            <textarea id="postBrief" name="brief" rows="2" required></textarea>
                        </div>

                        <div class="form-group">
                            <label for="postDescription">Description</label>
                            <textarea id="postDescription" name="description" rows="6" required></textarea>
                        </div>

                        <div class="image-upload-container">
                            <div class="image-preview">
                                <img src="" alt="Post thumbnail preview" id="thumbnailPreview">
                                <div class="image-overlay">
                                    <i class="fas fa-camera"></i>
                                    <span>Change Thumbnail</span>
                                </div>
                            </div>
                            <input type="file" id="thumbnailInput" accept="image/*" hidden>
                            <p class="image-hint">Recommended size: 800x600px</p>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="switch-wrapper">
                                    <input type="checkbox" id="postFeatured" name="featured">
                                    <span class="switch"></span>
                                    <span class="switch-label">Featured</span>
                                </label>
                            </div>
                            <div class="form-group">
                                <label for="postStatus">Status</label>
                                <select id="postStatus" name="status" required>
                                    <option value="published">Published</option>
                                    <option value="draft">Draft</option>
                                    <option value="archived">Archived</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button class="btn-secondary" data-action="cancel">Cancel</button>
                    <button class="btn-primary" data-action="save">Save Changes</button>
                </div>
            </div>
        </div>

        <!-- Post Details Modal -->
        <div class="modal" id="postDetailsModal" style="display: none">
            <div class="modal-overlay"></div>
            <div class="modal-container">
                <div class="modal-header">
                    <h2 class="modal-title">Post Details</h2>
                    <button class="modal-close">
                        <i class="fas fa-times"></i>
                    </button>
                </div>
                <div class="modal-content">
                    <div class="post-details">
                        <div class="post-preview">
                            <img src="" alt="Post thumbnail" id="detailsThumbnail">
                            <div class="post-info">
                                <div class="post-status-badge"></div>
                                <div class="post-category-badge"></div>
                                <div class="post-featured-badge"></div>
                            </div>
                        </div>

                        <div class="details-section">
                            <div class="detail-group">
                                <label>Title</label>
                                <div class="detail-value" id="detailsTitle"></div>
                            </div>

                            <div class="detail-group">
                                <label>Author</label>
                                <div class="detail-value" id="detailsAuthor"></div>
                            </div>

                            <div class="detail-group">
                                <label>Brief Information</label>
                                <div class="detail-value" id="detailsBrief"></div>
                            </div>

                            <div class="detail-group">
                                <label>Description</label>
                                <div class="detail-value" id="detailsDescription"></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn-secondary" data-action="close">Close</button>
                    <button class="btn-primary" data-action="edit">
                        <i class="fas fa-edit"></i>
                        Edit Post
                    </button>
                </div>
            </div>
        </div>

        <script src="assets/js/main.js"></script>

        <!--<script src="assets/js/posts.js"></script>-->

    </body>

</html>