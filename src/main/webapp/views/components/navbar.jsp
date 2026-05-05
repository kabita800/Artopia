<%-- ================================================================
   NAVBAR COMPONENT - Reusable Navigation Bar
   Include in all pages: <jsp:include page="../components/navbar.jsp" />
   ================================================================ --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    :root {
        --black: #080808;
        --off-black: #0f0f0f;
        --border: rgba(255,255,255,0.07);
        --border-hover: rgba(255,255,255,0.18);
        --white: #f5f0eb;
        --white-dim: rgba(245,240,235,0.6);
        --white-muted: rgba(245,240,235,0.35);
        --accent: #c9a96e;
        --accent-bright: #e8c88a;
    }

    @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=DM+Mono:wght@400;500&family=Outfit:wght@300;400;500&display=swap');

    nav {
        position: fixed;
        top: 0; left: 0; right: 0;
        z-index: 1000;
        background: rgba(8,8,8,0.88);
        backdrop-filter: blur(14px);
        -webkit-backdrop-filter: blur(14px);
        border-bottom: 1px solid var(--border);
        font-family: 'Outfit', sans-serif;
    }

    nav .container {
        max-width: 1280px;
        margin: 0 auto;
        padding: 0 3rem;
    }

    .navbar {
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 64px;
        gap: 2rem;
    }

    /* ── BRAND ── */
    .navbar-brand {
        font-family: 'Playfair Display', serif;
        font-size: 1.35rem;
        font-weight: 700;
        color: var(--white);
        text-decoration: none;
        letter-spacing: 0.04em;
        flex-shrink: 0;
    }

    .navbar-brand::after {
        content: '.';
        color: var(--accent);
    }

    /* ── MENU ── */
    .navbar-menu {
        display: flex;
        align-items: center;
        gap: 0.25rem;
        list-style: none;
        flex: 1;
        justify-content: center;
    }

    .navbar-menu li a {
        font-family: 'DM Mono', monospace;
        font-size: 0.68rem;
        letter-spacing: 0.12em;
        text-transform: uppercase;
        color: var(--white-dim);
        text-decoration: none;
        padding: 0.45rem 0.9rem;
        transition: color 0.2s, background 0.2s;
        border-radius: 2px;
        white-space: nowrap;
    }

    .navbar-menu li a:hover {
        color: var(--white);
        background: rgba(255,255,255,0.05);
    }

    .navbar-menu li a.active {
        color: var(--accent);
    }

    /* ── RIGHT SIDE ── */
    .navbar-right {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        flex-shrink: 0;
    }

    .navbar-right a {
        font-family: 'DM Mono', monospace;
        font-size: 0.68rem;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        text-decoration: none;
        transition: all 0.2s;
        white-space: nowrap;
    }

    /* Cart link */
    .navbar-right a[href*="cart"] {
        position: relative;
        color: var(--white-dim);
        padding: 0.45rem 0.75rem;
        border: 1px solid var(--border);
    }

    .navbar-right a[href*="cart"]:hover {
        color: var(--white);
        border-color: var(--border-hover);
    }

    .cart-badge {
        position: absolute;
        top: -7px;
        right: -7px;
        background: var(--accent) !important;
        color: var(--black) !important;
        border-radius: 50%;
        width: 18px !important;
        height: 18px !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        font-size: 0.6rem !important;
        font-weight: 700 !important;
        font-family: 'DM Mono', monospace;
        border: none;
    }

    /* User info */
    .navbar-user {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .navbar-user span {
        font-family: 'DM Mono', monospace;
        font-size: 0.68rem;
        letter-spacing: 0.08em;
        color: var(--white-muted);
        text-transform: uppercase;
    }

    /* Outline button */
    .btn.btn-small.btn-outline,
    .navbar-right .btn-outline {
        font-family: 'DM Mono', monospace;
        font-size: 0.68rem;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        background: transparent;
        color: var(--white-dim);
        padding: 0.45rem 1.1rem;
        border: 1px solid var(--border-hover);
        text-decoration: none;
        transition: all 0.2s;
        cursor: pointer;
    }

    .btn.btn-small.btn-outline:hover,
    .navbar-right .btn-outline:hover {
        color: var(--white);
        border-color: rgba(255,255,255,0.35);
    }

    /* Primary button */
    .btn.btn-small.btn-primary,
    .navbar-right .btn-primary {
        font-family: 'DM Mono', monospace;
        font-size: 0.68rem;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        background: var(--accent);
        color: var(--black);
        padding: 0.45rem 1.1rem;
        border: none;
        text-decoration: none;
        font-weight: 500;
        transition: all 0.2s;
        cursor: pointer;
    }

    .btn.btn-small.btn-primary:hover,
    .navbar-right .btn-primary:hover {
        background: var(--accent-bright);
        transform: translateY(-1px);
    }

    /* ── MOBILE TOGGLE ── */
    .navbar-toggle {
        display: none;
        background: transparent;
        border: 1px solid var(--border-hover);
        color: var(--white-dim);
        font-size: 1rem;
        padding: 0.35rem 0.65rem;
        cursor: pointer;
        transition: all 0.2s;
    }

    .navbar-toggle:hover {
        color: var(--white);
        border-color: rgba(255,255,255,0.35);
    }

    /* ── RESPONSIVE ── */
    @media (max-width: 900px) {
        nav .container { padding: 0 1.5rem; }

        .navbar-toggle { display: block; order: 3; }

        .navbar-menu {
            display: none;
            position: absolute;
            top: 64px; left: 0; right: 0;
            flex-direction: column;
            align-items: flex-start;
            background: rgba(8,8,8,0.97);
            border-bottom: 1px solid var(--border);
            padding: 1rem 1.5rem;
            gap: 0.25rem;
        }

        .navbar-menu.open { display: flex; }

        .navbar-menu li { width: 100%; }

        .navbar-menu li a {
            display: block;
            padding: 0.65rem 0;
            border-bottom: 1px solid var(--border);
        }

        .navbar-right {
            display: none;
            position: absolute;
            top: auto;
            flex-direction: column;
            align-items: flex-start;
        }

        .navbar-right.open { display: flex; }
    }

    .navbar-brand span {
        color: var(--accent);
        font-weight: bold;
    }

</style>

<nav>
    <div class="container">
        <div class="navbar">
            <!-- Brand -->
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <span>ART</span>OPIA
            </a>

            <!-- Mobile Toggle -->
            <button class="navbar-toggle" id="navbarToggle">☰</button>

            <!-- Menu -->
            <ul class="navbar-menu" id="navbarMenu">
                <%-- Determine user role from session --%>
                <% String userRole = (String) session.getAttribute("userRole"); %>

                <% if (userRole == null) { %>
                <!-- Guest Navigation -->
                <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/views/artist/artist-landing.jsp">Gallery</a></li>
                <li><a href="${pageContext.request.contextPath}/views/login.jsp">Artist</a></li>
                <li><a href="${pageContext.request.contextPath}/views/about.jsp">About</a></li>
                <li><a href="${pageContext.request.contextPath}/views/contact.jsp">Contact</a></li>
                <% } else if ("artist".equalsIgnoreCase(userRole)) { %>
                <!-- Artist Navigation -->
                <li><a href="${pageContext.request.contextPath}/views/home.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/views/artist/artist-gallery.jsp">Gallery</a></li>
                <li><a href="${pageContext.request.contextPath}/views/artist/artist-profile.jsp">Artist</a></li>
                <li><a href="${pageContext.request.contextPath}/views/about.jsp">About</a></li>
                <li><a href="${pageContext.request.contextPath}/views/contact.jsp">Contact</a></li>
                <% } else if ("buyer".equalsIgnoreCase(userRole)) { %>
                <!-- Buyer Navigation -->
                <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/views/artist/artist-landing.jsp">Gallery</a></li>
                <li><a href="${pageContext.request.contextPath}/views/login.jsp">Artist</a></li>
                <li><a href="${pageContext.request.contextPath}/views/about.jsp">About</a></li>
                <li><a href="${pageContext.request.contextPath}/views/contact.jsp">Contact</a></li>
                <% } else if ("admin".equalsIgnoreCase(userRole)) { %>
                <!-- Admin Navigation -->
                <li><a href="${pageContext.request.contextPath}/views/adminDashboard.jsp">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/views/login.jsp">Artist</a></li>
                <li><a href="${pageContext.request.contextPath}/views/artist/artist-landing.jsp">Gallery</a></li>
                <% } %>
            </ul>

            <!-- Right Menu -->
            <div class="navbar-right" id="navbarRight">
                <% if ("buyer".equals(userRole)) { %>
                <a href="${pageContext.request.contextPath}/buyer/cart.jsp">
                    🛒 Cart
                    <span class="cart-badge"></span>
                </a>
                <% } %>

                <% if (userRole != null) { %>
                <div class="navbar-user">
                    <span>${sessionScope.userName}</span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-small btn-outline">Logout</a>
                </div>
                <% } else { %>
                <a href="${pageContext.request.contextPath}/views/login.jsp" class="btn btn-small btn-outline">Login</a>
                <a href="${pageContext.request.contextPath}/views/register.jsp" class="btn btn-small btn-primary">Join Artopia</a>
                <% } %>
            </div>
        </div>
    </div>
</nav>

<script>
    (function() {
        var toggle = document.getElementById('navbarToggle');
        var menu   = document.getElementById('navbarMenu');
        var right  = document.getElementById('navbarRight');
        if (toggle) {
            toggle.addEventListener('click', function() {
                menu.classList.toggle('open');
                right.classList.toggle('open');
                toggle.textContent = menu.classList.contains('open') ? '✕' : '☰';
            });
        }
    })();
</script>
