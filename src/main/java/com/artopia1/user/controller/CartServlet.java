package com.artopia1.user.controller;

import com.artopia1.user.model.Art;
import com.artopia1.user.model.dao.ArtDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
            session.removeAttribute("discountPercent");
            session.removeAttribute("promoCode");

        } else if ("applyPromo".equalsIgnoreCase(action)) {
            // Valid promo codes: code -> discount fraction
            Map<String, Double> validCodes = new HashMap<>();
            validCodes.put("ART10",    0.10);
            validCodes.put("ARTOPIA20", 0.20);

            String code = request.getParameter("promoCode");
            if (code != null) code = code.trim().toUpperCase();

            if (code != null && validCodes.containsKey(code)) {
                session.setAttribute("discountPercent", validCodes.get(code));
                session.setAttribute("promoCode", code);
            } else {
                session.removeAttribute("discountPercent");
                session.removeAttribute("promoCode");
            }
            // After storing promo, redirect straight to checkout
            response.sendRedirect(request.getContextPath() + "/checkout");
            return;
        }

        response.sendRedirect(request.getContextPath() + "/cart");
    }
}
