package com.shopsphere.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = { "/cart", "/checkout", "/orders", "/profile" })
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest a, ServletResponse b, FilterChain c) throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) a;
        HttpServletResponse s = (HttpServletResponse) b;
        if (r.getSession().getAttribute("user") == null) {
            s.sendRedirect(r.getContextPath() + "/login.jsp");
            return;
        }
        c.doFilter(a, b);
    }
}
