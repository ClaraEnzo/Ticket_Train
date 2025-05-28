package com.trainticket.model;

public class Station {
    private int id;  // Changed from stationId to id
    private String name;
    private String city;
    private String address;
    private boolean isActive;

    public Station() {}

    public Station(String name, String city, String address) {
        this.name = name;
        this.city = city;
        this.address = address;
        this.isActive = true;
    }

    // Getters and Setters
    public int getId() { return id; }  // Added missing method
    public void setId(int id) { this.id = id; }  // Added missing method

    // Keep the old methods for backward compatibility
    public int getStationId() { return id; }
    public void setStationId(int stationId) { this.id = stationId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }

    @Override
    public String toString() {
        return "Station{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", city='" + city + '\'' +
                ", address='" + address + '\'' +
                ", isActive=" + isActive +
                '}';
    }
}