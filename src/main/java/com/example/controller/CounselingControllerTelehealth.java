package com.example.controller;

import com.example.model.CounselorTelehealth;
import com.example.model.TimeSlot;
import com.example.model.AppointmentTelehealth;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import com.example.model.User;
import com.example.model.TelehealthDAO;

@Controller
public class CounselingControllerTelehealth {

    @Autowired
    private TelehealthDAO telehealthDAO;

    @GetMapping("/telehealth")

    public String counseling(Model model, @ModelAttribute("loggedUser") User user) {
        if (user == null) return "redirect:/login";

        String userRole = user.getRole();

        // Fetch real appointments from DB
        List<AppointmentTelehealth> appointments;
        if ("student".equals(userRole)) {
            appointments = telehealthDAO.getSessionsByStudent(user.getEmail());
        } else {
            // If counselor accesses this page, maybe redirect? Or show their sessions?
            // For now, let's assume this page is main for students
            appointments = new ArrayList<>();
        }

        // Fetch active counselors from DB
        List<CounselorTelehealth> counselors = telehealthDAO.getAllActiveCounselors();

        // Generate dynamic time slots based on current date
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        String tomorrow = today.plusDays(1).format(formatter);
        String dayAfterTomorrow = today.plusDays(2).format(formatter);

        for (CounselorTelehealth c : counselors) {
            List<TimeSlot> slots = new ArrayList<>();
            slots.add(new TimeSlot("slot1", tomorrow, "10:00 AM", true));
            slots.add(new TimeSlot("slot2", tomorrow, "02:00 PM", true));
            slots.add(new TimeSlot("slot3", dayAfterTomorrow, "11:00 AM", true));
            slots.add(new TimeSlot("slot4", dayAfterTomorrow, "03:00 PM", true));
            c.setAvailableSlots(slots);
        }

        model.addAttribute("userRole", userRole);
        model.addAttribute("counselors", counselors);
        model.addAttribute("appointments", appointments);
        model.addAttribute("showHistory", false);

        return "telehealth";
    }

    @GetMapping("/telehealth/history")

    public String counselingHistory(Model model, @ModelAttribute("loggedUser") User user) {
        if (user == null) return "redirect:/login";

        List<AppointmentTelehealth> appointments = telehealthDAO.getSessionsByStudent(user.getEmail());
        List<CounselorTelehealth> counselors = telehealthDAO.getAllActiveCounselors();

        model.addAttribute("userRole", user.getRole());
        model.addAttribute("counselors", counselors);
        model.addAttribute("appointments", appointments);
        model.addAttribute("showHistory", true);

        return "telehealth";
    }

    @GetMapping("/telehealthCounselor")

    public String counselingCounselor(Model model, @ModelAttribute("loggedUser") User user) {
        if (user == null) return "redirect:/login";
        // Role check handled by security config ideally, or keep simple check if config missing
        // For safety, we keep role check here if config isn't updated yet, 
        // BUT verify user.getRole() matches expectations.
        if (!"mhprofessional".equals(user.getRole())) {
             // Let Global Exception handler or Access Denied handle it, or redirect
             return "redirect:/login";
        }

        List<AppointmentTelehealth> appointments = telehealthDAO.getSessionsByCounselor(user.getEmail());
        model.addAttribute("appointments", appointments);
        return "telehealthCounselor";
    }

    @PostMapping("/telehealth/book")

    public String bookAppointment(@RequestParam String counselorId,
            @RequestParam String slotDate,
            @RequestParam String slotTime,
            @ModelAttribute("loggedUser") User user) {

        if (user == null) return "redirect:/login";

        // counselorId is actually the email in our DB schema for now (or we can lookup)
        // In TelehealthDAO.getAllActiveCounselors, we set Id = email.

        telehealthDAO.bookSession(user.getEmail(), counselorId, slotDate, slotTime);

        return "redirect:/telehealth";
    }

    @PostMapping("/telehealthCounselor/start")

    public String startSession(@RequestParam int sessionId, @ModelAttribute("loggedUser") User user) {
        if (user == null) return "redirect:/login";

        telehealthDAO.startSession(sessionId);

        // We return 200 OK implicitly if we don't return a view name for AJAX,
        // but since this is a Spring MVC Controller returning String (view name),
        // and we want to use AJAX, we should probably annotate with @ResponseBody
        // or just return a simple Success string if we want to stay simple.
        // However, to keep it consistent with other methods returning redirects,
        // but consumed by AJAX, we can just return a simple HTTP OK status.
        // Let's annotate this method with @ResponseBody to return a simple string.
        return "redirect:/telehealthCounselor";
    }

    @PostMapping("/telehealthCounselor/complete")

    public String completeSession(@RequestParam int sessionId,
            @RequestParam String summary,
            @RequestParam String recommendations,
            @ModelAttribute("loggedUser") User user) {

        if (user == null) return "redirect:/login";

        telehealthDAO.completeSession(sessionId, summary, recommendations);

        return "redirect:/telehealthCounselor";
    }

    @PostMapping("/telehealthCounselor/updateNotes")

    public String updateNotes(@RequestParam int sessionId,
            @RequestParam String summary,
            @RequestParam String recommendations,
            @ModelAttribute("loggedUser") User user) {

        if (user == null) return "redirect:/login";

        telehealthDAO.updateSessionNotes(sessionId, summary, recommendations);

        return "redirect:/telehealthCounselor";
    }
}
