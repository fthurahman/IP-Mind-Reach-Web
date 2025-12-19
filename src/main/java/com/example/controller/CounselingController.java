package com.example.controller;

import com.example.demo.model.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.Controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CounselingController implements Controller {

    @Override
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
