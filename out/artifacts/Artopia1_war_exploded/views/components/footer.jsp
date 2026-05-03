<%-- ================================================================
   FOOTER COMPONENT - Reusable Footer
   Include in all pages: <jsp:include page="../components/footer.jsp" />
   ================================================================ --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer>
    <div class="container">
        <div class="footer-content">
            <!-- About Section -->
            <div class="footer-section">
                <h4>About Artopia</h4>
                <p>Artopia is a vibrant marketplace connecting artists with art enthusiasts worldwide. 
                   Discover unique artworks and support independent artists.</p>
            </div>

            <!-- Quick Links -->
            <div class="footer-section">
                <h4>Quick Links</h4>
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/views/about.jsp">About Us</a>
                <a href="${pageContext.request.contextPath}/views/contact.jsp">Contact</a>
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
            </div>

            <!-- For Artists -->
            <div class="footer-section">
                <h4>For Artists</h4>
                <a href="${pageContext.request.contextPath}/artist/artist-landing.jsp">Get Started</a>
                <a href="#">How to Sell</a>
                <a href="#">Commission Guidelines</a>
                <a href="#">Artist Support</a>
            </div>

            <!-- For Buyers -->
            <div class="footer-section">
                <h4>For Buyers</h4>
                <a href="${pageContext.request.contextPath}/buyer/buyer-landing.jsp">Browse Art</a>
                <a href="#">Find Artists</a>
                <a href="#">How to Buy</a>
                <a href="#">Payment Options</a>
            </div>

            <!-- Contact Section -->
            <div class="footer-section">
                <h4>Contact Us</h4>
                <p>Email: <a href="mailto:hello@artopia.com">hello@artopia.com</a></p>
                <p>Phone: <a href="tel:+1234567890">+1 (234) 567-890</a></p>
                <p>Address: 123 Art Street, Creative City, CC 12345</p>
            </div>
        </div>

        <!-- Footer Bottom -->
        <div class="footer-bottom">
            <p>&copy; 2026 Artopia Marketplace. All rights reserved. | 
               <a href="#">Privacy</a> | 
               <a href="#">Terms</a> | 
               <a href="#">Cookies</a>
            </p>
        </div>
    </div>
</footer>