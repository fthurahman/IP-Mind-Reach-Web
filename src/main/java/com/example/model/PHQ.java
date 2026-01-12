package com.example.model;

public class PHQ {
    private int totalScore;
    private String severity;
    private boolean flaggedSuicide;

    public PHQ() {}

    public PHQ(int totalScore, String severity, boolean flaggedSuicide) {
        this.totalScore = totalScore;
        this.severity = severity;
        this.flaggedSuicide = flaggedSuicide;
    }

    public int getTotalScore() { return totalScore; }
    public void setTotalScore(int totalScore) { this.totalScore = totalScore; }

    public String getSeverity() { return severity; }
    public void setSeverity(String severity) { this.severity = severity; }

    public boolean isFlaggedSuicide() { return flaggedSuicide; }
    public void setFlaggedSuicide(boolean flaggedSuicide) { this.flaggedSuicide = flaggedSuicide; }
}
