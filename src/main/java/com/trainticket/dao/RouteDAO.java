package com.trainticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.trainticket.model.Route;
import com.trainticket.model.Station;
import com.trainticket.util.DBUtil;

public class RouteDAO {

    private StationDAO stationDAO = new StationDAO();

    public Route getRouteById(int routeId) {
        Route route = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM routes WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, routeId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                route = new Route();
                route.setRouteId(rs.getInt("id"));
                route.setName(rs.getString("name"));

                // Get departure station
                Station departureStation = stationDAO.getStationById(rs.getInt("departure_station_id"));
                route.setDepartureStation(departureStation);

                // Get arrival station
                Station arrivalStation = stationDAO.getStationById(rs.getInt("arrival_station_id"));
                route.setArrivalStation(arrivalStation);

                route.setDistance(rs.getDouble("distance"));
                route.setDirect(rs.getBoolean("is_direct"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return route;
    }

    public Route getRouteByStations(int departureStationId, int arrivalStationId) {
        Route route = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM routes WHERE departure_station_id = ? AND arrival_station_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, departureStationId);
            stmt.setInt(2, arrivalStationId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                route = new Route();
                route.setRouteId(rs.getInt("id"));
                route.setName(rs.getString("name"));

                // Get departure station
                Station departureStation = stationDAO.getStationById(rs.getInt("departure_station_id"));
                route.setDepartureStation(departureStation);

                // Get arrival station
                Station arrivalStation = stationDAO.getStationById(rs.getInt("arrival_station_id"));
                route.setArrivalStation(arrivalStation);

                route.setDistance(rs.getDouble("distance"));
                route.setDirect(rs.getBoolean("is_direct"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return route;
    }

    public List<Route> getAllRoutes() {
        List<Route> routes = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM routes ORDER BY name");

            while (rs.next()) {
                Route route = new Route();
                route.setRouteId(rs.getInt("id"));
                route.setName(rs.getString("name"));

                // Get departure station
                Station departureStation = stationDAO.getStationById(rs.getInt("departure_station_id"));
                route.setDepartureStation(departureStation);

                // Get arrival station
                Station arrivalStation = stationDAO.getStationById(rs.getInt("arrival_station_id"));
                route.setArrivalStation(arrivalStation);

                route.setDistance(rs.getDouble("distance"));
                route.setDirect(rs.getBoolean("is_direct"));
                routes.add(route);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return routes;
    }

    public List<Route> getRoutesByDepartureStation(int departureStationId) {
        List<Route> routes = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM routes WHERE departure_station_id = ? ORDER BY name";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, departureStationId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Route route = new Route();
                route.setRouteId(rs.getInt("id"));
                route.setName(rs.getString("name"));

                // Get departure station
                Station departureStation = stationDAO.getStationById(rs.getInt("departure_station_id"));
                route.setDepartureStation(departureStation);

                // Get arrival station
                Station arrivalStation = stationDAO.getStationById(rs.getInt("arrival_station_id"));
                route.setArrivalStation(arrivalStation);

                route.setDistance(rs.getDouble("distance"));
                route.setDirect(rs.getBoolean("is_direct"));
                routes.add(route);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return routes;
    }

    public boolean addRoute(Route route) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO routes (name, departure_station_id, arrival_station_id, distance, is_direct) VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, route.getName());
            stmt.setInt(2, route.getDepartureStation().getId());
            stmt.setInt(3, route.getArrivalStation().getId());
            stmt.setDouble(4, route.getDistance());
            stmt.setBoolean(5, route.isDirect());

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }

        return success;
    }

    public boolean updateRoute(Route route) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE routes SET name = ?, departure_station_id = ?, arrival_station_id = ?, distance = ?, is_direct = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, route.getName());
            stmt.setInt(2, route.getDepartureStation().getId());
            stmt.setInt(3, route.getArrivalStation().getId());
            stmt.setDouble(4, route.getDistance());
            stmt.setBoolean(5, route.isDirect());
            stmt.setInt(6, route.getRouteId());

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }

        return success;
    }

    public boolean deleteRoute(int routeId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "DELETE FROM routes WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, routeId);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, null);
        }

        return success;
    }

    public double calculateDistance(int departureStationId, int arrivalStationId) {
        double distance = 0.0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT distance FROM routes WHERE departure_station_id = ? AND arrival_station_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, departureStationId);
            stmt.setInt(2, arrivalStationId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                distance = rs.getDouble("distance");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBUtil.closeResources(conn, stmt, rs);
        }

        return distance;
    }
}
