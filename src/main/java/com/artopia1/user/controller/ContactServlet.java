package com.artopia1.user.controller;

import com.artopia1.user.model.dao.ContactDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

// Handles contact form submission from users
@WebServlet("/contact-handler")
public class ContactServlet extends HttpServlet {

    // DAO layer for saving contact messages to database
    private final ContactDAO contactDAO = new ContactDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // Read and sanitize input fields
        String first = trim(request.getParameter("firstName"));
        String last = trim(request.getParameter("lastName"));
        String email = trim(request.getParameter("email"));
        String subject = trim(request.getParameter("subject"));
        String type = trim(request.getParameter("type"));
        String message = trim(request.getParameter("message"));

        // Validate required fields
        if (first.isEmpty() || last.isEmpty() || email.isEmpty()
                || subject.isEmpty() || type.isEmpty() || message.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/views/shared/contact.jsp?error=missing");
            return;
        }

        // Save message to database
        boolean saved = contactDAO.saveMessage(first, last, email, subject, type, message);

        // Redirect based on result
        if (saved) {
            response.sendRedirect(request.getContextPath() + "/views/shared/contact.jsp?success=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/shared/contact.jsp?error=server");
        }
    }

    // Utility method for safe string trimming
    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }
}