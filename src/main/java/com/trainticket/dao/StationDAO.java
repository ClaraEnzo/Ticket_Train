package com.trainticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.trainticket.model.Station;
import com.trainticket.util.DBUtil;

public class StationDAO {

    public List<Station> getAllStations() {
        List<Station> stations = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM stations WHERE is_active = 1");  // Changed TRUE to 1 for tinyint

            while (rs.next()) {
                Station station = new Station();
                station.setId(rs.getInt("id"));  // Changed from station_id to id
                station.setName(rs.getString("name"));
                station.setCity(rs.getString("city"));
                station.setAddress(rs.getString("state"));  // Using state as address
                station.setActive(rs.getBoolean("is_active"));
                stations.add(station);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return stations;
    }

    public List<String> getAllCities() {
        List<String> cities = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT DISTINCT city FROM stations WHERE is_active = 1 ORDER BY city");  // Changed TRUE to 1

            while (rs.next()) {
                cities.add(rs.getString("city"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return cities;
    }

    public Station getStationById(int stationId) {
        Station station = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM stations WHERE id = ?";  // Changed from station_id to id
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, stationId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                station = new Station();
                station.setId(rs.getInt("id"));  // Changed from station_id to id
                station.setName(rs.getString("name"));
                station.setCity(rs.getString("city"));
                station.setAddress(rs.getString("state"));  // Using state as address since address column doesn't exist
                station.setActive(rs.getBoolean("is_active"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return station;
    }

    public boolean addStation(Station station) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "INSERT INTO stations (name, city, is_active) VALUES (?, ?, ?)")) {
            pstmt.setString(1, station.getName());
            pstmt.setString(2, station.getCity());
            pstmt.setBoolean(3, station.isActive());
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStation(Station station) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(
                     "UPDATE stations SET name = ?, city = ?, is_active = ? WHERE id = ?")) {
            pstmt.setString(1, station.getName());
            pstmt.setString(2, station.getCity());
            pstmt.setBoolean(3, station.isActive());
            pstmt.setInt(4, station.getId());
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteStation(int id) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM stations WHERE id = ?")) {
            pstmt.setInt(1, id);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private void closeResources(Connection conn, Statement stmt, ResultSet rs) {
        try {
            if (rs != null) {
				rs.close();
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (stmt != null) {
				stmt.close();
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            if (conn != null) {
				conn.close();
			}
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}