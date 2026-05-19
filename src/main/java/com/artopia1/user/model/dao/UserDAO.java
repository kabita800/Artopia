package com.artopia1.user.model.dao;

import com.artopia1.user.model.User;
import com.artopia1.utils.DBConnection;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class UserDAO implements UserInterface {

    @Override
    public boolean registeruser(User user) {

        String sql = "INSERT INTO user(name, email, password, role) VALUES (?,?,?,?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
            ps.setString(4, user.getRole());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    @Override
    public User loginUser(String email, String password) {

        User row = findByEmail(email);
        if (row == null) {
            return null;
        }

        String stored = row.getPassword();
        boolean ok;
        if (stored != null && stored.startsWith("$2a$")) {
            ok = BCrypt.checkpw(password, stored);
        } else {
            ok = stored != null && stored.equals(password);
        }

        if (!ok) {
            return null;
        }

        return new User(row.getId(), row.getName(), row.getEmail(), null, row.getRole());
    }

    public User findByEmail(String email) {
        String sql = "SELECT id, name, email, password, role FROM user WHERE email=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("role")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public User findById(int id) {
        String sql = "SELECT id, name, email, password, role FROM user WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("password"),
                            rs.getString("role")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE user SET name=?, email=?, role=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getRole());
            ps.setInt(4, user.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT id, name, email, role FROM user ORDER BY name ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                users.add(new User(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("email"),
                        null,
                        rs.getString("role")
                ));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
    @Override
    public List<User> searchUsers(String keyword) {
        List<User> users = new ArrayList<>();
        String sql = """
                SELECT id, name, email, role FROM user
                WHERE name LIKE ? OR email LIKE ?
                ORDER BY name ASC
                """;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    users.add(new User(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            null,
                            rs.getString("role")
                    ));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return users;
    }
    @Override
    public boolean deleteUser(int id) {
        String sql = "DELETE FROM user WHERE id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
