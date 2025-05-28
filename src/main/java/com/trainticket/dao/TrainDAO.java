package com.trainticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.trainticket.model.Train;
import com.trainticket.util.DBUtil;

public class TrainDAO {

    public Train getTrainById(int trainId) {
        Train train = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM trains WHERE trainId = ?";  // Changed to match your DB column
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, trainId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                train = new Train();
                train.setTrainId(rs.getInt("trainId"));           // Match your DB column
                train.setTrainNumber(rs.getString("train_number")); // Match your DB column
                train.setTrainName(rs.getString("train_name"));     // Match your DB column
                train.setTotalSeats(rs.getInt("total_seats"));      // Match your DB column
                train.setTrainType(rs.getString("train_type"));     // Match your DB column
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return train;
    }

    public List<Train> getAllTrains() {
        List<Train> trains = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM trains");

            while (rs.next()) {
                Train train = new Train();
                train.setTrainId(rs.getInt("trainId"));           // Match your DB column
                train.setTrainNumber(rs.getString("train_number")); // Match your DB column
                train.setTrainName(rs.getString("train_name"));     // Match your DB column
                train.setTotalSeats(rs.getInt("total_seats"));      // Match your DB column
                train.setTrainType(rs.getString("train_type"));     // Match your DB column
                trains.add(train);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return trains;
    }

    public boolean addTrain(Train train) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO trains (train_number, train_name, total_seats, train_type) VALUES (?, ?, ?, ?)")) {
            pstmt.setString(1, train.getTrainNumber());
            pstmt.setString(2, train.getTrainName());
            pstmt.setInt(3, train.getTotalSeats());
            pstmt.setString(4, train.getTrainType());
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateTrain(Train train) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "UPDATE trains SET train_number = ?, train_name = ?, total_seats = ?, train_type = ? WHERE trainId = ?")) {
            pstmt.setString(1, train.getTrainNumber());
            pstmt.setString(2, train.getTrainName());
            pstmt.setInt(3, train.getTotalSeats());
            pstmt.setString(4, train.getTrainType());
            pstmt.setInt(5, train.getTrainId());
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteTrain(int trainId) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM trains WHERE trainId = ?")) {
            pstmt.setInt(1, trainId);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
