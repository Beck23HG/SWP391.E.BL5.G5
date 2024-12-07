document.addEventListener('DOMContentLoaded', function() {
    // Initialize form validation
    initializeFormValidation();
});

// Initialize form validation
function initializeFormValidation() {
    const form = document.getElementById('contactForm');

    if (form) {
        form.addEventListener('submit', async function(e) {
            e.preventDefault();

            if (!form.checkValidity()) {
                e.stopPropagation();
                form.classList.add('was-validated');
                return;
            }

            const submitButton = form.querySelector('button[type="submit"]');
            const btnText = submitButton.querySelector('.btn-text');
            const btnLoader = submitButton.querySelector('.btn-loader');

            try {
                // Show loader
                btnText.classList.add('d-none');
                btnLoader.classList.remove('d-none');
                submitButton.disabled = true;

                // Get form data
                const formData = {
                    fullName: document.getElementById('fullName').value,
                    gender: document.getElementById('gender').value,
                    email: document.getElementById('email').value,
                    mobile: document.getElementById('mobile').value,
                    address: document.getElementById('address').value,
                    notes: document.getElementById('notes').value
                };

                // Simulate form submission
                console.log('Form submitted:', formData);

                // Reset button state after 1 second
                setTimeout(() => {
                    btnText.classList.remove('d-none');
                    btnLoader.classList.add('d-none');
                    submitButton.disabled = false;
                }, 1000);

            } catch (error) {
                console.error('Error:', error);
                btnText.classList.remove('d-none');
                btnLoader.classList.add('d-none');
                submitButton.disabled = false;
            }
        });
    }
}

// Show alert message
function showAlert(type, message) {
    const alertDiv = document.createElement('div');
    alertDiv.className = `alert alert-${type} alert-dismissible fade show`;
    alertDiv.role = 'alert';

    alertDiv.innerHTML = `
        ${message}
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    `;

    const form = document.getElementById('contactForm');
    form.parentNode.insertBefore(alertDiv, form);

    setTimeout(() => alertDiv.remove(), 5000);
}