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
					<input type="hidden" name="role" value="student">

					<div class="form-group">
						<label for="name">Full Name</label>
						<input type="text" id="name" name="name" placeholder="Alex Johnson" required>
					</div>

					<div class="form-group">
						<label for="email">Email</label>
						<input type="text" id="email" name="email" placeholder="your.email@example.com" required>
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
				function validateForm() {
					var email = document.getElementById("email").value;
					var password = document.getElementById("password").value;
					var confirmPassword = document.getElementById("confirmPassword").value;
					var errorDiv = document.getElementById("js-error");

					// UTM Student Email Validation
					var validDomains = ["@graduate.utm.my", "@live.utm.my"];
					var isValidEmail = validDomains.some(function (domain) {
						return email.endsWith(domain);
					});

					if (!isValidEmail) {
						errorDiv.innerText = "Registration is restricted to UTM Students (@graduate.utm.my, @live.utm.my)";
						errorDiv.style.display = "block";
						return false;
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