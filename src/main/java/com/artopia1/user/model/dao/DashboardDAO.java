package com.artopia1.user.model.dao;

import com.artopia1.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardDAO {

    public int getTotalUsers() {
        return count("SELECT COUNT(*) FROM user");
    }

    public int getTotalArtists() {
        return count("SELECT COUNT(*) FROM user WHERE role = 'artist'");
    }

    public int getTotalBuyers() {
        return count("SELECT COUNT(*) FROM user WHERE role = 'buyer'");
    }

    public int getTotalArtworks() {
        return count("SELECT COUNT(*) FROM artwork");
    }

    public int getTotalOrders() {
        return count("SELECT COUNT(*) FROM orders");
    }

    public double getTotalRevenue() {
        String sql = "SELECT COALESCE(SUM(total_price), 0) FROM orders";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getDouble(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private int count(String sql) {
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}