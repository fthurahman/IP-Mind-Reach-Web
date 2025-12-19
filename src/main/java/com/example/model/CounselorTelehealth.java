package com.example.model;

import java.util.List;

public class CounselorTelehealth {
    private String id;
    private String name;
    private String specialty;
    private String bio;
    private String profileImage;
    private List<TimeSlot> availableSlots;

    public CounselorTelehealth() {
    }

    public CounselorTelehealth(String id, String name, String specialty, String bio, String profileImage,
            List<TimeSlot> availableSlots) {
        this.id = id;
        this.name = name;
        this.specialty = specialty;
        this.bio = bio;
        this.profileImage = profileImage;
        this.availableSlots = availableSlots;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialty() {
        return specialty;
    }

    public void setSpecialty(String specialty) {
        this.specialty = specialty;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    public List<TimeSlot> getAvailableSlots() {
        return availableSlots;
    }

    public void setAvailableSlots(List<TimeSlot> availableSlots) {
        this.availableSlots = availableSlots;
    }
}