<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Forgot Password</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
</head>
<body>
<div class="form-container">
	<h2>Forgot Password</h2>
	
	<form action="forgotPassword" method="post">
		<label for="email">Email:</label>
		<input type="text" name="email" id="email" required /><br><br>
		<input type="submit" value="Verify email"/>
	</form>
	
	<c:if test="${not empty error}">
		<p style="color:red">${error}</p>
	</c:if>
	
	 <p class="form-footer">
        <a href="<c:url value='/login' />">Back to Login</a>
    </p>	
</div>
</body>
</html>