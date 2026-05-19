package com.artopia1.user.controller;

import com.artopia1.user.model.Art;
import com.artopia1.user.model.dao.ArtDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/editArt")
public class EditArtServlet extends HttpServlet {

    private final ArtDAO artDAO = new ArtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Art art = artDAO.findByIdAdmin(id);
                if (art != null) {
                    request.setAttribute("editArt", art);
                    request.getRequestDispatcher("/views/admin/edit_art.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect(request.getContextPath() + "/admin/manageArts");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String category = request.getParameter("category");
            double price = Double.parseDouble(request.getParameter("price"));
            boolean isSold = request.getParameter("isSold") != null;

            artDAO.updateAdmin(id, title, description, category, price, null, isSold);

        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/admin/manageArts");
    }
}
