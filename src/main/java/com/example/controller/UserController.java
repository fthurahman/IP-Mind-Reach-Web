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
	private org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

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


		// Check if matric number already exists (only for students)
		if ("student".equals(user.getRole()) && user.getMatricNumber() != null && !user.getMatricNumber().isEmpty()) {
			System.out.println("DEBUG: Checking matric number: " + user.getMatricNumber());
			User existingUser = userDAO.findByMatricNumber(user.getMatricNumber());
			if (existingUser != null) {
				System.out.println("DEBUG: Matric number found! User: " + existingUser.getEmail());
				model.addAttribute("error", "Matric Number already exists!");
				return "register";
			} else {
				System.out.println("DEBUG: Matric number NOT found.");
			}
		} else {
			System.out.println("DEBUG: Skipping matric check. Role: " + user.getRole() + ", Matric: " + user.getMatricNumber());
		}

		// Encrypt password before saving
		user.setPassword(passwordEncoder.encode(user.getPassword()));

		userDAO.save(user);
		return "redirect:/login";
	}

	// login page
	@GetMapping("/login")
	public String showLogin() {
		return "login";
	}

	// Login POST is handled by Spring Security now
	// We keep this just in case we need to handle specific errors passed via URL
	// params,
	// but typically Spring Security handles the authentication process.

	@Autowired
	private org.springframework.jdbc.core.JdbcTemplate jdbcTemplate;

	// handle logout
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/login";
	}

	@GetMapping("/homeStudent")

	public String homeStudent(@ModelAttribute("loggedUser") User user, Model model) {
		// user is injected by GlobalControllerAdvice
		// Logic uses user.getEmail(), which is available.

		// Safety check if user somehow is null (shouldn't happen due to SecurityConfig
		// filters)
		if (user == null)
			return "redirect:/login";

		// Check for latest DASS assessment
		String sqlDASS = "SELECT assessment_date FROM dass_results WHERE user_email = ? ORDER BY assessment_date DESC LIMIT 1";
		try {
			java.sql.Timestamp latestDate = jdbcTemplate.queryForObject(sqlDASS, new Object[] { user.getEmail() },
					java.sql.Timestamp.class);
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
			java.sql.Timestamp latestDatePHQ = jdbcTemplate.queryForObject(sqlPHQ, new Object[] { user.getEmail() },
					java.sql.Timestamp.class);
			if (latestDatePHQ != null) {
				java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd MMM yyyy");
				model.addAttribute("hasPHQAssessment", true);
				model.addAttribute("latestPHQDate", sdf.format(latestDatePHQ));
			}
		} catch (org.springframework.dao.EmptyResultDataAccessException e) {
			model.addAttribute("hasPHQAssessment", false);
		}

		// LOGGING: Self-Help module usage
		if (analyticsDAO != null) {
			analyticsDAO.logActivityProgress("Self-Help", user.getEmail());
		}

		return "homeStudent";
	}

	@Autowired
	private com.example.model.AnalyticsDAO analyticsDAO;

	@GetMapping("/homeAdmin")
	public String homeAdmin(Model model) {
		// 1. Key Metrics
		int weeklyActiveUsers = analyticsDAO.getWeeklyActiveUsers();
		int totalSessions = analyticsDAO.getTotalSessionsLastWeek();
		int counselingBookings = analyticsDAO.getCounselingBookingsLastWeek();
		int pendingReports = analyticsDAO.getPendingReportsCount();

		model.addAttribute("weeklyActiveUsers", weeklyActiveUsers);
		model.addAttribute("totalSessions", totalSessions);
		model.addAttribute("counselingBookings", counselingBookings);
		model.addAttribute("pendingReports", pendingReports);

		// 2. Charts Data (Converted to JSON)
		com.fasterxml.jackson.databind.ObjectMapper mapper = new com.fasterxml.jackson.databind.ObjectMapper();
		try {
			model.addAttribute("engagementData", mapper.writeValueAsString(analyticsDAO.getEngagementTrend()));
			model.addAttribute("moduleUsageData", mapper.writeValueAsString(analyticsDAO.getModuleUsage()));
			model.addAttribute("completionRatesData", mapper.writeValueAsString(analyticsDAO.getCompletionRates()));
		} catch (com.fasterxml.jackson.core.JsonProcessingException e) {
			e.printStackTrace();
			// Fallback empty arrays
			model.addAttribute("engagementData", "[]");
			model.addAttribute("moduleUsageData", "[]");
			model.addAttribute("completionRatesData", "[]");
		}

		// 3. Lists
		model.addAttribute("topResources", analyticsDAO.getTopResources());
		model.addAttribute("reportedPosts", analyticsDAO.getReportedPosts());

		return "homeAdmin";
	}

	// User Management - List Users
	@GetMapping("/user-management")
	// User Management - List Users

	public String userManagement(@ModelAttribute("loggedUser") User user, Model model) {
		// SecurityConfig handles access logic
		if (user == null)
			return "redirect:/login";

		// Fetch all users
		java.util.List<User> allUsers = userDAO.findAll();

		// Separate lists
		java.util.List<User> pendingCounselors = new java.util.ArrayList<>();
		java.util.List<User> activeCounselors = new java.util.ArrayList<>();
		java.util.List<User> students = new java.util.ArrayList<>();

		for (User u : allUsers) {
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

	public String approveUser(@RequestParam String email) {
		// SecurityConfig handles access checks
		// We trust the admin role check done by the filter filterChain

		User userToApprove = userDAO.findByEmail(email);
		if (userToApprove != null) {
			userToApprove.setStatus("active");
			userDAO.update(userToApprove);
		}

		return "redirect:/user-management";
	}

	// Reject User
	@PostMapping("/reject-user")
	public String rejectUser(@RequestParam("email") String email) {
		// SecurityConfig handles access checks

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

	public String counselorStudentResults(@RequestParam(name = "search", required = false) String search,
			@ModelAttribute("loggedUser") User user, Model model) {
		// SecurityConfig handles access checks
		if (user == null)
			return "redirect:/login";

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
		System.out.println("DEBUG: checkEmail called with: " + email);
		User user = userDAO.findByEmail(email);

		if (user == null) {
			System.out.println("DEBUG: User NOT found in database for email: " + email);
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

		// DEBUG: Print link to console for manual testing if email fails
		System.out.println("==================================================");
		System.out.println("DEBUG: Password Reset Link: " + resetLink);
		System.out.println("==================================================");

		try {
			emailService.sendEmail(email, "Password Reset Request", message);
			redirectAttributes.addFlashAttribute("successMessage",
					"A password reset link has been sent to your email.");
		} catch (Exception e) {
			System.err.println("Failed to send email to " + email);
			e.printStackTrace();
			System.out.println("DEBUG: Password Reset Link: " + resetLink); // Fallback for local testing
			redirectAttributes.addFlashAttribute("error", "Failed to send email, but logged to console for testing.");
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
			user.setPassword(passwordEncoder.encode(newPassword));
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

	// DEBUG: Temporary endpoint to generate BCrypt hash
	@GetMapping("/debug/generate-hash")
	@ResponseBody
	public String generateHash(@RequestParam String password) {
		return passwordEncoder.encode(password);
	}

	// Profile Page
	@GetMapping("/profile")
	public String showProfile(@ModelAttribute("loggedUser") User user, Model model) {
		if (user == null) return "redirect:/login";
		return "profile";
	}

	@PostMapping("/profile/update")
	public String updateProfile(@ModelAttribute("loggedUser") User user, 
								@RequestParam String name,
								@RequestParam(required = false) String phoneNumber,
								@RequestParam(required = false) String address,
								@RequestParam(required = false) String matricNumber,
								@RequestParam(required = false) String workingPlace,
								RedirectAttributes redirectAttributes,
								HttpSession session) {
		
		if (user == null) return "redirect:/login";

		User dbUser = userDAO.findByEmail(user.getEmail());
		if (dbUser != null) {
			dbUser.setName(name);
			dbUser.setPhoneNumber(phoneNumber);
			dbUser.setAddress(address);
			
			// Conditionally update Matric Number if not set
			if ((dbUser.getMatricNumber() == null || dbUser.getMatricNumber().isEmpty()) 
					&& matricNumber != null && !matricNumber.trim().isEmpty()) {
				dbUser.setMatricNumber(matricNumber);
			}

			// Update Working Place (Always allow updates for counselors)
			if (workingPlace != null) {
				dbUser.setWorkingPlace(workingPlace);
			}

			userDAO.update(dbUser);
			
			// Update Session User to reflect changes immediately
			session.setAttribute("user", dbUser);
			
			redirectAttributes.addFlashAttribute("successMessage", "Profile updated successfully!");
		}

		return "redirect:/profile";
	}

	// Admin: View User Details (Read-only)
	@GetMapping("/admin/user-details")
	public String viewUserDetails(@RequestParam("email") String email, @ModelAttribute("loggedUser") User loggedUser, Model model) {
		// Security check: only admin can access
		// Filter handles broad access, but explicit check is good
		if (loggedUser == null || !"admin".equals(loggedUser.getRole())) {
			return "redirect:/login";
		}

		User targetUser = userDAO.findByEmail(email);
		if (targetUser == null) {
			return "redirect:/user-management";
		}

		model.addAttribute("targetUser", targetUser);

		// If student, fetch results
		if ("student".equals(targetUser.getRole())) {
			model.addAttribute("dassResults", userDAO.getDassResultsByEmail(email));
			model.addAttribute("phqResults", userDAO.getPhqResultsByEmail(email));
		}

		return "admin-user-details";
	}

}
