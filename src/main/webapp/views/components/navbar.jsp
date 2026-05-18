<%-- ================================================================
   NAVBAR COMPONENT - Reusable Navigation Bar
   Include in all pages: <jsp:include page="../components/navbar.jsp" />
   ================================================================ --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String userRole = (String) session.getAttribute("userRole");
    String currentURI = request.getRequestURI();
%>

<style>
    * { box-sizing: border-box; margin: 0; padding: 0; }

    /* ── CSS Variables for Theme Colors ── */

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

    /* Container to center content and limit width */

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

    /* Brand Logo and Name */

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
        font-size: 0.78rem;
        letter-spacing: 0.12em;
        text-transform: uppercase;
        color: var(--white-dim);
        text-decoration: none;
        padding: 0.45rem 0.9rem;
        border-radius: 2px;
        white-space: nowrap;
        transition: color 0.2s, background 0.2s;
    }

    .navbar-menu li a:hover {
        color: var(--white);
        background: rgba(255,255,255,0.05);
    }

    /* ✅ ONLY ACTIVE STATE (UNCHANGED DESIGN) */
    .navbar-menu li a.active {
        color: var(--accent);
    }

    .navbar-right {
        display: flex;
        align-items: center;
        gap: 0.75rem;
        flex-shrink: 0;
    }

    .navbar-right a {
        font-family: 'DM Mono', monospace;
        font-size: 0.78rem;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        text-decoration: none;
        transition: all 0.2s;
        white-space: nowrap;
    }

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
        top: -3px;
        right: -3px;
        background: var(--accent) !important;
        color: var(--black) !important;
        border-radius: 50%;
        width: 10px !important;
        height: 10px !important;
        display: flex !important;
        align-items: center !important;
        justify-content: center !important;
        font-size: 0.44rem !important;
        font-weight: 700 !important;
        font-family: 'DM Mono', monospace;
    }

    .navbar-user {
        display: flex;
        align-items: center;
        gap: 0.75rem;
    }

    .navbar-user span {
        font-family: 'DM Mono', monospace;
        font-size: 0.78rem;
        letter-spacing: 0.08em;
        color: var(--white-muted);
    }

    .navbar span{
        color: var(--accent);
    }

    .btn.btn-small.btn-outline,
    .navbar-right .btn-outline {
        font-family: 'DM Mono', monospace;
        font-size: 0.78rem;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        background: transparent;
        color: var(--white-dim);
        padding: 0.45rem 1.1rem;
        border: 1px solid var(--border-hover);
        text-decoration: none;
        cursor: pointer;
    }

    .btn.btn-small.btn-primary,
    .navbar-right .btn-primary {
        font-family: 'DM Mono', monospace;
        font-size: 0.78rem;
        letter-spacing: 0.1em;
        text-transform: uppercase;
        background: var(--accent);
        color: var(--black);
        padding: 0.45rem 1.1rem;
        border: none;
        cursor: pointer;
    }

    .navbar-toggle {
        display: none;
    }

</style>

<nav>
    <div class="container">
        <div class="navbar">

            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <span>ART</span>OPIA
            </a>

            <button class="navbar-toggle" id="navbarToggle">☰</button>

            <ul class="navbar-menu" id="navbarMenu">

                <% if (userRole == null) { %>

                <li>
                    <a href="${pageContext.request.contextPath}/views/public/landing.jsp"
                       class="<%= currentURI.contains("landing.jsp") ? "active" : "" %>">
                        Home
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/buyer/gallery.jsp"
                       class="<%= currentURI.contains("gallery.jsp") ? "active" : "" %>">
                        Gallery
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/artist.jsp"
                       class="<%= currentURI.contains("artist.jsp") ? "active" : "" %>">
                        Artist
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/about.jsp"
                       class="<%= currentURI.contains("about.jsp") ? "active" : "" %>">
                        About
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/contact.jsp"
                       class="<%= currentURI.contains("contact.jsp") ? "active" : "" %>">
                        Contact
                    </a>
                </li>

                <% } else if ("artist".equalsIgnoreCase(userRole)) { %>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/home.jsp"
                       class="<%= currentURI.contains("home.jsp") ? "active" : "" %>">
                        Home
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/artist/gallery.jsp"
                       class="<%= currentURI.contains("gallery.jsp") ? "active" : "" %>">
                        Gallery
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/artist.jsp"
                       class="<%= currentURI.contains("artist.jsp") ? "active" : "" %>">
                        Artist
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/about.jsp"
                       class="<%= currentURI.contains("about.jsp") ? "active" : "" %>">
                        About
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/contact.jsp"
                       class="<%= currentURI.contains("contact.jsp") ? "active" : "" %>">
                        Contact
                    </a>
                </li>

                <% } else if ("buyer".equalsIgnoreCase(userRole)) { %>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/home.jsp"
                       class="<%= currentURI.contains("home.jsp") ? "active" : "" %>">
                        Home
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/buyer/gallery.jsp"
                       class="<%= currentURI.contains("gallery.jsp") ? "active" : "" %>">
                        Gallery
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/artist.jsp"
                       class="<%= currentURI.contains("artist.jsp") ? "active" : "" %>">
                        Artist
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/about.jsp"
                       class="<%= currentURI.contains("about.jsp") ? "active" : "" %>">
                        About
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/contact.jsp"
                       class="<%= currentURI.contains("contact.jsp") ? "active" : "" %>">
                        Contact
                    </a>
                </li>

                <% } else if ("admin".equalsIgnoreCase(userRole)) { %>

                <li>
                    <a href="${pageContext.request.contextPath}/views/admin/admin_dashboard.jsp"
                       class="<%= currentURI.contains("admin_dashboard.jsp") ? "active" : "" %>">
                        Dashboard
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/home.jsp"
                       class="<%= currentURI.contains("home.jsp") ? "active" : "" %>">
                        Home
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/artist/gallery.jsp"
                       class="<%= currentURI.contains("gallery.jsp") ? "active" : "" %>">
                        Gallery
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/views/shared/artist.jsp"
                       class="<%= currentURI.contains("artist.jsp") ? "active" : "" %>">
                        Artist
                    </a>
                </li>

                <% } %>

            </ul>

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
                <a href="${pageContext.request.contextPath}/views/public/login.jsp" class="btn btn-small btn-outline">Login</a>
                <a href="${pageContext.request.contextPath}/views/public/register.jsp" class="btn btn-small btn-primary">Join Artopia</a>
                <% } %>

            </div>

        </div>
    </div>
</nav>