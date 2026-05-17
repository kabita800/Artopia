package com.artopia1.user.controller;

import com.artopia1.user.model.User;
import com.artopia1.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

// Handles authentication, registration, and logout operations
@WebServlet({"/user-auth", "/logout"})
public class UserServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Determine action from URL or parameter
        String action = request.getParameter("action");

        if ("/logout".equals(request.getServletPath())) {
            action = "logout";
        }

        // Handle logout request
        if ("logout".equalsIgnoreCase(action)) {

            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            // Clear user cookie
            Cookie cookie = new Cookie("userEmail", "");
            cookie.setMaxAge(0);
            response.addCookie(cookie);

            response.sendRedirect(request.getContextPath() + "/views/public/login.jsp?logout=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/views/public/login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html");

        String action = request.getParameter("action");
        UserDAO userDAO = new UserDAO();

        /* ================= REGISTER ================= */
        if ("register".equalsIgnoreCase(action)) {

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            if (role != null) {
                role = role.trim().toLowerCase();
            }

            User user = new User(name, email, password, role);

            boolean success = userDAO.registeruser(user);
            HttpSession sess = request.getSession();

            if (success) {
                sess.setAttribute("flashSuccess", "Account created successfully. You can sign in now.");
                response.sendRedirect(request.getContextPath() + "/views/public/login.jsp");
            } else {
                sess.setAttribute("flashError", "Registration failed due to invalid data or DB issue.");
                response.sendRedirect(request.getContextPath() + "/views/public/register.jsp?error=failed");
            }
        }

        /* ================= LOGIN ================= */
        else if ("login".equalsIgnoreCase(action)) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = userDAO.loginUser(email, password);

            if (user != null) {

                // Create session after successful login
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userRole", user.getRole() != null ? user.getRole().toLowerCase() : "");
                session.setAttribute("userName", user.getName());
                session.setMaxInactiveInterval(30 * 60);

                // Set welcome message
                session.setAttribute("flashSuccess", "Welcome back, " + user.getName());

                // Store email in cookie for convenience
                Cookie cookie = new Cookie("userEmail", user.getEmail());
                cookie.setMaxAge(24 * 60 * 60);
                response.addCookie(cookie);

                String role = user.getRole() != null ? user.getRole().toLowerCase() : "";

                // Role-based routing
                if ("artist".equals(role) || "buyer".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/views/shared/home.jsp");
                } else if ("admin".equals(role)) {
                    response.sendRedirect(request.getContextPath() + "/views/admin/admin_dashboard.jsp");
                } else {
                    response.sendRedirect(request.getContextPath() + "/views/public/landing.jsp");
                }

            } else {
                HttpSession sess = request.getSession();
                sess.setAttribute("flashError", "Invalid email or password.");
                response.sendRedirect(request.getContextPath() + "/views/public/login.jsp?error=invalid");
            }
        }

        /* ================= LOGOUT ================= */
        else if ("logout".equalsIgnoreCase(action) || "/logout".equals(request.getServletPath())) {

            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }

            Cookie cookie = new Cookie("userEmail", "");
            cookie.setMaxAge(0);
            response.addCookie(cookie);

            response.sendRedirect(request.getContextPath() + "/views/public/login.jsp?logout=1");
        }

        /* ================= DEFAULT ================= */
        else {
            response.sendRedirect(request.getContextPath() + "/views/public/login.jsp");
        }
    }
}