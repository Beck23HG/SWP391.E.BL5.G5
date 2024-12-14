<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@page contentType="text/html" pageEncoding="UTF-8"%>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Posts Management - Healthcare Admin</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="assets/css/style.css">
            <link rel="stylesheet" href="assets/css/posts.css">
            <!-- Bootstrap CSS -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

            <!-- Bootstrap JS Bundle with Popper -->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

            <!-- jQuery (if needed) -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

            <!-- Your existing scripts -->
            <script src="assets/js/main.js"></script>
            <script src="assets/js/posts.js"></script>
            <style>
                #createPostImage {
                    margin: 10px auto;
                    border-radius: 4px;
                    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                }
                
                .modal-body {
                    max-height: 80vh;
                    overflow-y: auto;
                }
            </style>
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
                <a href="../../sliderList" class="nav-item">
                    <i class="fas fa-images"></i>
                    <span>Sliders</span>
                </a>
                <a href="../../ListService" class="nav-item">
                    <i class="fas fa-list"></i>
                    <span>Services List</span>
                </a>
                <a href="../../customerList" class="nav-item">
                    <i class="fas fa-users"></i>
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
                        <div class="search-sql">
                            <form action="${pageContext.request.contextPath}/Manager/Dashboard/postList" method="get" class="search-sql-bar">
                                <i class="fas fa-search"></i>
                                <input type="text" name="keyword" placeholder="Search by title or category..." value="${keyword}">

                                <select class="filter-select" name="categoryId" onchange="this.form.submit()">
                                    <option value="">All Categories</option>
                                    <c:forEach items="${categories}" var="category">
                                        <option value="${category.categoryId}" ${category.categoryId == selectedCategoryId ? 'selected' : ''}>
                                            ${category.categoryName}
                                        </option>
                                    </c:forEach>
                                </select>

                                <select class="filter-select" name="authorId" onchange="this.form.submit()">
                                    <option value="">All Authors</option>
                                    <c:forEach items="${authors}" var="author">
                                        <option value="${author.personId}" ${author.personId == selectedAuthorId ? 'selected' : ''}>
                                            ${author.personName}
                                        </option>
                                    </c:forEach>
                                </select>

                                <button type="submit" class="search-btn">
                                    <i class="fas fa-search"></i>
                                    Search
                                </button>
                            </form>
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
                                        <img src="${pageContext.request.contextPath}/Manager/Dashboard/assets/images/blog/${blog.image}" alt="${blog.title}" class="post-thumbnail">
                                    </td>
                                    <td>${blog.title}</td>
                                    <td><span class="badge" style="color: black;">${blog.category.categoryName}</span></td>
                                    <td>${blog.person.personName}</td>
                                    <td><i class="fas fa-star featured-badge"></i></td>
                                    <td><span class="status-badge published">published</span></td>
                                    <td class="actions">
                                        <button type="button" class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#viewPostModal" onclick="setPostModalData('${blog.title}', '${blog.content}', '${blog.description}',
                                                        '${blog.person.personName}', '${blog.category.categoryName}', '${blog.image}')">
                                        <i class="fas fa-eye"></i> View
                                    </button>
                                        <button type="button" class="btn btn-success btn-sm" data-bs-toggle="modal" data-bs-target="#editPostModal" data-id="${blog.blogId}" data-title="${blog.title}" data-content="${blog.content}" data-description="${blog.description}" data-category-id="${blog.category.categoryId}"
                                            data-image="${blog.image}">
                                        <i class="fas fa-edit"></i> Edit
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

            <!-- View Post Modal -->
            <div class="modal fade" id="viewPostModal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">View Post Details</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form class="row g-3">
                                <div class="col-12 text-center">
                                    <img id="viewPostImage" src="" alt="Post thumbnail" style="max-width: 300px; max-height: 200px;">
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Title</label>
                                    <input type="text" class="form-control" id="viewPostTitle" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Author</label>
                                    <input type="text" class="form-control" id="viewPostAuthor" readonly>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Category</label>
                                    <input type="text" class="form-control" id="viewPostCategory" readonly>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Content</label>
                                    <textarea class="form-control" id="viewPostContent" rows="3" readonly></textarea>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" id="viewPostDescription" rows="5" readonly></textarea>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Edit Post Modal -->
            <div class="modal fade" id="editPostModal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Post</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="editPostForm" action="${pageContext.request.contextPath}/Manager/Dashboard/postList" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="edit">
                                <input type="hidden" name="blogId" id="editPostId">
                                <div class="col-12 text-center">
                                    <img id="editPostImage" src="${pageContext.request.contextPath}/Manager/Dashboard/assets/image/blog/${blog.image}" alt="Post thumbnail" style="max-width: 300px; max-height: 200px;">
                                    <input type="file" class="form-control mt-2" id="editPostImageInput" name="image" accept="image/*">
                                    <input type="text" name="oldImagePath" id="oldImagePath" hidden="" value="${blog.image}">
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Title <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="editPostTitle" name="title" required>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Category <span class="text-danger">*</span></label>
                                    <select class="form-select" id="editPostCategory" name="categoryId" required>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.categoryId}">${category.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Content</label>
                                    <textarea class="form-control" id="editPostContent" name="content" rows="3"></textarea>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" id="editPostDescription" name="description" rows="5"></textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Save Changes</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Create Post Modal -->
            <div class="modal fade" id="createPostModal" tabindex="-1">
                <div class="modal-dialog modal-lg modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Create New Post</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="createPostForm" action="${pageContext.request.contextPath}/Manager/Dashboard/postList" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="create">
                                <div class="col-12 text-center">
                                    <img id="createPostImage" src="" alt="Post thumbnail" style="max-width: 300px; max-height: 200px; display: none;">
                                    <input type="file" class="form-control mt-2" id="createPostImageInput" name="image" accept="image/*" required>
                                </div>
                                <div class="col-12 mt-3">
                                    <label class="form-label">Title <span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" name="title" required>
                                </div>
                                <div class="col-12 mt-3">
                                    <label class="form-label">Category <span class="text-danger">*</span></label>
                                    <select class="form-select" name="categoryId" required>
                                        <option value="">Select Category</option>
                                        <c:forEach items="${categories}" var="category">
                                            <option value="${category.categoryId}">${category.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="col-12 mt-3">
                                    <label class="form-label">Content <span class="text-danger">*</span></label>
                                    <textarea class="form-control" name="content" rows="5" required></textarea>
                                </div>
                                <div class="col-12 mt-3">
                                    <label class="form-label">Description</label>
                                    <textarea class="form-control" name="description" rows="3"></textarea>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                    <button type="submit" class="btn btn-primary">Create Post</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Success Modal -->
            <div class="modal fade" id="successModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Success</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            Operation completed successfully!
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>

            <script src="assets/js/main.js"></script>
            <script src="assets/js/posts.js"></script>
            <script>
                const postsManager = {
                    // Initialize event listeners
                    init() {
                        // Add click handlers for view/edit buttons
                        document.querySelectorAll('.btn-icon').forEach(button => {
                            button.addEventListener('click', (e) => {
                                const action = e.currentTarget.getAttribute('title');
                                if (action === 'View Details') {
                                    this.openDetailsModal(e.currentTarget.closest('tr'));
                                } else if (action === 'Edit') {
                                    this.openEditModal(e.currentTarget.closest('tr'));
                                }
                            });
                        });

                        // Add click handlers for modal close buttons
                        document.querySelectorAll('.modal-close, .modal-overlay').forEach(element => {
                            element.addEventListener('click', () => {
                                this.closeModals();
                            });
                        });

                        // Thêm xử lý cho nút Close trong Details Modal
                        document.querySelectorAll('[data-action="close"]').forEach(button => {
                            button.addEventListener('click', () => {
                                this.closeModals();
                            });
                        });

                        // Update view details handler
                        document.querySelectorAll('[title="View Details"]').forEach(button => {
                            button.addEventListener('click', (e) => {
                                const blogId = e.currentTarget.dataset.id;
                                console.log('Blog ID:', blogId);
                                window.location.href = `/ChildCare/Manager/Dashboard/postList?blogId=${blogId}`;
                            });
                        });
                    },

                    async openDetailsModal(blogId) {
                        const modal = document.getElementById('postDetailsModal');
                        if (!modal)
                            return;

                        try {
                            // Fetch blog details from server
                            const response = await fetch(`/ChildCare/manager/blog/detail?id=${blogId}`);
                            if (!response.ok)
                                throw new Error('Failed to fetch blog details');
                            const blogData = await response.json();

                            // Populate modal with data
                            document.getElementById('detailsThumbnail').src = blogData.image;
                            document.getElementById('detailsTitle').value = blogData.title;
                            document.getElementById('detailsAuthor').value = blogData.person.personName;
                            document.getElementById('detailsBrief').value = blogData.content;
                            document.getElementById('detailsDescription').value = blogData.description;

                            // Update status and category badges
                            const statusBadge = modal.querySelector('.post-status-badge');
                            statusBadge.textContent = blogData.status;
                            statusBadge.className = `post-status-badge ${blogData.status.toLowerCase()}`;

                            const categoryBadge = modal.querySelector('.post-category-badge');
                            categoryBadge.textContent = blogData.category.categoryName;

                            // Show the modal
                            modal.style.display = 'block';
                        } catch (error) {
                            console.error('Error fetching blog details:', error);
                            alert('Failed to load blog details. Please try again.');
                        }
                    },

                    openEditModal(row) {
                        const modal = document.getElementById('postModal');
                        if (!modal)
                            return;

                        // Get data from the row
                        const title = row.querySelector('td:nth-child(3)').textContent;
                        const category = row.querySelector('.badge').textContent;
                        const author = row.querySelector('td:nth-child(5)').textContent;
                        const thumbnail = row.querySelector('.post-thumbnail').src;

                        // Populate form with data
                        document.getElementById('postTitle').value = title;
                        document.getElementById('thumbnailPreview').src = thumbnail;

                        // Show the modal
                        modal.style.display = 'block';
                    },

                    closeModals() {
                        document.querySelectorAll('.modal').forEach(modal => {
                            modal.style.display = 'none';
                        });
                    }
                };

                // Initialize when the document is loaded
                document.addEventListener('DOMContentLoaded', () => {
                    postsManager.init();
                });

                // Function to set data for View modal
                function setPostModalData(title, content, description, author, category, image) {
                    document.getElementById('viewPostTitle').value = title;
                    document.getElementById('viewPostContent').value = content;
                    document.getElementById('viewPostDescription').value = description;
                    document.getElementById('viewPostAuthor').value = author;
                    document.getElementById('viewPostCategory').value = category;
                    document.getElementById('viewPostImage').src = "/ChildCare/Manager/Dashboard/assets/images/blog/" + image || 'path/to/default/image.jpg';
                }

                // Initialize edit modal handlers
                document.addEventListener('DOMContentLoaded', function() {
                    // Edit button handlers
                    const editButtons = document.querySelectorAll('button[data-bs-target="#editPostModal"]');
                    editButtons.forEach(button => {
                        button.addEventListener('click', function() {
                            const id = this.getAttribute('data-id');
                            const title = this.getAttribute('data-title');
                            const content = this.getAttribute('data-content');
                            const description = this.getAttribute('data-description');
                            const categoryId = this.getAttribute('data-category-id');
                            const image = this.getAttribute('data-image');

                            document.getElementById('editPostId').value = id;
                            document.getElementById('editPostTitle').value = title;
                            document.getElementById('editPostContent').value = content;
                            document.getElementById('editPostDescription').value = description;
                            document.getElementById('editPostCategory').value = categoryId;
                            document.getElementById('editPostImage').src = "/ChildCare/Manager/Dashboard/assets/images/blog/" + image || 'path/to/default/image.jpg';
                            document.getElementById('oldImagePath').value = image;
                        });
                    });

                    // Image preview handlers
                    ['editPostImageInput', 'createPostImageInput'].forEach(inputId => {
                        document.getElementById(inputId).addEventListener('change', function(e) {
                            const file = e.target.files[0];
                            if (file) {
                                const reader = new FileReader();
                                reader.onload = function(e) {
                                    const imgId = inputId.replace('Input', '');
                                    document.getElementById(imgId).src = e.target.result;
                                }
                                reader.readAsDataURL(file);
                            }
                        });
                    });

                    // Form submission handlers
                    ['editPostForm', 'createPostForm'].forEach(formId => {
                        document.getElementById(formId).addEventListener('submit', function(e) {
                            e.preventDefault();

                            // Basic validation
                            const title = this.querySelector('[name="title"]').value.trim();
                            const categoryId = this.querySelector('[name="categoryId"]').value;

                            if (!title || !categoryId) {
                                alert('Please fill in all required fields');
                                return;
                            }

                            // Submit form
                            this.submit();
                        });
                    });
                });

                document.addEventListener('DOMContentLoaded', function() {
                    // Debug modal initialization
                    const viewModal = new bootstrap.Modal(document.getElementById('viewPostModal'));
                    console.log('Modal initialized:', viewModal);

                    // Debug button clicks
                    document.querySelectorAll('[data-bs-target="#viewPostModal"]').forEach(button => {
                        button.addEventListener('click', function() {
                            console.log('View button clicked');
                        });
                    });
                });

                // Xử lý preview ảnh khi chọn file
                document.getElementById('editPostImageInput').addEventListener('change', function(e) {
                    const file = e.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            document.getElementById('editPostImage').src = e.target.result;
                        }
                        reader.readAsDataURL(file);
                    }
                });

                // Cập nhật xử lý nút Edit
                document.querySelectorAll('button[data-bs-target="#postEditModal"]').forEach(button => {
                    button.addEventListener('click', function() {
                        const id = this.getAttribute('data-id');
                        const title = this.getAttribute('data-title');
                        const content = this.getAttribute('data-content');
                        const description = this.getAttribute('data-description');
                        const category = this.getAttribute('data-category');
                        const image = this.getAttribute('data-image');

                        document.getElementById('editPostId').value = id;
                        document.getElementById('editPostTitle').value = title;
                        document.getElementById('editPostContent').value = content;
                        document.getElementById('editPostDescription').value = description;
                        document.getElementById('editPostCategory').value = category;

                        // Cập nhật hiển thị ảnh hiện tại
                        const editPostImage = document.getElementById('editPostImage');
                        if (image && image !== 'null') {
                            editPostImage.src = image;
                        } else {
                            editPostImage.src = ''; // hoặc một ảnh placeholder mặc định
                        }
                    });
                });

                // Add this to your existing JavaScript
                document.addEventListener('DOMContentLoaded', function() {
                    // Handle New Post button click
                    const newPostButton = document.getElementById('newPostButton');
                    if (newPostButton) {
                        newPostButton.addEventListener('click', function() {
                            const createPostModal = new bootstrap.Modal(document.getElementById('createPostModal'));
                            createPostModal.show();
                        });
                    }

                    // Handle image preview for create post
                    const createPostImageInput = document.getElementById('createPostImageInput');
                    const createPostImage = document.getElementById('createPostImage');

                    if (createPostImageInput) {
                        createPostImageInput.addEventListener('change', function(e) {
                            const file = e.target.files[0];
                            if (file) {
                                const reader = new FileReader();
                                reader.onload = function(e) {
                                    createPostImage.src = e.target.result;
                                    createPostImage.style.display = 'block';
                                }
                                reader.readAsDataURL(file);
                            } else {
                                createPostImage.style.display = 'none';
                            }
                        });
                    }

                    // Handle form submission
                    const createPostForm = document.getElementById('createPostForm');
                    if (createPostForm) {
                        createPostForm.addEventListener('submit', function(e) {
                            e.preventDefault();

                            // Basic validation
                            const title = this.querySelector('[name="title"]').value.trim();
                            const content = this.querySelector('[name="content"]').value.trim();
                            const categoryId = this.querySelector('[name="categoryId"]').value;
                            const imageFile = this.querySelector('[name="image"]').files[0];

                            if (!title || !content || !categoryId || !imageFile) {
                                alert('Please fill in all required fields and select an image');
                                return;
                            }

                            // Submit form
                            const formData = new FormData(this);
                            fetch(this.action, {
                                    method: 'POST',
                                    body: formData
                                })
                                .then(response => response.text())
                                .then(data => {
                                    // Close modal
                                    const modal = bootstrap.Modal.getInstance(document.getElementById('createPostModal'));
                                    modal.hide();

                                    // Show success message
                                    alert('Post created successfully!');

                                    // Reload page to show new post
                                    window.location.reload();
                                })
                                .catch(error => {
                                    console.error('Error:', error);
                                    alert('An error occurred while creating the post');
                                });
                        });
                    }
                });

                // Xử lý khi nút Edit được click
                document.querySelectorAll('button[data-bs-target="#editPostModal"]').forEach(button => {
                    button.addEventListener('click', function() {
                        const id = this.getAttribute('data-id');
                        const title = this.getAttribute('data-title');
                        const content = this.getAttribute('data-content');
                        const description = this.getAttribute('data-description');
                        const categoryId = this.getAttribute('data-category-id');
                        const image = this.getAttribute('data-image');

                        // Populate form fields
                        document.getElementById('editPostId').value = id;
                        document.getElementById('editPostTitle').value = title;
                        document.getElementById('editPostContent').value = content;
                        document.getElementById('editPostDescription').value = description;
                        document.getElementById('editPostCategory').value = categoryId;

                        // Show current image if exists
                        const editPostImage = document.getElementById('editPostImage');
                        if (image && image !== 'null') {
                            editPostImage.src = image;
                            editPostImage.style.display = 'block';
                        } else {
                            editPostImage.style.display = 'none';
                        }
                    });
                });

                // Preview image when new file is selected
                document.getElementById('editPostImageInput').addEventListener('change', function(e) {
                    const file = e.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            document.getElementById('editPostImage').src = e.target.result;
                            document.getElementById('editPostImage').style.display = 'block';
                        }
                        reader.readAsDataURL(file);
                    }
                });

                function updateTableImage(blogId, newImagePath) {
                    const tableRow = document.querySelector(`tr[data-blog-id="${blogId}"]`);
                    if (tableRow) {
                        const imgElement = tableRow.querySelector('.post-thumbnail');
                        if (imgElement) {
                            imgElement.src = `${contextPath}/Manager/Dashboard/assets/images/blog/${newImagePath}`;
                        }
                    }
                }
            </script>
        </body>

        </html>