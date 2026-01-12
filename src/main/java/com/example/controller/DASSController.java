package com.example.controller;

import com.example.model.DASS;
import com.example.model.calculateDASS;
import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
    public ModelAndView processDASS(HttpServletRequest request, @ModelAttribute("loggedUser") com.example.model.User user) {

        int[] scores = new int[21];

        for (int i = 1; i <= 21; i++) {
            scores[i - 1] = Integer.parseInt(request.getParameter("q" + i));
        }

        // Call service to compute and interpret
        DASS dassResult = dassService.calculate(scores);
        
        // Get user from model
        String userEmail = (user != null) ? user.getEmail() : "guest@legacy.com";

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
    public ModelAndView loadDASSResult(@ModelAttribute("loggedUser") com.example.model.User user) {
        ModelAndView mv = new ModelAndView("resultDASS");
        
        if (user == null) return new ModelAndView("redirect:/login");

        String sql = "SELECT * FROM dass_results WHERE user_email = ? ORDER BY assessment_date DESC LIMIT 1";
        
        try {
            java.util.Map<String, Object> latestResult = jdbcTemplate.queryForMap(sql, user.getEmail());
            
            DASS dassResult = new DASS();
            dassResult.setDepression((Integer) latestResult.get("depression_score"));
            dassResult.setAnxiety((Integer) latestResult.get("anxiety_score"));
            dassResult.setStress((Integer) latestResult.get("stress_score"));
            dassResult.setLevelDepression((String) latestResult.get("level_depression"));
            dassResult.setLevelAnxiety((String) latestResult.get("level_anxiety"));
            dassResult.setLevelStress((String) latestResult.get("level_stress"));
            
            java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMMM yyyy, hh:mm a");
            String formattedDate = sdf.format((java.sql.Timestamp) latestResult.get("assessment_date"));

            mv.addObject("result", dassResult);
            mv.addObject("assessmentDate", formattedDate);
            
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            // No result found, redirect to assessment
            return new ModelAndView("redirect:/DASS");
        }

        return mv;
    }
}
