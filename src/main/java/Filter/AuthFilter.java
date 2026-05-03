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

        String path = request.getRequestURI().substring(request.getContextPath().length());
        HttpSession session = request.getSession(false);

        boolean loggedIn = (session != null && session.getAttribute("user") != null);

        if (isPublicPath(path)) {

            chain.doFilter(req, res);
            return;
        }

        // If not logged in → redirect to login
        if (!loggedIn) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }

        chain.doFilter(req, res);
    }

    private boolean isPublicPath(String path) {
        return "/".equals(path)
                || "/index.jsp".equals(path)
                || "/views/dashboard.jsp".equals(path)
            || "/views/artist/artist-home.jsp".equals(path)
                || "/views/login.jsp".equals(path)
                || "/views/register.jsp".equals(path)
                || "/views/about.jsp".equals(path)
                || "/views/contact.jsp".equals(path)
                || "/views/artist/artist-landing.jsp".equals(path)
                || "/views/artist/artist-login.jsp".equals(path)
                || "/views/artist/artist-register.jsp".equals(path)
                || "/user-auth".equals(path)
                || path.startsWith("/views/css/")
                || path.startsWith("/views/js/")
                || path.endsWith(".css")
                || path.endsWith(".js")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".gif")
                || path.endsWith(".svg");
    }
}