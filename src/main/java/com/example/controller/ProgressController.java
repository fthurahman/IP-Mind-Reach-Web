package com.example.controller;

import com.example.model.MoodEntry;
import com.example.model.Activity;
import com.example.service.MindReachService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Controller
public class ProgressController {

    @Autowired
    private MindReachService mindReachService;

    @GetMapping("/progress")
    public String progress(Model model, HttpSession session) {
        // Get or initialize mood data from session
        @SuppressWarnings("unchecked")
        List<MoodEntry> moodData = (List<MoodEntry>) session.getAttribute("moodData");

        if (moodData == null) {
            moodData = mindReachService.initializeMockMoodData();
            session.setAttribute("moodData", moodData);
        }

        // Calculate statistics
        double averageMood = mindReachService.calculateAverageMood(moodData);
        int currentStreak = 6; // Mock data
        int totalActivities = 27; // Mock data

        // Initialize activity data
        List<Activity> activities = mindReachService.initializeMockActivities();

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
            HttpSession session) {

        @SuppressWarnings("unchecked")
        List<MoodEntry> moodData = (List<MoodEntry>) session.getAttribute("moodData");

        if (moodData == null) {
            moodData = mindReachService.initializeMockMoodData();
        }

        // Add new mood entry
        String today = LocalDate.now().format(DateTimeFormatter.ofPattern("MM/dd"));
        moodData.add(new MoodEntry(today, moodValue, moodEmoji));

        // Keep only last 7 entries
        if (moodData.size() > 7) {
            moodData.remove(0);
        }

        session.setAttribute("moodData", moodData);

        return "redirect:/progress";
    }
}
