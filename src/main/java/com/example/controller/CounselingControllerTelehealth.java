package com.example.controller;

import com.example.model.CounselorTelehealth;
import com.example.model.TimeSlot;
import com.example.model.AppointmentTelehealth;
import com.example.service.MindReachService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class CounselingControllerTelehealth {

    @Autowired
    private MindReachService mindReachService;

    @GetMapping("/counseling")
    public String counseling(Model model, HttpSession session) {
        String userRole = "student"; // Default to student view

        // Get or initialize appointments from session
        @SuppressWarnings("unchecked")
        List<AppointmentTelehealth> appointments = (List<AppointmentTelehealth>) session.getAttribute("appointments");

        if (appointments == null) {
            appointments = mindReachService.initializeStudentAppointments();
            session.setAttribute("appointments", appointments);
        }

        // Initialize counselors
        List<CounselorTelehealth> counselors = mindReachService.initializeMockCounselors();

        // Add data to model
        model.addAttribute("userRole", userRole);
        model.addAttribute("counselors", counselors);
        model.addAttribute("appointments", appointments);
        model.addAttribute("showHistory", false);

        return "counseling";
    }

    @GetMapping("/counseling/history")
    public String counselingHistory(Model model, HttpSession session) {
        String userRole = "student";

        @SuppressWarnings("unchecked")
        List<AppointmentTelehealth> appointments = (List<AppointmentTelehealth>) session.getAttribute("appointments");

        if (appointments == null) {
            appointments = mindReachService.initializeStudentAppointments();
            session.setAttribute("appointments", appointments);
        }

        List<CounselorTelehealth> counselors = mindReachService.initializeMockCounselors();

        model.addAttribute("userRole", userRole);
        model.addAttribute("counselors", counselors);
        model.addAttribute("appointments", appointments);
        model.addAttribute("showHistory", true);

        return "counseling";
    }

    @PostMapping("/counseling/book")
    public String bookAppointment(@RequestParam String counselorId,
            @RequestParam String counselorName,
            @RequestParam String slotId,
            @RequestParam String slotDate,
            @RequestParam String slotTime,
            HttpSession session) {

        @SuppressWarnings("unchecked")
        List<AppointmentTelehealth> appointments = (List<AppointmentTelehealth>) session.getAttribute("appointments");

        if (appointments == null) {
            appointments = mindReachService.initializeStudentAppointments();
        }

        // Create new appointment
        String appointmentId = String.valueOf(System.currentTimeMillis());
        AppointmentTelehealth newAppointment = new AppointmentTelehealth(
                appointmentId, counselorId, counselorName, null,
                slotDate, slotTime, "upcoming", null, null);

        appointments.add(newAppointment);
        session.setAttribute("appointments", appointments);

        return "redirect:/counseling";
    }
}
