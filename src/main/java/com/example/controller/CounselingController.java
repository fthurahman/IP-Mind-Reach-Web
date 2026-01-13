package com.example.controller;

import com.example.model.*;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/counseling")
public class CounselingController {

    @org.springframework.beans.factory.annotation.Autowired
    private com.example.model.AnalyticsDAO analyticsDAO;

    @RequestMapping
    public ModelAndView handleRequest(
            HttpServletRequest request,
            HttpServletResponse response,
            java.security.Principal principal) {
        
        // LOGGING: Counseling module usage
        if (analyticsDAO != null && principal != null) {
                analyticsDAO.logActivityProgress("Counseling", principal.getName());
        }

        ModelAndView mv = new ModelAndView();

        mv.addObject("appointments", Appointment.mockAppointments());
        mv.addObject("counselors", Counselor.mockCounselors());

        mv.setViewName("counseling-student");
        return mv;
    }
}
