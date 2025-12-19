package com.example.model;

public class DASS{
    private int depression, anxiety, stress;
    private String levelDepression, levelAnxiety, levelStress;

    // Constructor
    public DASS(int depression, int anxiety, int stress, String levelDepression, String levelAnxiety, String levelStress) {
        this.depression = depression;
        this.anxiety = anxiety;
        this.stress = stress;
        this.levelDepression = levelDepression;
        this.levelAnxiety = levelAnxiety;
        this.levelStress = levelStress;
    }

    // Getters
    public int getDepression() { 
    	return depression; 
    }
    public int getAnxiety() { 
    	return anxiety; 
    }
    public int getStress() { 
    	return stress; 
    }
    public String getLevelDepression() { 
    	return levelDepression; 
    }
    public String getLevelAnxiety() { 
    	return levelAnxiety; 
    }
    public String getLevelStress() { 
    	return levelStress; 
    }
}
