package com.trainticket.model;

import java.sql.Timestamp;

public class Ticket {
    private int id;
    private int userId;
    private int journeyId;
    private String seatNumber;
    private Timestamp bookingDate;
    private String status;
    private String passengerName;
    private int passengerAge;

    // Related objects (for joins)
    private User user;
    private Journey journey;

    // Default constructor
    public Ticket() {}

    // Constructor with essential fields
    public Ticket(int userId, int journeyId, String seatNumber, String passengerName, int passengerAge) {
        this.userId = userId;
        this.journeyId = journeyId;
        this.seatNumber = seatNumber;
        this.passengerName = passengerName;
        this.passengerAge = passengerAge;
        this.status = "CONFIRMED";
        this.bookingDate = new Timestamp(System.currentTimeMillis());
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public int getJourneyId() { return journeyId; }
    public void setJourneyId(int journeyId) { this.journeyId = journeyId; }

    public String getSeatNumber() { return seatNumber; }
    public void setSeatNumber(String seatNumber) { this.seatNumber = seatNumber; }

    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getPassengerName() { return passengerName; }
    public void setPassengerName(String passengerName) { this.passengerName = passengerName; }

    public int getPassengerAge() { return passengerAge; }
    public void setPassengerAge(int passengerAge) { this.passengerAge = passengerAge; }

    // Related objects
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public Journey getJourney() { return journey; }
    public void setJourney(Journey journey) { this.journey = journey; }

    // Helper methods
    public boolean isConfirmed() {
        return "CONFIRMED".equals(status);
    }

    public boolean isCancelled() {
        return "CANCELLED".equals(status);
    }

    public boolean isPending() {
        return "PENDING".equals(status);
    }

    @Override
    public String toString() {
        return "Ticket{" +
                "id=" + id +
                ", userId=" + userId +
                ", journeyId=" + journeyId +
                ", seatNumber='" + seatNumber + '\'' +
                ", status='" + status + '\'' +
                ", passengerName='" + passengerName + '\'' +
                ", passengerAge=" + passengerAge +
                ", bookingDate=" + bookingDate +
                '}';
    }
}
