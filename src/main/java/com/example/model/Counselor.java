package com.example.demo.model;

import java.util.*;

public class Counselor {

    private int id;
    private String name;
    private String specialty;
    private String bio;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSpecialty() { return specialty; }
    public void setSpecialty(String specialty) { this.specialty = specialty; }

    public String getBio() { return bio; }
    public void setBio(String bio) { this.bio = bio; }

    public static List<Counselor> mockCounselors() {
        Counselor c = new Counselor();
        c.setId(1);
        c.setName("Dr. Sarah Mitchell");
        c.setSpecialty("Anxiety & Stress");
        c.setBio("CBT and mindfulness specialist");
        return List.of(c);
    }
}
