package com.artopia1.user.controller;

import com.artopia1.user.model.User;
import com.artopia1.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/manageUsers")
public class ManageUsersServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    // ── Load page ─────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String keyword = request.getParameter("search");

        List<User> users = (keyword != null && !keyword.isBlank())
                ? userDAO.searchUsers(keyword.trim())
                : userDAO.getAllUsers();

        request.setAttribute("users", users);
        request.setAttribute("search", keyword);

        request.getRequestDispatcher("/views/admin/manageUsers.jsp")
                .forward(request, response);
    }

    // ── Handle delete ─────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            try {
                int userId = Integer.parseInt(request.getParameter("id"));
                userDAO.deleteUser(userId);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/manageUsers");
    }
}