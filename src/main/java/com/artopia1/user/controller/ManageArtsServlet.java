package com.artopia1.user.controller;

import com.artopia1.user.model.Art;
import com.artopia1.user.model.dao.ArtDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manageArts")
public class ManageArtsServlet extends HttpServlet {

    private final ArtDAO artDAO = new ArtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Art> arts = artDAO.findAllWithArtist();
        request.setAttribute("arts", arts);

        request.getRequestDispatcher("/views/admin/manage_art.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            try {
                int artId = Integer.parseInt(request.getParameter("id"));
                artDAO.deleteAdmin(artId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/manageArts");
    }
}

