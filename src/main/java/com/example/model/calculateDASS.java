package com.example.model;

import org.springframework.stereotype.Service;

@Service
public class calculateDASS {

    public DASS calculate(int[] scores) {

        int totalDepression = scores[2] + scores[4] + scores[9] + scores[12] + scores[15] + scores[16] + scores[20];
        int totalAnxiety = scores[1] + scores[3] + scores[6] + scores[8] + scores[14] + scores[18] + scores[19];
        int totalStress = scores[0] + scores[5] + scores[7] + scores[10] + scores[11] + scores[13] + scores[17];

        return new DASS(totalDepression, totalAnxiety, totalStress, interpretDepression(totalDepression),
                interpretAnxiety(totalAnxiety), interpretStress(totalStress));
    }

    private String interpretDepression(int score) {
        if (score <= 4)
            return "Normal";
        else if (score <= 6)
            return "Mild";
        else if (score <= 10)
            return "Moderate";
        else if (score <= 13)
            return "Severe";
        else
            return "Extremely Severe";
    }

    private String interpretAnxiety(int score) {
        if (score <= 3)
            return "Normal";
        else if (score <= 5)
            return "Mild";
        else if (score <= 7)
            return "Moderate";
        else if (score <= 9)
            return "Severe";
        else
            return "Extremely Severe";
    }

    private String interpretStress(int score) {
        if (score <= 7)
            return "Normal";
        if (score <= 9)
            return "Mild";
        if (score <= 12)
            return "Moderate";
        if (score <= 16)
            return "Severe";
        return "Extremely Severe";
    }
}
