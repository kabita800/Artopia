package com.artopia1.user.model.dao;

import com.artopia1.user.model.Art;
import com.artopia1.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class ArtDAO {

    /** Per-request thread: last insert failure message for UI / logging */
    private static final ThreadLocal<String> LAST_INSERT_ERROR = new ThreadLocal<>();

    public static String takeLastInsertError() {
        String m = LAST_INSERT_ERROR.get();
        LAST_INSERT_ERROR.remove();
        return m;
    }

    private Art mapRow(ResultSet rs) throws Exception {
        Art a = new Art();
        a.setId(rs.getInt("id"));
        a.setArtistId(rs.getInt("artist_id"));
        a.setTitle(rs.getString("title"));
        a.setDescription(rs.getString("description"));
        a.setCategory(rs.getString("category"));
        a.setPrice(rs.getDouble("price"));
        a.setImageUrl(rs.getString("image_url"));
        a.setSold(rs.getInt("sold") == 1);
        a.setViewCount(rs.getInt("view_count"));
        a.setSoldCount(rs.getInt("sold_count"));
        Timestamp ts = rs.getTimestamp("created_at");
        if (ts != null) {
            a.setCreatedAt(ts.toLocalDateTime());
        }
        try {
            a.setArtistName(rs.getString("artist_name"));
        } catch (Exception ignored) {
            a.setArtistName("");
        }
        return a;
    }

    public List<Art> findAllWithArtist() {
        String sql = """
                SELECT a.*, u.name AS artist_name
                FROM art a
                JOIN user u ON u.id = a.artist_id
                ORDER BY a.created_at DESC
                """;
        List<Art> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Art> findAvailableForBuyers() {
        String sql = """
                SELECT a.*, u.name AS artist_name
                FROM art a
                JOIN user u ON u.id = a.artist_id
                WHERE a.sold = 0
                ORDER BY a.created_at DESC
                """;
        List<Art> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<String> findDistinctCategories(boolean availableOnly) {
        String sql = availableOnly
                ? "SELECT DISTINCT category FROM art WHERE sold = 0 ORDER BY category"
                : "SELECT DISTINCT category FROM art ORDER BY category";
        List<String> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Art> findByArtistId(int artistId) {
        String sql = """
                SELECT a.*, u.name AS artist_name
                FROM art a
                JOIN user u ON u.id = a.artist_id
                WHERE a.artist_id = ?
                ORDER BY a.created_at DESC
                """;
        List<Art> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, artistId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int insert(int artistId, String title, String description, String category,
                      double price, String imageFileName) {
        LAST_INSERT_ERROR.remove();
        String sql = """
                INSERT INTO art (artist_id, title, description, category, price, image_url, sold, view_count, sold_count)
                VALUES (?,?,?,?,?,?,0,0,0)
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, artistId);
            ps.setString(2, title);
            ps.setString(3, description != null ? description : "");
            ps.setString(4, category);
            ps.setDouble(5, price);
            ps.setString(6, imageFileName != null ? imageFileName : "");
            int rows = ps.executeUpdate();
            if (rows <= 0) {
                LAST_INSERT_ERROR.set("Insert did not affect any row.");
                return -1;
            }
            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) {
                    int id = keys.getInt(1);
                    if (id > 0) {
                        return id;
                    }
                }
            }
            // MySQL / some drivers omit generated keys — use LAST_INSERT_ID on same connection
            try (Statement st = conn.createStatement();
                 ResultSet rs = st.executeQuery("SELECT LAST_INSERT_ID()")) {
                if (rs.next()) {
                    int id = rs.getInt(1);
                    if (id > 0) {
                        return id;
                    }
                }
            }
            LAST_INSERT_ERROR.set("Could not read new artwork id from database.");
            return -1;
        } catch (SQLException e) {
            e.printStackTrace();
            LAST_INSERT_ERROR.set(e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            LAST_INSERT_ERROR.set(e.getMessage());
        }
        return -1;
    }

    public boolean update(int artId, int artistId, String title, String description, String category,
                          double price, String newImageFileNameOrNull) {
        if (newImageFileNameOrNull != null && !newImageFileNameOrNull.isEmpty()) {
            String sql = """
                    UPDATE art SET title=?, description=?, category=?, price=?, image_url=?
                    WHERE id=? AND artist_id=?
                    """;
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, title);
                ps.setString(2, description != null ? description : "");
                ps.setString(3, category);
                ps.setDouble(4, price);
                ps.setString(5, newImageFileNameOrNull);
                ps.setInt(6, artId);
                ps.setInt(7, artistId);
                return ps.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            String sql = """
                    UPDATE art SET title=?, description=?, category=?, price=?
                    WHERE id=? AND artist_id=?
                    """;
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, title);
                ps.setString(2, description != null ? description : "");
                ps.setString(3, category);
                ps.setDouble(4, price);
                ps.setInt(5, artId);
                ps.setInt(6, artistId);
                return ps.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean delete(int artId, int artistId) {
        String sql = "DELETE FROM art WHERE id=? AND artist_id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, artId);
            ps.setInt(2, artistId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public Art findByIdForArtist(int artId, int artistId) {
        String sql = """
                SELECT a.*, u.name AS artist_name
                FROM art a JOIN user u ON u.id = a.artist_id
                WHERE a.id=? AND a.artist_id=?
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, artId);
            ps.setInt(2, artistId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Art findByIdAdmin(int artId) {
        String sql = """
                SELECT a.*, u.name AS artist_name
                FROM art a JOIN user u ON u.id = a.artist_id
                WHERE a.id=?
                """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, artId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRow(rs);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateAdmin(int artId, String title, String description, String category,
                               double price, String newImageFileNameOrNull, boolean isSold) {
        int soldInt = isSold ? 1 : 0;
        if (newImageFileNameOrNull != null && !newImageFileNameOrNull.isEmpty()) {
            String sql = """
                    UPDATE art SET title=?, description=?, category=?, price=?, image_url=?, sold=?
                    WHERE id=?
                    """;
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, title);
                ps.setString(2, description != null ? description : "");
                ps.setString(3, category);
                ps.setDouble(4, price);
                ps.setString(5, newImageFileNameOrNull);
                ps.setInt(6, soldInt);
                ps.setInt(7, artId);
                return ps.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            String sql = """
                    UPDATE art SET title=?, description=?, category=?, price=?, sold=?
                    WHERE id=?
                    """;
            try (Connection conn = DBConnection.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, title);
                ps.setString(2, description != null ? description : "");
                ps.setString(3, category);
                ps.setDouble(4, price);
                ps.setInt(5, soldInt);
                ps.setInt(6, artId);
                return ps.executeUpdate() > 0;
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return false;
    }

    public boolean deleteAdmin(int artId) {
        String sql = "DELETE FROM art WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, artId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}

