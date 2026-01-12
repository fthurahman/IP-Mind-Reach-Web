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
	private com.example.service.EmailService emailService;

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
			user.setStatus("active");
		} else {
			// Any other email domain is treated as a potential Counselor
			user.setRole("mhprofessional");
			user.setStatus("pending"); // Counselors need approval
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

		// Check Status
		if ("pending".equals(user.getStatus())) {
			return "redirect:/approval-pending";
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
        String sqlDASS = "SELECT assessment_date FROM dass_results WHERE user_email = ? ORDER BY assessment_date DESC LIMIT 1";
        try {
            java.sql.Timestamp latestDate = jdbcTemplate.queryForObject(sqlDASS, new Object[]{user.getEmail()}, java.sql.Timestamp.class);
            if (latestDate != null) {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy");
                model.addAttribute("hasAssessment", true);
                model.addAttribute("latestAssessmentDate", sdf.format(latestDate));
            }
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            model.addAttribute("hasAssessment", false);
        }

        // Check for latest PHQ assessment
        String sqlPHQ = "SELECT assessment_date FROM phq_results WHERE user_email = ? ORDER BY assessment_date DESC LIMIT 1";
        try {
            java.sql.Timestamp latestDatePHQ = jdbcTemplate.queryForObject(sqlPHQ, new Object[]{user.getEmail()}, java.sql.Timestamp.class);
            if (latestDatePHQ != null) {
                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy");
                model.addAttribute("hasPHQAssessment", true);
                model.addAttribute("latestPHQDate", sdf.format(latestDatePHQ));
            }
        } catch (org.springframework.dao.EmptyResultDataAccessException e) {
            model.addAttribute("hasPHQAssessment", false);
        }

        return "homeStudent";
    }

	@GetMapping("/homeAdmin")
	public String homeAdmin(HttpSession session) {
		User user = (User) session.getAttribute("loggedUser");
		if (user == null || !"admin".equals(user.getRole())) {
			return "redirect:/login";
		}
		return "homeAdmin";
	}
	
	// User Management - List Users
	@GetMapping("/user-management")
	public String userManagement(HttpSession session, Model model) {
		User user = (User) session.getAttribute("loggedUser");
		if (user == null || !"admin".equals(user.getRole())) {
			return "redirect:/login";
		}
		
		// Fetch all users
		java.util.List<User> allUsers = userDAO.findAll();
		
		// Separate lists
		java.util.List<User> pendingCounselors = new java.util.ArrayList<>();
		java.util.List<User> activeCounselors = new java.util.ArrayList<>();
		java.util.List<User> students = new java.util.ArrayList<>();
		
		for(User u : allUsers) {
			if ("mhprofessional".equals(u.getRole())) {
				if ("pending".equals(u.getStatus())) {
					pendingCounselors.add(u);
				} else {
					activeCounselors.add(u);
				}
			} else if ("student".equals(u.getRole())) {
				students.add(u);
			}
		}
		
		model.addAttribute("pendingCounselors", pendingCounselors);
		model.addAttribute("activeCounselors", activeCounselors);
		model.addAttribute("students", students);
		
		return "user-management";
	}
	
	// Approve User
	@PostMapping("/approve-user")
	public String approveUser(@RequestParam String email, HttpSession session) {
		User admin = (User) session.getAttribute("loggedUser");
		if (admin == null || !"admin".equals(admin.getRole())) {
			return "redirect:/login";
		}
		
		User userToApprove = userDAO.findByEmail(email);
		if (userToApprove != null) {
			userToApprove.setStatus("active");
			userDAO.update(userToApprove);
		}
		
		return "redirect:/user-management";
	}

	// Reject User
	@PostMapping("/reject-user")
	public String rejectUser(@RequestParam("email") String email, HttpSession session) {
		User admin = (User) session.getAttribute("loggedUser");
		if (admin == null || !"admin".equals(admin.getRole())) {
			return "redirect:/login";
		}
		
		// "Reject" means removing them from the system
		userDAO.delete(email);
		
		return "redirect:/user-management";
	}
	
	// Pending Approval Page
	@GetMapping("/approval-pending")
	public String showApprovalPending() {
		return "approval-pending";
	}

	@GetMapping("/homeMProfessional")
	public String homeMProfessional(Model model) {
		// Fetch resources for the dashboard
		model.addAttribute("resources", com.example.model.Resource.mockResources());
		model.addAttribute("currentTopic", "all");
		return "homeMProfessional"; // maps to homeMProfessional.jsp
	}

    @GetMapping("/counselor/student-results")
    public String counselorStudentResults(@RequestParam(name = "search", required = false) String search, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loggedUser");
        // Ensure user is logged in AND is a counselor
        if (user == null || !"mhprofessional".equals(user.getRole())) {
             return "redirect:/login";
        }
        
        // Fetch all attempts for DASS and PHQ with search
        java.util.List<java.util.Map<String, Object>> dassResults = userDAO.getAllDassResults(search);
        java.util.List<java.util.Map<String, Object>> phqResults = userDAO.getAllPhqResults(search);
        
        model.addAttribute("dassResults", dassResults);
        model.addAttribute("phqResults", phqResults);
        model.addAttribute("searchQuery", search); // Return search query to view
        
        return "counselor-results";
    }

	// forgot password
	@GetMapping("/forgotPassword")
	public String forgotPassword() {
		return "forgotPassword";
	}

	// email checking for forgot password
	@PostMapping("/forgotPassword")
	public String checkEmail(@RequestParam String email, RedirectAttributes redirectAttributes) {
		User user = userDAO.findByEmail(email);

		if (user == null) {
			redirectAttributes.addFlashAttribute("error", "Email not registered yet!");
			return "redirect:/login"; 
		}

        // Generate Token
        String token = java.util.UUID.randomUUID().toString();
        user.setResetToken(token);
        // Expiry 24 hours from now
        user.setResetTokenExpiry(new java.sql.Timestamp(System.currentTimeMillis() + 24 * 60 * 60 * 1000));
        userDAO.update(user);
        
        // Send Email
        String resetLink = "http://localhost:8081/resetPassword?token=" + token;
        String message = "Hello " + user.getName() + ",\n\n" +
                         "You have requested to reset your password.\n" +
                         "Click the link below to reset your password:\n" +
                         resetLink + "\n\n" +
                         "If you did not request this, please ignore this email.\n\n" +
                         "Best regards,\nMindReach Team";
        
        try {
            emailService.sendEmail(email, "Password Reset Request", message);
            redirectAttributes.addFlashAttribute("successMessage", "A password reset link has been sent to your email.");
        } catch (Exception e) {
             System.err.println("Failed to send email to " + email);
             e.printStackTrace();
             redirectAttributes.addFlashAttribute("error", "Failed to send email. Verification: " + e.getMessage());
             return "redirect:/login";
        }

		return "redirect:/login";
	}

    // Show Reset Password Page (Validate Token)
	@GetMapping("/resetPassword")
	public String showResetPassword(@RequestParam(required = false) String token, Model model) {
        if (token == null || token.isEmpty()) {
            model.addAttribute("error", "Invalid password reset token.");
            return "login";
        }
        
        User user = userDAO.findByResetToken(token);
        if (user == null || user.getResetTokenExpiry().before(new java.sql.Timestamp(System.currentTimeMillis()))) {
             model.addAttribute("error", "Invalid or expired password reset token.");
             return "login";
        }
        
        model.addAttribute("token", token);
		return "resetPassword";
	}

	// handle password reset
	@PostMapping("/resetPassword")
	public String resetPassword(@RequestParam String token, @RequestParam String newPassword,
			RedirectAttributes redirectAttribute) {
		
        User user = userDAO.findByResetToken(token);

		if (user != null && user.getResetTokenExpiry().after(new java.sql.Timestamp(System.currentTimeMillis()))) {
			user.setPassword(newPassword);
            user.setResetToken(null);
            user.setResetTokenExpiry(null);
            
			userDAO.update(user);
			redirectAttribute.addFlashAttribute("successMessage",
					"Password successfully updated! You can now login with your new password.");
			return "redirect:/login";
		}
        
		redirectAttribute.addFlashAttribute("error", "Invalid or expired token.");
		return "redirect:/login";
	}

}