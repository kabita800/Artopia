package com.artopia1.user.model.dao;

import com.artopia1.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ContactDAO {

    public boolean saveMessage(String firstName, String lastName, String email,
                               String subject, String type, String message) {
        String sql = """
                INSERT INTO contact_message (first_name, last_name, email, subject, type, message)
                VALUES (?,?,?,?,?,?)
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setString(4, subject);
            ps.setString(5, type);
            ps.setString(6, message);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
