package com.artopia1.filter;

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

        if (!loggedIn) {
            response.sendRedirect(request.getContextPath() + "/views/public/login.jsp");
            return;
        }

        if (path.startsWith("/views/admin/")) {
            String role = session != null ? (String) session.getAttribute("userRole") : "";
            if (!"admin".equalsIgnoreCase(role)) {
                response.sendRedirect(request.getContextPath() + "/views/shared/home.jsp");
                return;
            }
        }

        chain.doFilter(req, res);
    }

    private boolean isPublicPath(String path) {
        return "/".equals(path)
                || "/index.jsp".equals(path)

                || "/views/public/landing.jsp".equals(path)
                || "/views/public/login.jsp".equals(path)
                || "/views/public/register.jsp".equals(path)

                || "/views/shared/home.jsp".equals(path)
                || "/views/shared/artist.jsp".equals(path)
                || "/views/shared/about.jsp".equals(path)
                || "/views/shared/contact.jsp".equals(path)

                || "/views/artist/gallery.jsp".equals(path)
                || "/views/buyer/gallery.jsp".equals(path)

                || "/user-auth".equals(path)
                || "/logout".equals(path)
                || "/contact-handler".equals(path)
                || "/home".equals(path)
                || "/buyer/gallery".equals(path)
                || "/artist/gallery".equals(path)

                || path.startsWith("/css/")
                || path.startsWith("/js/")
                || path.startsWith("/images/")
                || path.startsWith("/views/css/")
                || path.startsWith("/views/images/")
                || path.endsWith(".css")
                || path.endsWith(".js")
                || path.endsWith(".png")
                || path.endsWith(".jpg")
                || path.endsWith(".jpeg")
                || path.endsWith(".gif")
                || path.endsWith(".svg")
                || path.endsWith(".webp");
    }
}
