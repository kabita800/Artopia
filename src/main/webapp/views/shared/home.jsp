<%--
   HOME PAGE - Artopia Marketplace (All Users)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userName = (String) session.getAttribute("userName");
    boolean isLoggedIn = (userName != null && !userName.trim().isEmpty());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artopia Marketplace</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700;900&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --black:       #080808;
            --black-2:     #101010;
            --black-3:     #181818;
            --black-4:     #222222;
            --yellow:      #f5c842;
            --yellow-dark: #c9a22e;
            --white:       #f0ebe0;
            --muted:       #888070;
            --border:      rgba(245, 200, 66, 0.13);
            --glow:        rgba(245, 200, 66, 0.07);
            --font-display: 'Playfair Display', Georgia, serif;
            --font-body:    'DM Sans', sans-serif;
        }

        html { scroll-behavior: smooth; }

        body {
            background: var(--black);
            color: var(--white);
            font-family: var(--font-body);
            font-size: 16px;
            line-height: 1.65;
        }

        ::-webkit-scrollbar { width: 5px; }
        ::-webkit-scrollbar-track { background: var(--black); }
        ::-webkit-scrollbar-thumb { background: var(--accent); border-radius: 3px; }

        /* ── LAYOUT ── */
        .container { max-width: 1160px; margin: 0 auto; padding: 0 1.5rem; }
        section { padding: 5rem 0; }

        .nav-user strong { color: var(--accent); font-weight: 600; }
        .btn {
            display: inline-block; padding: 0.6rem 1.4rem;
            border-radius: 6px; font-family: var(--font-body);
            font-size: 0.85rem; font-weight: 700;
            letter-spacing: 0.03em; text-decoration: none;
            cursor: pointer; border: none;
            transition: transform 0.15s, box-shadow 0.2s, background 0.2s;
        }
        .btn:hover { transform: translateY(-2px); }
        .btn-primary {
            background: var(--accent); color: var(--black);
            box-shadow: 0 4px 18px rgba(245,200,66,0.18);
        }
        .btn-primary:hover { background: #ffd84d; box-shadow: 0 6px 26px rgba(245,200,66,0.32); }
        .btn-outline {
            background: transparent; color: var(--accent);
            border: 1.5px solid var(--accent);
        }
        .btn-outline:hover { background: rgba(245,200,66,0.07); }
        .btn-ghost {
            background: transparent; color: var(--muted);
            border: 1px solid rgba(255,255,255,0.1);
        }
        .btn-ghost:hover { color: var(--white); border-color: rgba(255,255,255,0.25); }

        /* ── HERO ── */
        .hero {
            padding: 6rem 0 5rem;
            border-bottom: 1px solid var(--border);
            position: relative; overflow: hidden;
        }
        .hero::before {
            content: '';
            position: absolute; top: -100px; right: -80px;
            width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(245,200,66,0.06) 0%, transparent 65%);
            pointer-events: none;
        }
        .hero::after {
            content: '';
            position: absolute; bottom: -80px; left: 30%;
            width: 400px; height: 400px;
            background: radial-gradient(circle, rgba(245,200,66,0.04) 0%, transparent 65%);
            pointer-events: none;
        }
        .hero-inner {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 4rem; align-items: center;
        }
        .hero-badge {
            display: inline-flex; align-items: center; gap: 0.5rem;
            font-size: 0.75rem; font-weight: 600;
            letter-spacing: 0.12em; text-transform: uppercase;
            color: var(--accent);
            border: 1px solid var(--border);
            padding: 0.3rem 0.85rem; border-radius: 999px;
            background: var(--glow); margin-bottom: 1.25rem;
        }
        .hero-badge::before {
            content: ''; width: 6px; height: 6px;
            background: var(--accent); border-radius: 50%;
            animation: blink 2s infinite;
        }
        @keyframes blink {
            0%,100% { opacity:1; } 50% { opacity:0.3; }
        }
        .hero-welcome {
            font-size: 0.95rem; color: var(--muted);
            margin-bottom: 0.5rem; font-weight: 400;
        }
        .hero-welcome strong { color: var(--accent); font-weight: 600; }
        .hero h1 {
            font-family: var(--font-display);
            font-size: clamp(2.4rem, 4.5vw, 3.8rem);
            font-weight: 900; line-height: 1.08;
            letter-spacing: -1.5px; color: var(--white);
            margin-bottom: 1.25rem;
        }
        .hero h1 em {
            font-style: normal; color: var(--accent);
            position: relative;
        }
        .hero h1 em::after {
            content: '';
            position: absolute; bottom: 2px; left: 0;
            width: 100%; height: 3px;
            background: var(--accent); opacity: 0.3; border-radius: 2px;
        }
        .hero-desc {
            color: var(--muted); font-size: 1rem;
            max-width: 420px; margin-bottom: 2rem; line-height: 1.7;
        }
        .hero-actions { display: flex; gap: 1rem; flex-wrap: wrap; margin-bottom: 2.5rem; }
        .hero-stats {
            display: flex; gap: 2rem; padding-top: 2rem;
            border-top: 1px solid var(--border);
        }
        .hero-stat-num {
            font-family: var(--font-display);
            font-size: 1.6rem; font-weight: 700;
            color: var(--accent); display: block; line-height: 1;
        }
        .hero-stat-label {
            font-size: 0.75rem; color: var(--muted);
            text-transform: uppercase; letter-spacing: 0.08em;
            margin-top: 0.2rem;
        }
        .hero-img-wrap { position: relative; }
        .hero-img-wrap img {
            width: 100%; border-radius: 16px; object-fit: cover;
            max-height: 480px;
            box-shadow: 0 30px 80px rgba(0,0,0,0.6), 0 0 0 1px var(--border);
            display: block;
        }
        .hero-img-badge {
            position: absolute; bottom: -18px; left: -18px;
            background: var(--black-3);
            border: 1px solid var(--border);
            border-radius: 12px; padding: 1rem 1.3rem;
            display: flex; align-items: center; gap: 0.8rem;
            box-shadow: 0 8px 32px rgba(0,0,0,0.5);
        }
        .badge-icon {
            width: 40px; height: 40px; border-radius: 50%;
            background:var(--accent);; color: var(--black);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem; font-weight: 700; flex-shrink: 0;
        }
        .badge-text { font-size: 0.78rem; color: var(--muted); }
        .badge-text strong { color: var(--white); font-size: 0.9rem; display: block; }

        /* ── SECTION HEADER ── */
        .sec-header {
            display: flex; align-items: flex-end;
            justify-content: space-between;
            margin-bottom: 2.5rem; flex-wrap: wrap; gap: 1rem;
        }
        .sec-header h2 {
            font-family: var(--font-display);
            font-size: 2rem; font-weight: 700;
            color: var(--white); letter-spacing: -0.5px;
        }
        .sec-header h2 span { color: var(--accent); }
        .sec-header p { color: var(--muted); font-size: 0.9rem; margin-top: 0.3rem; }
        .link-more {
            font-size: 0.8rem; font-weight: 600;
            text-transform: uppercase; letter-spacing: 0.1em;
            color: var(--accent); text-decoration: none;
            border-bottom: 1px solid transparent;
            transition: border-color 0.2s;
            white-space: nowrap;
        }
        .link-more:hover { border-color: var(--accent); }

        /* ── FEATURED PRODUCT ── */
        .featured-section { border-bottom: 1px solid var(--border); }
        .featured-card {
            display: flex; align-items: stretch;
            background: var(--black-3);
            border: 1px solid var(--border);
            border-radius: 18px; overflow: hidden;
            transition: box-shadow 0.3s;
        }
        .featured-card:hover { box-shadow: 0 0 60px rgba(245,200,66,0.07); }
        .featured-img {
            width: 46%; flex-shrink: 0;
            object-fit: cover; display: block;
        }
        .featured-body {
            padding: 3rem; display: flex;
            flex-direction: column; justify-content: center; flex: 1;
        }
        .tag {
            display: inline-block; font-size: 0.7rem;
            font-weight: 700; letter-spacing: 0.14em;
            text-transform: uppercase; color: var(--accent);
            background: rgba(245,200,66,0.1);
            border: 1px solid rgba(245,200,66,0.2);
            padding: 0.25rem 0.8rem; border-radius: 999px;
            margin-bottom: 1.1rem; width: fit-content;
        }
        .featured-body h3 {
            font-family: var(--font-display);
            font-size: 2.2rem; font-weight: 900;
            color: var(--white); letter-spacing: -0.5px;
            margin-bottom: 0.5rem;
        }
        .featured-body .artist-name {
            color: var(--muted); font-size: 0.88rem; margin-bottom: 1rem;
        }
        .featured-body p {
            color: var(--muted); font-size: 0.95rem;
            margin-bottom: 1.5rem; max-width: 380px;
        }
        .price {
            font-family: var(--font-display);
            font-size: 2rem; font-weight: 700;
            color: var(--accent); margin-bottom: 1.5rem;
        }
        .card-actions { display: flex; gap: 0.9rem; flex-wrap: wrap; }

        /* ── CATEGORIES ── */
        .categories-section { background: var(--black-2); border-bottom: 1px solid var(--border); }
        .grid-4 { display: grid; grid-template-columns: repeat(4, 1fr); gap: 1rem; }
        .cat-card {
            background: var(--black-3);
            border: 1px solid var(--border);
            border-radius: 12px; padding: 1.5rem 1.25rem;
            text-decoration: none;
            display: flex; flex-direction: column; align-items: flex-start;
            gap: 0.6rem;
            transition: transform 0.2s, border-color 0.2s, background 0.2s;
        }
        .cat-card:hover {
            transform: translateY(-4px);
            border-color: rgba(245,200,66,0.3);
            background: var(--black-4);
        }
        .cat-icon {
            font-size: 1.6rem; width: 48px; height: 48px;
            background: var(--glow); border: 1px solid var(--border);
            border-radius: 10px; display: flex;
            align-items: center; justify-content: center;
        }
        .cat-name { font-weight: 600; color: var(--white); font-size: 0.95rem; }
        .cat-count { font-size: 0.78rem; color: var(--muted); }

        /* ── PRODUCTS GRID ── */
        .products-section { border-bottom: 1px solid var(--border); }
        .grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 1.25rem; }
        .product-card {
            background: var(--black-3);
            border: 1px solid var(--border);
            border-radius: 14px; overflow: hidden;
            transition: transform 0.25s, box-shadow 0.25s, border-color 0.25s;
        }
        .product-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 20px 50px rgba(0,0,0,0.5), 0 0 0 1px rgba(245,200,66,0.22);
            border-color: rgba(245,200,66,0.25);
        }
        .product-img-wrap { position: relative; overflow: hidden; aspect-ratio: 4/3; }
        .product-img-wrap img {
            width: 100%; height: 100%; object-fit: cover; display: block;
            transition: transform 0.4s ease;
        }
        .product-card:hover .product-img-wrap img { transform: scale(1.07); }
        .product-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to top, rgba(8,8,8,0.8) 0%, transparent 55%);
            opacity: 0; transition: opacity 0.3s;
            display: flex; align-items: flex-end;
            justify-content: center; padding: 1rem;
        }
        .product-card:hover .product-overlay { opacity: 1; }
        .product-body { padding: 1rem 1.25rem 1.4rem; }
        .product-body h3 {
            font-family: var(--font-display);
            font-size: 1.05rem; font-weight: 700;
            color: var(--white); margin-bottom: 0.2rem;
        }
        .product-body .medium { color: var(--muted); font-size: 0.8rem; margin-bottom: 0.5rem; }
        .product-footer {
            display: flex; align-items: center;
            justify-content: space-between; margin-top: 0.75rem;
        }
        .product-price { font-weight: 700; color: var(--accent); font-size: 1.05rem; }
        .product-artist { font-size: 0.75rem; color: var(--muted); }

        /* ── CTA BANNER ── */
        .cta-section { background: var(--black-2); }
        .cta-box {
            background: linear-gradient(135deg, var(--black-3) 0%, var(--black-4) 100%);
            border: 1px solid var(--border);
            border-radius: 20px; padding: 4rem;
            display: flex; align-items: center;
            justify-content: space-between; gap: 2rem;
            flex-wrap: wrap; position: relative; overflow: hidden;
        }
        .cta-box::before {
            content: '';
            position: absolute; top: -60px; right: -60px;
            width: 300px; height: 300px;
            background: radial-gradient(circle, rgba(245,200,66,0.09) 0%, transparent 65%);
            pointer-events: none;
        }
        .cta-text h2 {
            font-family: var(--font-display);
            font-size: 2rem; font-weight: 900;
            color: var(--white); letter-spacing: -0.5px; margin-bottom: 0.6rem;
        }
        .cta-text h2 span { color: var(--accent); }
        .cta-text p { color: var(--muted); font-size: 0.95rem; max-width: 400px; }
        .cta-actions { display: flex; gap: 1rem; flex-wrap: wrap; flex-shrink: 0; }


        /* ── RESPONSIVE ── */
        @media (max-width: 960px) {
            .hero-inner { grid-template-columns: 1fr; gap: 3rem; }
            .hero-img-wrap { display: none; }
            .grid-3 { grid-template-columns: repeat(2, 1fr); }
            .grid-4 { grid-template-columns: repeat(2, 1fr); }
            .featured-card { flex-direction: column; }
            .featured-img { width: 100%; max-height: 300px; }
        }
        @media (max-width: 600px) {
            .nav-links { display: none; }
            .grid-3 { grid-template-columns: 1fr; }
            .grid-4 { grid-template-columns: repeat(2, 1fr); }
            .cta-box { padding: 2rem 1.5rem; }
            .hero-stats { gap: 1.5rem; }
        }
    </style>
</head>
<body>

<jsp:include page="../components/navbar.jsp" />

<main>

    <!-- ══ HERO ══ -->
    <section class="hero">
        <div class="container">
            <div class="hero-inner">
                <div>
                    <div class="hero-badge fu">✦ Original Art Marketplace</div>

                    <% if (isLoggedIn) { %>
                    <p class="hero-welcome fu d1">Welcome back, <strong><%= userName %></strong>!</p>
                    <% } %>

                    <h1 class="fu d2">
                        Discover <em>Original</em><br>Art You'll<br>Love Forever
                    </h1>
                    <p class="hero-desc fu d3">
                        Explore thousands of one-of-a-kind artworks from independent artists around the world. Buy, collect, and connect.
                    </p>
                    <div class="hero-actions fu d4">
                        <a href="gallery.jsp" class="btn btn-primary">Explore Gallery</a>
                        <a href="artists.jsp" class="btn btn-outline">Meet the Artists</a>
                    </div>
                    <div class="hero-stats fu d5">
                        <div>
                            <span class="hero-stat-num">2,400+</span>
                            <span class="hero-stat-label">Artworks</span>
                        </div>
                        <div>
                            <span class="hero-stat-num">380+</span>
                            <span class="hero-stat-label">Artists</span>
                        </div>
                        <div>
                            <span class="hero-stat-num">12k+</span>
                            <span class="hero-stat-label">Collectors</span>
                        </div>
                    </div>
                </div>
                <div class="hero-img-wrap fu d3">
                    <img src="https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?auto=format&fit=crop&w=900&q=80"
                         alt="Featured artwork">
                    <div class="hero-img-badge">
                        <div class="badge-icon">★</div>
                        <div class="badge-text">
                            <strong>Golden Horizon</strong>
                            Featured this week
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ══ FEATURED PRODUCT ══ -->
    <section class="featured-section">
        <div class="container">
            <div class="sec-header fu">
                <div>
                    <h2>Featured <span>Product</span></h2>
                    <p>Hand-picked by our curators this week</p>
                </div>
                <a href="gallery.jsp" class="link-more">View All →</a>
            </div>
            <div class="featured-card fu d1">
                <img src="https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?auto=format&fit=crop&w=900&q=80"
                     alt="Golden Horizon" class="featured-img"/>
                <div class="featured-body">
                    <span class="tag">✦ Featured This Week</span>
                    <h3>Golden Horizon</h3>
                    <p class="artist-name">by <strong style="color:var(--white);">Elena Marsh</strong></p>
                    <p>Acrylic on canvas — a luminous landscape capturing the fleeting moment when golden light pours over the earth at dusk.</p>
                    <div class="price">$320.00</div>
                    <div class="card-actions">
                        <a href="gallery.jsp" class="btn btn-primary">View Details</a>
                        <a href="#" class="btn btn-outline">Add to Cart</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ══ CATEGORIES ══ -->
    <section class="categories-section">
        <div class="container">
            <div class="sec-header fu">
                <div>
                    <h2>Browse by <span>Category</span></h2>
                    <p>Find the style that speaks to you</p>
                </div>
            </div>
            <div class="grid-4">
                <a href="gallery.jsp?cat=painting" class="cat-card fu d1">
                    <div class="cat-icon">🎨</div>
                    <span class="cat-name">Painting</span>
                    <span class="cat-count">840 works</span>
                </a>
                <a href="gallery.jsp?cat=photography" class="cat-card fu d2">
                    <div class="cat-icon">📷</div>
                    <span class="cat-name">Photography</span>
                    <span class="cat-count">520 works</span>
                </a>
                <a href="gallery.jsp?cat=sculpture" class="cat-card fu d3">
                    <div class="cat-icon">🗿</div>
                    <span class="cat-name">Sculpture</span>
                    <span class="cat-count">310 works</span>
                </a>
                <a href="gallery.jsp?cat=digital" class="cat-card fu d4">
                    <div class="cat-icon">💻</div>
                    <span class="cat-name">Digital Art</span>
                    <span class="cat-count">730 works</span>
                </a>
            </div>
        </div>
    </section>

    <!-- ══ PRODUCTS ══ -->
    <section class="products-section">
        <div class="container">
            <div class="sec-header fu">
                <div>
                    <h2>New <span>Arrivals</span></h2>
                    <p>Fresh works added by our artists</p>
                </div>
                <a href="gallery.jsp" class="link-more">Browse All →</a>
            </div>
            <div class="grid-3">

                <div class="product-card fu d1">
                    <div class="product-img-wrap">
                        <img src="https://images.unsplash.com/photo-1578301978069-8f7ed8f63835?auto=format&fit=crop&w=700&q=80"
                             alt="Mountain Silence">
                        <div class="product-overlay">
                            <a href="#" class="btn btn-primary" style="width:100%;text-align:center;">Quick View</a>
                        </div>
                    </div>
                    <div class="product-body">
                        <h3>Mountain Silence</h3>
                        <p class="medium">Oil Painting</p>
                        <div class="product-footer">
                            <span class="product-price">$180.00</span>
                            <span class="product-artist">by David K.</span>
                        </div>
                    </div>
                </div>

                <div class="product-card fu d2">
                    <div class="product-img-wrap">
                        <img src="https://images.unsplash.com/photo-1577083165633-14ebcdb0f658?auto=format&fit=crop&w=700&q=80"
                             alt="Urban Pulse">
                        <div class="product-overlay">
                            <a href="#" class="btn btn-primary" style="width:100%;text-align:center;">Quick View</a>
                        </div>
                    </div>
                    <div class="product-body">
                        <h3>Urban Pulse</h3>
                        <p class="medium">Mixed Media</p>
                        <div class="product-footer">
                            <span class="product-price">$210.00</span>
                            <span class="product-artist">by Mia T.</span>
                        </div>
                    </div>
                </div>

                <div class="product-card fu d3">
                    <div class="product-img-wrap">
                        <img src="https://images.unsplash.com/photo-1547891654-e66ed7ebb968?auto=format&fit=crop&w=700&q=80"
                             alt="Calm River">
                        <div class="product-overlay">
                            <a href="#" class="btn btn-primary" style="width:100%;text-align:center;">Quick View</a>
                        </div>
                    </div>
                    <div class="product-body">
                        <h3>Calm River</h3>
                        <p class="medium">Watercolor</p>
                        <div class="product-footer">
                            <span class="product-price">$145.00</span>
                            <span class="product-artist">by Sara L.</span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- ══ CTA BANNER ══ -->
    <section class="cta-section">
        <div class="container">
            <div class="cta-box fu">
                <div class="cta-text">
                    <h2>Are you an <span>Artist?</span></h2>
                    <p>Join Artopia and start selling your original work to thousands of collectors worldwide. Free to get started.</p>
                </div>
                <div class="cta-actions">
                    <a href="register.jsp?role=artist" class="btn btn-primary">Join as Artist</a>
                    <a href="about.jsp" class="btn btn-outline">Learn More</a>
                </div>
            </div>
        </div>
    </section>

</main>

<jsp:include page="../components/footer.jsp" />

</body>
</html>
