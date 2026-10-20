package com.shopsphere.controller;

import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.CartItem;
import com.shopsphere.model.Product;
import com.shopsphere.model.User;
import com.shopsphere.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user = (User) req.getSession().getAttribute("user");
        try {
            req.setAttribute("orders", new OrderDAO().listForUser(user.getUserId()));
            req.getRequestDispatcher("/orders.jsp").forward(req, resp);
        } catch (Exception e) {
            throw new ServletException("Unable to load orders", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user = (User) req.getSession().getAttribute("user");
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            Map<Integer, Integer> requested = new OrderDAO().getReorderItems(user.getUserId(), orderId);
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) req.getSession().getAttribute("cart");
            if (cart == null) {
                cart = new LinkedHashMap<>();
                req.getSession().setAttribute("cart", cart);
            }
            ProductService service = new ProductService();
            for (Map.Entry<Integer, Integer> entry : requested.entrySet()) {
                Product p = service.get(entry.getKey());
                if (p != null && p.getStock() > 0) {
                    int old = cart.containsKey(p.getProductId()) ? cart.get(p.getProductId()).getQuantity() : 0;
                    cart.put(p.getProductId(), new CartItem(p, Math.min(p.getStock(), old + entry.getValue())));
                }
            }
            req.getSession().setAttribute("reorderMessage",
                    requested.isEmpty() ? "No available items from this order could be reordered."
                            : "Available items have been added to your cart.");
            resp.sendRedirect(req.getContextPath() + "/cart");
        } catch (Exception e) {
            throw new ServletException("Unable to reorder", e);
        }
    }
}
