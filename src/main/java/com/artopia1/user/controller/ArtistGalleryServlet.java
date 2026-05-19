package com.artopia1.user.controller;

import com.artopia1.user.model.Art;
import com.artopia1.user.model.User;
import com.artopia1.user.model.dao.ArtDAO;
import com.artopia1.utils.CsrfUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/artist/gallery")
public class ArtistGalleryServlet extends HttpServlet {

    // DAO object for artwork database operations
    private final ArtDAO artDAO = new ArtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create session if not already available
        HttpSession session = request.getSession(true);

        // Ensure CSRF token exists for security
        CsrfUtil.ensureToken(session);

        // Retrieve success and error flash messages
        String flashOk = (String) session.getAttribute("galleryFlashOk");
        String flashErr = (String) session.getAttribute("galleryFlashErr");

        // Remove flash messages after displaying once
        session.removeAttribute("galleryFlashOk");
        session.removeAttribute("galleryFlashErr");

        // Fetch all artworks from database
        List<Art> allArtworks = artDAO.findAllWithArtist();

        // Initialize empty artwork list for current user
        List<Art> myArtworks = Collections.emptyList();

        // Get logged-in user from session
        User user = (User) session.getAttribute("user");

        // Fetch artworks uploaded by current artist
        if (user != null && user.getId() > 0) {
            myArtworks = artDAO.findByArtistId(user.getId());
        }

        // Set attributes for JSP page
        request.setAttribute("allArtworks", allArtworks);
        request.setAttribute("myArtworks", myArtworks);
        request.setAttribute("successMsg", flashOk);
        request.setAttribute("errorMsg", flashErr);

        // TODO: Add pagination for better performance

        // Forward request to gallery page
        request.getRequestDispatcher("/views/artist/gallery.jsp")
                .forward(request, response);
    }
}