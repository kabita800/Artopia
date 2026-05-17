package com.artopia1.user.controller;

import com.artopia1.user.model.Art;
import com.artopia1.user.model.dao.ArtDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

// Controller for buyer gallery view (shows available artworks)
@WebServlet("/buyer/gallery")
public class BuyerGalleryServlet extends HttpServlet {

    // DAO layer for fetching artwork data
    private final ArtDAO artDAO = new ArtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Create or get session for flash messages
        HttpSession session = request.getSession(true);

        // Retrieve flash messages (success/error)
        String flashOk = (String) session.getAttribute("buyerGalleryFlashOk");
        String flashErr = (String) session.getAttribute("buyerGalleryFlashErr");

        // Clear flash messages after reading (one-time display)
        session.removeAttribute("buyerGalleryFlashOk");
        session.removeAttribute("buyerGalleryFlashErr");

        // Fetch all available artworks for buyers
        List<Art> artworks = artDAO.findAvailableForBuyers();

        // Fetch distinct categories for filtering UI
        List<String> categories = artDAO.findDistinctCategories(true);

        // Send data to JSP view layer
        request.setAttribute("artworks", artworks);
        request.setAttribute("categories", categories);
        request.setAttribute("successMsg", flashOk);
        request.setAttribute("errorMsg", flashErr);

        // Forward request to buyer gallery page
        request.getRequestDispatcher("/views/buyer/gallery.jsp")
                .forward(request, response);
    }
}
