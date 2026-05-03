<%-- 
   ARTIST HOME / DASHBOARD PAGE
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artist Dashboard - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />

    <main>
        <!-- Header -->
        <section style="background-color: var(--bg-light); padding: var(--spacing-lg) 0; border-bottom: 1px solid var(--border-color);">
            <div class="container">
                <h1 style="margin: 0;">Welcome back, John!</h1>
                <p class="text-muted">Here's your art marketplace dashboard</p>
            </div>
        </section>

        <!-- Featured Product -->
        <section>
            <div class="container">
                <h2>Featured Product</h2>
                <div class="card">
                    <div class="card-body" style="display:flex; gap: var(--spacing-lg); align-items:center; flex-wrap:wrap;">
                        <img src="https://images.unsplash.com/photo-1579783902614-a3fb3927b6a5?auto=format&fit=crop&w=900&q=80"
                             alt="Featured artwork"
                             style="width:100%; max-width:420px; border-radius:10px; object-fit:cover;">
                        <div style="flex:1; min-width:260px;">
                            <h3 style="margin-top:0;">Golden Horizon</h3>
                            <p class="text-muted">Acrylic on canvas by our featured artist of the week.</p>
                            <p style="font-size:1.35rem; font-weight:700; color: var(--accent-color); margin: 0.75rem 0;">$320.00</p>
                            <a href="artist-gallery.jsp" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Products -->
        <section style="background-color: var(--bg-light);">
            <div class="container">
                <h2>Products</h2>
                <div class="grid grid-3">
                    <div class="card">
                        <div class="card-body">
                            <img src="https://images.unsplash.com/photo-1578301978069-8f7ed8f63835?auto=format&fit=crop&w=700&q=80"
                                 alt="Artwork 1"
                                 style="width:100%; border-radius:8px; margin-bottom: var(--spacing-md); object-fit:cover;">
                            <h3 style="margin:0 0 0.5rem;">Mountain Silence</h3>
                            <p class="text-muted" style="margin:0 0 0.75rem;">Oil painting</p>
                            <p style="font-weight:700; color: var(--accent-color); margin:0;">$180.00</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <img src="https://images.unsplash.com/photo-1577083165633-14ebcdb0f658?auto=format&fit=crop&w=700&q=80"
                                 alt="Artwork 2"
                                 style="width:100%; border-radius:8px; margin-bottom: var(--spacing-md); object-fit:cover;">
                            <h3 style="margin:0 0 0.5rem;">Urban Pulse</h3>
                            <p class="text-muted" style="margin:0 0 0.75rem;">Mixed media</p>
                            <p style="font-weight:700; color: var(--accent-color); margin:0;">$210.00</p>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-body">
                            <img src="https://images.unsplash.com/photo-1547891654-e66ed7ebb968?auto=format&fit=crop&w=700&q=80"
                                 alt="Artwork 3"
                                 style="width:100%; border-radius:8px; margin-bottom: var(--spacing-md); object-fit:cover;">
                            <h3 style="margin:0 0 0.5rem;">Calm River</h3>
                            <p class="text-muted" style="margin:0 0 0.75rem;">Watercolor</p>
                            <p style="font-weight:700; color: var(--accent-color); margin:0;">$145.00</p>
                        </div>
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