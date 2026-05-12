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

@WebServlet("/buyer/gallery")
public class BuyerGalleryServlet extends HttpServlet {

    private final ArtDAO artDAO = new ArtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String flashOk = (String) session.getAttribute("buyerGalleryFlashOk");
        String flashErr = (String) session.getAttribute("buyerGalleryFlashErr");
        session.removeAttribute("buyerGalleryFlashOk");
        session.removeAttribute("buyerGalleryFlashErr");

        List<Art> artworks = artDAO.findAvailableForBuyers();
        List<String> categories = artDAO.findDistinctCategories(true);

        request.setAttribute("artworks", artworks);
        request.setAttribute("categories", categories);
        request.setAttribute("successMsg", flashOk);
        request.setAttribute("errorMsg", flashErr);

        request.getRequestDispatcher("/views/buyer/gallery.jsp").forward(request, response);
    }
}
