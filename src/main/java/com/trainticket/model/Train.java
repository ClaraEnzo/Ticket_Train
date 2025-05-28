package com.trainticket.model;

public class Train {
    private int trainId;
    private String trainNumber;
    private String trainName;
    private int totalSeats;
    private String trainType;

    public Train() {}

    public Train(String trainNumber, String trainName, int totalSeats, String trainType) {
        this.trainNumber = trainNumber;
        this.trainName = trainName;
        this.totalSeats = totalSeats;
        this.trainType = trainType;
    }

    // Getters and Setters
    public int getTrainId() { return trainId; }
    public void setTrainId(int trainId) { this.trainId = trainId; }

    public String getTrainNumber() { return trainNumber; }
    public void setTrainNumber(String trainNumber) { this.trainNumber = trainNumber; }

    public String getTrainName() { return trainName; }
    public void setTrainName(String trainName) { this.trainName = trainName; }

    public int getTotalSeats() { return totalSeats; }
    public void setTotalSeats(int totalSeats) { this.totalSeats = totalSeats; }

    public String getTrainType() { return trainType; }
    public void setTrainType(String trainType) { this.trainType = trainType; }

    // Legacy methods for backward compatibility (if other code uses these)
    public String getName() { return trainName; }
    public void setName(String name) { this.trainName = name; }

    // Helper methods for capacity calculations
    public int getCapacityFirstClass() {
        return (int) Math.floor(totalSeats * 0.2); // 20% first class
    }

    public int getCapacitySecondClass() {
        return (int) Math.floor(totalSeats * 0.3); // 30% second class
    }

    public int getCapacityEconomy() {
        return (int) Math.floor(totalSeats * 0.5); // 50% economy
    }

    @Override
    public String toString() {
        return "Train{" +
                "trainId=" + trainId +
                ", trainNumber='" + trainNumber + '\'' +
                ", trainName='" + trainName + '\'' +
                ", totalSeats=" + totalSeats +
                ", trainType='" + trainType + '\'' +
                '}';
    }
}
