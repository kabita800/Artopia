package com.artopia1.user.controller;

import com.artopia1.user.model.Art;
import com.artopia1.user.model.dao.ArtDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final ArtDAO artDAO = new ArtDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Art> cart = (List<Art>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
        }

        double subtotal = 0;
        for (Art art : cart) {
            subtotal += art.getPrice();
        }

        request.setAttribute("cart", cart);
        request.setAttribute("subtotal", subtotal);

        request.getRequestDispatcher("/views/buyer/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        List<Art> cart = (List<Art>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        if ("add".equalsIgnoreCase(action)) {
            try {
                int artId = Integer.parseInt(request.getParameter("id"));
                // Check if already in cart
                boolean exists = cart.stream().anyMatch(a -> a.getId() == artId);
                if (!exists) {
                    Art art = artDAO.findByIdAdmin(artId); // using this to just find by id
                    if (art != null) {
                        cart.add(art);
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("remove".equalsIgnoreCase(action)) {
            try {
                int artId = Integer.parseInt(request.getParameter("id"));
                Iterator<Art> iterator = cart.iterator();
                while (iterator.hasNext()) {
                    if (iterator.next().getId() == artId) {
                        iterator.remove();
                        break;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("clear".equalsIgnoreCase(action)) {
            cart.clear();
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
