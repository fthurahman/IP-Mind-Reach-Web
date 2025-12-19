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

        ModelAndView mv = new ModelAndView("resultDASS");
        mv.addObject("result", dassResult);

        return mv;
    }
    
    @GetMapping("/resultDASS")
    public String loadDASSResult() {
        return "resultDASS";
    }
}
