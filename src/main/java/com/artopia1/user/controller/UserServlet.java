package com.artopia1.user.controller;

import com.artopia1.user.model.User;
import com.artopia1.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/user-auth")
public class UserServlet extends HttpServlet {

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

            User user = new User(name, email, password, role);

            boolean success = userDAO.registeruser(user);

            if (success) {
                response.sendRedirect("views/login.jsp");
            } else {
                response.sendRedirect("views/register.jsp?error=failed");
            }
        }

        /* ================= LOGIN ================= */
        else if ("login".equalsIgnoreCase(action)) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = userDAO.loginUser(email, password);

            if (user != null) {

                // CREATE SESSION
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(30 * 60); // 30 min

                // OPTIONAL COOKIE
                Cookie cookie = new Cookie("userEmail", user.getEmail());
                cookie.setMaxAge(24 * 60 * 60);
                response.addCookie(cookie);

                // Send users to app root (index forwards to artist dashboard)
                response.sendRedirect(request.getContextPath() + "/");

            } else {
                response.sendRedirect("views/login.jsp?error=invalid");
            }
        }

        /* ================= LOGOUT ================= */
        else if ("logout".equalsIgnoreCase(action)) {

            HttpSession session = request.getSession(false);

            if (session != null) {
                session.invalidate();
            }

            Cookie cookie = new Cookie("userEmail", "");
            cookie.setMaxAge(0);
            response.addCookie(cookie);

            response.sendRedirect("views/login.jsp");
        }

        /* ================= DEFAULT ================= */
        else {
            response.sendRedirect("views/login.jsp");
        }
    }
}