<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Register</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
</head>
<body>
<div class="form-container">
	<h2>Register Page</h2>
	<form action="register" method="post">
		<label for="name">Name:</label> 
		<input type="text" name="name" required /><br>
		<label for="email">Email:</label> 
		<input type="text" name="email" required /><br>
		<label for="password">Password:</label> 
		<input type="password" name="password" required /><br>
		<div class="form-group">
            <label>Select Role</label>
            <select name="role" required>
				<option value="student">Student</option>
				<option value="admin">Admin</option>
				<option value="mhprofessional">Mental Health Professional</option>
			</select>
		</div><br>
		<input type="submit" value="Register">
	</form>
	<c:if test="${not empty error}">
		<p style="color:red">${error}</p>
	</c:if>
	<p style="margin-top:15px;">
		Already have an account? <a href="login"><strong>Sign In</strong></a>
	</p>
</div>
</body>
</body>
</html>