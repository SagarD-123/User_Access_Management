package com.accessmanagement.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:postgresql://localhost:5432/access_management";
    private static final String USER = "postgres";
    private static final String PASSWORD = "Sagar@123";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
//
//public class DBConnection {
//
//    private static final String URL = "jdbc:postgresql://localhost:5432/access_management";
//    private static final String USER = "your_db_username";
//    private static final String PASSWORD = "your_db_password";
//
//    public static Connection getConnection() throws SQLException {
//        return DriverManager.getConnection(URL, USER, PASSWORD);
//    }
//}

