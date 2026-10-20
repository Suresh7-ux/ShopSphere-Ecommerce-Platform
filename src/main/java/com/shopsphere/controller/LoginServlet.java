package com.shopsphere.controller;
import com.shopsphere.service.AuthService; import com.shopsphere.model.User; import jakarta.servlet.*; import jakarta.servlet.http.*; import jakarta.servlet.annotation.*; import java.io.*;
@WebServlet("/login")
public class LoginServlet extends HttpServlet {protected void doPost(HttpServletRequest r,HttpServletResponse s)throws IOException,ServletException{try{User u=new AuthService().login(r.getParameter("email"),r.getParameter("password"));if(u==null){r.setAttribute("error","Invalid email or password");r.getRequestDispatcher("/login.jsp").forward(r,s);return;}r.getSession().setAttribute("user",u);r.getSession().setAttribute("role",u.getRole());s.sendRedirect("products");}catch(Exception e){throw new ServletException(e);}}}
