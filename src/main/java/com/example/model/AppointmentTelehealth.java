package com.example.model;

public class AppointmentTelehealth {
    private String id;
    private String counselorId;
    private String counselorName;
    private String studentName;
    private String date;
    private String time;
    private String status; // "upcoming" or "completed"
    private String summary;
    private String recommendations;

    public AppointmentTelehealth() {
    }

    public AppointmentTelehealth(String id, String counselorId, String counselorName, String studentName, String date,
            String time, String status, String summary, String recommendations) {
        this.id = id;
        this.counselorId = counselorId;
        this.counselorName = counselorName;
        this.studentName = studentName;
        this.date = date;
        this.time = time;
        this.status = status;
        this.summary = summary;
        this.recommendations = recommendations;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCounselorId() {
        return counselorId;
    }

    public void setCounselorId(String counselorId) {
        this.counselorId = counselorId;
    }

    public String getCounselorName() {
        return counselorName;
    }

    public void setCounselorName(String counselorName) {
        this.counselorName = counselorName;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
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

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getRecommendations() {
        return recommendations;
    }

    public void setRecommendations(String recommendations) {
        this.recommendations = recommendations;
    }
}