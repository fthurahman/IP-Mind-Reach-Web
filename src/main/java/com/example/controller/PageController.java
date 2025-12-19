package com.example.controller;

import com.example.model.ReportedPost;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class PageController {

  @GetMapping("/")
  public String home() {
    return "index";
  }

  @GetMapping("/analytics")
  public String analytics(Model model) {
    List<ReportedPost> reportedPosts = new ArrayList<>();
    reportedPosts.add(new ReportedPost(
        "1",
        "This is a potentially inappropriate post that was flagged by users.",
        "Anonymous Fox",
        "Inappropriate content",
        "Anonymous Owl",
        new Date(System.currentTimeMillis() - 2L * 60 * 60 * 1000),
        "pending"));
    reportedPosts.add(new ReportedPost(
        "2",
        "Another post that was reported for containing harmful advice.",
        "Anonymous Bear",
        "Harmful advice",
        "Anonymous Butterfly",
        new Date(System.currentTimeMillis() - 5L * 60 * 60 * 1000),
        "pending"));

    int pendingReports = 0;
    for (ReportedPost p : reportedPosts) {
      if ("pending".equalsIgnoreCase(p.getStatus()))
        pendingReports++;
    }

    model.addAttribute("reportedPosts", reportedPosts);
    model.addAttribute("pendingReports", pendingReports);
    return "analytics";
  }

  // ⚠️ BUANG method ni terus:
  // @GetMapping("/chatbot")
  // public String chatbot() { return "chatbot"; }
}
