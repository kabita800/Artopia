<%-- 
   CONTACT PAGE - Contact form and information
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Us - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
</head>
<body>
    <!-- Navbar -->
    <jsp:include page="components/navbar.jsp" />

    <main>
        <!-- Hero -->
        <section class="hero">
            <div class="container">
                <h1>Get In Touch</h1>
                <p>Have questions? We'd love to hear from you. Contact us anytime.</p>
            </div>
        </section>

        <!-- Contact Content -->
        <section>
            <div class="container">
                <div class="grid grid-2" style="gap: var(--spacing-xl);">
                    <!-- Contact Form -->
                    <div>
                        <h2 style="margin-top: 0;">Send us a Message</h2>

                        <% if (request.getParameter("success") != null) { %>
                            <div class="alert alert-success">
                                Thank you! Your message has been sent. We'll get back to you soon.
                            </div>
                        <% } %>

                        <form method="POST" action="${pageContext.request.contextPath}/contact-handler">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="firstName">First Name</label>
                                    <input type="text" id="firstName" name="firstName" required>
                                </div>
                                <div class="form-group">
                                    <label for="lastName">Last Name</label>
                                    <input type="text" id="lastName" name="lastName" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" id="email" name="email" required>
                            </div>

                            <div class="form-group">
                                <label for="subject">Subject</label>
                                <input type="text" id="subject" name="subject" required>
                            </div>

                            <div class="form-group">
                                <label for="type">Type of Inquiry</label>
                                <select id="type" name="type" required>
                                    <option value="">-- Select --</option>
                                    <option value="artist">Artist Support</option>
                                    <option value="buyer">Buyer Support</option>
                                    <option value="technical">Technical Issue</option>
                                    <option value="partnership">Partnership Inquiry</option>
                                    <option value="other">Other</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="message">Message</label>
                                <textarea id="message" name="message" placeholder="Tell us what's on your mind..." required></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary btn-large">
                                Send Message
                            </button>
                        </form>
                    </div>

                    <!-- Contact Information -->
                    <div>
                        <h2 style="margin-top: 0;">Contact Information</h2>

                        <div style="margin-bottom: var(--spacing-lg);">
                            <h3 style="margin-top: 0;">Email</h3>
                            <p>
                                General: <a href="mailto:hello@artopia.com">hello@artopia.com</a><br>
                                Support: <a href="mailto:support@artopia.com">support@artopia.com</a><br>
                                Artists: <a href="mailto:artists@artopia.com">artists@artopia.com</a><br>
                                Partners: <a href="mailto:partners@artopia.com">partners@artopia.com</a>
                            </p>
                        </div>

                        <div style="margin-bottom: var(--spacing-lg);">
                            <h3>Phone</h3>
                            <p>
                                <a href="tel:+1234567890">+1 (234) 567-890</a><br>
                                <small>Monday - Friday, 9AM - 6PM EST</small>
                            </p>
                        </div>

                        <div style="margin-bottom: var(--spacing-lg);">
                            <h3>Address</h3>
                            <p>
                                Artopia Inc.<br>
                                123 Art Street<br>
                                Creative City, CC 12345<br>
                                United States
                            </p>
                        </div>

                        <div style="margin-bottom: var(--spacing-lg);">
                            <h3>Office Hours</h3>
                            <p>
                                Monday - Friday: 9:00 AM - 6:00 PM<br>
                                Saturday: 10:00 AM - 4:00 PM<br>
                                Sunday: Closed
                            </p>
                        </div>

                        <div style="background-color: var(--bg-light); padding: var(--spacing-lg); border-radius: 8px;">
                            <h3 style="margin-top: 0;">Follow Us</h3>
                            <p>
                                <a href="https://twitter.com/artopia" style="margin-right: 1rem;">Twitter</a>
                                <a href="https://instagram.com/artopia" style="margin-right: 1rem;">Instagram</a>
                                <a href="https://facebook.com/artopia" style="margin-right: 1rem;">Facebook</a>
                                <a href="https://youtube.com/artopia">YouTube</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- FAQ Section -->
        <section style="background-color: var(--bg-light);">
            <div class="container-sm">
                <h2 class="text-center mb-3">Frequently Asked Questions</h2>

                <div style="display: flex; flex-direction: column; gap: var(--spacing-md);">
                    <!-- FAQ Item -->
                    <details style="padding: var(--spacing-md); background-color: white; border-radius: 8px; border: 1px solid var(--border-color);">
                        <summary style="cursor: pointer; font-weight: 600;">How long does it take to get approved as an artist?</summary>
                        <p style="margin: var(--spacing-md) 0 0;">Typically within 24-48 hours. We review applications and verify authenticity.</p>
                    </details>

                    <!-- FAQ Item -->
                    <details style="padding: var(--spacing-md); background-color: white; border-radius: 8px; border: 1px solid var(--border-color);">
                        <summary style="cursor: pointer; font-weight: 600;">What payment methods do you accept?</summary>
                        <p style="margin: var(--spacing-md) 0 0;">We accept credit cards, debit cards, PayPal, and bank transfers.</p>
                    </details>

                    <!-- FAQ Item -->
                    <details style="padding: var(--spacing-md); background-color: white; border-radius: 8px; border: 1px solid var(--border-color);">
                        <summary style="cursor: pointer; font-weight: 600;">How do you handle shipping?</summary>
                        <p style="margin: var(--spacing-md) 0 0;">Artists handle shipping directly with buyers. We recommend insured shipping for valuable pieces.</p>
                    </details>

                    <!-- FAQ Item -->
                    <details style="padding: var(--spacing-md); background-color: white; border-radius: 8px; border: 1px solid var(--border-color);">
                        <summary style="cursor: pointer; font-weight: 600;">What's your return policy?</summary>
                        <p style="margin: var(--spacing-md) 0 0;">Return policies are set by individual artists. Check the artwork listing for details.</p>
                    </details>

                    <!-- FAQ Item -->
                    <details style="padding: var(--spacing-md); background-color: white; border-radius: 8px; border: 1px solid var(--border-color);">
                        <summary style="cursor: pointer; font-weight: 600;">How can I report inappropriate content?</summary>
                        <p style="margin: var(--spacing-md) 0 0;">Use the report button on any listing. Our moderation team reviews reports within 48 hours.</p>
                    </details>
                </div>
            </div>
        </section>
    </main>

    <!-- Footer -->
    <jsp:include page="components/footer.jsp" />

    <script src="${pageContext.request.contextPath}/views/js/script.js"></script>
</body>
</html>