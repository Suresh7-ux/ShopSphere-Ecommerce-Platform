package com.shopsphere.controller;

import java.io.IOException;

import com.shopsphere.model.User;
import com.shopsphere.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest r, HttpServletResponse s) throws IOException, ServletException {
        try {
            User u = new AuthService().login(r.getParameter("email"), r.getParameter("password"));
            if (u == null) {
                r.setAttribute("error", "Invalid email or password");
                r.getRequestDispatcher("/login.jsp").forward(r, s);
                return;
            }
            r.getSession().setAttribute("user", u);
            r.getSession().setAttribute("role", u.getRole());
            s.sendRedirect("products");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
