package com.shopsphere.listener;
import jakarta.servlet.*; import jakarta.servlet.annotation.*;
@WebListener public class AppListener implements ServletContextListener {
 public void contextInitialized(ServletContextEvent e){e.getServletContext().setAttribute("appName","ShopSphere");}
 public void contextDestroyed(ServletContextEvent e){}
}
