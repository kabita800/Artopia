<%-- 
   ARTIST LANDING PAGE
   Landing page for artists to learn about the marketplace
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>For Artists - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />

    <main>
        <!-- Hero Section -->
        <section class="hero">
            <div class="container">
                <h1>Showcase Your Art to the World</h1>
                <p>Join thousands of artists on Artopia and reach art enthusiasts globally. 
                   Sell your original artwork, prints, and digital art without commission fees.</p>
                <div class="hero-buttons">
                    <a href="artist-register.jsp" class="btn btn-primary btn-large">Get Started Free</a>
                    <a href="artist-login.jsp" class="btn btn-outline btn-large">Already Have an Account?</a>
                </div>
            </div>
        </section>

        <!-- Features Section -->
        <section>
            <div class="container">
                <h2 class="text-center mb-3">Why Choose Artopia?</h2>
                <div class="grid grid-3">
                    <!-- Feature 1 -->
                    <div class="card">
                        <div class="card-body">
                            <h3>🎨 Easy Upload</h3>
                            <p>Upload your artwork in minutes. Simple interface, powerful tools to showcase your best work.</p>
                        </div>
                    </div>

                    <!-- Feature 2 -->
                    <div class="card">
                        <div class="card-body">
                            <h3>💰 Keep More Earnings</h3>
                            <p>No hidden fees. Set your own prices and keep 100% of your sales. We only take a small transaction fee.</p>
                        </div>
                    </div>

                    <!-- Feature 3 -->
                    <div class="card">
                        <div class="card-body">
                            <h3>🌍 Global Reach</h3>
                            <p>Reach millions of art enthusiasts worldwide. Your art displayed in front of people who appreciate it.</p>
                        </div>
                    </div>

                    <!-- Feature 4 -->
                    <div class="card">
                        <div class="card-body">
                            <h3>📊 Analytics</h3>
                            <p>Track your sales, views, and engagement. Data-driven insights to help grow your art business.</p>
                        </div>
                    </div>

                    <!-- Feature 5 -->
                    <div class="card">
                        <div class="card-body">
                            <h3>💬 Direct Messaging</h3>
                            <p>Connect with buyers directly. Discuss commissions, custom orders, and build lasting relationships.</p>
                        </div>
                    </div>

                    <!-- Feature 6 -->
                    <div class="card">
                        <div class="card-body">
                            <h3>📱 Mobile Friendly</h3>
                            <p>Your art looks stunning on all devices. Responsive design ensures perfect presentation everywhere.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- How It Works -->
        <section style="background-color: var(--bg-light);">
            <div class="container">
                <h2 class="text-center mb-3">How It Works</h2>
                <div class="grid grid-2" style="gap: 3rem; align-items: center;">
                    <div>
                        <h3>Step 1: Create Account</h3>
                        <p>Sign up for free and verify your email. Set up your artist profile with a bio and profile picture.</p>
                        <h3 style="margin-top: var(--spacing-lg);">Step 2: Add Artwork</h3>
                        <p>Upload high-quality images of your art with descriptions, pricing, and licensing information.</p>
                        <h3 style="margin-top: var(--spacing-lg);">Step 3: Manage & Sell</h3>
                        <p>Promote your work, respond to inquiries, and manage orders. Watch your sales grow!</p>
                    </div>
                    <div style="background-color: var(--primary-color); color: var(--secondary-color); padding: var(--spacing-lg); border-radius: 8px; min-height: 300px; display: flex; align-items: center; justify-content: center; font-size: 3rem;">
                        🎨 → 💻 → 💰
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA Section -->
        <section>
            <div class="container text-center">
                <h2>Ready to Start Selling Your Art?</h2>
                <p style="font-size: 1.1rem; max-width: 600px; margin: var(--spacing-lg) auto;">
                    Join our community of talented artists and turn your passion into profit. 
                    It's free to start and takes just a few minutes.
                </p>
                <a href="artist-register.jsp" class="btn btn-primary btn-large">Sign Up Now</a>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="../components/footer.jsp" />

    <script src="${pageContext.request.contextPath}/views/js/script.js"></script>
</body>
</html>