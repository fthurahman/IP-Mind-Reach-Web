package com.example.model;

public class MoodEntry {
    private String date;
    private int mood;
    private String emoji;

    public MoodEntry() {
    }

    public MoodEntry(String date, int mood, String emoji) {
        this.date = date;
        this.mood = mood;
        this.emoji = emoji;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getMood() {
        return mood;
    }

    public void setMood(int mood) {
        this.mood = mood;
    }

    public String getEmoji() {
        return emoji;
    }

    public void setEmoji(String emoji) {
        this.emoji = emoji;
    }
}