package com.shopsphere.controller;

import com.shopsphere.dao.OrderDAO;
import com.shopsphere.model.CartItem;
import com.shopsphere.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Map;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        User user=(User)req.getSession().getAttribute("user");
        if(user==null){resp.sendRedirect(req.getContextPath()+"/login.jsp");return;}
        Map<Integer,CartItem> cart=(Map<Integer,CartItem>)req.getSession().getAttribute("cart");
        String address=req.getParameter("addressLine"), city=req.getParameter("city"), state=req.getParameter("state"), pin=req.getParameter("pincode");
        if(cart==null||cart.isEmpty()||blank(address)||blank(city)||blank(state)||pin==null||!pin.trim().matches("[0-9]{5,10}")){
            req.getSession().setAttribute("checkoutError","Please add items and enter a complete delivery address with a valid pincode.");resp.sendRedirect(req.getContextPath()+"/checkout.jsp");return;
        }
        try {
            String payment=req.getParameter("paymentMethod"); if(!"COD".equals(payment)&&!"UPI_DEMO".equals(payment)&&!"CARD_DEMO".equals(payment)) payment="COD";
            int orderId=new OrderDAO().placeOrder(user,cart,address.trim(),city.trim(),state.trim(),pin.trim(),payment);
            req.getSession().removeAttribute("cart");req.getSession().setAttribute("orderSuccessId",orderId);
            resp.sendRedirect(req.getContextPath()+"/orders?placed=1");
        } catch(Exception e){getServletContext().log("Order could not be placed", e);req.getSession().setAttribute("checkoutError","Order could not be placed. Please check your address, stock, and database connection, then try again.");resp.sendRedirect(req.getContextPath()+"/checkout.jsp");}
    }
    private boolean blank(String s){return s==null||s.trim().isEmpty();}
}
