<%-- 
   ABOUT PAGE - Information about Artopia marketplace
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Artopia - Art Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="components/navbar.jsp" />

    <main>
        <!-- Hero -->
        <section class="hero">
            <div class="container">
                <h1>About Artopia</h1>
                <p>Connecting artists with art enthusiasts worldwide</p>
            </div>
        </section>

        <!-- Story -->
        <section>
            <div class="container">
                <div class="grid grid-2" style="gap: var(--spacing-xl); align-items: center;">
                    <div>
                        <h2>Our Story</h2>
                        <p>Artopia was founded in 2020 with a simple mission: to create a platform where artists can thrive and art lovers can discover unique, authentic creations directly from creators.</p>
                        <p>We believe that every artist deserves a fair platform to showcase and monetize their work without unnecessary intermediaries or high commission fees.</p>
                        <p>Today, Artopia hosts thousands of talented artists from around the world, collectively serving millions of art enthusiasts.</p>
                    </div>
                    <div style="background-color: var(--bg-light); padding: var(--spacing-xl); border-radius: 8px; min-height: 300px; display: flex; align-items: center; justify-content: center; font-size: 4rem;">
                        🎨
                    </div>
                </div>
            </div>
        </section>

        <!-- Values -->
        <section style="background-color: var(--bg-light);">
            <div class="container">
                <h2 class="text-center mb-3">Our Values</h2>
                <div class="grid grid-3">
                    <div class="card">
                        <div class="card-body">
                            <h3>🎯 Artist-Centric</h3>
                            <p>We prioritize the needs of artists. Fair pricing, transparent policies, and full creative control.</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <h3>✨ Quality & Authenticity</h3>
                            <p>Every artwork is directly from the artist. No reproductions, no mass-produced items.</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <h3>🌍 Global Community</h3>
                            <p>Breaking geographical boundaries. Connecting artists and collectors across the globe.</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <h3>💪 Empowerment</h3>
                            <p>Providing tools and support to help artists succeed and grow their creative business.</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <h3>🔒 Trust & Safety</h3>
                            <p>Secure platform with buyer protection and transparent dispute resolution.</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <h3>🚀 Innovation</h3>
                            <p>Continuously improving with new features and tools to serve our community better.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Statistics -->
        <section>
            <div class="container">
                <h2 class="text-center mb-3">By The Numbers</h2>
                <div class="grid grid-4">
                    <div class="card text-center">
                        <div class="card-body">
                            <h3 style="color: var(--accent-color); font-size: 2rem; margin: 0;">15K+</h3>
                            <p style="margin: 0.5rem 0 0;">Active Artists</p>
                        </div>
                    </div>

                    <div class="card text-center">
                        <div class="card-body">
                            <h3 style="color: var(--accent-color); font-size: 2rem; margin: 0;">50K+</h3>
                            <p style="margin: 0.5rem 0 0;">Artworks Listed</p>
                        </div>
                    </div>

                    <div class="card text-center">
                        <div class="card-body">
                            <h3 style="color: var(--accent-color); font-size: 2rem; margin: 0;">200K+</h3>
                            <p style="margin: 0.5rem 0 0;">Registered Buyers</p>
                        </div>
                    </div>

                    <div class="card text-center">
                        <div class="card-body">
                            <h3 style="color: var(--accent-color); font-size: 2rem; margin: 0;">$5M+</h3>
                            <p style="margin: 0.5rem 0 0;">Total Sales</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Team (Optional) -->
        <section style="background-color: var(--bg-light);">
            <div class="container">
                <h2 class="text-center mb-3">Our Team</h2>
                <div class="grid grid-3">
                    <div class="card text-center">
                        <div style="width: 120px; height: 120px; margin: var(--spacing-lg) auto 0; border-radius: 50%; background-color: var(--primary-color); display: flex; align-items: center; justify-content: center; color: var(--secondary-color); font-size: 2rem;">👨‍💼</div>
                        <div class="card-body">
                            <h3>Alex Johnson</h3>
                            <p style="color: var(--accent-color); font-weight: 600;">Founder & CEO</p>
                            <p class="text-muted" style="font-size: 0.9rem;">Art entrepreneur with 15 years of industry experience</p>
                        </div>
                    </div>

                    <div class="card text-center">
                        <div style="width: 120px; height: 120px; margin: var(--spacing-lg) auto 0; border-radius: 50%; background-color: var(--primary-color); display: flex; align-items: center; justify-content: center; color: var(--secondary-color); font-size: 2rem;">👩‍💻</div>
                        <div class="card-body">
                            <h3>Sarah Mitchell</h3>
                            <p style="color: var(--accent-color); font-weight: 600;">Head of Product</p>
                            <p class="text-muted" style="font-size: 0.9rem;">Former designer, passionate about user experience</p>
                        </div>
                    </div>

                    <div class="card text-center">
                        <div style="width: 120px; height: 120px; margin: var(--spacing-lg) auto 0; border-radius: 50%; background-color: var(--primary-color); display: flex; align-items: center; justify-content: center; color: var(--secondary-color); font-size: 2rem;">👨‍🎓</div>
                        <div class="card-body">
                            <h3>Mike Chen</h3>
                            <p style="color: var(--accent-color); font-weight: 600;">Community Lead</p>
                            <p class="text-muted" style="font-size: 0.9rem;">Artist and art community advocate since 2008</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />

    <script src="${pageContext.request.contextPath}/views/js/script.js"></script>
</body>
</html>