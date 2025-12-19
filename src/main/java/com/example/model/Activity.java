package com.example.model;

public class Activity {
    private String name;
    private String fullName;
    private int completed;
    private int total;

    public Activity() {
    }

    public Activity(String name, String fullName, int completed, int total) {
        this.name = name;
        this.fullName = fullName;
        this.completed = completed;
        this.total = total;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public int getCompleted() {
        return completed;
    }

    public void setCompleted(int completed) {
        this.completed = completed;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public int getPercentage() {
        return Math.round((float) completed / total * 100);
    }
}