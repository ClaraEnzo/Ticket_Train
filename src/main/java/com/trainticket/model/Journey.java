package com.trainticket.model;

import java.math.BigDecimal;
import java.util.Date;

public class Journey {
    private int journeyId;
    private Train train;
    private Route route;
    private Date departureTime;
    private Date arrivalTime;
    private String status;
    private int availableSeats;
    private BigDecimal price;  // Changed from double to BigDecimal
    private Date journeyDate;
    private boolean isDirect;  // Added missing field

    public Journey() {}

    public Journey(Train train, Route route, Date departureTime, Date arrivalTime,
                   int availableSeats, BigDecimal price, Date journeyDate) {
        this.train = train;
        this.route = route;
        this.departureTime = departureTime;
        this.arrivalTime = arrivalTime;
        this.availableSeats = availableSeats;
        this.price = price;
        this.journeyDate = journeyDate;
        this.status = "SCHEDULED";
        this.isDirect = true; // Default to direct
    }

    // Getters and Setters
    public int getJourneyId() { return journeyId; }
    public void setJourneyId(int journeyId) { this.journeyId = journeyId; }

    // Convenience method for JSP compatibility
    public int getId() { return journeyId; }
    public void setId(int id) { this.journeyId = id; }

    public Train getTrain() { return train; }
    public void setTrain(Train train) { this.train = train; }

    public Route getRoute() { return route; }
    public void setRoute(Route route) { this.route = route; }

    public Date getDepartureTime() { return departureTime; }
    public void setDepartureTime(Date departureTime) { this.departureTime = departureTime; }

    public Date getArrivalTime() { return arrivalTime; }
    public void setArrivalTime(Date arrivalTime) { this.arrivalTime = arrivalTime; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getAvailableSeats() { return availableSeats; }
    public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }

    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }

    // Convenience method for double values
    public void setPrice(double price) {
        this.price = BigDecimal.valueOf(price);
    }

    // Helper method to get price as double for calculations
    public double getPriceAsDouble() {
        return price != null ? price.doubleValue() : 0.0;
    }

    public Date getJourneyDate() { return journeyDate; }
    public void setJourneyDate(Date journeyDate) { this.journeyDate = journeyDate; }

    // Direct journey methods - ADDED
    public boolean isDirect() { return isDirect; }
    public void setDirect(boolean direct) { this.isDirect = direct; }

    // Alternative getter for JSP compatibility - ADDED
    public boolean getDirect() { return isDirect; }

    // Convenience methods for JSP to access station information
    public Station getDepartureStation() {
        return route != null ? route.getDepartureStation() : null;
    }

    public Station getArrivalStation() {
        return route != null ? route.getArrivalStation() : null;
    }

    // Helper methods
    public boolean isActive() {
        return "SCHEDULED".equals(status) || "DELAYED".equals(status);
    }

    public boolean isCancelled() {
        return "CANCELLED".equals(status);
    }

    public boolean isCompleted() {
        return "COMPLETED".equals(status);
    }

    public long getDurationInMinutes() {
        if (departureTime != null && arrivalTime != null) {
            return (arrivalTime.getTime() - departureTime.getTime()) / (1000 * 60);
        }
        return 0;
    }

    public String getFormattedDuration() {
        long minutes = getDurationInMinutes();
        long hours = minutes / 60;
        long remainingMinutes = minutes % 60;
        return String.format("%dh %02dm", hours, remainingMinutes);
    }

    public String getFormattedPrice() {
        return price != null ? String.format("$%.2f", price.doubleValue()) : "$0.00";
    }

    // Helper method to get journey type as string - ADDED
    public String getJourneyType() {
        return isDirect ? "Direct" : "Regular";
    }

    @Override
    public String toString() {
        return "Journey{" +
                "journeyId=" + journeyId +
                ", train=" + (train != null ? train.getTrainName() : "null") +
                ", route=" + route +
                ", departureTime=" + departureTime +
                ", arrivalTime=" + arrivalTime +
                ", status='" + status + '\'' +
                ", availableSeats=" + availableSeats +
                ", price=" + price +
                ", isDirect=" + isDirect +
                '}';
    }
}
