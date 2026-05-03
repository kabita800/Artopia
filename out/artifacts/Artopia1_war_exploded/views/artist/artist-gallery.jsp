<%-- 
   ARTIST GALLERY PAGE - Manage artworks (Add, Edit, Delete, View)
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Gallery - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />

    <main>
        <!-- Header -->
        <section style="background-color: var(--bg-light); padding: var(--spacing-lg) 0; border-bottom: 1px solid var(--border-color);">
            <div class="container">
                <div style="display: flex; justify-content: space-between; align-items: center;">
                    <div>
                        <h1 style="margin: 0;">My Gallery</h1>
                        <p class="text-muted" style="margin: 0.5rem 0 0;">Manage and showcase your artworks</p>
                    </div>
                    <button class="btn btn-secondary" onclick="Modal.open('#addArtModal')">
                        + Add Artwork
                    </button>
                </div>
            </div>
        </section>

        <!-- Gallery Grid -->
        <section>
            <div class="container">
                <div class="gallery-grid">
                    <!-- Art Card 1 -->
                    <div class="card">
                        <img src="https://via.placeholder.com/280x250?text=Sunset+Dreams" alt="Sunset Dreams" class="card-image">
                        <div class="card-body">
                            <h3 class="card-title">Sunset Dreams</h3>
                            <p class="card-text">Oil on canvas, abstract landscape artwork</p>
                            <div class="card-price">$150.00</div>
                            <p class="text-muted" style="font-size: 0.9rem;">12 views • Sold 2</p>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-small btn-outline" onclick="Modal.open('#editArtModal')">✏ Edit</button>
                            <button class="btn btn-small btn-danger">🗑 Delete</button>
                        </div>
                    </div>

                    <!-- Art Card 2 -->
                    <div class="card">
                        <img src="https://via.placeholder.com/280x250?text=Ocean+Serenity" alt="Ocean Serenity" class="card-image">
                        <div class="card-body">
                            <h3 class="card-title">Ocean Serenity</h3>
                            <p class="card-text">Watercolor painting, calming seascape</p>
                            <div class="card-price">$120.00</div>
                            <p class="text-muted" style="font-size: 0.9rem;">8 views • Sold 1</p>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-small btn-outline" onclick="Modal.open('#editArtModal')">✏ Edit</button>
                            <button class="btn btn-small btn-danger">🗑 Delete</button>
                        </div>
                    </div>

                    <!-- Art Card 3 -->
                    <div class="card">
                        <img src="https://via.placeholder.com/280x250?text=Abstract+Vision" alt="Abstract Vision" class="card-image">
                        <div class="card-body">
                            <h3 class="card-title">Abstract Vision</h3>
                            <p class="card-text">Digital art, modern abstract design</p>
                            <div class="card-price">$200.00</div>
                            <p class="text-muted" style="font-size: 0.9rem;">15 views • Sold 3</p>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-small btn-outline" onclick="Modal.open('#editArtModal')">✏ Edit</button>
                            <button class="btn btn-small btn-danger">🗑 Delete</button>
                        </div>
                    </div>

                    <!-- Art Card 4 -->
                    <div class="card">
                        <img src="https://via.placeholder.com/280x250?text=Forest+Mystery" alt="Forest Mystery" class="card-image">
                        <div class="card-body">
                            <h3 class="card-title">Forest Mystery</h3>
                            <p class="card-text">Acrylic on canvas, nature landscape</p>
                            <div class="card-price">$180.00</div>
                            <p class="text-muted" style="font-size: 0.9rem;">5 views • Sold 1</p>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-small btn-outline" onclick="Modal.open('#editArtModal')">✏ Edit</button>
                            <button class="btn btn-small btn-danger">🗑 Delete</button>
                        </div>
                    </div>

                    <!-- Art Card 5 -->
                    <div class="card">
                        <img src="https://via.placeholder.com/280x250?text=City+Lights" alt="City Lights" class="card-image">
                        <div class="card-body">
                            <h3 class="card-title">City Lights</h3>
                            <p class="card-text">Photography, urban night scene</p>
                            <div class="card-price">$95.00</div>
                            <p class="text-muted" style="font-size: 0.9rem;">22 views • Sold 4</p>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-small btn-outline" onclick="Modal.open('#editArtModal')">✏ Edit</button>
                            <button class="btn btn-small btn-danger">🗑 Delete</button>
                        </div>
                    </div>

                    <!-- Art Card 6 -->
                    <div class="card">
                        <img src="https://via.placeholder.com/280x250?text=Eternal+Beauty" alt="Eternal Beauty" class="card-image">
                        <div class="card-body">
                            <h3 class="card-title">Eternal Beauty</h3>
                            <p class="card-text">Charcoal drawing, portrait study</p>
                            <div class="card-price">$175.00</div>
                            <p class="text-muted" style="font-size: 0.9rem;">18 views • Sold 2</p>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-small btn-outline" onclick="Modal.open('#editArtModal')">✏ Edit</button>
                            <button class="btn btn-small btn-danger">🗑 Delete</button>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- Modal: Add Artwork -->
    <div id="addArtModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Add New Artwork</h2>
                <button type="button" class="modal-close">&times;</button>
            </div>
            <div class="modal-body">
                <form method="POST" action="${pageContext.request.contextPath}/art-add" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="title">Artwork Title</label>
                        <input type="text" id="title" name="title" placeholder="Enter artwork title" required>
                    </div>

                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" placeholder="Describe your artwork..."></textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="price">Price ($)</label>
                            <input type="number" id="price" name="price" step="0.01" placeholder="0.00" required>
                        </div>

                        <div class="form-group">
                            <label for="category">Category</label>
                            <select id="category" name="category" required>
                                <option value="">-- Select --</option>
                                <option value="painting">Painting</option>
                                <option value="digital">Digital Art</option>
                                <option value="photography">Photography</option>
                                <option value="sculpture">Sculpture</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="image">Upload Image</label>
                        <input type="file" id="image" name="image" accept="image/*" required>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline" onclick="Modal.close('#addArtModal')">Cancel</button>
                        <button type="submit" class="btn btn-primary">Add Artwork</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal: Edit Artwork -->
    <div id="editArtModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h2>Edit Artwork</h2>
                <button type="button" class="modal-close">&times;</button>
            </div>
            <div class="modal-body">
                <form method="POST" action="${pageContext.request.contextPath}/art-update" enctype="multipart/form-data">
                    <div class="form-group">
                        <label for="editTitle">Artwork Title</label>
                        <input type="text" id="editTitle" name="title" value="Sunset Dreams" required>
                    </div>

                    <div class="form-group">
                        <label for="editDescription">Description</label>
                        <textarea id="editDescription" name="description">Oil on canvas, abstract landscape artwork</textarea>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="editPrice">Price ($)</label>
                            <input type="number" id="editPrice" name="price" step="0.01" value="150.00" required>
                        </div>

                        <div class="form-group">
                            <label for="editCategory">Category</label>
                            <select id="editCategory" name="category" required>
                                <option value="painting" selected>Painting</option>
                                <option value="digital">Digital Art</option>
                                <option value="photography">Photography</option>
                                <option value="sculpture">Sculpture</option>
                                <option value="other">Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-outline" onclick="Modal.close('#editArtModal')">Cancel</button>
                        <button type="submit" class="btn btn-primary">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <jsp:include page="../components/footer.jsp" />

    <script src="${pageContext.request.contextPath}/views/js/script.js"></script>
</body>
</html>