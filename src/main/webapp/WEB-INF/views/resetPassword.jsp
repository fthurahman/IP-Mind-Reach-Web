<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<title>Reset Password</title>
			<style>
				/* Fonts */
				@import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Work+Sans:ital,wght@0,100..900;1,100..900&display=swap');

				:root {
					/* Colors matching login.jsp */
					--font-family-serif: 'DM Serif Display', serif;
					--font-family-sans: 'Work Sans', sans-serif;

					--background: #F7F3EF;
					--foreground: #3D3A37;
					--card: #FFFFFF;
					--card-foreground: #5A5653;
					--primary: #B4C59B;
					--primary-hover: #9AAF86;
					--primary-foreground: #3D3A37;
					--secondary: #D8A79E;
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
					padding: 2rem;
					border-radius: var(--radius-3xl);
					box-shadow: 0 4px 20px rgba(180, 197, 155, 0.15);
					border: 1px solid var(--border);
					position: relative;
					z-index: 10;
					box-sizing: border-box;
					text-align: center;
				}

				h1.brand-title {
					font-family: var(--font-family-serif);
					font-size: 2rem;
					margin: 0 0 0.5rem 0;
					color: #3D3A37;
				}

				p.subtitle {
					color: var(--muted-foreground);
					margin: 0 0 1.5rem 0;
					font-size: 1rem;
				}

				.form-group {
					margin-bottom: 1rem;
					text-align: left;
				}

				label {
					display: block;
					font-size: 0.875rem;
					font-weight: 500;
					margin-bottom: 0.5rem;
					color: var(--foreground);
				}

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
					margin-top: 1rem;
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
					text-align: left;
				}

				.footer-text {
					text-align: center;
					font-size: 0.875rem;
					color: var(--muted-foreground);
					margin-top: 1.5rem;
				}

				.footer-text a {
					color: var(--foreground);
					text-decoration: none;
					font-weight: 500;
				}

				.footer-text a:hover {
					color: var(--primary);
				}
			</style>
		</head>

		<body>
			<!-- Full Canvas Background -->
			<div class="login-bg"></div>
			<div class="login-overlay"></div>

			<!-- Main Card -->
			<div class="login-card">
				<h1 class="brand-title">Reset Password</h1>
				<p class="subtitle">Enter your new password below</p>

				<c:if test="${not empty error}">
					<div class="error-alert">${error}</div>
				</c:if>

				<form action="resetPassword" method="post">
					<input type="hidden" name="token" value="${token}" />

					<div class="form-group">
						<label for="newPassword">New Password</label>
						<input type="password" name="newPassword" id="newPassword" placeholder="••••••••" required />
					</div>

					<button type="submit" class="btn-primary">Update Password</button>
				</form>

				<div class="footer-text">
					<a href="<c:url value='/login' />">Back to Login</a>
				</div>
			</div>
		</body>

		</html>