package com.trainticket.model;

public class Route {
    private int routeId;
    private String name;  // Added missing name field
    private Station departureStation;
    private Station arrivalStation;
    private double distance;
    private int estimatedDuration; // in minutes
    private boolean isDirect;

    public Route() {}

    public Route(String name, Station departureStation, Station arrivalStation, double distance) {
        this.name = name;
        this.departureStation = departureStation;
        this.arrivalStation = arrivalStation;
        this.distance = distance;
        this.isDirect = true;
    }

    // Getters and Setters
    public int getRouteId() { return routeId; }
    public void setRouteId(int routeId) { this.routeId = routeId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public Station getDepartureStation() { return departureStation; }
    public void setDepartureStation(Station departureStation) { this.departureStation = departureStation; }

    public Station getArrivalStation() { return arrivalStation; }
    public void setArrivalStation(Station arrivalStation) { this.arrivalStation = arrivalStation; }

    public double getDistance() { return distance; }
    public void setDistance(double distance) { this.distance = distance; }

    public int getEstimatedDuration() { return estimatedDuration; }
    public void setEstimatedDuration(int estimatedDuration) { this.estimatedDuration = estimatedDuration; }

    public boolean isDirect() { return isDirect; }
    public void setDirect(boolean direct) { isDirect = direct; }

    // Helper methods
    public String getRouteDescription() {
        if (departureStation != null && arrivalStation != null) {
            return departureStation.getCity() + " → " + arrivalStation.getCity();
        }
        return "Unknown Route";
    }

    public String getFormattedDistance() {
        return String.format("%.1f km", distance);
    }

    // Auto-generate name if not set
    public String getDisplayName() {
        if (name != null && !name.trim().isEmpty()) {
            return name;
        }
        return getRouteDescription();
    }

    @Override
    public String toString() {
        return "Route{" +
                "routeId=" + routeId +
                ", name='" + name + '\'' +
                ", departureStation=" + (departureStation != null ? departureStation.getName() : "null") +
                ", arrivalStation=" + (arrivalStation != null ? arrivalStation.getName() : "null") +
                ", distance=" + distance +
                ", isDirect=" + isDirect +
                '}';
    }
}
