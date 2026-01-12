package com.example.controller;

import com.example.model.PHQ;
import com.example.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

@Controller
public class PHQController {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @GetMapping("/assessmentPHQ")
    public String loadPHQForm() {
        return "assessmentPHQ";
    }

    @PostMapping("/assessmentPHQ")
    public ModelAndView processPHQ(HttpServletRequest request) {
        int totalScore = 0;
        int q9 = 0;

        // Calculate Score
        for (int i = 1; i <= 9; i++) {
            int score = Integer.parseInt(request.getParameter("q" + i));
            totalScore += score;
            if (i == 9) q9 = score;
        }

        // Determine Severity (KPM Standard)
        String severity;
        if (totalScore <= 4) severity = "Minimal / None";
        else if (totalScore <= 9) severity = "Mild";
        else if (totalScore <= 14) severity = "Moderate";
        else if (totalScore <= 19) severity = "Moderately Severe";
        else severity = "Severe";

        boolean flaggedSuicide = (q9 >= 1);

        PHQ result = new PHQ(totalScore, severity, flaggedSuicide);

        // Save to Database
        User user = (User) request.getSession().getAttribute("loggedUser");
        String userEmail = (user != null) ? user.getEmail() : "guest@legacy.com";

        String sql = "INSERT INTO phq_results (user_email, total_score, severity, flagged_suicide, assessment_date) VALUES (?, ?, ?, ?, ?)";
        java.sql.Timestamp now = new java.sql.Timestamp(new java.util.Date().getTime());

        try {
            jdbcTemplate.update(sql, userEmail, totalScore, severity, flaggedSuicide, now);
        } catch (Exception e) {
            e.printStackTrace();
        }

        ModelAndView mv = new ModelAndView("resultPHQ");
        mv.addObject("result", result);
        mv.addObject("assessmentDate", new java.text.SimpleDateFormat("dd MMMM yyyy, hh:mm a").format(now));

        return mv;
    }

    @GetMapping("/resultPHQ")
    public ModelAndView loadPHQResult(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("resultPHQ");
        User user = (User) request.getSession().getAttribute("loggedUser");
        if (user == null) return new ModelAndView("redirect:/login");

        String sql = "SELECT * FROM phq_results WHERE user_email = ? ORDER BY assessment_date DESC LIMIT 1";

        try {
            Map<String, Object> latestResult = jdbcTemplate.queryForMap(sql, user.getEmail());
            PHQ result = new PHQ();
            result.setTotalScore((Integer) latestResult.get("total_score"));
            result.setSeverity((String) latestResult.get("severity"));
            result.setFlaggedSuicide((Boolean) latestResult.get("flagged_suicide"));

            String formattedDate = new java.text.SimpleDateFormat("dd MMMM yyyy, hh:mm a")
                    .format((java.sql.Timestamp) latestResult.get("assessment_date"));

            mv.addObject("result", result);
            mv.addObject("assessmentDate", formattedDate);
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            return new ModelAndView("redirect:/assessmentPHQ");
        }
        return mv;
    }
}
