package com.accessmanagement.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.accessmanagement.util.DBConnection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SoftwareDAO {

    // Method to add a new software application to the database
   // In the addSoftware method
public boolean addSoftware(Software software) {
    String sql = "INSERT INTO software (name, description, access_levels) VALUES (?, ?, ?) RETURNING id";

    try (Connection conn = DBConnection.getConnection(); 
         PreparedStatement stmt = conn.prepareStatement(sql)) {

        stmt.setString(1, software.getName());
        stmt.setString(2, software.getDescription());
        stmt.setString(3, software.getAccessLevels());

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            software.setId(rs.getLong("id"));
            return true;
        }
        return false;

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

// Update the getAdminSoftware method to fetch all software instead
public List<Software> getAdminSoftware(int adminId) {
    return getAllSoftware(); // Since we don't track who created the software
}

public List<Software> getAllSoftware() {
    List<Software> softwareList = new ArrayList<>();
    String sql = "SELECT * FROM software";

    try (Connection conn = DBConnection.getConnection(); 
         PreparedStatement stmt = conn.prepareStatement(sql); 
         ResultSet rs = stmt.executeQuery()) {

        while (rs.next()) {
            Software software = new Software(
                rs.getLong("id"),
                rs.getString("name"),
                rs.getString("description"),
                rs.getString("access_levels")
            );
            softwareList.add(software);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }
    return softwareList;
}
}
