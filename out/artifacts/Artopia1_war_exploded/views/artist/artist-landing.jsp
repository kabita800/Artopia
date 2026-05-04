<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>For Artists — Artopia Marketplace</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,400;0,700;0,900;1,400;1,700&family=DM+Mono:wght@300;400;500&family=Outfit:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --black: #080808;
            --off-black: #0f0f0f;
            --dark: #161616;
            --card-bg: #111111;
            --border: rgba(255,255,255,0.07);
            --border-hover: rgba(255,255,255,0.18);
            --white: #f5f0eb;
            --white-dim: rgba(245,240,235,0.6);
            --white-muted: rgba(245,240,235,0.35);
            --accent: #c9a96e;
            --accent-dim: rgba(201,169,110,0.15);
            --accent-bright: #e8c88a;
            --red: #c94e4e;
        }

        html { scroll-behavior: smooth; }

        body {
            background: var(--black);
            color: var(--white);
            font-family: 'Outfit', sans-serif;
            font-weight: 300;
            line-height: 1.7;
            overflow-x: hidden;
        }

        /* ── HERO ────────────────────────────────── */
        .hero {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            padding: 10rem 3rem 6rem;
            position: relative;
            overflow: hidden;
        }

        .hero::before {
            content: '';
            position: absolute;
            top: -200px; right: -200px;
            width: 700px; height: 700px;
            background: radial-gradient(circle, rgba(201,169,110,0.06) 0%, transparent 70%);
            pointer-events: none;
        }

        .hero::after {
            content: '';
            position: absolute;
            bottom: -100px; left: -100px;
            width: 500px; height: 500px;
            background: radial-gradient(circle, rgba(201,80,80,0.04) 0%, transparent 70%);
            pointer-events: none;
        }

        .hero-eyebrow {
            font-family: 'DM Mono', monospace;
            font-size: 0.72rem;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: var(--accent);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .hero-eyebrow::before {
            content: '';
            display: inline-block;
            width: 32px; height: 1px;
            background: var(--accent);
        }

        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: clamp(3.5rem, 8vw, 7.5rem);
            font-weight: 900;
            line-height: 1.0;
            letter-spacing: -0.02em;
            max-width: 900px;
            margin-bottom: 2rem;
        }

        .hero h1 em {
            font-style: italic;
            color: var(--accent);
        }

        .hero-sub {
            font-size: 1.1rem;
            color: var(--white-dim);
            max-width: 520px;
            margin-bottom: 3rem;
            line-height: 1.8;
        }

        .hero-buttons {
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        .btn-primary {
            font-family: 'DM Mono', monospace;
            font-size: 0.75rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            background: var(--accent);
            color: var(--black);
            padding: 1rem 2.5rem;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.25s;
            display: inline-block;
        }

        .btn-primary:hover {
            background: var(--accent-bright);
            transform: translateY(-2px);
        }

        .btn-outline {
            font-family: 'DM Mono', monospace;
            font-size: 0.75rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            background: transparent;
            color: var(--white-dim);
            padding: 1rem 2.5rem;
            text-decoration: none;
            border: 1px solid var(--border-hover);
            transition: all 0.25s;
            display: inline-block;
        }

        .btn-outline:hover {
            color: var(--white);
            border-color: rgba(255,255,255,0.35);
        }

        .hero-scroll {
            position: absolute;
            bottom: 2.5rem;
            left: 3rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-family: 'DM Mono', monospace;
            font-size: 0.65rem;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            color: var(--white-muted);
        }

        .scroll-line {
            width: 40px; height: 1px;
            background: var(--white-muted);
            animation: scrollPulse 2.5s ease-in-out infinite;
        }

        @keyframes scrollPulse {
            0%, 100% { opacity: 0.3; width: 40px; }
            50% { opacity: 1; width: 60px; }
        }

        /* ── STATS BAND ──────────────────────────── */
        .stats-band {
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
            background: var(--off-black);
            padding: 2rem 3rem;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
            gap: 2rem;
        }

        .stat {
            text-align: center;
        }

        .stat-num {
            font-family: 'Playfair Display', serif;
            font-size: 2.2rem;
            font-weight: 700;
            color: var(--accent);
            display: block;
        }

        .stat-label {
            font-family: 'DM Mono', monospace;
            font-size: 0.65rem;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            color: var(--white-muted);
        }

        /* ── SECTIONS ────────────────────────────── */
        section { padding: 7rem 3rem; }

        .section-eyebrow {
            font-family: 'DM Mono', monospace;
            font-size: 0.68rem;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: var(--accent);
            margin-bottom: 1rem;
        }

        .section-title {
            font-family: 'Playfair Display', serif;
            font-size: clamp(2.2rem, 4vw, 3.5rem);
            font-weight: 700;
            line-height: 1.1;
            margin-bottom: 1.5rem;
        }

        .section-sub {
            color: var(--white-dim);
            max-width: 520px;
            font-size: 1.05rem;
            margin-bottom: 4rem;
        }

        /* ── FEATURES GRID ───────────────────────── */
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1px;
            border: 1px solid var(--border);
            background: var(--border);
        }

        .feature-card {
            background: var(--card-bg);
            padding: 2.5rem;
            transition: background 0.3s;
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 2px;
            background: var(--accent);
            transform: scaleX(0);
            transform-origin: left;
            transition: transform 0.35s ease;
        }

        .feature-card:hover::before { transform: scaleX(1); }
        .feature-card:hover { background: var(--dark); }

        .feature-num {
            font-family: 'DM Mono', monospace;
            font-size: 0.65rem;
            letter-spacing: 0.15em;
            color: var(--white-muted);
            margin-bottom: 1.5rem;
            display: block;
        }

        .feature-icon {
            font-size: 1.8rem;
            display: block;
            margin-bottom: 1.2rem;
        }

        .feature-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            color: var(--white);
        }

        .feature-text {
            color: var(--white-muted);
            font-size: 0.9rem;
            line-height: 1.75;
        }

        /* ── HOW IT WORKS ────────────────────────── */
        .how-section { background: var(--off-black); }

        .steps {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 3rem;
            margin-top: 1rem;
        }

        .step {
            position: relative;
        }

        .step-num {
            font-family: 'Playfair Display', serif;
            font-size: 5rem;
            font-weight: 900;
            color: rgba(201,169,110,0.1);
            line-height: 1;
            margin-bottom: -1.5rem;
        }

        .step-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            position: relative;
        }

        .step-title::after {
            content: '';
            display: block;
            width: 32px; height: 1px;
            background: var(--accent);
            margin-top: 0.75rem;
        }

        .step-text {
            color: var(--white-muted);
            font-size: 0.92rem;
            line-height: 1.8;
        }

        /* ── TESTIMONIAL QUOTE ───────────────────── */
        .quote-section {
            background: var(--black);
            border-top: 1px solid var(--border);
            border-bottom: 1px solid var(--border);
        }

        .quote-wrap {
            max-width: 800px;
            margin: 0 auto;
            text-align: center;
        }

        .quote-mark {
            font-family: 'Playfair Display', serif;
            font-size: 6rem;
            color: var(--accent);
            line-height: 0.5;
            display: block;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        .quote-text {
            font-family: 'Playfair Display', serif;
            font-size: clamp(1.4rem, 2.8vw, 2rem);
            font-style: italic;
            line-height: 1.55;
            color: var(--white);
            margin-bottom: 2rem;
        }

        .quote-attr {
            font-family: 'DM Mono', monospace;
            font-size: 0.68rem;
            letter-spacing: 0.15em;
            text-transform: uppercase;
            color: var(--accent);
        }

        /* ── CTA SECTION ─────────────────────────── */
        .cta-section {
            background: var(--dark);
            border-top: 1px solid var(--border);
            text-align: center;
        }

        .cta-section .section-title { margin: 0 auto 1rem; }
        .cta-section .section-sub { margin: 0 auto 2.5rem; text-align: center; }

        .cta-note {
            font-family: 'DM Mono', monospace;
            font-size: 0.68rem;
            letter-spacing: 0.12em;
            text-transform: uppercase;
            color: var(--white-muted);
            margin-top: 1.5rem;
        }

        /* ── FOOTER ──────────────────────────────── */
        footer {
            background: var(--off-black);
            border-top: 1px solid var(--border);
            padding: 3rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1.5rem;
        }

        .footer-logo {
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            font-weight: 700;
            color: var(--white);
            text-decoration: none;
        }

        .footer-logo span { color: var(--accent); }

        .footer-copy {
            font-family: 'DM Mono', monospace;
            font-size: 0.65rem;
            letter-spacing: 0.1em;
            color: var(--white-muted);
        }

        .footer-links {
            display: flex;
            gap: 2rem;
            list-style: none;
        }

        .footer-links a {
            font-family: 'DM Mono', monospace;
            font-size: 0.65rem;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--white-muted);
            text-decoration: none;
            transition: color 0.25s;
        }

        .footer-links a:hover { color: var(--accent); }

        /* ── ANIMATIONS ──────────────────────────── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .fade-up {
            opacity: 0;
            animation: fadeUp 0.8s ease forwards;
        }

        .delay-1 { animation-delay: 0.1s; }
        .delay-2 { animation-delay: 0.25s; }
        .delay-3 { animation-delay: 0.4s; }
        .delay-4 { animation-delay: 0.55s; }

        /* ── RESPONSIVE ──────────────────────────── */
        @media (max-width: 768px) {
            nav { padding: 1rem 1.5rem; }
            .nav-links { display: none; }
            .hero { padding: 8rem 1.5rem 5rem; }
            .hero-scroll { left: 1.5rem; }
            section { padding: 5rem 1.5rem; }
            .stats-band { padding: 2rem 1.5rem; }
            footer { padding: 2rem 1.5rem; flex-direction: column; align-items: flex-start; }
        }
    </style>
</head>
<body>

<jsp:include page="../components/navbar.jsp" />


<!-- HERO -->
<section class="hero">
    <p class="hero-eyebrow fade-up delay-1">Artist Marketplace</p>
    <h1 class="fade-up delay-2">Showcase Your <em>Art</em><br>to the World.</h1>
    <p class="hero-sub fade-up delay-3">
        Join thousands of artists on Artopia and reach art enthusiasts globally.
        Sell original artwork, prints, and digital art — zero commission fees.
    </p>
    <div class="hero-buttons fade-up delay-4">
        <a href="artist-register.jsp" class="btn-primary">Get Started Free</a>
        <a href="artist-login.jsp" class="btn-outline">Sign In</a>
    </div>
    <div class="hero-scroll">
        <span class="scroll-line"></span>
        Scroll
    </div>
</section>

<!-- STATS -->
<div class="stats-band">
    <div class="stat">
        <span class="stat-num">48K+</span>
        <span class="stat-label">Artists Worldwide</span>
    </div>
    <div class="stat">
        <span class="stat-num">$0</span>
        <span class="stat-label">Commission Fees</span>
    </div>
    <div class="stat">
        <span class="stat-num">120+</span>
        <span class="stat-label">Countries Reached</span>
    </div>
    <div class="stat">
        <span class="stat-num">2.4M</span>
        <span class="stat-label">Art Enthusiasts</span>
    </div>
</div>

<!-- FEATURES -->
<section>
    <p class="section-eyebrow">Why Artopia</p>
    <h2 class="section-title">Every Tool You Need<br>to Grow Your Art Business.</h2>
    <p class="section-sub">Built by artists, for artists. Everything you need to present your work professionally and sell globally.</p>

    <div class="features-grid">
        <div class="feature-card">
            <span class="feature-num">01</span>
            <span class="feature-icon">🎨</span>
            <h3 class="feature-title">Easy Upload</h3>
            <p class="feature-text">Upload your artwork in minutes. Simple interface, powerful tools to showcase your best work at its finest quality.</p>
        </div>
        <div class="feature-card">
            <span class="feature-num">02</span>
            <span class="feature-icon">💰</span>
            <h3 class="feature-title">Keep Your Earnings</h3>
            <p class="feature-text">No hidden fees. Set your own prices and keep 100% of your sales. We only take a small transaction fee on each order.</p>
        </div>
        <div class="feature-card">
            <span class="feature-num">03</span>
            <span class="feature-icon">🌍</span>
            <h3 class="feature-title">Global Reach</h3>
            <p class="feature-text">Reach millions of art enthusiasts worldwide. Your art displayed in front of people who truly appreciate it.</p>
        </div>
        <div class="feature-card">
            <span class="feature-num">04</span>
            <span class="feature-icon">📊</span>
            <h3 class="feature-title">Smart Analytics</h3>
            <p class="feature-text">Track sales, views, and engagement in real time. Data-driven insights to help you grow your art business intelligently.</p>
        </div>
        <div class="feature-card">
            <span class="feature-num">05</span>
            <span class="feature-icon">💬</span>
            <h3 class="feature-title">Direct Messaging</h3>
            <p class="feature-text">Connect with buyers directly. Discuss commissions, custom orders, and build lasting relationships that matter.</p>
        </div>
        <div class="feature-card">
            <span class="feature-num">06</span>
            <span class="feature-icon">📱</span>
            <h3 class="feature-title">Mobile First</h3>
            <p class="feature-text">Your art looks stunning on all devices. Responsive design ensures a perfect, beautiful presentation everywhere.</p>
        </div>
    </div>
</section>

<!-- HOW IT WORKS -->
<section class="how-section">
    <p class="section-eyebrow">The Process</p>
    <h2 class="section-title">Three Steps to<br>Start Selling.</h2>
    <div class="steps">
        <div class="step">
            <p class="step-num">01</p>
            <h3 class="step-title">Create Account</h3>
            <p class="step-text">Sign up for free and verify your email. Set up your artist profile with a bio, style description, and profile picture that represents you.</p>
        </div>
        <div class="step">
            <p class="step-num">02</p>
            <h3 class="step-title">Add Artwork</h3>
            <p class="step-text">Upload high-quality images of your art with descriptions, pricing, and licensing information. Your gallery, your rules.</p>
        </div>
        <div class="step">
            <p class="step-num">03</p>
            <h3 class="step-title">Manage & Sell</h3>
            <p class="step-text">Promote your work, respond to inquiries, and manage orders. Watch your art business grow month over month.</p>
        </div>
    </div>
</section>

<!-- QUOTE -->
<section class="quote-section">
    <div class="quote-wrap">
        <span class="quote-mark">"</span>
        <p class="quote-text">Artopia changed the way I connect with collectors. Within three months of joining, I'd sold more pieces than in the entire previous year combined.</p>
        <p class="quote-attr">— Mia Tanaka, Visual Artist · Tokyo</p>
    </div>
</section>

<!-- CTA -->
<section class="cta-section">
    <p class="section-eyebrow">Get Started</p>
    <h2 class="section-title">Ready to Turn Your<br><em style="font-family:'Playfair Display',serif; color:var(--accent);">Passion into Profit?</em></h2>
    <p class="section-sub">Join our community of talented artists. Free to start, takes just minutes to set up your first gallery.</p>
    <a href="artist-register.jsp" class="btn-primary">Sign Up Now — It's Free</a>
    <p class="cta-note">No credit card required &nbsp;·&nbsp; Setup in under 5 minutes</p>
</section>

<!-- FOOTER -->
<footer>
    <a class="footer-logo" href="#">Art<span>opia</span></a>
    <ul class="footer-links">
        <li><a href="#">Privacy</a></li>
        <li><a href="#">Terms</a></li>
        <li><a href="#">Support</a></li>
        <li><a href="#">Blog</a></li>
    </ul>
    <p class="footer-copy">© 2025 Artopia Marketplace. All rights reserved.</p>
</footer>

</body>
</html>
