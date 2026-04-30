<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.artopia1.user.model.User"%>

<%
    User user = (User) session.getAttribute("user");

    // Security check (ADMIN only)
    if (user == null || !user.getRole().equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Artopia</title>
    <link rel="stylesheet" href="../Style.css">
</head>

<body>

<!-- NAVBAR -->
<nav class="navbar">

    <a class="nav-logo" href="adminDashboard.jsp">
        Art<span>opia</span>
    </a>

    <ul class="nav-links">
        <li><a href="adminDashboard.jsp">Dashboard</a></li>
        <li><a href="manage-users.jsp">Users</a></li>
        <li><a href="manage-art.jsp">Artworks</a></li>
        <li><a href="reports.jsp">Reports</a></li>
    </ul>

    <div class="nav-actions">

        <span style="color:var(--text2);font-size:0.85rem;">
            Admin: <%= user.getName() %>
        </span>

        <form action="../user-auth" method="post" style="display:inline;">
            <input type="hidden" name="action" value="logout"/>
            <button type="submit" class="btn-nav btn-nav-primary">Logout</button>
        </form>

    </div>

</nav>

<!-- MAIN -->
<main>

    <section class="section">

        <div class="section-header">
            <div class="section-label">Admin Panel</div>
            <h2>Dashboard Overview</h2>
            <p>Manage users, artworks, and platform activity.</p>
        </div>

        <!-- STATS -->
        <div class="dash-stats">

            <div class="dash-stat">
                <div class="dash-stat-num">120</div>
                <div class="dash-stat-label">Total Users</div>
                <div class="dash-stat-change">+12 this week</div>
            </div>

            <div class="dash-stat">
                <div class="dash-stat-num">85</div>
                <div class="dash-stat-label">Artworks</div>
                <div class="dash-stat-change">+8 new uploads</div>
            </div>

            <div class="dash-stat">
                <div class="dash-stat-num">45</div>
                <div class="dash-stat-label">Artists</div>
                <div class="dash-stat-change">+3 new artists</div>
            </div>

            <div class="dash-stat">
                <div class="dash-stat-num">230</div>
                <div class="dash-stat-label">Orders</div>
                <div class="dash-stat-change">+18 today</div>
            </div>

        </div>

        <!-- TABLE -->
        <div class="dash-table">

            <div class="dash-table-header">
                <h3>Recent Activity</h3>
                <button class="btn-secondary">View All</button>
            </div>

            <table>
                <thead>
                <tr>
                    <th>User</th>
                    <th>Action</th>
                    <th>Role</th>
                    <th>Status</th>
                </tr>
                </thead>

                <tbody>
                <tr>
                    <td>Ram Sharma</td>
                    <td>Uploaded Artwork</td>
                    <td>ARTIST</td>
                    <td><span class="status-badge available">Active</span></td>
                </tr>

                <tr>
                    <td>Sita Rai</td>
                    <td>Purchased Art</td>
                    <td>BUYER</td>
                    <td><span class="status-badge available">Active</span></td>
                </tr>

                <tr>
                    <td>Admin</td>
                    <td>Approved User</td>
                    <td>ADMIN</td>
                    <td><span class="status-badge pending">Reviewed</span></td>
                </tr>
                </tbody>

            </table>

        </div>

    </section>

</main>

<!-- FOOTER -->
<footer>
    <div class="footer-bottom">
        <p>© 2026 Artopia Admin Panel</p>
    </div>
</footer>

</body>
</html>