package com.example.controller;

import com.example.model.MoodEntry;
import com.example.model.Activity;
import com.example.model.User;
import com.example.model.ProgressDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.time.LocalDate;
import java.util.List;

@Controller
public class ProgressController {

    @Autowired
    private ProgressDAO progressDAO;

    @Autowired
    private com.example.model.AnalyticsDAO analyticsDAO;

    @GetMapping("/progress")
    public String progress(Model model, @ModelAttribute("loggedUser") User user, java.security.Principal principal) {
             // LOGGING: Progress module usage
             if (analyticsDAO != null && principal != null) {
                 analyticsDAO.logActivityProgress("Progress", principal.getName());
             }

        if (user == null) {
            return "redirect:/login";
        }
        String email = user.getEmail();

        // 1. Fetch Mood Data
        // Default to last 7 entries for the chart
        List<MoodEntry> moodData = progressDAO.getRecentMoodEntries(email, 7);

        // 2. Fetch/Calculate Statistics
        double averageMood = progressDAO.calculateAverageMood(email);
        int currentStreak = progressDAO.getCurrentStreak(email);
        int totalActivities = progressDAO.getTotalActivities(email);

        // 3. Fetch Activities
        List<Activity> activities = progressDAO.getUserActivities(email);

        // Add data to model
        model.addAttribute("moodData", moodData);
        model.addAttribute("averageMood", String.format("%.1f", averageMood));
        model.addAttribute("currentStreak", currentStreak);
        model.addAttribute("totalActivities", totalActivities);
        model.addAttribute("activities", activities);

        return "progress";
    }

    @PostMapping("/progress/logMood")
    public String logMood(@RequestParam int moodValue,
            @RequestParam String moodEmoji,
            @ModelAttribute("loggedUser") User user) {

        if (user == null) {
            return "redirect:/login";
        }

        // Logic for "Presentation Mode": Sequential Date Increment
        // Fetch the last logged date for this user
        String lastDateStr = progressDAO.getLastMoodDate(user.getEmail());
        String entryDate;

        if (lastDateStr != null) {
            // Increment by 1 day from the last entry
            LocalDate lastDate = LocalDate.parse(lastDateStr);
            entryDate = lastDate.plusDays(1).toString();
        } else {
            // First entry starts today
            entryDate = LocalDate.now().toString();
        }

        try {
            progressDAO.logMood(user.getEmail(), moodValue, moodEmoji, entryDate);
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/progress?error=true";
        }

        return "redirect:/progress";
    }
}
