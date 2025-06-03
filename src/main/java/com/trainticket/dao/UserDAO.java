package com.trainticket.dao;

import com.trainticket.model.User;
import com.trainticket.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
	// Méthode pour compter le nombre total d'utilisateurs (avec recherche optionnelle)
	public int getUserCount(String searchTerm) {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    int count = 0;
	    
	    try {
	        conn = DBUtil.getConnection();
	        String sql = "SELECT COUNT(*) FROM users";
	        
	        if (searchTerm != null && !searchTerm.isEmpty()) {
	            sql += " WHERE username LIKE ? OR full_name LIKE ? OR email LIKE ?";
	        }
	        
	        stmt = conn.prepareStatement(sql);
	        
	        if (searchTerm != null && !searchTerm.isEmpty()) {
	            String searchPattern = "%" + searchTerm + "%";
	            stmt.setString(1, searchPattern);
	            stmt.setString(2, searchPattern);
	            stmt.setString(3, searchPattern);
	        }
	        
	        rs = stmt.executeQuery();
	        
	        if (rs.next()) {
	            count = rs.getInt(1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBUtil.closeResources(conn, stmt, rs);
	    }
	    
	    return count;
	}

	// Méthode pour récupérer les utilisateurs avec pagination et recherche
	public List<User> getUsersWithPagination(int offset, int limit, String searchTerm) {
	    List<User> users = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = DBUtil.getConnection();
	        String sql = "SELECT id, username, email, full_name, phone, role, created_at FROM users";
	        
	        if (searchTerm != null && !searchTerm.isEmpty()) {
	            sql += " WHERE username LIKE ? OR full_name LIKE ? OR email LIKE ?";
	        }
	        
	        sql += " ORDER BY created_at DESC LIMIT ? OFFSET ?";
	        
	        stmt = conn.prepareStatement(sql);
	        
	        int paramIndex = 1;
	        if (searchTerm != null && !searchTerm.isEmpty()) {
	            String searchPattern = "%" + searchTerm + "%";
	            stmt.setString(paramIndex++, searchPattern);
	            stmt.setString(paramIndex++, searchPattern);
	            stmt.setString(paramIndex++, searchPattern);
	        }
	        
	        stmt.setInt(paramIndex++, limit);
	        stmt.setInt(paramIndex++, offset);
	        
	        rs = stmt.executeQuery();
	        
	        while (rs.next()) {
	            User user = new User();
	            user.setUserId(rs.getInt("id"));
	            user.setUsername(rs.getString("username"));
	            user.setEmail(rs.getString("email"));
	            user.setFullName(rs.getString("full_name"));
	            user.setPhone(rs.getString("phone"));
	            user.setRole(rs.getString("role"));
	            user.setCreatedAt(rs.getTimestamp("created_at"));
	            user.setActive(true);
	            users.add(user);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        DBUtil.closeResources(conn, stmt, rs);
	    }
	    
	    return users;
	}
    // Méthode pour authentifier un utilisateur
    public User getUserByUsername(String username) {
        User user = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT id, username, email, password, full_name, phone, role, created_at FROM users WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setActive(true); // Par défaut actif
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
        
        return user;
    }
    
    // Méthode pour obtenir un utilisateur par ID
    public User getUserById(int userId) {
        User user = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT id, username, email, password, full_name, phone, role, created_at FROM users WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();
            
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setActive(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
        
        return user;
    }
    
    // Méthode pour ajouter un nouvel utilisateur
    public boolean addUser(User user) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO users (username, email, password, full_name, phone, role) VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPassword());
            stmt.setString(4, user.getFullName());
            stmt.setString(5, user.getPhone());
            stmt.setString(6, user.getRole());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Méthode pour mettre à jour un utilisateur
    public boolean updateUser(User user) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE users SET email = ?, full_name = ?, phone = ?, role = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, user.getEmail());
            stmt.setString(2, user.getFullName());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getRole());
            stmt.setInt(5, user.getUserId());
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Méthode pour supprimer un utilisateur
    public boolean deleteUser(int userId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "DELETE FROM users WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }
        
        return success;
    }
    
    // Méthode pour obtenir tous les utilisateurs
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT id, username, email, password, full_name, phone, role, created_at FROM users ORDER BY created_at DESC";
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setActive(true);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
        
        return users;
    }
    
    // Méthode pour obtenir les utilisateurs récents
    public List<User> getRecentUsers(int limit) {
        List<User> users = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT id, username, email, password, full_name, phone, role, created_at FROM users ORDER BY created_at DESC LIMIT ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            rs = stmt.executeQuery();
            
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setFullName(rs.getString("full_name"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                user.setActive(true);
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
        
        return users;
    }
    
    // Méthode pour vérifier si un nom d'utilisateur existe
    public boolean usernameExists(String username) {
        return getUserByUsername(username) != null;
    }
    
    // Méthode pour vérifier si un email existe
    public boolean emailExists(String email) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT id FROM users WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            exists = rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }
        
        return exists;
    }
 // Ajouter cette méthode à la classe UserDAO existante

    public boolean updatePassword(int userId, String hashedPassword) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE users SET password = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, hashedPassword);
            stmt.setInt(2, userId);
            
            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }
        
        return success;
    }
}