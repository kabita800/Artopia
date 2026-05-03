/* ================================================================
   ART MARKETPLACE - JAVASCRIPT UTILITIES
   Minimal interactive features
   ================================================================ */

// ---- DOM UTILITIES ----
const DOM = {
    get: (selector) => document.querySelector(selector),
    getAll: (selector) => document.querySelectorAll(selector),
    create: (tag, className = '') => {
        const el = document.createElement(tag);
        if (className) el.className = className;
        return el;
    }
};

// ---- NAVBAR TOGGLE ----
function initNavbar() {
    const toggle = DOM.get('.navbar-toggle');
    const menu = DOM.get('.navbar-menu');

    if (toggle) {
        toggle.addEventListener('click', () => {
            menu.classList.toggle('active');
        });

        // Close menu when link is clicked
        DOM.getAll('.navbar-menu a').forEach(link => {
            link.addEventListener('click', () => {
                menu.classList.remove('active');
            });
        });
    }
}

// ---- MODAL ----
const Modal = {
    open: (modalId) => {
        const modal = DOM.get(modalId);
        if (modal) modal.classList.add('active');
    },
    close: (modalId) => {
        const modal = DOM.get(modalId);
        if (modal) modal.classList.remove('active');
    },
    init: () => {
        DOM.getAll('.modal-close').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.target.closest('.modal').classList.remove('active');
            });
        });

        // Close modal when clicking outside
        DOM.getAll('.modal').forEach(modal => {
            modal.addEventListener('click', (e) => {
                if (e.target === modal) modal.classList.remove('active');
            });
        });
    }
};

// ---- CART FUNCTIONALITY ----
const Cart = {
    items: JSON.parse(localStorage.getItem('cart')) || [],

    add: (item) => {
        const existing = Cart.items.find(i => i.id === item.id);
        if (existing) {
            existing.quantity += item.quantity || 1;
        } else {
            Cart.items.push({ ...item, quantity: item.quantity || 1 });
        }
        Cart.save();
        Cart.notify('Added to cart!');
    },

    remove: (itemId) => {
        Cart.items = Cart.items.filter(i => i.id !== itemId);
        Cart.save();
    },

    updateQuantity: (itemId, quantity) => {
        const item = Cart.items.find(i => i.id === itemId);
        if (item) {
            item.quantity = Math.max(1, quantity);
            Cart.save();
        }
    },

    clear: () => {
        Cart.items = [];
        Cart.save();
    },

    getTotal: () => {
        return Cart.items.reduce((sum, item) => sum + (item.price * item.quantity), 0);
    },

    getCount: () => {
        return Cart.items.reduce((sum, item) => sum + item.quantity, 0);
    },

    save: () => {
        localStorage.setItem('cart', JSON.stringify(Cart.items));
        Cart.updateCartUI();
    },

    updateCartUI: () => {
        const badge = DOM.get('.cart-badge');
        if (badge) {
            const count = Cart.getCount();
            badge.textContent = count;
            badge.style.display = count > 0 ? 'inline-block' : 'none';
        }
    },

    notify: (message) => {
        const notification = DOM.create('div', 'notification');
        notification.textContent = message;
        notification.style.cssText = `
            position: fixed;
            bottom: 20px;
            right: 20px;
            background: #28a745;
            color: white;
            padding: 1rem;
            border-radius: 4px;
            z-index: 9999;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        `;
        document.body.appendChild(notification);
        setTimeout(() => notification.remove(), 3000);
    }
};

// ---- FORM VALIDATION ----
const Validation = {
    validateEmail: (email) => {
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return regex.test(email);
    },

    validatePassword: (password) => {
        return password.length >= 6;
    },

    validateForm: (formId) => {
        const form = DOM.get(formId);
        if (!form) return true;

        let isValid = true;
        const inputs = form.querySelectorAll('input, textarea, select');

        inputs.forEach(input => {
            if (!input.value.trim()) {
                input.style.borderColor = '#dc3545';
                isValid = false;
            } else {
                input.style.borderColor = '';
            }
        });

        return isValid;
    },

    init: () => {
        DOM.getAll('form').forEach(form => {
            form.addEventListener('submit', (e) => {
                if (!Validation.validateForm(form.id)) {
                    e.preventDefault();
                    alert('Please fill all required fields');
                }
            });
        });
    }
};

// ---- SEARCH & FILTER ----
const Search = {
    filterGallery: (query) => {
        const cards = DOM.getAll('.card');
        const lowerQuery = query.toLowerCase();

        cards.forEach(card => {
            const title = card.querySelector('.card-title')?.textContent.toLowerCase() || '';
            const description = card.querySelector('.card-text')?.textContent.toLowerCase() || '';
            const match = title.includes(lowerQuery) || description.includes(lowerQuery);
            card.style.display = match ? 'block' : 'none';
        });
    },

    init: () => {
        const searchInput = DOM.get('.search-input');
        if (searchInput) {
            searchInput.addEventListener('input', (e) => {
                Search.filterGallery(e.target.value);
            });
        }
    }
};

// ---- PRICE RANGE FILTER ----
const PriceFilter = {
    init: () => {
        const minInput = DOM.get('input[name="min-price"]');
        const maxInput = DOM.get('input[name="max-price"]');

        if (minInput && maxInput) {
            const applyFilter = () => {
                const min = parseFloat(minInput.value) || 0;
                const max = parseFloat(maxInput.value) || Infinity;
                const cards = DOM.getAll('.card');

                cards.forEach(card => {
                    const priceText = card.querySelector('.card-price')?.textContent || '$0';
                    const price = parseFloat(priceText.replace('$', ''));
                    const match = price >= min && price <= max;
                    card.style.display = match ? 'block' : 'none';
                });
            };

            minInput.addEventListener('change', applyFilter);
            maxInput.addEventListener('change', applyFilter);
        }
    }
};

// ---- SORT FUNCTIONALITY ----
const Sort = {
    init: () => {
        const sortSelect = DOM.get('select[name="sort"]');
        if (sortSelect) {
            sortSelect.addEventListener('change', (e) => {
                const value = e.target.value;
                const gallery = DOM.get('.gallery-grid');
                if (!gallery) return;

                const cards = Array.from(gallery.querySelectorAll('.card'));

                cards.sort((a, b) => {
                    const priceA = parseFloat(a.querySelector('.card-price')?.textContent.replace('$', '') || 0);
                    const priceB = parseFloat(b.querySelector('.card-price')?.textContent.replace('$', '') || 0);
                    const titleA = a.querySelector('.card-title')?.textContent || '';
                    const titleB = b.querySelector('.card-title')?.textContent || '';

                    switch (value) {
                        case 'price-low':
                            return priceA - priceB;
                        case 'price-high':
                            return priceB - priceA;
                        case 'name-asc':
                            return titleA.localeCompare(titleB);
                        case 'name-desc':
                            return titleB.localeCompare(titleA);
                        case 'newest':
                            return -1; // Placeholder
                        default:
                            return 0;
                    }
                });

                gallery.innerHTML = '';
                cards.forEach(card => gallery.appendChild(card));
            });
        }
    }
};

// ---- QUANTITY INPUT ----
const QuantityInput = {
    init: () => {
        DOM.getAll('.quantity-input').forEach(input => {
            const decreaseBtn = input.previousElementSibling;
            const increaseBtn = input.nextElementSibling;

            if (decreaseBtn && decreaseBtn.classList.contains('btn-decrease')) {
                decreaseBtn.addEventListener('click', () => {
                    input.value = Math.max(1, parseInt(input.value) - 1);
                    input.dispatchEvent(new Event('change'));
                });
            }

            if (increaseBtn && increaseBtn.classList.contains('btn-increase')) {
                increaseBtn.addEventListener('click', () => {
                    input.value = parseInt(input.value) + 1;
                    input.dispatchEvent(new Event('change'));
                });
            }
        });
    }
};

// ---- INITIALIZE ALL ----
document.addEventListener('DOMContentLoaded', () => {
    initNavbar();
    Modal.init();
    Validation.init();
    Search.init();
    PriceFilter.init();
    Sort.init();
    QuantityInput.init();
    Cart.updateCartUI();
});