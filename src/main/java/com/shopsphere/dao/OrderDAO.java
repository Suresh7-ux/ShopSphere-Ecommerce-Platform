package com.shopsphere.dao;

import com.shopsphere.model.CartItem;
import com.shopsphere.model.User;
import com.shopsphere.util.DB;
import java.sql.*;
import java.util.*;

public class OrderDAO {
    public int placeOrder(User user, Map<Integer, CartItem> cart, String addressLine,
                          String city, String state, String pincode, String paymentMethod) throws SQLException {
        if (cart == null || cart.isEmpty()) throw new SQLException("Your cart is empty.");
        try (Connection con = DB.getConnection()) {
            con.setAutoCommit(false);
            try {
                int addressId;
                String addressSql = "INSERT INTO addresses(user_id,address_line,city,state,pincode,address_type) VALUES(?,?,?,?,?,'HOME')";
                try (PreparedStatement ps = con.prepareStatement(addressSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, user.getUserId()); ps.setString(2, addressLine); ps.setString(3, city);
                    ps.setString(4, state); ps.setString(5, pincode); ps.executeUpdate();
                    try (ResultSet keys = ps.getGeneratedKeys()) { if (!keys.next()) throw new SQLException("Could not save address."); addressId = keys.getInt(1); }
                }
                double total = cart.values().stream().mapToDouble(CartItem::getSubtotal).sum();
                int orderId;
                String orderSql = "INSERT INTO orders(user_id,address_id,total_amount,payment_method,payment_status,order_status) VALUES(?,?,?,?,?,?)";
                try (PreparedStatement ps = con.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setInt(1, user.getUserId()); ps.setInt(2, addressId); ps.setDouble(3, total);
                    ps.setString(4, paymentMethod); ps.setString(5, "COD".equals(paymentMethod) ? "PENDING" : "DEMO PAID");
                    ps.setString(6, "PLACED"); ps.executeUpdate();
                    try (ResultSet keys = ps.getGeneratedKeys()) { if (!keys.next()) throw new SQLException("Could not create order."); orderId = keys.getInt(1); }
                }
                try (PreparedStatement item = con.prepareStatement("INSERT INTO order_items(order_id,product_id,quantity,price) VALUES(?,?,?,?)");
                     PreparedStatement stock = con.prepareStatement("UPDATE products SET stock=stock-? WHERE product_id=? AND stock>=?")) {
                    for (CartItem ci : cart.values()) {
                        item.setInt(1, orderId); item.setInt(2, ci.getProduct().getProductId()); item.setInt(3, ci.getQuantity()); item.setDouble(4, ci.getProduct().getFinalPrice()); item.executeUpdate();
                        stock.setInt(1, ci.getQuantity()); stock.setInt(2, ci.getProduct().getProductId()); stock.setInt(3, ci.getQuantity());
                        if (stock.executeUpdate() != 1) throw new SQLException("Insufficient stock for " + ci.getProduct().getName());
                    }
                }
                con.commit(); return orderId;
            } catch (SQLException ex) { con.rollback(); throw ex; }
            finally { con.setAutoCommit(true); }
        }
    }

    public List<Map<String,Object>> listForUser(int userId) throws SQLException {
        List<Map<String,Object>> orders = new ArrayList<>();
        String sql = "SELECT o.order_id,o.total_amount,o.payment_method,o.payment_status,o.order_status,o.created_at, " +
                     "oi.product_id,oi.quantity,oi.price,p.name,p.image_url FROM orders o " +
                     "JOIN order_items oi ON o.order_id=oi.order_id JOIN products p ON p.product_id=oi.product_id " +
                     "WHERE o.user_id=? ORDER BY o.created_at DESC,o.order_id DESC";
        try (Connection con=DB.getConnection(); PreparedStatement ps=con.prepareStatement(sql)) {
            ps.setInt(1,userId); try(ResultSet rs=ps.executeQuery()) {
                Map<Integer,Map<String,Object>> byId=new LinkedHashMap<>();
                while(rs.next()) {
                    int id=rs.getInt("order_id"); Map<String,Object> o=byId.get(id);
                    if(o==null){o=new LinkedHashMap<>();o.put("orderId",id);o.put("total",rs.getDouble("total_amount"));o.put("paymentMethod",rs.getString("payment_method"));o.put("paymentStatus",rs.getString("payment_status"));o.put("status",rs.getString("order_status"));o.put("createdAt",rs.getTimestamp("created_at"));o.put("items",new ArrayList<Map<String,Object>>());byId.put(id,o);}
                    Map<String,Object> item=new LinkedHashMap<>(); item.put("productId",rs.getInt("product_id"));item.put("quantity",rs.getInt("quantity"));item.put("price",rs.getDouble("price"));item.put("name",rs.getString("name"));item.put("imageUrl",rs.getString("image_url"));
                    ((List<Map<String,Object>>)o.get("items")).add(item);
                }
                orders.addAll(byId.values());
            }
        } return orders;
    }

    public Map<Integer,Integer> getReorderItems(int userId,int orderId) throws SQLException {
        Map<Integer,Integer> items=new LinkedHashMap<>();
        try(Connection con=DB.getConnection();PreparedStatement ps=con.prepareStatement("SELECT oi.product_id,oi.quantity FROM order_items oi JOIN orders o ON o.order_id=oi.order_id JOIN products p ON p.product_id=oi.product_id WHERE o.order_id=? AND o.user_id=? AND p.status=1 AND p.stock>0")) {
            ps.setInt(1,orderId);ps.setInt(2,userId);try(ResultSet rs=ps.executeQuery()){while(rs.next())items.put(rs.getInt(1),rs.getInt(2));}
        } return items;
    }
}
