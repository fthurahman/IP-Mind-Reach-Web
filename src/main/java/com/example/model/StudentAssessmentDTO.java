package com.example.model;

import java.sql.Timestamp;

public class StudentAssessmentDTO {
    private String name;
    private String email;
    
    // Latest DASS Results
    private int depressionScore;
    private int anxietyScore;
    private int stressScore;
    private String levelDepression;
    private String levelAnxiety;
    private String levelStress;
    private Timestamp dassDate;

    // Latest PHQ Results
    private int phqScore;
    private String phqSeverity;
    private boolean phqFlagged;
    private Timestamp phqDate;

    public StudentAssessmentDTO() {}

    // Getters and Setters
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public int getDepressionScore() { return depressionScore; }
    public void setDepressionScore(int depressionScore) { this.depressionScore = depressionScore; }

    public int getAnxietyScore() { return anxietyScore; }
    public void setAnxietyScore(int anxietyScore) { this.anxietyScore = anxietyScore; }

    public int getStressScore() { return stressScore; }
    public void setStressScore(int stressScore) { this.stressScore = stressScore; }

    public String getLevelDepression() { return levelDepression; }
    public void setLevelDepression(String levelDepression) { this.levelDepression = levelDepression; }

    public String getLevelAnxiety() { return levelAnxiety; }
    public void setLevelAnxiety(String levelAnxiety) { this.levelAnxiety = levelAnxiety; }

    public String getLevelStress() { return levelStress; }
    public void setLevelStress(String levelStress) { this.levelStress = levelStress; }

    public Timestamp getDassDate() { return dassDate; }
    public void setDassDate(Timestamp dassDate) { this.dassDate = dassDate; }

    public int getPhqScore() { return phqScore; }
    public void setPhqScore(int phqScore) { this.phqScore = phqScore; }

    public String getPhqSeverity() { return phqSeverity; }
    public void setPhqSeverity(String phqSeverity) { this.phqSeverity = phqSeverity; }

    public boolean isPhqFlagged() { return phqFlagged; }
    public void setPhqFlagged(boolean phqFlagged) { this.phqFlagged = phqFlagged; }

    public Timestamp getPhqDate() { return phqDate; }
    public void setPhqDate(Timestamp phqDate) { this.phqDate = phqDate; }
}
