package com.artopia1.user.controller;

import com.artopia1.user.model.Art;
import com.artopia1.user.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // ── GET: Show the checkout / invoice preview page ────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Redirect to cart if cart is empty
        List<Art> cart = (List<Art>) session.getAttribute("cart");
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Redirect to login if not logged in
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Calculate totals
        double subtotal = 0;
        for (Art art : cart) {
            subtotal += art.getPrice();
        }

        double discountPercent = session.getAttribute("discountPercent") != null
                ? (double) session.getAttribute("discountPercent") : 0.0;
        String promoCode = session.getAttribute("promoCode") != null
                ? (String) session.getAttribute("promoCode") : "";

        double discountAmount = subtotal * discountPercent;
        double subtotalAfterDiscount = subtotal - discountAmount;
        double tax = subtotalAfterDiscount * 0.09;
        double total = subtotalAfterDiscount + tax;

        // Generate a stable order ID for this checkout session
        String orderId = (String) session.getAttribute("pendingOrderId");
        if (orderId == null) {
            orderId = "ART-" + String.format("%05d", (int)(Math.random() * 90000) + 10000);
            session.setAttribute("pendingOrderId", orderId);
        }

        request.setAttribute("cart", cart);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("discountPercent", discountPercent);
        request.setAttribute("discountAmount", discountAmount);
        request.setAttribute("tax", tax);
        request.setAttribute("total", total);
        request.setAttribute("orderId", orderId);
        request.setAttribute("promoCode", promoCode);
        request.setAttribute("user", user);

        request.getRequestDispatcher("/views/buyer/checkout.jsp").forward(request, response);
    }

    // ── POST: Confirm payment → store bill → clear cart → redirect to bill ──
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        List<Art> cart = (List<Art>) session.getAttribute("cart");
        User user = (User) session.getAttribute("user");

        if (cart == null || cart.isEmpty() || user == null) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // Re-calculate totals
        double subtotal = 0;
        for (Art art : cart) subtotal += art.getPrice();

        double discountPercent = session.getAttribute("discountPercent") != null
                ? (double) session.getAttribute("discountPercent") : 0.0;
        String promoCode = session.getAttribute("promoCode") != null
                ? (String) session.getAttribute("promoCode") : "";

        double discountAmount   = subtotal * discountPercent;
        double subtotalAfterDisc = subtotal - discountAmount;
        double tax               = subtotalAfterDisc * 0.09;
        double total             = subtotalAfterDisc + tax;

        String orderId = session.getAttribute("pendingOrderId") != null
                ? (String) session.getAttribute("pendingOrderId")
                : "ART-" + String.format("%05d", (int)(Math.random() * 90000) + 10000);

        // Persist bill data in session so bill.jsp can display it
        session.setAttribute("bill_orderId",         orderId);
        session.setAttribute("bill_cart",            new ArrayList<>(cart));
        session.setAttribute("bill_subtotal",        subtotal);
        session.setAttribute("bill_discountPercent", discountPercent);
        session.setAttribute("bill_discountAmount",  discountAmount);
        session.setAttribute("bill_tax",             tax);
        session.setAttribute("bill_total",           total);
        session.setAttribute("bill_promoCode",       promoCode);
        session.setAttribute("bill_buyerName",       user.getName());
        session.setAttribute("bill_buyerEmail",      user.getEmail());
        session.setAttribute("bill_timestamp",       java.time.LocalDateTime.now()
                .format(java.time.format.DateTimeFormatter.ofPattern("MMM dd, yyyy  HH:mm")));

        // Clear cart and pending order state
        cart.clear();
        session.removeAttribute("pendingOrderId");
        session.removeAttribute("discountPercent");
        session.removeAttribute("promoCode");

        response.sendRedirect(request.getContextPath() + "/bill");
    }
}
