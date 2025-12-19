<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Login Page</title>
			<style>
				/* Fonts */
				@import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Work+Sans:ital,wght@0,100..900;1,100..900&display=swap');

				:root {
					/* Colors from global.css */
					--font-family-serif: 'DM Serif Display', serif;
					--font-family-sans: 'Work Sans', sans-serif;

					--background: #F7F3EF;
					--foreground: #3D3A37;
					--card: #FFFFFF;
					--card-foreground: #5A5653;
					--primary: #B4C59B;
					/* Muted Olive */
					--primary-hover: #9AAF86;
					--primary-foreground: #3D3A37;
					--secondary: #D8A79E;
					/* Clay Blush */
					--muted-foreground: #8C8784;
					--border: #E9E4DF;
					--error-bg: rgba(216, 167, 158, 0.2);
					--error-text: #3D3A37;
					--error-border: rgba(216, 167, 158, 0.3);

					--radius-xl: 0.75rem;
					/* rounded-xl */
					--radius-3xl: 1.5rem;
					/* rounded-3xl */
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
					/* For fixed background */
				}

				/* Background Image Layer */
				.login-bg {
					position: fixed;
					top: 0;
					left: 0;
					right: 0;
					bottom: 0;
					background-image: url('https://images.unsplash.com/photo-1710685375110-3b1f3bf8bb1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwZWFjZWZ1bCUyMG5hdHVyZSUyMGJhY2tncm91bmR8ZW58MXx8fHwxNzYyNTA5MDQ4fDA&ixlib=rb-4.1.0&q=80&w=1080');
					background-size: cover;
					background-position: center;
					background-attachment: fixed;
					z-index: -1;
				}

				.login-overlay {
					position: absolute;
					top: 0;
					left: 0;
					right: 0;
					bottom: 0;
					background-color: rgba(0, 0, 0, 0.4);
					z-index: 0;
				}

				/* Card Container */
				.login-card {
					background: var(--card);
					width: 100%;
					max-width: 28rem;
					/* max-w-md */
					padding: 2rem;
					border-radius: var(--radius-3xl);
					box-shadow: 0 4px 20px rgba(180, 197, 155, 0.15);
					border: 1px solid var(--border);
					position: relative;
					z-index: 10;
					box-sizing: border-box;
				}

				/* Typography */
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

				/* Forms */
				.form-group {
					margin-bottom: 1rem;
				}

				label {
					display: block;
					font-size: 0.875rem;
					/* text-sm */
					font-weight: 500;
					margin-bottom: 0.5rem;
					color: var(--foreground);
				}

				.input-wrapper {
					position: relative;
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
					/* Crucial for width: 100% */
				}

				input:focus {
					outline: 2px solid var(--primary);
					outline-offset: 2px;
					border-color: var(--primary);
				}

				/* Links and Buttons */
				.password-header {
					display: flex;
					justify-content: space-between;
					align-items: center;
					margin-bottom: 0.5rem;
				}

				.forgot-link {
					font-size: 0.75rem;
					/* text-xs */
					color: var(--primary);
					text-decoration: none;
					background: none;
					border: none;
					cursor: pointer;
					padding: 0;
				}

				.forgot-link:hover {
					color: var(--primary-hover);
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

				/* Footer */
				.footer-text {
					text-align: center;
					font-size: 0.875rem;
					color: var(--muted-foreground);
					margin-top: 1.5rem;
				}

				.create-account-link {
					color: var(--foreground);
					text-decoration: none;
					background: none;
					border: none;
					cursor: pointer;
					font-weight: 500;
					padding: 0;
				}

				.create-account-link:hover {
					color: var(--primary);
				}

				.demo-accounts {
					margin-top: 1rem;
					padding: 0.75rem;
					background-color: rgba(180, 197, 155, 0.2);
					/* Light primary bg */
					border: 1px dashed var(--primary);
					border-radius: var(--radius-xl);
					font-size: 0.8rem;
					color: var(--foreground);
					text-align: center;
					line-height: 1.5;
					font-weight: 500;
				}

				.demo-accounts p {
					margin: 0;
				}

				/* Modal/Dialog */
				.dialog-backdrop {
					display: none;
					/* Hidden by default */
					position: fixed;
					top: 0;
					left: 0;
					right: 0;
					bottom: 0;
					background-color: rgba(0, 0, 0, 0.5);
					z-index: 50;
					justify-content: center;
					align-items: center;
					opacity: 0;
					transition: opacity 0.2s ease-in-out;
				}

				.dialog-backdrop.open {
					display: flex;
					opacity: 1;
				}

				.dialog-content {
					background: white;
					width: 90%;
					max-width: 425px;
					padding: 1.5rem;
					border-radius: 1rem;
					/* rounded-2xl */
					box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
					transform: scale(0.95);
					transition: transform 0.2s ease;
				}

				.dialog-backdrop.open .dialog-content {
					transform: scale(1);
				}

				.dialog-icon {
					width: 3rem;
					height: 3rem;
					background: rgba(180, 197, 155, 0.2);
					border-radius: 50%;
					display: flex;
					align-items: center;
					justify-content: center;
					margin: 0 auto 1rem auto;
					color: var(--primary);
				}

				.dialog-title {
					text-align: center;
					font-family: var(--font-family-serif);
					font-size: 1.25rem;
					margin: 0 0 0.5rem 0;
				}

				.dialog-description {
					text-align: center;
					color: var(--card-foreground);
					font-size: 0.875rem;
					margin-bottom: 1.5rem;
				}

				.dialog-actions {
					display: flex;
					gap: 0.5rem;
					margin-top: 1.5rem;
				}

				.btn-outline {
					flex: 1;
					padding: 0.75rem;
					border-radius: var(--radius-xl);
					border: 1px solid var(--border);
					background: white;
					cursor: pointer;
					font-weight: 500;
				}

				.btn-outline:hover {
					background: #f9f9f9;
				}
			</style>
		</head>

		<body class="auth-page">
			<!-- Full Canvas Background -->
			<div class="login-bg"></div>
			<div class="login-overlay"></div>

			<!-- Login Card -->
			<div class="login-card">
				<h1 class="brand-title">MindReach</h1>
				<p class="subtitle">Your gentle companion for wellbeing</p>

				<form action="login" method="post">
					<div class="form-group">
						<label for="email">Email</label>
						<input type="text" id="email" name="email" placeholder="your.email@example.com" required>
					</div>

					<div class="form-group">
						<div class="password-header">
							<label for="password">Password</label>
							<button type="button" class="forgot-link" onclick="openModal()">Forgot password?</button>
						</div>
						<input type="password" id="password" name="password" placeholder="••••••••" required>
					</div>

					<c:if test="${not empty error}">
						<div class="error-alert">${error}</div>
					</c:if>

					<button type="submit" class="btn-primary">Sign In</button>
				</form>

				<div class="footer-text">
					Don't have an account? <a href="register" class="create-account-link">Create one</a>
				</div>

				<div class="demo-accounts">
					<p>Student: ali_student@graduate.utm.my</p>
				</div>
			</div>

			<!-- Forgot Password Modal -->
			<div id="forgotPasswordModal" class="dialog-backdrop">
				<div class="dialog-content">
					<div class="dialog-icon">
						<!-- Simple Mail Icon SVG -->
						<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
							stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
							<rect width="20" height="16" x="2" y="4" rx="2" />
							<path d="m22 7-8.97 5.7a1.94 1.94 0 0 1-2.06 0L2 7" />
						</svg>
					</div>
					<h2 class="dialog-title">Forgot Password?</h2>
					<p class="dialog-description">No worries! Enter your email and we'll send you a password reset link.
					</p>

					<form action="forgotPassword" method="get">
						<!-- Assuming GET for demo simplicity or map to POST logic -->
						<div class="form-group">
							<label for="recoveryEmail">Email</label>
							<input type="email" id="recoveryEmail" placeholder="your.email@example.com" required>
						</div>

						<div class="dialog-actions">
							<button type="button" class="btn-outline" onclick="closeModal()">Cancel</button>
							<button type="submit" class="btn-primary" style="box-shadow:none;">Send Reset Link</button>
						</div>
					</form>
				</div>
			</div>

			<script>
				function openModal() {
					const modal = document.getElementById('forgotPasswordModal');
					modal.classList.add('open');
				}

				function closeModal() {
					const modal = document.getElementById('forgotPasswordModal');
					modal.classList.remove('open');
				}

				// Close on click outside
				window.onclick = function (event) {
					const modal = document.getElementById('forgotPasswordModal');
					if (event.target == modal) {
						closeModal();
					}
				}

				// Check for success message
				var successMsg = "${successMessage}";
				if (successMsg && successMsg.trim() !== "") {
					alert(successMsg);
				}
			</script>
		</body>

		</html>