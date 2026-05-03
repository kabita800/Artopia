<%-- 
   ARTIST LOGIN PAGE
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artist Login - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />

    <main>
        <section style="min-height: 100vh; display: flex; align-items: center;">
            <div class="container-sm">
                <div class="card">
                    <div class="card-body" style="padding: var(--spacing-xl);">
                        <h1 class="text-center" style="margin-top: 0;">Artist Login</h1>
                        <p class="text-center text-muted" style="margin-bottom: var(--spacing-lg);">
                            Sign in to your artist account
                        </p>

                        <!-- Alert Messages -->
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-error">
                                <%= request.getParameter("error") %>
                            </div>
                        <% } %>

                        <!-- Login Form -->
                        <form id="loginForm" method="POST" action="${pageContext.request.contextPath}/artist-login-handler">
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" id="email" name="email" placeholder="your@email.com" required>
                            </div>

                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" placeholder="••••••••" required>
                            </div>

                            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: var(--spacing-lg);">
                                <label style="margin-bottom: 0;">
                                    <input type="checkbox" name="remember" style="margin-right: 0.5rem;">
                                    <span>Remember me</span>
                                </label>
                                <a href="#" style="color: var(--accent-color);">Forgot password?</a>
                            </div>

                            <button type="submit" class="btn btn-primary btn-large btn-block">
                                Sign In
                            </button>

                            <p style="text-align: center; margin-top: var(--spacing-lg);">
                                Don't have an account? 
                                <a href="artist-register.jsp" style="color: var(--accent-color); font-weight: 600;">
                                    Register here
                                </a>
                            </p>
                        </form>

                        <!-- Back to Landing -->
                        <p style="text-align: center; margin-top: var(--spacing-lg);">
                            <a href="artist-landing.jsp">← Back to Artists Landing</a>
                        </p>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="../components/footer.jsp" />

    <script src="${pageContext.request.contextPath}/views/js/script.js"></script>
</body>
</html>