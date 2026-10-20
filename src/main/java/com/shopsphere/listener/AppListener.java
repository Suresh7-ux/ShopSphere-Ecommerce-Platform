package com.shopsphere.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppListener implements ServletContextListener {
    public void contextInitialized(ServletContextEvent e) {
        e.getServletContext().setAttribute("appName", "ShopSphere");
    }

    public void contextDestroyed(ServletContextEvent e) {
    }
}
