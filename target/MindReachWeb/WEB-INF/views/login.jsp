<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Login Page</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
</head>
<body>
<div class="form-container">
	<h1>MindReach</h1>
	<p>Your gentle companion for wellbeing</p>
	<form action="login" method="post">
		<label for="email">Email</label>
		<input type="text" id="email" name="email"><br><br>
		<label for="password">Password</label>
		<input type="password" id="password" name="password"><br><br>
		<input type="submit" value="Sign In">
	</form>
	
	<c:if test="${not empty error}">
        <p style="color:red">${error}</p>
    </c:if>
    
    <br>
	<a href="forgotPassword">Forgot Password</a><br><br>
	
	<p style="margin-top:15px;">
    	Don't have an account? <a href="register"><strong>Create one</strong></a>
    </p>
    
	<c:if test="${not empty successMessage}">
		<script>
			alert("${successMessage}");
		</script>
	</c:if>
</div>
</body>
</html>