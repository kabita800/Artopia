<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>

    :root{
        --accent: #c9a96e;
    }

    /* ── Admin Sidebar Styles ── */

    .admin-sidebar{
        width:260px;
        height:100vh;
        background:#111111;
        border-right:1px solid rgba(255,255,255,0.08);
        padding:30px 20px;
        position:fixed;
        top:0;
        left:0;
        display:flex;
        flex-direction:column;
        justify-content:space-between;
        z-index:1000;
    }

    .admin-logo{
        font-family:'Playfair Display', serif;
        font-size:2rem;
        font-weight:700;
        color:#ffffff;
        margin-bottom:40px;
    }

    /* Accent color for the "ART" part of the logo */

    .admin-logo span{
        color:var(--accent);
    }

    .admin-menu{
        display:flex;
        flex-direction:column;
        gap:12px;
    }

    .admin-menu a{
        text-decoration:none;
        color:#cfcfcf;
        padding:14px 18px;
        border-radius:12px;
        transition:0.3s ease;
        border:1px solid transparent;
        font-size:0.95rem;
        font-family:'Inter', sans-serif;
    }
    /* Hover and active states for menu items */

    .admin-menu a:hover,
    .admin-menu a.active{
        background:rgba(232,161,63,0.12);
        color:var(--accent);
        border-color:rgba(232,161,63,0.25);
    }

    .admin-bottom{
        padding:16px;
        background:#151515;
        border-radius:16px;
        border:1px solid rgba(255,255,255,0.08);
    }

    .admin-bottom h4{
        color:#ffffff;
        margin-bottom:4px;
        font-size:1rem;
    }

    .admin-bottom p{
        color:#8b8b8b;
        font-size:0.82rem;
    }

    @media(max-width:768px){

        .admin-sidebar{
            width:100%;
            height:auto;
            position:relative;
            border-right:none;
            border-bottom:1px solid rgba(255,255,255,0.08);
        }

    }

</style>

<%
    String uri = request.getRequestURI();
%>

<div class="admin-sidebar">

    <div>

        <div class="admin-logo">
            <span>ART</span>OPIA
        </div>

        <div class="admin-menu">

            <a href="admin_dashboard.jsp"
               class="<%= uri.contains("admin_dashboard.jsp") ? "active" : "" %>">
                Dashboard
            </a>

            <a href="manage_users.jsp"
               class="<%= uri.contains("manage_users.jsp") ? "active" : "" %>">
                Manage Users
            </a>

            <a href="manage_art.jsp"
               class="<%= uri.contains("manage_art.jsp") ? "active" : "" %>">
                Manage Arts
            </a>

            <a href="../buyer/gallery.jsp">
                Gallery
            </a>

            <a href="${pageContext.request.contextPath}/logout">
                Logout
            </a>

        </div>

    </div>

    <div class="admin-bottom">
        <h4>Administrator</h4>
        <p>Full access control panel</p>
    </div>

</div>