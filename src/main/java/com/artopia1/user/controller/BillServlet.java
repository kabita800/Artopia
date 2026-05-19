package com.artopia1.user.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // If there is no bill stored in session, redirect to home
        if (session == null || session.getAttribute("bill_orderId") == null) {
            response.sendRedirect(request.getContextPath() + "/gallery");
            return;
        }

        // Pass all bill attributes to the JSP
        request.setAttribute("bill_orderId",         session.getAttribute("bill_orderId"));
        request.setAttribute("bill_cart",            session.getAttribute("bill_cart"));
        request.setAttribute("bill_subtotal",        session.getAttribute("bill_subtotal"));
        request.setAttribute("bill_discountPercent", session.getAttribute("bill_discountPercent"));
        request.setAttribute("bill_discountAmount",  session.getAttribute("bill_discountAmount"));
        request.setAttribute("bill_tax",             session.getAttribute("bill_tax"));
        request.setAttribute("bill_total",           session.getAttribute("bill_total"));
        request.setAttribute("bill_promoCode",       session.getAttribute("bill_promoCode"));
        request.setAttribute("bill_buyerName",       session.getAttribute("bill_buyerName"));
        request.setAttribute("bill_buyerEmail",      session.getAttribute("bill_buyerEmail"));
        request.setAttribute("bill_timestamp",       session.getAttribute("bill_timestamp"));

        // Clear bill data from session after reading (one-time display)
        session.removeAttribute("bill_orderId");
        session.removeAttribute("bill_cart");
        session.removeAttribute("bill_subtotal");
        session.removeAttribute("bill_discountPercent");
        session.removeAttribute("bill_discountAmount");
        session.removeAttribute("bill_tax");
        session.removeAttribute("bill_total");
        session.removeAttribute("bill_promoCode");
        session.removeAttribute("bill_buyerName");
        session.removeAttribute("bill_buyerEmail");
        session.removeAttribute("bill_timestamp");

        request.getRequestDispatcher("/views/buyer/bill.jsp").forward(request, response);
    }
}
