package com.shopsphere.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import com.shopsphere.model.CartItem;
import com.shopsphere.model.Product;
import com.shopsphere.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    @Override protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        req.getRequestDispatcher("/cart.jsp").forward(req, resp);
    }

    @SuppressWarnings("unchecked")
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        try {
            HttpSession session = req.getSession();
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new LinkedHashMap<>();
                session.setAttribute("cart", cart);
            }
            int id = Integer.parseInt(req.getParameter("id"));
            String action = req.getParameter("action");
            if ("remove".equals(action)) {
                cart.remove(id);
            } else {
                Product product = new ProductService().get(id);
                if (product == null || product.getStock() <= 0) {
                    session.setAttribute("cartMessage", "This product is currently unavailable.");
                    resp.sendRedirect(req.getContextPath() + "/cart");
                    return;
                }
                int current = cart.containsKey(id) ? cart.get(id).getQuantity() : 0;
                int requested = "update".equals(action)
                    ? Integer.parseInt(req.getParameter("qty")) : current + 1;
                if (requested <= 0) cart.remove(id);
                else cart.put(id, new CartItem(product, Math.min(requested, product.getStock())));
            }
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product or quantity.");
        } catch (Exception e) {
            throw new ServletException("Unable to update cart", e);
        }
    }
}
