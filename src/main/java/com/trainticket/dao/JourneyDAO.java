package com.trainticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.trainticket.model.Journey;
import com.trainticket.model.Route;
import com.trainticket.model.Station;
import com.trainticket.model.Train;
import com.trainticket.util.DBUtil;

public class JourneyDAO {

    private TrainDAO trainDAO = new TrainDAO();
    private StationDAO stationDAO = new StationDAO();
    public int getActiveTrainsCount() {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        int count = 0;
        
        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM trains WHERE status = 'ACTIVE'";
            stmt = conn.prepareStatement(sql);
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
    public Journey getJourneyById(int journeyId) {
        Journey journey = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM journeys WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, journeyId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                journey = createJourneyFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return journey;
    }

    public List<Journey> searchJourneys(String departureCity, String arrivalCity, Date date) {
        List<Journey> journeys = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT j.* FROM journeys j " +
                         "JOIN stations ds ON j.departure_station_id = ds.id " +
                         "JOIN stations arr_s ON j.arrival_station_id = arr_s.id " +
                         "WHERE ds.city = ? AND arr_s.city = ? " +
                         "AND DATE(j.departure_time) = ? " +
                         "AND (j.status IS NULL OR j.status != 'CANCELLED') " +
                         "ORDER BY j.departure_time";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, departureCity);
            stmt.setString(2, arrivalCity);
            stmt.setDate(3, new java.sql.Date(date.getTime()));
            rs = stmt.executeQuery();

            while (rs.next()) {
                Journey journey = createJourneyFromResultSet(rs);
                journeys.add(journey);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return journeys;
    }

    public List<Journey> getAllJourneys() {
        List<Journey> journeys = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM journeys ORDER BY departure_time");

            while (rs.next()) {
                Journey journey = createJourneyFromResultSet(rs);
                journeys.add(journey);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return journeys;
    }

    public List<Journey> getUpcomingJourneys(int limit) {
        List<Journey> journeys = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM journeys WHERE departure_time > NOW() " +
                         "AND (status IS NULL OR status != 'CANCELLED') " +
                         "ORDER BY departure_time LIMIT ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, limit);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Journey journey = createJourneyFromResultSet(rs);
                journeys.add(journey);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return journeys;
    }

    public List<Journey> getJourneysByTrain(int trainId) {
        List<Journey> journeys = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM journeys WHERE train_id = ? ORDER BY departure_time";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, trainId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Journey journey = createJourneyFromResultSet(rs);
                journeys.add(journey);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return journeys;
    }

    public boolean addJourney(Journey journey) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO journeys (train_id, departure_station_id, arrival_station_id, " +
                         "departure_time, arrival_time, available_seats, price, journey_date, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, journey.getTrain().getTrainId());
            stmt.setInt(2, journey.getDepartureStation().getId());
            stmt.setInt(3, journey.getArrivalStation().getId());
            stmt.setTimestamp(4, new java.sql.Timestamp(journey.getDepartureTime().getTime()));
            stmt.setTimestamp(5, new java.sql.Timestamp(journey.getArrivalTime().getTime()));
            stmt.setInt(6, journey.getAvailableSeats());
            stmt.setBigDecimal(7, journey.getPrice());
            stmt.setDate(8, new java.sql.Date(journey.getJourneyDate().getTime()));
            stmt.setString(9, journey.getStatus());

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }

        return success;
    }

    public boolean updateJourney(Journey journey) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE journeys SET train_id = ?, departure_station_id = ?, arrival_station_id = ?, " +
                         "departure_time = ?, arrival_time = ?, available_seats = ?, price = ?, " +
                         "journey_date = ?, status = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, journey.getTrain().getTrainId());
            stmt.setInt(2, journey.getDepartureStation().getId());
            stmt.setInt(3, journey.getArrivalStation().getId());
            stmt.setTimestamp(4, new java.sql.Timestamp(journey.getDepartureTime().getTime()));
            stmt.setTimestamp(5, new java.sql.Timestamp(journey.getArrivalTime().getTime()));
            stmt.setInt(6, journey.getAvailableSeats());
            stmt.setBigDecimal(7, journey.getPrice());
            stmt.setDate(8, new java.sql.Date(journey.getJourneyDate().getTime()));
            stmt.setString(9, journey.getStatus());
            stmt.setInt(10, journey.getJourneyId());

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }

        return success;
    }

    public boolean updateJourneySeats(int journeyId, int newAvailableSeats) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE journeys SET available_seats = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, newAvailableSeats);
            stmt.setInt(2, journeyId);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }

        return success;
    }

    public boolean updateJourneyStatus(int journeyId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE journeys SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, journeyId);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }

        return success;
    }

    public boolean deleteJourney(int journeyId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "DELETE FROM journeys WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, journeyId);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }

        return success;
    }

    public int getAvailableSeatsCount(int journeyId) {
        int availableSeats = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT available_seats FROM journeys WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, journeyId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                availableSeats = rs.getInt("available_seats");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return availableSeats;
    }

    // Helper method to create Journey object from ResultSet
    private Journey createJourneyFromResultSet(ResultSet rs) throws SQLException {
        Journey journey = new Journey();
        journey.setJourneyId(rs.getInt("id"));

        // Get train information
        Train train = trainDAO.getTrainById(rs.getInt("train_id"));
        journey.setTrain(train);

        // Get departure station
        Station departureStation = stationDAO.getStationById(rs.getInt("departure_station_id"));
        // Get arrival station
        Station arrivalStation = stationDAO.getStationById(rs.getInt("arrival_station_id"));

        // Create a route object
        Route route = new Route();
        route.setDepartureStation(departureStation);
        route.setArrivalStation(arrivalStation);
        journey.setRoute(route);

        journey.setDepartureTime(rs.getTimestamp("departure_time"));
        journey.setArrivalTime(rs.getTimestamp("arrival_time"));
        journey.setAvailableSeats(rs.getInt("available_seats"));
        journey.setPrice(rs.getBigDecimal("price"));
        journey.setJourneyDate(rs.getDate("journey_date"));
        journey.setStatus(rs.getString("status"));

        return journey;
    }
}
