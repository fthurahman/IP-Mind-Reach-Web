package com.example.model;

import java.util.*;

public class Appointment {

    private int id;
    private String counselorName;
    private String date;
    private String time;
    private String status;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCounselorName() {
        return counselorName;
    }

    public void setCounselorName(String counselorName) {
        this.counselorName = counselorName;
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

    public static List<Appointment> mockAppointments() {
        Appointment a = new Appointment();
        a.setId(1);
        a.setCounselorName("Dr. Sarah Mitchell");
        a.setDate("8 Nov 2025");
        a.setTime("10:00 AM");
        a.setStatus("upcoming");
        return Arrays.asList(a);
    }

    public static List<Appointment> mockCompletedAppointments() {
        Appointment a = new Appointment();
        a.setId(2);
        a.setCounselorName("Dr. James Chen");
        a.setDate("5 Nov 2025");
        a.setTime("2:00 PM");
        a.setStatus("completed");
        return Arrays.asList(a);
    }
}
