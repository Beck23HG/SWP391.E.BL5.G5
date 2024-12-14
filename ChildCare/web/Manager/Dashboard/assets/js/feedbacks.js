document.addEventListener('DOMContentLoaded', function() {
    // Theme toggle functionality
    const themeToggle = document.querySelector('.theme-toggle');
    const body = document.body;

    // Check for saved theme preference
    const savedTheme = localStorage.getItem('theme') || 'light';
    body.setAttribute('data-theme', savedTheme);

    themeToggle.addEventListener('click', () => {
        const currentTheme = body.getAttribute('data-theme');
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';

        body.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
    });

    // Search and Filter functionality
    const searchInput = document.querySelector('.search-filters .search-bar input');
    const filters = document.querySelectorAll('.filter-select');
    const activeFiltersContainer = document.querySelector('.active-filters');

    // ... keep the rest of the filter, sort, and modal functionality ...
});