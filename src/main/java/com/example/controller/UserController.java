package com.example.controller;

import com.example.model.User;
import com.example.model.UserDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
public class UserController {

	@Autowired
	private UserDAO userDAO;

	// register page
	@GetMapping("/register")
	public String showRegister() {
		return "register";
	}

	// handle Register
	@PostMapping("/register")
	public String register(@ModelAttribute User user, Model model) {
		String email = user.getEmail();

		// Assign role based on email domain
		if (email.endsWith("@graduate.utm.my") || email.endsWith("@live.utm.my")) {
			user.setRole("student");
		} else if (email.endsWith("@gmail.com")) {
			user.setRole("mhprofessional");
		} else {
			model.addAttribute("error",
					"Registration is restricted to UTM Students (@graduate.utm.my, @live.utm.my) or Counselors (@gmail.com)");
			return "register";
		}

		// Check if email already exists
		if (userDAO.findByEmail(email) != null) {
			model.addAttribute("error", "Email already exists!");
			return "register";
		}

		userDAO.save(user);
		return "redirect:/login";
	}

	// login page
	@GetMapping("/login")
	public String showLogin() {
		return "login";
	}

	// handle login
	@PostMapping("/login")
	public String login(@RequestParam String email,
			@RequestParam String password,
			HttpSession session,
			Model model) {
		User user = userDAO.findByEmail(email);

		if (user == null) {
			model.addAttribute("error", "Email not registered yet!");
			return "login"; // show login page again with error
		}

		if (!user.getPassword().equals(password)) {
			model.addAttribute("error", "Incorrect password!");
			return "login";
		}

		// Successful login
		session.setAttribute("loggedUser", user);

		// Redirect based on role
		switch (user.getRole()) {
			case "student":
				return "redirect:/homeStudent";
			case "admin":
				return "redirect:/homeAdmin";
			case "mhprofessional":
				return "redirect:/homeMProfessional";
			default:
				return "login";
		}
	}

    @Autowired
    private org.springframework.jdbc.core.JdbcTemplate jdbcTemplate;

    // handle logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }

    @GetMapping("/homeStudent")
    public String homeStudent(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedUser");
        if (user == null) return "redirect:/login";

        // Check for latest DASS assessment
        String sql = "SELECT assessment_date FROM dass_results WHERE user_email = ? ORDER BY assessment_date DESC LIMIT 1";
        
        try {
            java.sql.Timestamp latestDate = jdbcTemplate.queryForObject(sql, new Object[]{user.getEmail()}, java.sql.Timestamp.class);
            
            if (latestDate != null) {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy");
                model.addAttribute("hasAssessment", true);
                model.addAttribute("latestAssessmentDate", sdf.format(latestDate));
            }
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            model.addAttribute("hasAssessment", false);
        }

        return "homeStudent";
    }

	@GetMapping("/homeAdmin")
	public String homeAdmin() {
		return "homeAdmin"; // maps to homeAdmin.jsp
	}

	@GetMapping("/homeMProfessional")
	public String homeMProfessional(Model model) {
		// Fetch resources for the dashboard
		model.addAttribute("resources", com.example.model.Resource.mockResources());
		model.addAttribute("currentTopic", "all");
		return "homeMProfessional"; // maps to homeMProfessional.jsp
	}

	// forgot password
	@GetMapping("/forgotPassword")
	public String forgotPassword() {
		return "forgotPassword";
	}

	// email checking for forgot password
	@PostMapping("/forgotPassword")
	public String checkEmail(@RequestParam String email, Model model) {
		User user = userDAO.findByEmail(email);

		if (user == null) {
			model.addAttribute("error", "Email not registered yet!");
			return "forgotPassword"; // show forgot password page again with error
		}

		model.addAttribute("email", email);
		return "resetPassword";
	}

	// handle password reset
	@PostMapping("/resetPassword")
	public String resetPassword(@RequestParam String email, @RequestParam String newPassword,
			RedirectAttributes redirectAttribute) {
		User user = userDAO.findByEmail(email);

		if (user != null) {
			user.setPassword(newPassword);
			userDAO.update(user);
			redirectAttribute.addFlashAttribute("successMessage",
					"Password successfully updated! You can now login with your new password.");
			return "redirect:/login";
		}
		redirectAttribute.addFlashAttribute("message", "Email not found.");
		return "resetPassword";
	}

}