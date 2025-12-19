<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Reset Password</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
</head>
<body>
<div class="form-container">
	<h2>Reset Password</h2>
	
	<form action="resetPassword" method="post">
		<input type="hidden" name="email" id="email" value="${email}"/>
		<label for="newPasssword">New password:</label> 
		<input type="password" name="newPassword" id="newPassword"/><br><br>
		<input type="submit" value="Reset Password"/>
	</form>
	
	<c:if test="${not empty message}">
		<p style="color:green">${message}</p>
	</c:if>
	
	<p class="form-footer">
        <a href="<c:url value='/login' />">Back to Login</a>
    </p>
</div>
</body>
</html>