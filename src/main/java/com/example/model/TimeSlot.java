package com.example.model;

public class TimeSlot {
    private String id;
    private String date;
    private String time;
    private boolean available;

    public TimeSlot() {
    }

    public TimeSlot(String id, String date, String time, boolean available) {
        this.id = id;
        this.date = date;
        this.time = time;
        this.available = available;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }
}