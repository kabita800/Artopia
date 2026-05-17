package com.artopia1.user.controller;

import com.artopia1.user.model.dao.DashboardDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final DashboardDAO dashboardDAO = new DashboardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("totalUsers",    dashboardDAO.getTotalUsers());
        request.setAttribute("totalArtists",  dashboardDAO.getTotalArtists());
        request.setAttribute("totalBuyers",   dashboardDAO.getTotalBuyers());
        request.setAttribute("totalArtworks", dashboardDAO.getTotalArtworks());
        request.setAttribute("totalOrders",   dashboardDAO.getTotalOrders());
        request.setAttribute("totalRevenue",  dashboardDAO.getTotalRevenue());

        request.getRequestDispatcher("/views/admin/admin_dashboard.jsp")
                .forward(request, response);
    }
}