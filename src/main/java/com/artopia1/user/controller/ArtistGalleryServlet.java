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

    private final ArtDAO artDAO = new ArtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        CsrfUtil.ensureToken(session);

        String flashOk = (String) session.getAttribute("galleryFlashOk");
        String flashErr = (String) session.getAttribute("galleryFlashErr");
        session.removeAttribute("galleryFlashOk");
        session.removeAttribute("galleryFlashErr");

        List<Art> allArtworks = artDAO.findAllWithArtist();

        List<Art> myArtworks = Collections.emptyList();
        User user = (User) session.getAttribute("user");
        if (user != null && user.getId() > 0) {
            myArtworks = artDAO.findByArtistId(user.getId());
        }

        request.setAttribute("allArtworks", allArtworks);
        request.setAttribute("myArtworks", myArtworks);
        request.setAttribute("successMsg", flashOk);
        request.setAttribute("errorMsg", flashErr);

        request.getRequestDispatcher("/views/artist/gallery.jsp").forward(request, response);
    }
}
