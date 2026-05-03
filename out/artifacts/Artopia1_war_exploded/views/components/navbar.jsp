<%-- ================================================================
   NAVBAR COMPONENT - Reusable Navigation Bar
   Include in all pages: <jsp:include page="../components/navbar.jsp" />
   ================================================================ --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<nav>
    <div class="container">
        <div class="navbar">
            <!-- Brand -->
            <a href="${pageContext.request.contextPath}/" class="navbar-brand">
                ARTOPIA
            </a>

            <!-- Mobile Toggle -->
            <button class="navbar-toggle" id="navbarToggle">
                <span>☰</span>
            </button>

            <!-- Menu -->
            <ul class="navbar-menu" id="navbarMenu">
                <%-- Determine user role from session --%>
                <% String userRole = (String) session.getAttribute("userRole"); %>

                <% if (userRole == null) { %>
                    <!-- Guest Navigation -->
                    <li><a href="${pageContext.request.contextPath}/artist/artist-home.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/artist/artist-landing.jsp">For Artists</a></li>
                    <li><a href="${pageContext.request.contextPath}/buyer/buyer-landing.jsp">For Buyers</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/about.jsp">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/contact.jsp">Contact</a></li>
                <% } else if ("artist".equals(userRole)) { %>
                    <!-- Artist Navigation -->
                    <li><a href="${pageContext.request.contextPath}/artist/artist-home.jsp">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/artist/artist-gallery.jsp">My Gallery</a></li>
                    <li><a href="${pageContext.request.contextPath}/artist/artist-profile.jsp">Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/about.jsp">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/contact.jsp">Contact</a></li>
                <% } else if ("buyer".equals(userRole)) { %>
                    <!-- Buyer Navigation -->
                    <li><a href="${pageContext.request.contextPath}/buyer/buyer-home.jsp">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/buyer/buyer-gallery.jsp">Gallery</a></li>
                    <li><a href="${pageContext.request.contextPath}/buyer/artists.jsp">Artists</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/about.jsp">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/views/contact.jsp">Contact</a></li>
                <% } else if ("admin".equals(userRole)) { %>
                    <!-- Admin Navigation -->
                    <li><a href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp#arts">Manage Arts</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/admin-dashboard.jsp#users">Manage Users</a></li>
                <% } %>
            </ul>

            <!-- Right Menu (User Account & Cart) -->
            <div class="navbar-right">
                <% if ("buyer".equals(userRole)) { %>
                    <a href="${pageContext.request.contextPath}/buyer/cart.jsp" style="position: relative;">
                        🛒 Cart
                        <span class="cart-badge" style="
                            position: absolute;
                            top: -8px;
                            right: -8px;
                            background-color: #e8a13f;
                            color: white;
                            border-radius: 50%;
                            width: 20px;
                            height: 20px;
                            display: flex;
                            align-items: center;
                            justify-content: center;
                            font-size: 0.8rem;
                            font-weight: bold;
                        "></span>
                    </a>
                <% } %>

                <% if (userRole != null) { %>
                    <div class="navbar-user">
                        <span>${sessionScope.userName}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-small btn-outline">
                            Logout
                        </a>
                    </div>
                <% } else { %>
                    <a href="${pageContext.request.contextPath}/artist/artist-login.jsp" class="btn btn-small btn-outline">
                        Artist Login
                    </a>
                    <a href="${pageContext.request.contextPath}/buyer/buyer-login.jsp" class="btn btn-small btn-primary">
                        Buyer Login
                    </a>
                <% } %>
            </div>
        </div>
    </div>
</nav>