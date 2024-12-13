class PostsManager {
    constructor() {
        // Initialize event listeners
        this.initializeEventListeners();
        // Initialize theme handler
        this.initializeThemeHandler();
    }

    initializeEventListeners() {
        // Modal handlers
        this.initializeModalHandlers();
    }

    initializeModalHandlers() {
        // New Post button
        const newPostButton = document.getElementById('newPostButton');
        if (newPostButton) {
            newPostButton.addEventListener('click', () => this.openCreateModal());
        }

        // Modal close buttons
        document.querySelectorAll('.modal-close, [data-action="cancel"]')
            .forEach(button => {
                button.addEventListener('click', () => this.closeModals());
            });
    }

    openCreateModal() {
        const modal = document.getElementById('postModal');
        if (!modal) return;

        // Reset form before showing modal
        const form = document.getElementById('postForm');
        if (form) {
            form.reset();
            form.dataset.action = 'create';
            delete form.dataset.postId;
        }

        // Reset thumbnail preview
        const preview = document.getElementById('thumbnailPreview');
        if (preview) {
            preview.src = 'https://via.placeholder.com/800x600?text=Upload+Image';
        }

        // Update modal title
        const title = modal.querySelector('.modal-title');
        if (title) title.textContent = 'Create New Post';

        // Show modal with animation
        this.showModal(modal);
    }

    closeModals() {
        const modals = document.querySelectorAll('.modal');
        modals.forEach(modal => {
            modal.classList.remove('show');
            setTimeout(() => {
                if (!modal.classList.contains('show')) {
                    modal.style.display = 'none';
                }
            }, 300);
        });
        document.body.style.overflow = '';
    }

    showModal(modal) {
        // Ensure any existing modals are closed
        this.closeModals();

        // Show the modal
        modal.style.display = 'flex';
        modal.offsetHeight; // Force reflow
        modal.classList.add('show');
        document.body.style.overflow = 'hidden';

        // Add click handlers for overlay close
        const overlay = modal.querySelector('.modal-overlay');
        if (overlay) {
            overlay.addEventListener('click', (e) => {
                if (e.target === overlay) {
                    this.closeModals();
                }
            });
        }
    }

    initializeThemeHandler() {
        const themeToggle = document.querySelector('.theme-toggle');
        if (themeToggle) {
            themeToggle.addEventListener('click', () => this.toggleTheme());
        }
        this.initializeTheme();
    }

    initializeTheme() {
        const savedTheme = localStorage.getItem('theme');
        if (savedTheme) {
            document.documentElement.setAttribute('data-theme', savedTheme);
        } else {
            const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
            document.documentElement.setAttribute('data-theme', prefersDark ? 'dark' : 'light');
            localStorage.setItem('theme', prefersDark ? 'dark' : 'light');
        }
    }

    toggleTheme() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
    }
}

// Initialize the posts manager
window.addEventListener('DOMContentLoaded', () => {
    window.postsManager = new PostsManager();
});