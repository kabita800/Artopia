
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    /* ── Google Fonts ── */
    @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=DM+Sans:wght@300;400;500&display=swap');

    /* ── Design Tokens ── */
    footer {
        --c-bg:        #0f0e0c;
        --c-surface:   #1a1815;
        --c-border:    rgba(255,255,255,0.07);
        --c-gold:      #c9a84c;
        --c-gold-dim:  rgba(201,168,76,0.15);
        --c-text:      #e8e2d9;
        --c-muted:     rgba(232,226,217,0.45);
        --c-link:      rgba(232,226,217,0.7);
        --c-link-h:    #c9a84c;
        --radius:      4px;
        --ff-head:     'Playfair Display', Georgia, serif;
        --ff-body:     'DM Sans', sans-serif;
        --transition:  0.22s ease;

        background: var(--c-bg);
        color: var(--c-text);
        font-family: var(--ff-body);
        font-size: 14px;
        font-weight: 300;
        line-height: 1.7;
        border-top: 1px solid var(--c-border);
        position: relative;
        overflow: hidden;
    }

    /* Ambient glow */
    footer::before {
        content: '';
        position: absolute;
        top: -120px;
        left: 50%;
        transform: translateX(-50%);
        width: 600px;
        height: 240px;
        background: radial-gradient(ellipse, rgba(201,168,76,0.08) 0%, transparent 70%);
        pointer-events: none;
    }

    /* ── Layout ── */
    footer .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 24px;
    }

    .footer-top-bar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 40px 0 36px;
        border-bottom: 1px solid var(--c-border);
        gap: 16px;
        flex-wrap: wrap;
    }

    .footer-brand {
        display: flex;
        align-items: center;
        gap: 12px;
        text-decoration: none;
    }

    .footer-brand-icon {
        width: 36px;
        height: 36px;
        border: 1px solid var(--c-gold);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        background: var(--c-gold-dim);
        flex-shrink: 0;
    }

    .footer-brand-icon svg {
        width: 18px;
        height: 18px;
        fill: var(--c-gold);
    }

    .footer-brand-name {
        font-family: var(--ff-head);
        font-size: 22px;
        font-weight: 600;
        color: var(--c-text);
        letter-spacing: 0.02em;
    }

    .footer-social {
        display: flex;
        gap: 10px;
    }

    .footer-social a {
        width: 36px;
        height: 36px;
        border: 1px solid var(--c-border);
        border-radius: var(--radius);
        display: flex;
        align-items: center;
        justify-content: center;
        color: var(--c-muted);
        text-decoration: none;
        transition: var(--transition);
        background: var(--c-surface);
    }

    .footer-social a:hover {
        border-color: var(--c-gold);
        color: var(--c-gold);
        background: var(--c-gold-dim);
    }

    .footer-social a svg {
        width: 15px;
        height: 15px;
        fill: currentColor;
    }

    /* ── Main Grid ── */
    .footer-content {
        display: grid;
        grid-template-columns: 1.8fr 1fr 1fr 1fr 1.4fr;
        gap: 48px 32px;
        padding: 48px 0 40px;
        border-bottom: 1px solid var(--c-border);
    }

    /* ── Section Headings ── */
    .footer-section h4 {
        font-family: var(--ff-head);
        font-size: 13px;
        font-weight: 400;
        letter-spacing: 0.12em;
        text-transform: uppercase;
        color: var(--c-gold);
        margin: 0 0 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid var(--c-gold-dim);
        position: relative;
    }

    .footer-section h4::after {
        content: '';
        position: absolute;
        bottom: -1px;
        left: 0;
        width: 24px;
        height: 1px;
        background: var(--c-gold);
    }

    /* ── About Text ── */
    .footer-section p {
        margin: 0 0 10px;
        color: var(--c-muted);
        font-size: 13.5px;
        line-height: 1.75;
    }

    .footer-section p:last-child {
        margin-bottom: 0;
    }

    /* ── Links ── */
    .footer-section a {
        display: block;
        color: var(--c-link);
        text-decoration: none;
        font-size: 13.5px;
        margin-bottom: 9px;
        transition: var(--transition);
        position: relative;
        padding-left: 0;
    }

    .footer-section a::before {
        content: '–';
        position: absolute;
        left: -14px;
        color: var(--c-gold);
        opacity: 0;
        transition: var(--transition);
    }

    .footer-section a:hover {
        color: var(--c-link-h);
        padding-left: 14px;
    }

    .footer-section a:hover::before {
        opacity: 1;
    }

    .footer-section a:last-child {
        margin-bottom: 0;
    }

    /* Contact inline links (inside <p>) */
    .footer-section p a {
        display: inline;
        padding-left: 0;
        color: var(--c-link);
    }

    .footer-section p a::before { display: none; }

    .footer-section p a:hover {
        color: var(--c-link-h);
        padding-left: 0;
    }

    /* ── Contact detail rows ── */
    .contact-row {
        display: flex;
        gap: 8px;
        align-items: flex-start;
        margin-bottom: 10px;
    }

    .contact-row:last-child { margin-bottom: 0; }

    .contact-row svg {
        width: 14px;
        height: 14px;
        fill: var(--c-gold);
        flex-shrink: 0;
        margin-top: 3px;
    }

    .contact-row span {
        color: var(--c-muted);
        font-size: 13.5px;
        line-height: 1.6;
    }

    .contact-row span a {
        display: inline;
        color: var(--c-link);
        padding-left: 0;
        margin-bottom: 0;
    }

    .contact-row span a::before { display: none; }

    .contact-row span a:hover {
        color: var(--c-link-h);
        padding-left: 0;
    }

    /* ── Footer Bottom ── */
    .footer-bottom {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 22px 0;
        gap: 12px;
        flex-wrap: wrap;
    }

    .footer-bottom p {
        margin: 0;
        font-size: 12.5px;
        color: var(--c-muted);
        letter-spacing: 0.01em;
    }

    .footer-bottom a {
        color: var(--c-muted);
        text-decoration: none;
        transition: color var(--transition);
    }

    .footer-bottom a:hover { color: var(--c-gold); }

    .footer-bottom-links {
        display: flex;
        gap: 20px;
    }

    .footer-bottom-links a {
        font-size: 12.5px;
        color: var(--c-muted);
        text-decoration: none;
        transition: color var(--transition);
    }

    .footer-bottom-links a:hover { color: var(--c-gold); }

    /* ── Responsive ── */
    @media (max-width: 900px) {
        .footer-content {
            grid-template-columns: 1fr 1fr;
            gap: 36px 24px;
        }
    }

    @media (max-width: 560px) {
        .footer-content {
            grid-template-columns: 1fr;
            gap: 28px;
            padding: 36px 0 32px;
        }

        .footer-top-bar {
            flex-direction: column;
            align-items: flex-start;
        }

        .footer-bottom {
            flex-direction: column;
            align-items: flex-start;
            gap: 8px;
        }
    }
</style>

<footer>
    <div class="container">

        <!-- Top Bar: Brand + Social -->
        <div class="footer-top-bar">
            <a href="${pageContext.request.contextPath}/" class="footer-brand">
                <div class="footer-brand-icon">
                    <!-- Palette icon -->
                    <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                        <path d="M12 2C6.48 2 2 6.48 2 12c0 5.52 4.48 10 10 10 .55 0 1-.45 1-1 0-.27-.1-.51-.26-.7-.16-.19-.25-.43-.25-.68 0-.55.45-1 1-1h1.17c3.22 0 5.84-2.62 5.84-5.84C21.5 6.08 17.22 2 12 2zm-5.5 9c-.83 0-1.5-.67-1.5-1.5S5.67 8 6.5 8 8 8.67 8 9.5 7.33 11 6.5 11zm3-4C8.67 7 8 6.33 8 5.5S8.67 4 9.5 4s1.5.67 1.5 1.5S10.33 7 9.5 7zm5 0c-.83 0-1.5-.67-1.5-1.5S13.67 4 14.5 4s1.5.67 1.5 1.5S15.33 7 14.5 7zm3 4c-.83 0-1.5-.67-1.5-1.5S16.67 8 17.5 8s1.5.67 1.5 1.5S18.33 11 17.5 11z"/>
                    </svg>
                </div>
                <span class="footer-brand-name">Artopia</span>
            </a>

            <div class="footer-social">
                <!-- Instagram -->
                <a href="#" aria-label="Instagram">
                    <svg viewBox="0 0 24 24"><path d="M7.75 2h8.5A5.75 5.75 0 0 1 22 7.75v8.5A5.75 5.75 0 0 1 16.25 22h-8.5A5.75 5.75 0 0 1 2 16.25v-8.5A5.75 5.75 0 0 1 7.75 2zm0 1.5A4.25 4.25 0 0 0 3.5 7.75v8.5A4.25 4.25 0 0 0 7.75 20.5h8.5A4.25 4.25 0 0 0 20.5 16.25v-8.5A4.25 4.25 0 0 0 16.25 3.5h-8.5zM12 7a5 5 0 1 1 0 10A5 5 0 0 1 12 7zm0 1.5a3.5 3.5 0 1 0 0 7 3.5 3.5 0 0 0 0-7zm5.25-2.25a.875.875 0 1 1 0 1.75.875.875 0 0 1 0-1.75z"/></svg>
                </a>
                <!-- Twitter/X -->
                <a href="#" aria-label="Twitter">
                    <svg viewBox="0 0 24 24"><path d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z"/></svg>
                </a>
                <!-- Pinterest -->
                <a href="#" aria-label="Pinterest">
                    <svg viewBox="0 0 24 24"><path d="M12 2C6.477 2 2 6.477 2 12c0 4.236 2.636 7.855 6.356 9.312-.088-.791-.167-2.005.035-2.868.181-.78 1.172-4.97 1.172-4.97s-.299-.598-.299-1.482c0-1.388.806-2.428 1.808-2.428.852 0 1.265.64 1.265 1.408 0 .858-.546 2.141-.828 3.33-.236.995.499 1.806 1.476 1.806 1.771 0 3.135-1.867 3.135-4.561 0-2.385-1.715-4.052-4.163-4.052-2.836 0-4.498 2.127-4.498 4.326 0 .856.329 1.774.741 2.277a.3.3 0 0 1 .069.286c-.076.311-.243.995-.276 1.134-.044.183-.145.222-.334.134-1.249-.581-2.03-2.407-2.03-3.874 0-3.154 2.292-6.052 6.608-6.052 3.469 0 6.165 2.473 6.165 5.776 0 3.447-2.173 6.22-5.19 6.22-1.013 0-1.966-.527-2.292-1.148l-.623 2.378c-.226.869-.835 1.958-1.244 2.621.937.29 1.931.446 2.962.446 5.522 0 10-4.477 10-10S17.522 2 12 2z"/></svg>
                </a>
                <!-- Facebook -->
                <a href="#" aria-label="Facebook">
                    <svg viewBox="0 0 24 24"><path d="M24 12.073C24 5.405 18.627 0 12 0S0 5.405 0 12.073C0 18.1 4.388 23.094 10.125 24v-8.437H7.078v-3.49h3.047v-2.66c0-3.025 1.792-4.697 4.533-4.697 1.312 0 2.686.236 2.686.236v2.97h-1.513c-1.491 0-1.956.93-1.956 1.886v2.265h3.328l-.532 3.49h-2.796V24C19.612 23.094 24 18.1 24 12.073z"/></svg>
                </a>
            </div>
        </div>

        <!-- Main Content Grid -->
        <div class="footer-content">

            <!-- About -->
            <div class="footer-section">
                <h4>About Artopia</h4>
                <p>A vibrant marketplace connecting artists with art enthusiasts worldwide. Discover unique artworks and support independent creators at every stage of their journey.</p>
            </div>

            <!-- Quick Links -->
            <div class="footer-section">
                <h4>Quick Links</h4>
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/views/about.jsp">About Us</a>
                <a href="${pageContext.request.contextPath}/views/contact.jsp">Contact</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
            </div>

            <!-- For Artists -->
            <div class="footer-section">
                <h4>For Artists</h4>
                <a href="${pageContext.request.contextPath}/artist/artist-landing.jsp">Get Started</a>
                <a href="#">How to Sell</a>
                <a href="#">Commission Guidelines</a>
                <a href="#">Artist Support</a>
            </div>

            <!-- For Buyers -->
            <div class="footer-section">
                <h4>For Buyers</h4>
                <a href="${pageContext.request.contextPath}/buyer/buyer-landing.jsp">Browse Art</a>
                <a href="#">Find Artists</a>
                <a href="#">How to Buy</a>
                <a href="#">Payment Options</a>
            </div>

            <!-- Contact -->
            <div class="footer-section">
                <h4>Contact Us</h4>

                <div class="contact-row">
                    <svg viewBox="0 0 24 24"><path d="M20 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4-8 5-8-5V6l8 5 8-5v2z"/></svg>
                    <span><a href="mailto:hello@artopia.com">hello@artopia.com</a></span>
                </div>

                <div class="contact-row">
                    <svg viewBox="0 0 24 24"><path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z"/></svg>
                    <span><a href="tel:+1234567890">+1 (234) 567-890</a></span>
                </div>

                <div class="contact-row">
                    <svg viewBox="0 0 24 24"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>
                    <span>123 Art Street, Creative City, CC 12345</span>
                </div>
            </div>

        </div>

        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <p>&copy; 2026 Artopia Marketplace. All rights reserved.</p>
            <div class="footer-bottom-links">
                <a href="#">Privacy</a>
                <a href="#">Terms</a>
                <a href="#">Cookies</a>
            </div>
        </div>

    </div>
</footer>
