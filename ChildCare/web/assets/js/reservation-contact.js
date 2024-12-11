document.addEventListener('DOMContentLoaded', function() {
    initializeFormValidation();
});

function initializeFormValidation() {
    const form = document.getElementById('contactForm');

    if (form) {
        form.addEventListener('submit', async function(e) {
            e.preventDefault();

            // Validate form
            if (!form.checkValidity()) {
                e.stopPropagation();
                form.classList.add('was-validated');
                return;
            }

            // Check services
            const services = JSON.parse(localStorage.getItem('serviceList') || '[]');
            if (services.length === 0) {
                showAlert('danger', 'Please select at least one service');
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

                // Prepare form data
                const formData = new URLSearchParams();
                formData.append('fullName', document.getElementById('fullName').value);
                formData.append('gender', document.getElementById('gender').value === 'male');
                formData.append('email', document.getElementById('email').value);
                formData.append('mobile', document.getElementById('mobile').value);
                formData.append('address', document.getElementById('address').value);
                formData.append('notes', document.getElementById('notes').value);
                formData.append('reservationDate', document.getElementById('reservationDate').value);
                formData.append('doctorId', document.getElementById('selectedDoctor').dataset.doctorId);
                formData.append('services', JSON.stringify(services));

                // Submit form
                const response = await fetch('reservationAddCustomer', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: formData
                });

                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }

                const data = await response.json();

                if (data.success) {
                    // Clear services from localStorage
                    localStorage.removeItem('serviceList');

                    // Show success message
                    showAlert('success', 'Reservation created successfully!');

                    // Redirect after short delay
                    setTimeout(() => {
                        window.location.href = 'reservationView';
                    }, 2000);
                } else {
                    throw new Error(data.message || 'Failed to create reservation');
                }

            } catch (error) {
                console.error('Error:', error);
                showAlert('danger', 'An error occurred: ' + error.message);
            } finally {
                // Reset button state
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

    // Insert alert before the form
    const form = document.getElementById('contactForm');
    form.parentNode.insertBefore(alertDiv, form);

    // Auto remove after 5 seconds
    setTimeout(() => alertDiv.remove(), 5000);
}

// Validate reservation date
function validateReservationDate() {
    const dateInput = document.getElementById('reservationDate');
    const today = new Date().toISOString().split('T')[0];
    dateInput.min = today;

    dateInput.addEventListener('change', function() {
        if (this.value < today) {
            this.value = today;
            showAlert('warning', 'Reservation date cannot be in the past');
        }
    });
}

// Initialize date validation when document loads
document.addEventListener('DOMContentLoaded', function() {
    validateReservationDate();
});