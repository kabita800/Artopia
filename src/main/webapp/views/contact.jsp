<%-- 
   CONTACT PAGE
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <style>
        /* Reset & Base */
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --black:       #0a0a0a;
            --black-soft:  #111111;
            --black-card:  #161616;
            --border:      #2a2a2a;
            --border-glow: #f5c518;
            --accent:      #f5c518;
            --accent-dim:  #c9a012;
            --white:       #f0f0f0;
            --muted:       #888888;
            --font-display: 'Bebas Neue', sans-serif;
            --font-body:    'DM Sans', sans-serif;
        }

        html { scroll-behavior: smooth; }

        body {
            background-color: var(--black);
            color: var(--white);
            font-family: var(--font-body);
            font-weight: 300;
            line-height: 1.7;
            min-height: 100vh;
        }

        a { color: var(--accent); text-decoration: none; transition: opacity .2s; }
        a:hover { opacity: .75; }

        /* Container */
        .container    { max-width: 1160px; margin: 0 auto; padding: 0 2rem; }
        .container-sm { max-width: 800px;  margin: 0 auto; padding: 0 2rem; }

        /* Hero */
        .hero {
            position: relative;
            padding: 6rem 2rem 5rem;
            text-align: center;
            overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background:
                    radial-gradient(ellipse 60% 50% at 50% 0%, rgba(245,197,24,.12) 0%, transparent 70%);
            pointer-events: none;
        }
        /* big decorative letter */
        .hero::after {
            content: '✉';
            position: absolute;
            font-size: 26rem;
            opacity: .03;
            top: -4rem;
            left: 50%;
            transform: translateX(-50%);
            pointer-events: none;
            line-height: 1;
        }
        .hero h1 {
            font-family: var(--font-display);
            font-size: clamp(3.5rem, 8vw, 7rem);
            letter-spacing: .04em;
            color: var(--accent);
            line-height: 1;
            margin-bottom: 1rem;
        }
        .hero p {
            color: var(--muted);
            font-size: 1.1rem;
            max-width: 480px;
            margin: 0 auto;
        }

        /* Divider line */
        .divider {
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--border-glow), transparent);
            opacity: .3;
            margin: 0 2rem;
        }

        /* Main grid */
        .contact-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem;
            padding: 5rem 0;
        }
        @media (max-width: 768px) {
            .contact-grid { grid-template-columns: 1fr; gap: 3rem; }
        }

        /* Section headings */
        .section-heading {
            font-family: var(--font-display);
            font-size: 2rem;
            letter-spacing: .06em;
            color: var(--accent);
            margin-bottom: 2rem;
        }

        /* Alert */
        .alert-success {
            background: rgba(245,197,24,.1);
            border: 1px solid rgba(245,197,24,.4);
            border-left: 4px solid var(--accent);
            color: var(--accent);
            padding: .9rem 1.2rem;
            border-radius: 4px;
            margin-bottom: 1.8rem;
            font-size: .95rem;
        }

        /* Form */
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        @media (max-width: 480px) { .form-row { grid-template-columns: 1fr; } }

        .form-group {
            display: flex;
            flex-direction: column;
            margin-bottom: 1.4rem;
        }

        label {
            font-size: .8rem;
            font-weight: 500;
            letter-spacing: .12em;
            text-transform: uppercase;
            color: var(--muted);
            margin-bottom: .5rem;
        }

        input[type="text"],
        input[type="email"],
        select,
        textarea {
            background: var(--black-card);
            border: 1px solid var(--border);
            color: var(--white);
            font-family: var(--font-body);
            font-size: 1rem;
            font-weight: 300;
            padding: .75rem 1rem;
            border-radius: 4px;
            outline: none;
            transition: border-color .25s, box-shadow .25s;
            appearance: none;
            -webkit-appearance: none;
        }
        input[type="text"]:focus,
        input[type="email"]:focus,
        select:focus,
        textarea:focus {
            border-color: var(--accent);
            box-shadow: 0 0 0 3px rgba(245,197,24,.12);
        }
        textarea {
            min-height: 140px;
            resize: vertical;
        }
        select {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='8' viewBox='0 0 12 8'%3E%3Cpath d='M1 1l5 5 5-5' stroke='%23888' stroke-width='1.5' fill='none' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 1rem center;
            padding-right: 2.5rem;
            cursor: pointer;
        }
        select option { background: var(--black-card); }

        /* placeholder */
        ::placeholder { color: #444; }

        /* Button */
        .btn-submit {
            display: inline-flex;
            align-items: center;
            gap: .6rem;
            background: var(--accent);
            color: var(--black);
            font-family: var(--font-display);
            font-size: 1.1rem;
            letter-spacing: .1em;
            padding: .85rem 2.4rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: background .2s, transform .15s, box-shadow .2s;
            margin-top: .5rem;
        }
        .btn-submit:hover {
            background: #ffd740;
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(245,197,24,.25);
        }
        .btn-submit:active { transform: translateY(0); }
        .btn-submit svg { width: 18px; height: 18px; }

        /* Info Panel */
        .info-block {
            margin-bottom: 2rem;
        }
        .info-block h3 {
            font-family: var(--font-display);
            font-size: 1.1rem;
            letter-spacing: .1em;
            color: var(--accent);
            margin-bottom: .6rem;
        }
        .info-block p {
            color: #b0b0b0;
            font-size: .95rem;
            line-height: 1.8;
        }
        .info-block small { color: var(--muted); font-size: .82rem; }

        /* Social Links */
        .social-box {
            background: var(--black-card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 1.4rem 1.6rem;
        }
        .social-box h3 {
            font-family: var(--font-display);
            font-size: 1.1rem;
            letter-spacing: .1em;
            color: var(--accent);
            margin-bottom: 1rem;
        }
        .social-links { display: flex; flex-wrap: wrap; gap: .8rem; }
        .social-links a {
            display: inline-block;
            background: var(--black-soft);
            border: 1px solid var(--border);
            color: var(--white);
            font-size: .82rem;
            font-weight: 500;
            letter-spacing: .08em;
            text-transform: uppercase;
            padding: .45rem 1rem;
            border-radius: 3px;
            transition: border-color .2s, color .2s, background .2s;
        }
        .social-links a:hover {
            border-color: var(--accent);
            color: var(--accent);
            background: rgba(245,197,24,.06);
            opacity: 1;
        }

        /* FAQ Section */
        .faq-section {
            background: var(--black-soft);
            border-top: 1px solid var(--border);
            padding: 5rem 0;
        }
        .faq-section h2 {
            font-family: var(--font-display);
            font-size: clamp(2rem, 5vw, 3.5rem);
            letter-spacing: .06em;
            color: var(--accent);
            text-align: center;
            margin-bottom: 2.5rem;
        }
        .faq-list {
            display: flex;
            flex-direction: column;
            gap: .8rem;
        }
        details {
            background: var(--black-card);
            border: 1px solid var(--border);
            border-radius: 6px;
            overflow: hidden;
            transition: border-color .25s;
        }
        details[open],
        details:hover {
            border-color: rgba(245,197,24,.35);
        }
        summary {
            cursor: pointer;
            font-weight: 500;
            font-size: 1rem;
            color: var(--white);
            padding: 1.1rem 1.4rem;
            list-style: none;
            display: flex;
            justify-content: space-between;
            align-items: center;
            user-select: none;
        }
        summary::-webkit-details-marker { display: none; }
        summary::after {
            content: '+';
            font-size: 1.4rem;
            color: var(--accent);
            line-height: 1;
            transition: transform .25s;
        }
        details[open] summary::after {
            transform: rotate(45deg);
        }
        details p {
            padding: 0 1.4rem 1.2rem;
            color: #9a9a9a;
            font-size: .95rem;
            line-height: 1.7;
        }

        /* Noise texture overlay */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='1'/%3E%3C/svg%3E");
            opacity: .022;
            pointer-events: none;
            z-index: 9999;
        }

        /* Fade-in animation */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .hero h1 { animation: fadeUp .7s ease both; }
        .hero p  { animation: fadeUp .7s .15s ease both; }
        .contact-grid { animation: fadeUp .7s .25s ease both; }
    </style>
</head>
<body>

<!-- Navbar -->
<jsp:include page="components/navbar.jsp" />

<main>

    <!--  Hero -->
    <section class="hero">
        <div class="container">
            <h1>Get In Touch</h1>
            <p>Have questions? We'd love to hear from you. Contact us anytime.</p>
        </div>
    </section>

    <div class="divider"></div>

    <!-- ── Contact Content ── -->
    <section>
        <div class="container">
            <div class="contact-grid">

                <!-- Left: Form -->
                <div>
                    <h2 class="section-heading">Send Us a Message</h2>

                    <% if (request.getParameter("success") != null) { %>
                    <div class="alert-success">
                        ✓ Thank you! Your message has been sent. We'll get back to you soon.
                    </div>
                    <% } %>

                    <form method="POST" action="${pageContext.request.contextPath}/contact-handler">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="firstName">First Name</label>
                                <input type="text" id="firstName" name="firstName" placeholder="Jane" required>
                            </div>
                            <div class="form-group">
                                <label for="lastName">Last Name</label>
                                <input type="text" id="lastName" name="lastName" placeholder="Doe" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="email">Email Address</label>
                            <input type="email" id="email" name="email" placeholder="jane@example.com" required>
                        </div>

                        <div class="form-group">
                            <label for="subject">Subject</label>
                            <input type="text" id="subject" name="subject" placeholder="How can we help?" required>
                        </div>

                        <div class="form-group">
                            <label for="type">Type of Inquiry</label>
                            <select id="type" name="type" required>
                                <option value="">-- Select --</option>
                                <option value="artist">Artist Support</option>
                                <option value="buyer">Buyer Support</option>
                                <option value="technical">Technical Issue</option>
                                <option value="partnership">Partnership Inquiry</option>
                                <option value="other">Other</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="message">Message</label>
                            <textarea id="message" name="message" placeholder="Tell us what's on your mind..." required></textarea>
                        </div>

                        <button type="submit" class="btn-submit">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <line x1="22" y1="2" x2="11" y2="13"></line>
                                <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
                            </svg>
                            Send Message
                        </button>
                    </form>
                </div>

                <!-- Right: Info -->
                <div>
                    <h2 class="section-heading">Contact Information</h2>

                    <div class="info-block">
                        <h3>Email</h3>
                        <p>
                            General: <a href="mailto:hello@artopia.com">hello@artopia.com</a><br>
                            Support: <a href="mailto:support@artopia.com">support@artopia.com</a><br>
                            Artists: <a href="mailto:artists@artopia.com">artists@artopia.com</a><br>
                            Partners: <a href="mailto:partners@artopia.com">partners@artopia.com</a>
                        </p>
                    </div>

                    <div class="info-block">
                        <h3>Phone</h3>
                        <p>
                            <a href="tel:+1234567890">+1 (234) 567-890</a><br>
                            <small>Monday – Friday, 9 AM – 6 PM EST</small>
                        </p>
                    </div>

                    <div class="info-block">
                        <h3>Address</h3>
                        <p>
                            Artopia Inc.<br>
                            123 Art Street<br>
                            Creative City, CC 12345<br>
                            United States
                        </p>
                    </div>

                    <div class="info-block">
                        <h3>Office Hours</h3>
                        <p>
                            Monday – Friday: 9:00 AM – 6:00 PM<br>
                            Saturday: 10:00 AM – 4:00 PM<br>
                            Sunday: Closed
                        </p>
                    </div>

                    <div class="social-box">
                        <h3>Follow Us</h3>
                        <div class="social-links">
                            <a href="https://twitter.com/artopia">Twitter</a>
                            <a href="https://instagram.com/artopia">Instagram</a>
                            <a href="https://facebook.com/artopia">Facebook</a>
                            <a href="https://youtube.com/artopia">YouTube</a>
                        </div>
                    </div>
                </div>

            </div><!-- /contact-grid -->
        </div>
    </section>

    <!-- ── FAQ ── -->
    <section class="faq-section">
        <div class="container-sm">
            <h2>Frequently Asked Questions</h2>
            <div class="faq-list">

                <details>
                    <summary>How long does it take to get approved as an artist?</summary>
                    <p>Typically within 24–48 hours. We review applications and verify authenticity before granting access.</p>
                </details>

                <details>
                    <summary>What payment methods do you accept?</summary>
                    <p>We accept credit cards, debit cards, PayPal, and bank transfers for seamless and secure transactions.</p>
                </details>

                <details>
                    <summary>How do you handle shipping?</summary>
                    <p>Artists handle shipping directly with buyers. We recommend insured shipping for all valuable or fragile pieces.</p>
                </details>

                <details>
                    <summary>What's your return policy?</summary>
                    <p>Return policies are set by individual artists. Please check the specific artwork listing page for details.</p>
                </details>

                <details>
                    <summary>How can I report inappropriate content?</summary>
                    <p>Use the report button on any listing or profile. Our moderation team reviews all reports within 48 hours.</p>
                </details>

            </div>
        </div>
    </section>

</main>


<jsp:include page="components/footer.jsp" />

<script src="${pageContext.request.contextPath}/views/js/script.js"></script>
</body>
</html>
