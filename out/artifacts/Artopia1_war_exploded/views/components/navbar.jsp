<%--
   NAVBAR COMPONENT - Responsive Reusable Navigation Bar
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String userRole = (String) session.getAttribute("userRole");
    String currentURI = request.getRequestURI();
%>

<style>

    *{
        box-sizing:border-box;
        margin:0;
        padding:0;
    }

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

    body{
        font-family:'Outfit',sans-serif;
    }

    nav{
        position:fixed;
        top:0;
        left:0;
        right:0;
        z-index:1000;
        background:rgba(8,8,8,0.92);
        backdrop-filter:blur(14px);
        -webkit-backdrop-filter:blur(14px);
        border-bottom:1px solid var(--border);
    }

    nav .container{
        max-width:1280px;
        margin:0 auto;
        padding:0 2rem;
    }

    .navbar{
        display:flex;
        align-items:center;
        justify-content:space-between;
        min-height:70px;
        gap:2rem;
        position:relative;
    }

    /* BRAND */

    .navbar-brand{
        font-family:'Playfair Display',serif;
        font-size:1.35rem;
        font-weight:700;
        color:var(--white);
        text-decoration:none;
        letter-spacing:0.04em;
        flex-shrink:0;
        z-index:1002;
    }

    .navbar-brand::after{
        content:'.';
        color:var(--accent);
    }

    .navbar span{
        color:var(--accent);
    }

    /* MENU */

    .navbar-menu{
        display:flex;
        align-items:center;
        justify-content:center;
        gap:0.3rem;
        list-style:none;
        flex:1;
    }

    .navbar-menu li{
        list-style:none;
    }

    .navbar-menu li a{
        font-family:'DM Mono',monospace;
        font-size:0.78rem;
        letter-spacing:0.12em;
        text-transform:uppercase;
        color:var(--white-dim);
        text-decoration:none;
        padding:0.55rem 0.9rem;
        border-radius:4px;
        white-space:nowrap;
        transition:0.25s ease;
        display:block;
    }

    .navbar-menu li a:hover{
        color:var(--white);
        background:rgba(255,255,255,0.05);
    }

    .navbar-menu li a.active{
        color:var(--accent);
    }

    /* RIGHT SIDE */

    .navbar-right{
        display:flex;
        align-items:center;
        gap:0.75rem;
        flex-shrink:0;
    }

    .navbar-user{
        display:flex;
        align-items:center;
        gap:0.75rem;
    }

    .navbar-user span{
        font-family:'DM Mono',monospace;
        font-size:0.78rem;
        letter-spacing:0.08em;
        color:var(--white-muted);
    }

    .navbar-right a{
        font-family:'DM Mono',monospace;
        font-size:0.78rem;
        letter-spacing:0.1em;
        text-transform:uppercase;
        text-decoration:none;
        transition:0.25s ease;
        white-space:nowrap;
    }

    /* CART */

    .navbar-right a[href*="cart"]{
        position:relative;
        color:var(--white-dim);
        padding:0.45rem 0.75rem;
        border:1px solid var(--border);
    }

    .navbar-right a[href*="cart"]:hover{
        color:var(--white);
        border-color:var(--border-hover);
    }

    .cart-badge{
        position:absolute;
        top:-3px;
        right:-3px;
        background:var(--accent);
        color:var(--black);
        border-radius:50%;
        width:10px;
        height:10px;
    }

    /* BUTTONS */

    .btn.btn-small.btn-outline,
    .navbar-right .btn-outline{
        font-family:'DM Mono',monospace;
        font-size:0.78rem;
        letter-spacing:0.1em;
        text-transform:uppercase;
        background:transparent;
        color:var(--white-dim);
        padding:0.55rem 1rem;
        border:1px solid var(--border-hover);
        text-decoration:none;
        cursor:pointer;
    }

    .btn.btn-small.btn-outline:hover{
        color:var(--white);
        border-color:var(--accent);
    }

    .btn.btn-small.btn-primary,
    .navbar-right .btn-primary{
        font-family:'DM Mono',monospace;
        font-size:0.78rem;
        letter-spacing:0.1em;
        text-transform:uppercase;
        background:var(--accent);
        color:var(--black);
        padding:0.55rem 1rem;
        border:none;
        text-decoration:none;
        cursor:pointer;
    }

    .btn.btn-small.btn-primary:hover{
        background:var(--accent-bright);
    }

    /* MOBILE TOGGLE */

    .navbar-toggle{
        display:none;
        background:none;
        border:none;
        color:var(--white);
        font-size:1.8rem;
        cursor:pointer;
        z-index:1002;
    }

    /* =========================
       RESPONSIVE
    ========================== */

    @media (max-width: 992px){

        nav .container{
            padding:0 1.2rem;
        }

        .navbar{
            flex-wrap:wrap;
            align-items:center;
            padding:0.8rem 0;
        }

        .navbar-toggle{
            display:block;
        }

        .navbar-menu{
            position:absolute;
            top:100%;
            left:0;
            right:0;
            background:var(--off-black);
            border-bottom:1px solid var(--border);
            flex-direction:column;
            align-items:flex-start;
            padding:1rem 1.2rem;
            gap:0.3rem;

            max-height:0;
            overflow:hidden;
            opacity:0;
            visibility:hidden;

            transition:all 0.3s ease;
        }

        .navbar-menu.active{
            max-height:600px;
            opacity:1;
            visibility:visible;
        }

        .navbar-menu li{
            width:100%;
        }

        .navbar-menu li a{
            width:100%;
            padding:0.9rem 0.5rem;
        }

        .navbar-right{
            position:absolute;
            top:100%;
            left:0;
            right:0;
            background:var(--off-black);
            flex-direction:column;
            align-items:flex-start;
            padding:0 1.2rem 1.2rem;

            max-height:0;
            overflow:hidden;
            opacity:0;
            visibility:hidden;

            transition:all 0.3s ease;
            border-bottom:1px solid var(--border);
        }

        .navbar-right.active{
            max-height:400px;
            opacity:1;
            visibility:visible;
        }

        .navbar-user{
            flex-direction:column;
            align-items:flex-start;
            width:100%;
        }

        .navbar-right a,
        .navbar-user a{
            width:100%;
        }
    }

</style>

<nav>
    <div class="container">

        <div class="navbar">

            <!-- LOGO -->
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                <span>ART</span>OPIA
            </a>

            <!-- MOBILE BUTTON -->
            <button class="navbar-toggle" id="navbarToggle">
                ☰
            </button>

            <!-- MENU -->
            <ul class="navbar-menu" id="navbarMenu">

                <% if (userRole == null) { %>

                <li>
                    <a href="${pageContext.request.contextPath}/views/public/landing.jsp"
                       class="<%= currentURI.contains("landing.jsp") ? "active" : "" %>">
                        Home
                    </a>
                </li>

                <li>
                    <a href="${pageContext.request.contextPath}/buyer/gallery"
                       class="<%= currentURI.contains("/buyer/gallery") || currentURI.contains("gallery.jsp") ? "active" : "" %>">
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
                    <a href="${pageContext.request.contextPath}/artist/gallery"
                       class="<%= currentURI.contains("/artist/gallery") || currentURI.contains("gallery.jsp") ? "active" : "" %>">
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
                    <a href="${pageContext.request.contextPath}/buyer/gallery"
                       class="<%= currentURI.contains("/buyer/gallery") || currentURI.contains("gallery.jsp") ? "active" : "" %>">
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
                    <a href="${pageContext.request.contextPath}/artist/gallery"
                       class="<%= currentURI.contains("/artist/gallery") || currentURI.contains("gallery.jsp") ? "active" : "" %>">
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

            <!-- RIGHT SIDE -->
            <div class="navbar-right" id="navbarRight">

                <% if ("buyer".equals(userRole)) { %>
                <a href="${pageContext.request.contextPath}/views/buyer/cart.jsp">
                    🛒 Cart
                    <span class="cart-badge"></span>
                </a>
                <% } %>

                <% if (userRole != null) { %>

                <div class="navbar-user">
                    <span>${sessionScope.userName}</span>

                    <a href="${pageContext.request.contextPath}/logout"
                       class="btn btn-small btn-outline">
                        Logout
                    </a>
                </div>

                <% } else { %>

                <a href="${pageContext.request.contextPath}/views/public/login.jsp"
                   class="btn btn-small btn-outline">
                    Login
                </a>

                <a href="${pageContext.request.contextPath}/views/public/register.jsp"
                   class="btn btn-small btn-primary">
                    Join Artopia
                </a>

                <% } %>

            </div>

        </div>

    </div>
</nav>

<script>

    const navbarToggle = document.getElementById('navbarToggle');
    const navbarMenu = document.getElementById('navbarMenu');
    const navbarRight = document.getElementById('navbarRight');

    navbarToggle.addEventListener('click', function () {

        navbarMenu.classList.toggle('active');
        navbarRight.classList.toggle('active');

        if (navbarToggle.innerHTML === '☰') {
            navbarToggle.innerHTML = '✕';
        } else {
            navbarToggle.innerHTML = '☰';
        }
    });

</script>

<jsp:include page="/views/components/artopia_toast.jsp" />