package com.artopia1.user.controller;

import com.artopia1.user.model.User;
import com.artopia1.user.model.dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
@WebServlet("/user-auth")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException
    {
        UserDAO userDAO = new UserDAO();
        String action = request.getParameter("action");

        if(action.equals("register")) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            User user = new User(name, email, password, role);
            userDAO.registeruser(user);
            response.sendRedirect("views/login.jsp");

        }else if (action.equals("login")){
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user  = userDAO.loginUser(email, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                Cookie emailCookie = new Cookie("userEmail", user.getEmail());
                emailCookie.setMaxAge(60*60*24);
                emailCookie.setHttpOnly(true);
                response.addCookie(emailCookie);

                if (user.getRole().equals("ADMIN")) {
                    response.sendRedirect("views/admin.jsp");
                }else {
                    response.sendRedirect("views/dashboard.jsp");
                }
            }

        } else if (action.equals("logout")) {
            HttpSession session = request.getSession();
            session.invalidate();

            Cookie emailCookie = new Cookie ("userEmail", "");
            emailCookie.setMaxAge(0);
            response.addCookie(emailCookie);

            response.sendRedirect("views/login.jsp");
        }
    }
}
