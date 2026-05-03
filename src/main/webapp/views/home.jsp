<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.artopia1.user.model.User"%>

<%
    User user = (User) session.getAttribute("user");


    if (user == null) {
        response.sendRedirect("../views/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Artopia - Artist Home</title>
    <link rel="stylesheet" href="../Style.css" />
</head>

<body>

<nav class="navbar">
    <a class="nav-logo" href="home.jsp" style="cursor:pointer">
        Art<span>opia</span>
    </a>

    <ul class="nav-links">
        <li><a href="home.jsp">Home</a></li>
        <li><a href="add-art.jsp">Add Art</a></li>
        <li><a href="about.jsp">About</a></li>
        <li><a href="contact.jsp">Contact</a></li>
    </ul>

    <div class="nav-actions">

        <span style="color:var(--text2);font-size:0.85rem;">
            Welcome, <%= user.getName() %>
        </span>

        <form action="../user-auth" method="post" style="display:inline;">
            <input type="hidden" name="action" value="logout"/>
            <button type="submit" class="btn-nav btn-nav-primary">Logout</button>
        </form>

    </div>
</nav>

<main>


    <section class="hero">
        <div class="hero-bg"></div>
        <div class="hero-grid"></div>

        <div class="hero-content">
            <div class="hero-label">Artist Dashboard</div>

            <h1>Welcome <em><%= user.getName() %></em></h1>

            <p class="hero-sub">
                Manage your artworks, upload new creations, and connect with buyers across Nepal.
            </p>

            <div class="hero-actions">
                <button type="button" class="btn-primary" onclick="location.href='add-art.jsp'">
                    Upload Art
                </button>

                <button type="button" class="btn-secondary" onclick="location.href='home.jsp'">
                    View Gallery
                </button>
            </div>
        </div>

        <div class="hero-stats">
            <div class="hero-stat">
                <div class="hero-stat-num">Your</div>
                <div class="hero-stat-label">Portfolio</div>
            </div>
            <div class="hero-stat">
                <div class="hero-stat-num">Live</div>
                <div class="hero-stat-label">Uploads</div>
            </div>
            <div class="hero-stat">
                <div class="hero-stat-num">Buyers</div>
                <div class="hero-stat-label">Connected</div>
            </div>
        </div>
    </section>

</main>

<footer>
    <div class="footer-bottom" style="max-width:1280px;margin:0 auto;padding:2rem 0">
        <p>Copyright 2026 Artopia Nepal. All rights reserved.</p>
    </div>
</footer>

</body>
</html>