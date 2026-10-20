package com.shopsphere.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public final class DB {
    private static final String URL =
        "jdbc:mysql://localhost:3306/shopsphere"
        + "?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=Asia/Kolkata";
    private static final String USER = "root";
    // Change this value if your local MySQL root account uses a different password.
    private static final String PASSWORD = "1234";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(
                "MySQL Connector/J is missing. Check WEB-INF/lib and pom.xml: " + e.getMessage()
            );
        }
    }

    private DB() { }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
