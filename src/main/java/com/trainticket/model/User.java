package com.trainticket.model;

import java.util.Date;

public class User {
    private int id;  // Changed from userId to match DB
    private String username;
    private String password;
    private String email;
    private String fullName;  // Changed to match DB full_name
    private String phone;     // Added to match DB
    private Date createdAt;

    // Default constructor
    public User() {}

    // Constructor with parameters
    public User(String username, String password, String email, String fullName, String phone) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.fullName = fullName;
        this.phone = phone;
        this.createdAt = new Date();
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    // Keep for backward compatibility
    public int getUserId() { return id; }
    public void setUserId(int userId) { this.id = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }

    // Helper methods for backward compatibility
    public String getFirstName() {
        if (fullName != null && fullName.contains(" ")) {
            return fullName.split(" ")[0];
        }
        return fullName;
    }

    public String getLastName() {
        if (fullName != null && fullName.contains(" ")) {
            String[] parts = fullName.split(" ");
            return parts[parts.length - 1];
        }
        return "";
    }

    public void setFirstName(String firstName) {
        if (fullName == null || fullName.isEmpty()) {
            fullName = firstName;
        } else {
            String lastName = getLastName();
            fullName = firstName + (lastName.isEmpty() ? "" : " " + lastName);
        }
    }

    public void setLastName(String lastName) {
        String firstName = getFirstName();
        fullName = firstName + (lastName.isEmpty() ? "" : " " + lastName);
    }

    // Default values for missing DB fields
    public String getRole() { return "USER"; }
    public void setRole(String role) { /* DB doesn't have role column */ }

    public boolean isActive() { return true; }
    public void setActive(boolean active) { /* DB doesn't have is_active column */ }
}
