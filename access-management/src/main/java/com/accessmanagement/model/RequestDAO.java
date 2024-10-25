package com.accessmanagement.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.accessmanagement.util.DBConnection;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;
import java.util.logging.Level;

public class RequestDAO {

    private static final Logger LOGGER = Logger.getLogger(RequestDAO.class.getName());

    // Method to add a new access request to the database
    public boolean addRequest(Request request) {
        String sql = "INSERT INTO requests (user_id, software_id, access_type, reason, status) VALUES (?, ?, ?, ?, 'Pending')";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, request.getUserId());
            stmt.setInt(2, request.getSoftwareId());
            stmt.setString(3, request.getAccessType());
            stmt.setString(4, request.getReason());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Method to update the status of an access request
    public boolean updateRequestStatus(int requestId, String status) {
        String sql = "UPDATE requests SET status = ? WHERE id = ?";

        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, requestId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0; // Return true if at least one row was updated

        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Return false in case of an error
        }
    }

    public List<Request> getAllRequests() {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT r.*, s.name as software_name, u.username FROM requests r " +
                     "JOIN software s ON r.software_id = s.id " +
                     "JOIN users u ON r.user_id = u.id " +
                     "WHERE r.status = 'Pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Request request = new Request();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setSoftwareId(rs.getInt("software_id"));
                request.setSoftwareName(rs.getString("software_name"));
                request.setAccessType(rs.getString("access_type"));
                request.setReason(rs.getString("reason"));
                request.setStatus(rs.getString("status"));
                request.setUsername(rs.getString("username"));
                requests.add(request);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }

  public List<Request> getPendingRequests() {
        List<Request> requestList = new ArrayList<>();
        String sql = "SELECT r.id, r.user_id, u.username, r.software_id, s.name AS software_name, " +
                     "r.access_type, r.reason, r.status " +
                     "FROM requests r " +
                     "JOIN users u ON r.user_id = u.id " +
                     "JOIN software s ON r.software_id = s.id " +
                     "WHERE r.status = 'Pending'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Request request = new Request();
                request.setId(rs.getInt("id"));
                request.setUserId(rs.getInt("user_id"));
                request.setUsername(rs.getString("username"));
                request.setSoftwareId(rs.getInt("software_id"));
                request.setSoftwareName(rs.getString("software_name"));
                request.setAccessType(rs.getString("access_type"));
                request.setReason(rs.getString("reason"));
                request.setStatus(rs.getString("status"));
                requestList.add(request);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requestList;
    }

    public List<Request> getUserRequests(int userId) {
        List<Request> requests = new ArrayList<>();
        String sql = "SELECT r.*, s.name as software_name FROM requests r " +
                     "JOIN software s ON r.software_id = s.id " +
                     "WHERE r.user_id = ?";

        LOGGER.info("Executing SQL: " + sql);
        LOGGER.info("With user ID: " + userId);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
       
       stmt.setInt(1, userId);
       ResultSet rs = stmt.executeQuery();

       LOGGER.info("Query executed successfully");

       while (rs.next()) {
           LOGGER.info("Processing row from result set");
           Request request = new Request();
           request.setId(rs.getInt("id"));
           request.setUserId(rs.getInt("user_id"));
           request.setSoftwareId(rs.getInt("software_id"));
           request.setSoftwareName(rs.getString("software_name"));
           request.setAccessType(rs.getString("access_type"));
           request.setReason(rs.getString("reason"));
           request.setStatus(rs.getString("status"));
           requests.add(request);
           LOGGER.info("Added request: " + request);
       }
   } catch (SQLException e) {
       LOGGER.log(Level.SEVERE, "Error fetching user requests", e);
   }

   LOGGER.info("Total requests fetched: " + requests.size());
   return requests;
    }

}
