package com.artopia1.user.filter;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(jakarta.servlet.ServletRequest req,
                         jakarta.servlet.ServletResponse res,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getRequestURI();
        HttpSession session = request.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        // Allow public pages (login/register/css/js)
        if (path.contains("login.jsp") ||
                path.contains("register.jsp") ||
                path.contains("Style.css") ||
                path.contains("App.js") ||
                path.contains("user-auth")) {

            chain.doFilter(req, res);
            return;
        }

        // If not logged in → redirect to login
        if (!loggedIn) {
            response.sendRedirect("views/login.jsp");
            return;
        }

        chain.doFilter(req, res);
    }
}