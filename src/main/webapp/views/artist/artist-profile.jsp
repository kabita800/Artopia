<%-- 
   ARTIST PROFILE PAGE - Edit profile information
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artist Profile - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="../components/navbar.jsp" />

    <main>
        <!-- Header -->
        <section style="background-color: var(--bg-light); padding: var(--spacing-lg) 0; border-bottom: 1px solid var(--border-color);">
            <div class="container">
                <h1 style="margin: 0;">Artist Profile</h1>
                <p class="text-muted" style="margin: 0.5rem 0 0;">Manage your public profile and settings</p>
            </div>
        </section>

        <!-- Profile Content -->
        <section>
            <div class="container-sm">
                <div class="grid grid-2" style="gap: var(--spacing-xl);">
                    <!-- Profile Form -->
                    <div>
                        <div class="card">
                            <div class="card-body" style="padding: var(--spacing-lg);">
                                <h2 style="margin-top: 0;">Profile Information</h2>

                                <form method="POST" action="${pageContext.request.contextPath}/artist-profile-update" enctype="multipart/form-data">
                                    <!-- Profile Picture -->
                                    <div class="form-group">
                                        <label>Profile Picture</label>
                                        <div style="margin-bottom: var(--spacing-md);">
                                            <img src="https://via.placeholder.com/150" alt="Profile" 
                                                 style="width: 150px; height: 150px; border-radius: 8px; object-fit: cover;">
                                        </div>
                                        <input type="file" name="profilePicture" accept="image/*">
                                    </div>

                                    <!-- Name -->
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="firstName">First Name</label>
                                            <input type="text" id="firstName" name="firstName" value="John" required>
                                        </div>
                                        <div class="form-group">
                                            <label for="lastName">Last Name</label>
                                            <input type="text" id="lastName" name="lastName" value="Doe" required>
                                        </div>
                                    </div>

                                    <!-- Artist Name -->
                                    <div class="form-group">
                                        <label for="artistName">Artist Name</label>
                                        <input type="text" id="artistName" name="artistName" value="John Doe Art Studio" required>
                                    </div>

                                    <!-- Email -->
                                    <div class="form-group">
                                        <label for="email">Email Address</label>
                                        <input type="email" id="email" name="email" value="john@example.com" required>
                                    </div>

                                    <!-- Bio -->
                                    <div class="form-group">
                                        <label for="bio">Bio</label>
                                        <textarea id="bio" name="bio" placeholder="Tell buyers about yourself...">A passionate artist with 10 years of experience in oil painting and contemporary art.</textarea>
                                    </div>

                                    <!-- Location -->
                                    <div class="form-row">
                                        <div class="form-group">
                                            <label for="country">Country</label>
                                            <input type="text" id="country" name="country" value="United States">
                                        </div>
                                        <div class="form-group">
                                            <label for="city">City</label>
                                            <input type="text" id="city" name="city" value="New York">
                                        </div>
                                    </div>

                                    <!-- Website -->
                                    <div class="form-group">
                                        <label for="website">Personal Website</label>
                                        <input type="url" id="website" name="website" placeholder="https://yourwebsite.com">
                                    </div>

                                    <!-- Social Media -->
                                    <div class="form-group">
                                        <label for="instagram">Instagram</label>
                                        <input type="text" id="instagram" name="instagram" placeholder="@yourhandle" value="@johndoeart">
                                    </div>

                                    <div class="form-group">
                                        <label for="twitter">Twitter</label>
                                        <input type="text" id="twitter" name="twitter" placeholder="@yourhandle">
                                    </div>

                                    <button type="submit" class="btn btn-primary btn-large btn-block" style="margin-top: var(--spacing-lg);">
                                        Save Changes
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>

                    <!-- Settings -->
                    <div>
                        <div class="card" style="margin-bottom: var(--spacing-lg);">
                            <div class="card-body" style="padding: var(--spacing-lg);">
                                <h3 style="margin-top: 0;">Privacy & Notifications</h3>

                                <form method="POST" action="${pageContext.request.contextPath}/artist-settings-update">
                                    <!-- Public Profile -->
                                    <div style="margin-bottom: var(--spacing-md);">
                                        <label style="display: flex; gap: 0.5rem; align-items: center;">
                                            <input type="checkbox" name="publicProfile" checked>
                                            <span>Make my profile public</span>
                                        </label>
                                        <small class="text-muted" style="display: block; margin-top: 0.25rem;">Allow other users to see your gallery and profile</small>
                                    </div>

                                    <!-- Allow Messages -->
                                    <div style="margin-bottom: var(--spacing-md);">
                                        <label style="display: flex; gap: 0.5rem; align-items: center;">
                                            <input type="checkbox" name="allowMessages" checked>
                                            <span>Allow direct messages from buyers</span>
                                        </label>
                                    </div>

                                    <!-- Email Notifications -->
                                    <div style="margin-bottom: var(--spacing-md);">
                                        <label style="display: flex; gap: 0.5rem; align-items: center;">
                                            <input type="checkbox" name="emailOnSale" checked>
                                            <span>Email me on new sales</span>
                                        </label>
                                    </div>

                                    <!-- Weekly Digest -->
                                    <div style="margin-bottom: var(--spacing-lg);">
                                        <label style="display: flex; gap: 0.5rem; align-items: center;">
                                            <input type="checkbox" name="weeklyDigest" checked>
                                            <span>Send weekly sales digest</span>
                                        </label>
                                    </div>

                                    <button type="submit" class="btn btn-primary btn-block">
                                        Update Settings
                                    </button>
                                </form>
                            </div>
                        </div>

                        <!-- Danger Zone -->
                        <div class="card">
                            <div class="card-body" style="padding: var(--spacing-lg); border: 1px solid #dc3545; border-radius: 8px;">
                                <h3 style="margin-top: 0; color: #dc3545;">Danger Zone</h3>

                                <button type="button" class="btn btn-danger btn-block" onclick="if(confirm('Are you sure? This action cannot be undone.')) { location.href='${pageContext.request.contextPath}/delete-account'; }">
                                    Delete Account
                                </button>

                                <small class="text-muted" style="display: block; margin-top: 0.5rem;">
                                    Permanently delete your account and all associated data.
                                </small>
                            </div>
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