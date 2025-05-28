package com.trainticket.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.trainticket.model.Journey;
import com.trainticket.model.Ticket;
import com.trainticket.util.DBUtil;

public class TicketDAO {

    public Ticket getTicketById(int ticketId) {
        Ticket ticket = null;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM tickets WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, ticketId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                ticket = mapResultSetToTicket(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return ticket;
    }

    public List<Ticket> getTicketsByUserId(int userId) {
        List<Ticket> tickets = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT t.*, j.departure_time, j.arrival_time, j.price, " +
                        "ds.name as departure_station, ds.city as departure_city, " +
                        "arr_s.name as arrival_station, arr_s.city as arrival_city, " +
                        "tr.train_name, tr.train_number " +
                        "FROM tickets t " +
                        "JOIN journeys j ON t.journey_id = j.id " +
                        "JOIN stations ds ON j.departure_station_id = ds.id " +
                        "JOIN stations arr_s ON j.arrival_station_id = arr_s.id " +
                        "JOIN trains tr ON j.train_id = tr.trainId " +
                        "WHERE t.user_id = ? " +
                        "ORDER BY t.booking_date DESC";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                Ticket ticket = mapResultSetToTicket(rs);

                // Create and populate journey object with additional info
                Journey journey = new Journey();
                journey.setJourneyId(rs.getInt("journey_id"));
                journey.setDepartureTime(rs.getTimestamp("departure_time"));
                journey.setArrivalTime(rs.getTimestamp("arrival_time"));
                // Remove the setPrice call since Ticket model doesn't have price field
                // The price information is available in the Journey object if needed

                ticket.setJourney(journey);

                tickets.add(ticket);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return tickets;
    }

    public List<Ticket> getTicketsByJourneyId(int journeyId) {
        List<Ticket> tickets = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT * FROM tickets WHERE journey_id = ? ORDER BY seat_number";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, journeyId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                tickets.add(mapResultSetToTicket(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return tickets;
    }

    public boolean addTicket(Ticket ticket) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO tickets (user_id, journey_id, seat_number, passenger_name, passenger_age, status) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, ticket.getUserId());
            stmt.setInt(2, ticket.getJourneyId());
            stmt.setString(3, ticket.getSeatNumber());
            stmt.setString(4, ticket.getPassengerName());
            stmt.setInt(5, ticket.getPassengerAge());
            stmt.setString(6, ticket.getStatus());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    ticket.setId(generatedKeys.getInt(1));
                }
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }

        return success;
    }

    public boolean updateTicketStatus(int ticketId, String status) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "UPDATE tickets SET status = ? WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            stmt.setInt(2, ticketId);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }

        return success;
    }

    public boolean cancelTicket(int ticketId) {
        return updateTicketStatus(ticketId, "CANCELLED");
    }

    public boolean confirmTicket(int ticketId) {
        return updateTicketStatus(ticketId, "CONFIRMED");
    }

    public boolean deleteTicket(int ticketId) {
        Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "DELETE FROM tickets WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, ticketId);

            int rowsAffected = stmt.executeUpdate();
            success = rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }

        return success;
    }

    public List<String> getBookedSeatsForJourney(int journeyId) {
        List<String> bookedSeats = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT seat_number FROM tickets WHERE journey_id = ? AND status != 'CANCELLED'";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, journeyId);
            rs = stmt.executeQuery();

            while (rs.next()) {
                bookedSeats.add(rs.getString("seat_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return bookedSeats;
    }

    public int getTicketCountByStatus(String status) {
        int count = 0;
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            String sql = "SELECT COUNT(*) FROM tickets WHERE status = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, status);
            rs = stmt.executeQuery();

            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return count;
    }

    public List<Ticket> getAllTickets() {
        List<Ticket> tickets = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtil.getConnection();
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM tickets ORDER BY booking_date DESC");

            while (rs.next()) {
                tickets.add(mapResultSetToTicket(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, rs);
        }

        return tickets;
    }

    private Ticket mapResultSetToTicket(ResultSet rs) throws SQLException {
        Ticket ticket = new Ticket();
        ticket.setId(rs.getInt("id"));
        ticket.setUserId(rs.getInt("user_id"));
        ticket.setJourneyId(rs.getInt("journey_id"));
        ticket.setSeatNumber(rs.getString("seat_number"));
        ticket.setBookingDate(rs.getTimestamp("booking_date"));
        ticket.setStatus(rs.getString("status"));
        ticket.setPassengerName(rs.getString("passenger_name"));
        ticket.setPassengerAge(rs.getInt("passenger_age"));
        return ticket;
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

	public boolean addTicket(int id, int journeyId, String seatNumber, String passengerName, int passengerAge) {
		Connection conn = null;
        PreparedStatement stmt = null;
        boolean success = false;

        try {
            conn = DBUtil.getConnection();
            String sql = "INSERT INTO tickets (user_id, journey_id, seat_number, passenger_name, passenger_age, status) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            stmt.setInt(1, id);
            stmt.setInt(2, journeyId);
            stmt.setString(3, seatNumber);
            stmt.setString(4, passengerName);
            stmt.setInt(5, passengerAge);
            stmt.setString(6, null);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();

                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources(conn, stmt, null);
        }

        return success;
	}
}
