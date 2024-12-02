<!DOCTYPE html>
<html lang="en">
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Health & Care Blogs - Children Care System</title>
        <meta name="description" content="Latest healthcare insights and tips for your child's wellbeing">

        <!-- Favicon -->
        <link rel="icon" type="image/x-icon" href="assets/images/favicon.ico">

        <!-- CSS Files -->
        <link rel="stylesheet" href="assets/css/style.css">
        <link rel="stylesheet" href="assets/css/responsive.css">

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    </head>

    <body>

        <!-- Header Section -->
        <header class="header fixed-top">
            <nav class="navbar navbar-expand-lg navbar-light">
                <div class="container">
                    <a class="navbar-brand" href="index">
                        <img src="assets/images/children-care-logo-removebg.png" alt="Children Care Logo" class="logo">
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarNav">
                        <ul class="navbar-nav ms-auto align-items-center">
                            <li class="nav-item">
                                <a class="nav-link active" href="/">Home</a>
                            </li>
                            <li class="nav-item dropdown">
                                <button class="nav-link dropdown-toggle btn btn-link" data-bs-toggle="dropdown">
                                    <a style="text-decoration: none; color: inherit;" href="services">Services</a>
                                </button>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="services/pediatric">Pediatric Care</a></li>
                                    <li><a class="dropdown-item" href="services/vaccination">Vaccination</a></li>
                                    <li><a class="dropdown-item" href="services/development">Child Development</a></li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="doctors">Our Doctors</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="blogs">Blogs</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="contact">Contact</a>
                            </li>
                            <li class="nav-item ms-lg-3">
                                <a class="btn btn-primary rounded-pill px-4" href="appointment">
                                    <i class="fas fa-calendar-check me-2"></i>Book Appointment
                                </a>
                            </li>
                            <li class="nav-item ms-lg-2">
                                <a class="btn btn-outline-primary rounded-pill px-4" href="login">
                                    <i class="fas fa-user me-2"></i>Login
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>

        <!-- Main Content Area -->
        <main id="main-content">
            <!-- Blog Hero Section -->
            <section class="blog-hero-section">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-lg-6">
                            <span class="badge bg-primary-soft mb-3">Our Blog</span>
                            <h1 class="display-4 fw-bold mb-4">Health & Care Insights</h1>
                            <p class="lead mb-4">Discover expert advice, tips, and insights about children's health and wellbeing.
                            </p>
                            <div class="search-box">
                                <div class="input-group">
                                    <input type="text" class="form-control" id="searchInput" placeholder="Search articles...">
                                    <button class="btn btn-primary" type="button" onclick="searchBlogs()">
                                        <i class="fas fa-search"></i>
                                    </button>
                                </div>
                            </div>
                            <div id="searchResults" class="mt-3"></div>
                            <script>
                                function searchBlogs() {
                                    const searchInput = document.getElementById('searchInput').value.toLowerCase();
                                    const blogContainer = document.getElementById('blogContainer');
                                    const searchResults = document.getElementById('searchResults');
                                    const blogItems = document.querySelectorAll('.blog-item');
                                    let found = false;

                                    blogItems.forEach(item => {
                                        const title = item.querySelector('.blog-title').textContent.toLowerCase();
                                        const description = item.querySelector('.blog-excerpt').textContent.toLowerCase();

                                        if (title.includes(searchInput) || description.includes(searchInput)) {
                                            item.style.display = 'block';
                                            found = true;
                                        } else {
                                            item.style.display = 'none';
                                        }
                                    });

                                    if (!found) {
                                        searchResults.innerHTML = '<div class="alert alert-warning">Not found</div>';
                                    } else {
                                        searchResults.innerHTML = '';
                                    }
                                }
                            </script>
                        </div>
                        <div class="col-lg-6">
                            <img src="https://kajabi-storefronts-production.kajabi-cdn.com/kajabi-storefronts-production/file-uploads/blogs/24900/images/a5a706b-a1e6-bc3-7be8-8448147867a_Family_Engagement.png" alt="Blog Hero" class="img-fluid rounded-4">
                        </div>
                    </div>
                </div>
            </section>

            <!-- Blog Categories -->
            <section class="blog-categories py-5">
                <div class="container">
                    <div class="categories-wrapper">
                        <button class="btn btn-outline-primary active" data-category="all">All Posts</button>
                        <button class="btn btn-outline-primary" data-category="health">Health Tips</button>
                        <button class="btn btn-outline-primary" data-category="nutrition">Nutrition</button>
                        <button class="btn btn-outline-primary" data-category="development">Child Development</button>
                        <button class="btn btn-outline-primary" data-category="parenting">Parenting</button>
                    </div>
                </div>
            </section>
            <!-- Loc -->
            <script>
                    const categoryButtons = document.querySelectorAll('.categories-wrapper button');

                    categoryButtons.forEach(button => {
                        button.addEventListener('click', () => {
                            // Remove active class from all buttons
                            categoryButtons.forEach(btn => btn.classList.remove('active'));
                            // Add active class to clicked button
                            button.classList.add('active');

                            const category = button.getAttribute('data-category');
                            filterBlogs(category);
                        });
                    });

                    function filterBlogs(category) {
                        const blogItems = document.querySelectorAll('.blog-item');

                        blogItems.forEach(item => {
                            const title = item.querySelector('.blog-title').textContent.toLowerCase();
                            const description = item.querySelector('.blog-excerpt').textContent.toLowerCase();
                            const content = title + ' ' + description;

                            if (category === 'all') {
                                item.style.display = 'block';
                            } else if (category === 'health' && content.includes('health')) {
                                item.style.display = 'block';
                            } else if (category === 'nutrition' && content.includes('nutrition')) {
                                item.style.display = 'block';
                            } else if (category === 'development' && content.includes('development')) {
                                item.style.display = 'block';
                            } else if (category === 'parenting' && content.includes('vaccin')) {
                                item.style.display = 'block';
                            } else {
                                item.style.display = 'none';
                            }
                        });
                    }
                </script>
            

            <!-- Featured Posts -->
            <section class="featured-posts py-5 bg-light">
                <div class="container">
                    <h2 class="section-title mb-4">Featured Articles</h2>
                    <div class="row g-4" id="blogContainer">
                        <c:forEach items="${blogs}" var="blog">
                            <div class="col-md-6 col-lg-4 blog-item">
                                <article class="blog-card featured">
                                    <div class="blog-card-image">
                                        <img src="${blog.image}" alt="${blog.title}" class="img-fluid">
                                        <span class="category-badge">Health Tips</span>
                                    </div>
                                    <div class="blog-card-content">
                                        <div class="blog-meta">
                                            <span><i class="far fa-calendar me-2"></i>
                                                <fmt:formatDate value="${blog.created_Date}" pattern="MMM dd, yyyy"/>
                                            </span>
                                            <span><i class="far fa-clock me-2"></i>5 min read</span>
                                        </div>
                                        <h3 class="blog-title">${blog.title}</h3>
                                        <p class="blog-excerpt">${blog.description}</p>
                                        <a href="blog-detail?id=${blog.blogId}" class="btn btn-link text-primary p-0">
                                            Read More <i class="fas fa-arrow-right ms-2"></i>
                                        </a>
                                    </div>
                                </article>
                            </div>
                        </c:forEach>
                    </div>

                    <div class="d-flex justify-content-center align-items-center mt-4">
                        <button onclick="previousPage()" class="btn btn-primary me-2">Previous</button>
                        <span id="pageInfo" class="mx-3">Page 1</span>
                        <button onclick="nextPage()" class="btn btn-primary ms-2">Next</button>
                    </div>
                </div>
            </section>
            <script>
                let currentPage = 1;
                const itemsPerPage = 4;
                const blogItems = document.querySelectorAll('.blog-item');
                const totalPages = Math.ceil(blogItems.length / itemsPerPage);
                console.log(blogItems);
                function showPage(page) {
                    const start = (page - 1) * itemsPerPage;
                    const end = start + itemsPerPage;

                    blogItems.forEach((item, index) => {
                        if (index >= start && index < end) {
                            item.style.display = 'block';
                        } else {
                            item.style.display = 'none';
                        }
                    });

                    document.getElementById('pageInfo').textContent = `Page ${page} of ${totalPages}`;
                }

                function nextPage() {
                    if (currentPage < totalPages) {
                        currentPage++;
                        showPage(currentPage);
                    }
                }

                function previousPage() {
                    if (currentPage > 1) {
                        currentPage--;
                        showPage(currentPage);
                    }
                }

                // Initialize first page
                showPage(1);
            </script>


            <!-- Latest Posts -->
            <section class="latest-posts py-5">
                <div class="container">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="section-title mb-0">Latest Articles</h2>
                        <div class="view-options">
                            <button class="btn btn-light" data-view="grid">
                                <i class="fas fa-th-large"></i>
                            </button>
                            <button class="btn btn-light" data-view="list">
                                <i class="fas fa-list"></i>
                            </button>
                        </div>
                    </div>
                    <div class="row g-4" id="blogPosts">
                        <!-- Blog posts will be loaded dynamically -->
                    </div>
                    <div class="text-center mt-5">
                        <button class="btn btn-outline-primary btn-lg load-more">
                            Load More Articles
                        </button>
                    </div>
                </div>
            </section>

            <!-- Newsletter Section -->
            <section class="newsletter-section py-5 bg-primary-soft">
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-6 text-center">
                            <h3 class="mb-4">Subscribe to Our Newsletter</h3>
                            <p class="mb-4">Get the latest health tips and insights delivered to your inbox.</p>
                            <form class="newsletter-form">
                                <div class="input-group">
                                    <input type="email" class="form-control" placeholder="Enter your email">
                                    <button class="btn btn-primary" type="submit">Subscribe</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </main>

        <!-- Footer Section -->
        <footer class="footer bg-light py-5">
            <div class="container">
                <div class="row g-4">
                    <div class="col-lg-4">
                        <h5 class="fw-bold mb-4">About Children Care</h5>
                        <p class="text-muted">Providing comprehensive healthcare services for children with care, compassion, and expertise.</p>
                        <div class="social-links mt-4">
                            <a href="#" class="me-3"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="me-3"><i class="fab fa-instagram"></i></a>
                            <a href="#"><i class="fab fa-linkedin-in"></i></a>
                        </div>
                    </div>
                    <div class="col-lg-2">
                        <h5 class="fw-bold mb-4">Quick Links</h5>
                        <ul class="list-unstyled footer-links">
                            <li><a href="services">Services</a></li>
                            <li><a href="blogs">Blogs</a></li>
                            <li><a href="contact">Contact</a></li>
                            <li><a href="about">About Us</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-3">
                        <h5 class="fw-bold mb-4">Contact Info</h5>
                        <ul class="list-unstyled contact-info">
                            <li><i class="fas fa-phone text-primary"></i> +1 234 567 890</li>
                            <li><i class="fas fa-envelope text-primary"></i> info@childrencare.com</li>
                            <li><i class="fas fa-location-dot text-primary"></i> 123 Healthcare St, Medical City</li>
                        </ul>
                    </div>
                    <div class="col-lg-3">
                        <h5 class="fw-bold mb-4">Newsletter</h5>
                        <p class="text-muted">Subscribe for health tips and updates</p>
                        <form class="newsletter-form">
                            <div class="input-group">
                                <input type="email" class="form-control" placeholder="Your email">
                                <button class="btn btn-primary" type="submit">Subscribe</button>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="footer-bottom text-center mt-5 pt-4 border-top">
                    <p class="mb-0"> 2024 Children Care. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="assets/js/blogs.js"></script>

    </body>
    <!-- Featured Articles Paginatedly(Phan Trang) -->


</html>