<%-- 
   ARTIST REGISTRATION PAGE
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artist Registration - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />

    <main>
        <section style="min-height: 100vh; padding: var(--spacing-xl) 0;">
            <div class="container-sm">
                <div class="card">
                    <div class="card-body" style="padding: var(--spacing-xl);">
                        <h1 class="text-center" style="margin-top: 0;">Join as Artist</h1>
                        <p class="text-center text-muted" style="margin-bottom: var(--spacing-lg);">
                            Create your free account and start selling your art
                        </p>

                        <!-- Alert Messages -->
                        <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-error">
                                <%= request.getParameter("error") %>
                            </div>
                        <% } %>
                        <% if (request.getParameter("success") != null) { %>
                            <div class="alert alert-success">
                                <%= request.getParameter("success") %>
                            </div>
                        <% } %>

                        <!-- Registration Form -->
                        <form id="registrationForm" method="POST" action="${pageContext.request.contextPath}/artist-register-handler">
                            <!-- Name -->
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" id="firstName" name="firstName" placeholder="John" required>
                                </div>

                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" placeholder="Doe" required>
                                </div>
                            </div>

                            <!-- Email -->
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" id="email" name="email" placeholder="your@email.com" required>
                            </div>

                            <!-- Artist Name -->
                            <div class="form-group">
                                <label for="artistName">Artist Name / Studio Name</label>
                                <input type="text" id="artistName" name="artistName" placeholder="Your artistic name" required>
                            </div>

                            <!-- Art Category -->
                            <div class="form-group">
                                <label for="category">Primary Art Category</label>
                                <select id="category" name="category" required>
                                    <option value="">-- Select Category --</option>
                                    <option value="painting">Painting</option>
                                    <option value="sculpture">Sculpture</option>
                                    <option value="digital">Digital Art</option>
                                    <option value="photography">Photography</option>
                                    <option value="illustration">Illustration</option>
                                    <option value="printmaking">Printmaking</option>
                                    <option value="other">Other</option>
                                </select>
                            </div>

                            <!-- Bio -->
                            <div class="form-group">
                                <label for="bio">Short Bio</label>
                                <textarea id="bio" name="bio" placeholder="Tell buyers about yourself..." maxlength="500"></textarea>
                                <small>Max 500 characters</small>
                            </div>

                            <!-- Password -->
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" id="password" name="password" placeholder="••••••••" required>
                                    <small>At least 6 characters</small>
                                </div>

                                <div class="form-group">
                                    <label for="confirmPassword">Confirm Password</label>
                                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="••••••••" required>
                                </div>
                            </div>

                            <!-- Terms -->
                            <div style="margin-bottom: var(--spacing-md);">
                                <label style="display: flex; align-items: flex-start; gap: 0.5rem;">
                                    <input type="checkbox" name="terms" required style="margin-top: 2px;">
                                    <span>
                                        I agree to the <a href="#">Terms of Service</a> and 
                                        <a href="#">Privacy Policy</a>
                                    </span>
                                </label>
                            </div>

                            <button type="submit" class="btn btn-primary btn-large btn-block">
                                Create Account
                            </button>

                            <p style="text-align: center; margin-top: var(--spacing-lg);">
                                Already have an account? 
                                <a href="artist-login.jsp" style="color: var(--accent-color); font-weight: 600;">
                                    Sign in here
                                </a>
                            </p>
                        </form>
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