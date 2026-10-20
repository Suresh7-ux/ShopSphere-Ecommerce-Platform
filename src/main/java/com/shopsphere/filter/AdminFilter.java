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

@WebFilter(urlPatterns = { "/admin/*" })
public class AdminFilter implements Filter {
    public void doFilter(ServletRequest a, ServletResponse b, FilterChain c) throws IOException, ServletException {
        HttpServletRequest r = (HttpServletRequest) a;
        HttpServletResponse s = (HttpServletResponse) b;
        Object role = r.getSession().getAttribute("role");
        if (!"ADMIN".equals(role)) {
            s.sendError(403, "Admin access required");
            return;
        }
        c.doFilter(a, b);
    }
}
