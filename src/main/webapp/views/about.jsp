<%--
   ABOUT PAGE
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Artopia - Art Marketplace</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

    <style>

        :root {
            --bg-black:        #0a0a0a;
            --bg-card:         #111111;
            --bg-section-alt:  #0f0f0f;
            --accent-color:    #e8a13f;
            --accent-dim:      rgba(232, 161, 63, 0.12);
            --accent-glow:     rgba(232, 161, 63, 0.35);
            --text-primary:    #ffffff;
            --text-secondary:  #d1d1d1;
            --text-muted:      #888888;
            --border:          rgba(255, 255, 255, 0.08);
            --border-hover:    rgba(232, 161, 63, 0.5);
            --font-display:    'Playfair Display', Georgia, serif;
            --font-body:       'DM Sans', sans-serif;
            --spacing-xs:      0.5rem;
            --spacing-sm:      1rem;
            --spacing-md:      1.5rem;
            --spacing-lg:      2rem;
            --spacing-xl:      3rem;
            --spacing-xxl:     5rem;
            --radius-sm:       4px;
            --radius-md:       8px;
            --radius-lg:       16px;
            --transition:      0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        *, *::before, *::after {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html { scroll-behavior: smooth; }

        body {
            background-color: var(--bg-black);
            color: var(--text-primary);
            font-family: var(--font-body);
            font-size: 16px;
            line-height: 1.7;
            min-height: 100vh;
            overflow-x: hidden;
        }

        /* Subtle grain texture overlay */
        body::before {
            content: '';
            position: fixed;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noise'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noise)' opacity='0.04'/%3E%3C/svg%3E");
            pointer-events: none;
            z-index: 999;
            opacity: 0.4;
        }

        /* TYPOGRAPHY  */
        h1, h2, h3 {
            font-family: var(--font-display);
            line-height: 1.2;
            color: var(--text-primary);
        }

        h1 { font-size: clamp(2.5rem, 6vw, 4.5rem); font-weight: 900; }
        h2 { font-size: clamp(1.8rem, 4vw, 2.8rem); font-weight: 700; }
        h3 { font-size: 1.2rem; font-weight: 700; color: var(--accent);; }

        p { color: var(--text-secondary); margin-bottom: var(--spacing-sm); }
        p:last-child { margin-bottom: 0; }

        .text-center { text-align: center; }
        .text-muted   { color: var(--text-muted); }

        /* ============================================================
           LAYOUT
        ============================================================ */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 var(--spacing-lg);
        }

        section { padding: var(--spacing-xxl) 0; }

        .grid { display: grid; gap: var(--spacing-lg); }
        .grid-2 { grid-template-columns: repeat(2, 1fr); }
        .grid-3 { grid-template-columns: repeat(3, 1fr); }
        .grid-4 { grid-template-columns: repeat(4, 1fr); }
        .grid-5 { grid-template-columns: repeat(5, 1fr); }

        .mb-3 { margin-bottom: var(--spacing-xl); }

        /* ============================================================
           HERO
        ============================================================ */
        .hero {
            position: relative;
            padding: var(--spacing-xxl) 0;
            text-align: center;
            overflow: hidden;
            background: radial-gradient(ellipse 80% 60% at 50% 0%, rgba(232, 161, 63, 0.08) 0%, transparent 70%);
        }

        .hero::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 200px;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--accent), transparent);
        }

        .hero-eyebrow {
            display: inline-block;
            font-size: 0.75rem;
            letter-spacing: 0.25em;
            text-transform: uppercase;
            color: var(--accent);
            border: 1px solid var(--border);
            padding: 0.35rem 1rem;
            border-radius: 20px;
            margin-bottom: var(--spacing-lg);
        }

        .hero h1 {
            background: linear-gradient(135deg, #ffffff 30%, var(--accent) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: var(--spacing-md);
        }

        .hero p {
            font-size: 1.15rem;
            color: var(--text-muted);
            max-width: 500px;
            margin: 0 auto;
        }

        /* ============================================================
           CARDS
        ============================================================ */
        .card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            transition: border-color var(--transition), transform var(--transition), box-shadow var(--transition);
            overflow: hidden;
        }

        .card:hover {
            border-color: var(--accent);
            transform: translateY(-4px);
            box-shadow: 0 20px 60px rgba(232, 161, 63, 0.1);
        }

        .card-body { padding: var(--spacing-lg); }

        /* ============================================================
           STORY SECTION
        ============================================================ */
        /* ============================================================
   STORY SECTION (UPDATED ONLY)
============================================================ */

        .story-image-box {
            background: linear-gradient(135deg, #1a1200 0%, #0f0c00 100%);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);

            height: 340px;               /* FIX: use fixed height */
            width: 100%;

            position: relative;
            overflow: hidden;

            display: block;              /* FIX: remove flex issues */
        }

        /* Image inside story box */
        .story-image-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;

            display: block;              /* FIX spacing issue */

            border-radius: var(--radius-lg);

            transition: transform 0.5s ease, filter 0.3s ease;
        }

        /* Hover effect (modern feel) */
        .story-image-box:hover img {
            transform: scale(1.06);
            filter: brightness(1.1);
        }

        /* Soft golden overlay glow */
        .story-image-box::after {
            content: "";
            position: absolute;
            inset: 0;

            background: radial-gradient(
                    circle at center,
                    rgba(232, 161, 63, 0.15),
                    transparent 65%
            );

            pointer-events: none;
        }

        /* Story text spacing fix */
        .story-text h2 {
            margin-bottom: var(--spacing-md);

        }

        /* Optional paragraph tuning for consistency */
        .story-text p {
            color: var(--text-secondary);
            line-height: 1.8;
            margin-bottom: var(--spacing-sm);
        }
        /* ============================================================
           VALUES SECTION
        ============================================================ */
        .section-alt { background-color: var(--bg-section-alt); }

        .values-card h3 {
            font-family: var(--font-body);
            font-size: 1rem;
            font-weight: 600;
            color: var(--accent);
            margin-bottom: var(--spacing-sm);
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        /* ============================================================
           STATS SECTION
        ============================================================ */
        .stat-number {
            font-family: var(--font-display);
            font-size: 2.6rem;
            font-weight: 900;
            display: block;
            margin-bottom: 0.25rem;
            background: linear-gradient(135deg, #ffffff 20%,  var(--accent) 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.1em;
            color: var(--text-muted);
            margin: 0;
        }

        /* ============================================================
           TEAM SECTION
        ============================================================ */
        .team-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: var(--spacing-lg);
        }

        .team-card {
            background: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            text-align: center;
            overflow: hidden;
            transition: border-color var(--transition), transform var(--transition), box-shadow var(--transition);
        }

        .team-card:hover {
            border-color: var(--accent);
            transform: translateY(-6px);
            box-shadow: 0 24px 60px rgba(232, 161, 63, 0.12);
        }

        .team-avatar {
            width: 90px;
            height: 90px;
            margin: var(--spacing-lg) auto var(--spacing-sm);
            border-radius: 50%;
            background: linear-gradient(135deg, #2a1800, #1a1000);
            border: 2px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            transition: border-color var(--transition);
        }

        .team-card:hover .team-avatar { border-color:var(--accent);}

        .team-card .card-body { padding: var(--spacing-md); }

        .team-card h3 {
            font-size: 1rem;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .team-role {
            font-size: 0.78rem;
            color: var(--accent);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            margin-bottom: var(--spacing-sm);
        }

        .team-bio {
            font-size: 0.82rem;
            color: var(--text-muted);
            margin: 0;
        }


        /* ============================================================
           SECTION DIVIDER
        ============================================================ */
        .section-label {
            display: inline-flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.72rem;
            text-transform: uppercase;
            letter-spacing: 0.2em;
            color: var(--accent);
            margin-bottom: var(--spacing-md);
        }

        .section-label::before,
        .section-label::after {
            content: '';
            width: 30px;
            height: 1px;
            background: var(--accent);;
        }

        /* ============================================================
           ANIMATIONS
        ============================================================ */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(30px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .fade-up { animation: fadeUp 0.7s ease forwards; }

        .hero-eyebrow { animation: fadeUp 0.5s ease 0.1s both; }
        .hero h1      { animation: fadeUp 0.6s ease 0.25s both; }
        .hero p       { animation: fadeUp 0.6s ease 0.4s both; }

        /* ============================================================
           RESPONSIVE
        ============================================================ */
        @media (max-width: 1100px) {
            .team-grid { grid-template-columns: repeat(3, 1fr); }
        }

        @media (max-width: 900px) {
            .grid-4 { grid-template-columns: repeat(2, 1fr); }
            .grid-3 { grid-template-columns: repeat(2, 1fr); }
        }

        @media (max-width: 700px) {
            .grid-2, .grid-3, .grid-4 { grid-template-columns: 1fr; }
            .team-grid { grid-template-columns: repeat(2, 1fr); }
            .navbar-links { display: none; }
        }

        @media (max-width: 480px) {
            .team-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

<jsp:include page="/views/components/navbar.jsp" />

<main>

    <!-- ============================================================
         HERO
    ============================================================ -->
    <section class="hero">
        <div class="container">
            <div class="section-label">Our Story</div>
            <h1>About Artopia</h1>
            <p>Connecting artists with art enthusiasts worldwide — one authentic creation at a time.</p>
        </div>
    </section>

    <!-- ============================================================
         STORY
    ============================================================ -->
    <section>
        <div class="container">
            <div class="grid grid-2" style="align-items: center; gap: var(--spacing-xl);">

                <!-- TEXT SIDE -->
                <div class="story-text">
                    <div class="section-label">Who We Are</div>
                    <h2>Our Story</h2>

                    <p>Artopia was founded in 2020 with a simple mission: to create a platform where artists can thrive and art lovers can discover unique, authentic creations directly from creators.</p>

                    <p>We believe that every artist deserves a fair platform to showcase and monetize their work without unnecessary intermediaries or high commission fees.</p>

                    <p>Today, Artopia hosts thousands of talented artists from around the world, collectively serving millions of art enthusiasts.</p>
                </div>


                <div class="story-image-box">
                    <img src="<%= request.getContextPath() %>/views/images/group.webp" alt="Art Image">
                </div>

            </div>
        </div>
    </section>

    <!-- ============================================================
         VALUES
    ============================================================ -->
    <section class="section-alt">
        <div class="container">
            <div class="text-center mb-3">
                <div class="section-label" style="justify-content: center;">What Drives Us</div>
                <h2>Our Values</h2>
            </div>
            <div class="grid grid-3">

                <div class="card values-card">
                    <div class="card-body">
                        <h3><span>🎯</span> Artist-Centric</h3>
                        <p>We prioritize the needs of artists. Fair pricing, transparent policies, and full creative control.</p>
                    </div>
                </div>

                <div class="card values-card">
                    <div class="card-body">
                        <h3><span>✨</span> Quality & Authenticity</h3>
                        <p>Every artwork is directly from the artist. No reproductions, no mass-produced items.</p>
                    </div>
                </div>

                <div class="card values-card">
                    <div class="card-body">
                        <h3><span>🌍</span> Global Community</h3>
                        <p>Breaking geographical boundaries. Connecting artists and collectors across the globe.</p>
                    </div>
                </div>

                <div class="card values-card">
                    <div class="card-body">
                        <h3><span>💪</span> Empowerment</h3>
                        <p>Providing tools and support to help artists succeed and grow their creative business.</p>
                    </div>
                </div>

                <div class="card values-card">
                    <div class="card-body">
                        <h3><span>🔒</span> Trust & Safety</h3>
                        <p>Secure platform with buyer protection and transparent dispute resolution.</p>
                    </div>
                </div>

                <div class="card values-card">
                    <div class="card-body">
                        <h3><span>🚀</span> Innovation</h3>
                        <p>Continuously improving with new features and tools to serve our community better.</p>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- ============================================================
         STATISTICS
    ============================================================ -->
    <section>
        <div class="container">
            <div class="text-center mb-3">
                <div class="section-label" style="justify-content: center;">Impact</div>
                <h2>By The Numbers</h2>
            </div>
            <div class="grid grid-4">

                <div class="card text-center">
                    <div class="card-body">
                        <span class="stat-number">15K+</span>
                        <p class="stat-label">Active Artists</p>
                    </div>
                </div>

                <div class="card text-center">
                    <div class="card-body">
                        <span class="stat-number">50K+</span>
                        <p class="stat-label">Artworks Listed</p>
                    </div>
                </div>

                <div class="card text-center">
                    <div class="card-body">
                        <span class="stat-number">200K+</span>
                        <p class="stat-label">Registered Buyers</p>
                    </div>
                </div>

                <div class="card text-center">
                    <div class="card-body">
                        <span class="stat-number">$5M+</span>
                        <p class="stat-label">Total Sales</p>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- ============================================================
         TEAM — 5 MEMBERS
    ============================================================ -->
    <section class="section-alt">
        <div class="container">
            <div class="text-center mb-3">
                <div class="section-label" style="justify-content: center;">The People</div>
                <h2>Our Team</h2>
            </div>

            <div class="team-grid">

                <div class="team-card">
                    <div class="team-avatar">👨‍💼</div>
                    <div class="card-body">
                        <h3>Alex Johnson</h3>
                        <p class="team-role">Founder &amp; CEO</p>
                        <p class="team-bio">Art entrepreneur with 15 years of industry experience shaping the digital art market.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-avatar">👩‍💻</div>
                    <div class="card-body">
                        <h3>Sarah Mitchell</h3>
                        <p class="team-role">Head of Product</p>
                        <p class="team-bio">Former designer passionate about seamless user experiences and creative interfaces.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-avatar">👨‍🎓</div>
                    <div class="card-body">
                        <h3>Mike Chen</h3>
                        <p class="team-role">Community Lead</p>
                        <p class="team-bio">Artist and art community advocate championing creator rights since 2008.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-avatar">👩‍🎨</div>
                    <div class="card-body">
                        <h3>Priya Nair</h3>
                        <p class="team-role">Creative Director</p>
                        <p class="team-bio">Award-winning visual artist and curator with a global exhibition portfolio.</p>
                    </div>
                </div>

                <div class="team-card">
                    <div class="team-avatar">👨‍🔬</div>
                    <div class="card-body">
                        <h3>James Rivera</h3>
                        <p class="team-role">Head of Engineering</p>
                        <p class="team-bio">Full-stack architect building scalable systems that power millions of transactions.</p>
                    </div>
                </div>

            </div>
        </div>
    </section>

</main>

<jsp:include page="/views/components/footer.jsp" />

<script>
    // Scroll-triggered fade-up for cards
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, { threshold: 0.1 });

    document.querySelectorAll('.card, .team-card').forEach((el, i) => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(24px)';
        el.style.transition = `opacity 0.5s ease ${i * 0.06}s, transform 0.5s ease ${i * 0.06}s, border-color 0.3s ease, box-shadow 0.3s ease`;
        observer.observe(el);
    });
</script>

</body>
</html>
