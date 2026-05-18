package com.artopia1.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

// Utility class for managing database connections

public class DBConnection {
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Abal@0726";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/artopia";

    // Method to establish and return a database connection

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD);
    }
}
