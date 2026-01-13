package com.example.controller;

import com.example.model.AnalyticsDAO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

  @Autowired
  private AnalyticsDAO analyticsDAO;

  @GetMapping("/")
  public String home() {
    return "redirect:/login";
  }

  @GetMapping("/analytics")
  public String analytics(Model model) {
    // 1. Key Metrics
    int weeklyActiveUsers = analyticsDAO.getWeeklyActiveUsers();
    int totalSessions = analyticsDAO.getTotalSessionsLastWeek();
    int counselingBookings = analyticsDAO.getCounselingBookingsLastWeek();
    int pendingReports = analyticsDAO.getPendingReportsCount();

    model.addAttribute("weeklyActiveUsers", weeklyActiveUsers);
    model.addAttribute("totalSessions", totalSessions);
    model.addAttribute("counselingBookings", counselingBookings);
    model.addAttribute("pendingReports", pendingReports);

    // 2. Charts Data (Converted to JSON)
    ObjectMapper mapper = new ObjectMapper();
    try {
      model.addAttribute("engagementData", mapper.writeValueAsString(analyticsDAO.getEngagementTrend()));
      model.addAttribute("moduleUsageData", mapper.writeValueAsString(analyticsDAO.getModuleUsage()));
      model.addAttribute("completionRatesData", mapper.writeValueAsString(analyticsDAO.getCompletionRates()));
    } catch (JsonProcessingException e) {
      e.printStackTrace();
      // Fallback empty arrays
      model.addAttribute("engagementData", "[]");
      model.addAttribute("moduleUsageData", "[]");
      model.addAttribute("completionRatesData", "[]");
    }

    // 3. Lists
    model.addAttribute("topResources", analyticsDAO.getTopResources());
    model.addAttribute("reportedPosts", analyticsDAO.getReportedPosts());

    return "analytics";
  }
}
