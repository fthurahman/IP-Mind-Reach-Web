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

    @RequestMapping
    public ModelAndView handleRequest(
            HttpServletRequest request,
            HttpServletResponse response) {

        ModelAndView mv = new ModelAndView();

        mv.addObject("appointments", Appointment.mockAppointments());
        mv.addObject("counselors", Counselor.mockCounselors());

        mv.setViewName("counseling-student");
        return mv;
    }
}
