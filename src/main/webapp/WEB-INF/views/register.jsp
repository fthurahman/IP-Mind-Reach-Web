<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Join MindReach</title>
			<style>
				/* Fonts */
				@import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Work+Sans:ital,wght@0,100..900;1,100..900&display=swap');

				:root {
					--font-family-serif: 'DM Serif Display', serif;
					--font-family-sans: 'Work Sans', sans-serif;

					--background: #F7F3EF;
					--foreground: #3D3A37;
					--card: #FFFFFF;
					--card-foreground: #5A5653;
					--primary: #B4C59B;
					--primary-hover: #9AAF86;
					--primary-foreground: #3D3A37;
					--muted-foreground: #8C8784;
					--border: #E9E4DF;
					--error-bg: rgba(216, 167, 158, 0.2);
					--error-text: #3D3A37;
					--error-border: rgba(216, 167, 158, 0.3);

					--radius-xl: 0.75rem;
					--radius-3xl: 1.5rem;
				}

				body {
					margin: 0;
					padding: 0;
					font-family: var(--font-family-sans);
					background-color: var(--background);
					color: var(--foreground);
					height: 100vh;
					display: flex;
					justify-content: center;
					align-items: center;
					overflow: hidden;
				}

				/* Background Image Layer - Updated for Register Page */
				.register-bg {
					position: fixed;
					top: 0;
					left: 0;
					right: 0;
					bottom: 0;
					background-image: url('https://images.unsplash.com/photo-1441974231531-c6227db76b6e?q=80&w=2560&auto=format&fit=crop');
					background-size: cover;
					background-position: center;
					background-attachment: fixed;
					z-index: -1;
				}

				/* Using a lighter overlay for this specific image if needed, or keeping standard */
				.register-overlay {
					position: absolute;
					top: 0;
					left: 0;
					right: 0;
					bottom: 0;
					/* React code uses no overlay div but the image itself. 
               We'll use a slight overlay to ensure text readability if needed, 
               or just match the CSS logic of login but with potential adjustments. 
               React code: bg-white/95 backdrop-blur-sm on card. 
            */
					z-index: 0;
				}

				/* Card Container - Updated to match Rect: bg-white/95 backdrop-blur-sm */
				.register-card {
					background: rgba(255, 255, 255, 0.95);
					backdrop-filter: blur(4px);
					width: 100%;
					max-width: 28rem;
					padding: 2rem;
					border-radius: var(--radius-3xl);
					box-shadow: 0 4px 20px rgba(180, 197, 155, 0.15);
					border: 1px solid var(--border);
					position: relative;
					z-index: 10;
					box-sizing: border-box;
				}

				h1.brand-title {
					font-family: var(--font-family-serif);
					font-size: 2rem;
					text-align: center;
					margin: 0 0 0.5rem 0;
					color: #3D3A37;
				}

				p.subtitle {
					text-align: center;
					color: var(--muted-foreground);
					margin: 0 0 1.5rem 0;
					font-size: 1rem;
				}

				.form-group {
					margin-bottom: 1rem;
				}

				label {
					display: block;
					font-size: 0.875rem;
					font-weight: 500;
					margin-bottom: 0.5rem;
					color: var(--foreground);
				}

				input[type="text"],
				input[type="email"],
				input[type="password"] {
					width: 100%;
					padding: 0.75rem 1rem;
					border-radius: var(--radius-xl);
					border: 1px solid var(--border);
					font-family: var(--font-family-sans);
					font-size: 0.875rem;
					background: #fff;
					box-sizing: border-box;
				}

				input:focus {
					outline: 2px solid var(--primary);
					outline-offset: 2px;
					border-color: var(--primary);
				}

				.btn-primary {
					width: 100%;
					padding: 0.75rem;
					border-radius: var(--radius-xl);
					background-color: var(--primary);
					color: var(--primary-foreground);
					font-weight: 500;
					font-size: 0.875rem;
					border: none;
					cursor: pointer;
					box-shadow: 0 4px 12px rgba(180, 197, 155, 0.25);
					transition: background-color 0.2s;
					margin-top: 0.5rem;
				}

				.btn-primary:hover {
					background-color: var(--primary-hover);
				}

				.error-alert {
					background-color: var(--error-bg);
					color: var(--error-text);
					padding: 0.75rem;
					border-radius: var(--radius-xl);
					font-size: 0.875rem;
					border: 1px solid var(--error-border);
					margin-bottom: 1rem;
				}

				.footer-text {
					text-align: center;
					font-size: 0.875rem;
					color: var(--muted-foreground);
					margin-top: 1.5rem;
				}

				.signin-link {
					color: #3D3A37;
					text-decoration: none;
					font-weight: 500;
					cursor: pointer;
				}

				.signin-link:hover {
					color: var(--primary);
				}

				/* Role Selection Styles */
				.role-group {
					margin-bottom: 1rem;
				}

				.role-grid {
					display: grid;
					grid-template-columns: 1fr 1fr;
					gap: 0.75rem;
				}

				.role-btn {
					padding: 1rem;
					border-radius: var(--radius-xl);
					border: 2px solid var(--border);
					background: transparent;
					cursor: pointer;
					transition: all 0.2s ease;
					display: flex;
					flex-direction: column;
					align-items: center;
					gap: 0.5rem;
				}

				.role-btn:hover {
					border-color: rgba(180, 197, 155, 0.5);
				}

				.role-btn.active {
					border-color: var(--primary);
					background-color: rgba(180, 197, 155, 0.1);
				}

				.role-icon {
					width: 24px;
					height: 24px;
					color: var(--muted-foreground);
					transition: color 0.2s;
				}

				.role-btn.active .role-icon {
					color: var(--primary);
				}

				.role-label {
					font-size: 0.875rem;
					font-weight: 500;
					color: var(--foreground);
				}
			</style>
		</head>

		<body class="auth-page">
			<div class="register-bg"></div>
			<!-- <div class="register-overlay"></div> -->
			<!-- React design has clear image, so minimal overlay or none. Removing logic for overlay to match "clear" look if preferred, but keeping div structure if needed later. -->

			<div class="register-card">
				<h1 class="brand-title">Join MindReach</h1>
				<p class="subtitle">Begin your wellness journey today</p>

				<form action="register" method="post" onsubmit="return validateForm()">
					<!-- Default role to student as per React design -->
					<input type="hidden" id="roleInput" name="role" value="student">

					<div class="form-group">
						<label for="name">Full Name</label>
						<input type="text" id="name" name="name" placeholder="Ali bin Abu" required>
					</div>

					<div class="form-group">
						<label for="email">Email</label>
						<input type="text" id="email" name="email" placeholder="name@graduate.utm.my" required>
					</div>

					<div class="form-group" id="matric-group">
						<label for="matricNumber">Matric Number</label>
						<input type="text" id="matricNumber" name="matricNumber" placeholder="A24CS0001">
					</div>

					<div class="form-group" id="hospital-group" style="display:none;">
						<label for="workingPlace">Organization / Hospital </label>
						<input type="text" id="workingPlace" name="workingPlace" placeholder="General Hospital">
					</div>

					<div class="form-group role-group">
						<label>I am a</label>
						<div class="role-grid">
							<button type="button" id="btn-student" onclick="setRole('student')" class="role-btn active">
								<div class="role-icon">
									<!-- GraduationCap SVG -->
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
										fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round">
										<path
											d="M21.42 10.922a1 1 0 0 0-.019-1.838L12.83 5.18a2 2 0 0 0-1.66 0L2.6 9.08a1 1 0 0 0 0 1.832l8.57 3.908a2 2 0 0 0 1.66 0z" />
										<path d="M22 10v6" />
										<path d="M6 12.5V16a6 3 0 0 0 12 0v-3.5" />
									</svg>
								</div>
								<span class="role-label">Student</span>
							</button>

							<button type="button" id="btn-counselor" onclick="setRole('counselor')" class="role-btn">
								<div class="role-icon">
									<!-- Stethoscope SVG -->
									<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
										fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
										stroke-linejoin="round">
										<path d="M11 2v2" />
										<path d="M5 2v2" />
										<path d="M5 3H4a2 2 0 0 0-2 2v4a6 6 0 0 0 12 0V5a2 2 0 0 0-2-2h-1" />
										<path d="M8 15a6 6 0 0 0 12 0v-3" />
										<circle cx="20" cy="10" r="2" />
									</svg>
								</div>
								<span class="role-label">Counselor</span>
							</button>
						</div>
					</div>

					<div class="form-group">
						<label for="password">Password</label>
						<input type="password" id="password" name="password" placeholder="••••••••" required>
					</div>

					<div class="form-group">
						<label for="confirmPassword">Confirm Password</label>
						<input type="password" id="confirmPassword" name="confirmPassword" placeholder="••••••••"
							required>
					</div>

					<c:if test="${not empty error}">
						<div class="error-alert">${error}</div>
					</c:if>

					<div id="js-error" class="error-alert" style="display:none;"></div>

					<button type="submit" class="btn-primary">Create Account</button>
				</form>

				<div class="footer-text">
					Already have an account? <a href="login" class="signin-link">Sign in</a>
				</div>
			</div>

			<script>
				function setRole(role) {
					document.getElementById('roleInput').value = role;

					// Reset buttons
					document.getElementById('btn-student').classList.remove('active');
					document.getElementById('btn-counselor').classList.remove('active');

					// Activate selected
					document.getElementById('btn-' + role).classList.add('active');

					// Toggle inputs
					if (role === 'student') {
						document.getElementById('matric-group').style.display = 'block';
						document.getElementById('hospital-group').style.display = 'none';
					} else {
						document.getElementById('matric-group').style.display = 'none';
						document.getElementById('hospital-group').style.display = 'block';
					}
				}

				function validateForm() {
					var email = document.getElementById("email").value;
					var password = document.getElementById("password").value;
					var confirmPassword = document.getElementById("confirmPassword").value;
					var role = document.getElementById("roleInput").value;
					var errorDiv = document.getElementById("js-error");
					var matric = document.getElementById("matricNumber").value;
					var hospital = document.getElementById("workingPlace").value;

					// Email Validation based on Role
					var isValidEmail = false;
					if (role === 'student') {
						var validDomains = ["@graduate.utm.my", "@live.utm.my"];
						isValidEmail = validDomains.some(function (domain) {
							return email.endsWith(domain);
						});
						if (!isValidEmail) {
							errorDiv.innerText = "Students must use a valid UTM email (@graduate.utm.my, @live.utm.my)";
							errorDiv.style.display = "block";
							return false;
						}
						if (matric.trim() === "") {
							errorDiv.innerText = "Please enter your Matric Number";
							errorDiv.style.display = "block";
							return false;
						}
						// Matric Number Validation: 9 characters, alphanumeric
						var matricRegex = /^[a-zA-Z0-9]{9}$/;
						if (!matricRegex.test(matric)) {
							errorDiv.innerText = "Matric Number must be exactly 9 alphanumeric characters";
							errorDiv.style.display = "block";
							return false;
						}
					} else if (role === 'counselor') {
						// Logic Update: Counselors can use any email domain
						if (email.trim() === "") {
							errorDiv.innerText = "Please enter a valid email address";
							errorDiv.style.display = "block";
							return false;
						}
						if (hospital.trim() === "") {
							errorDiv.innerText = "Please enter your Hospital Name (Working Place)";
							errorDiv.style.display = "block";
							return false;
						}
					}

					if (password.length < 6) {
						errorDiv.innerText = "Password must be at least 6 characters";
						errorDiv.style.display = "block";
						return false;
					}

					if (password !== confirmPassword) {
						errorDiv.innerText = "Passwords do not match";
						errorDiv.style.display = "block";
						return false;
					}

					errorDiv.style.display = "none";
					return true;
				}
			</script>
		</body>

		</html>