package com.example.controller;

import com.example.model.DASS;
import com.example.model.calculateDASS;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DASSController {

    @Autowired
    private calculateDASS dassService;

    @Autowired
    private org.springframework.jdbc.core.JdbcTemplate jdbcTemplate;
    
    @GetMapping("/DASS")
    public String loadDASSForm() {
        return "assessmentDASS";
    }

    @PostMapping("/DASS")
    public ModelAndView processDASS(HttpServletRequest request) {

        int[] scores = new int[21];

        for (int i = 1; i <= 21; i++) {
            scores[i - 1] = Integer.parseInt(request.getParameter("q" + i));
        }

        // Call service to compute and interpret
        DASS dassResult = dassService.calculate(scores);
        
        // Get user from session
        com.example.model.User user = (com.example.model.User) request.getSession().getAttribute("loggedUser");
        String userEmail = (user != null) ? user.getEmail() : "guest@legacy.com"; // Fallback if session issue

        // Save to Database
        String sql = "INSERT INTO dass_results (user_email, depression_score, anxiety_score, stress_score, " +
                     "level_depression, level_anxiety, level_stress, assessment_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        java.sql.Timestamp now = new java.sql.Timestamp(new java.util.Date().getTime());
        
        try {
            jdbcTemplate.update(sql, userEmail, 
                dassResult.getDepression(), dassResult.getAnxiety(), dassResult.getStress(),
                dassResult.getLevelDepression(), dassResult.getLevelAnxiety(), dassResult.getLevelStress(),
                now
            );
        } catch (Exception e) {
            e.printStackTrace(); // Log error but show result anyway
        }
        
        // Format date for display
        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMMM yyyy, hh:mm a");
        String formattedDate = sdf.format(now);

        ModelAndView mv = new ModelAndView("resultDASS");
        mv.addObject("result", dassResult);
        mv.addObject("assessmentDate", formattedDate);

        return mv;
    }
    
    @GetMapping("/resultDASS")
    public String loadDASSResult() {
        return "resultDASS";
    }
}
