<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>DASS Assessment Result</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
</head>
<body>
	<div class="result-container">
	<h2>DASS Assessment Result</h2>
	
	<div class="score-box">
        Depression Score: <strong>${result.depression}</strong>
        <span class="level ${result.levelDepression}"> → ${result.levelDepression}</span>
    </div>
	
	<div class="score-box">
        Anxiety Score: <strong>${result.anxiety}</strong>
        <span class="level ${result.levelAnxiety}"> → ${result.levelAnxiety}</span>
    </div>
    
    <div class="score-box">
        Stress Score: <strong>${result.stress}</strong>
        <span class="level ${result.levelStress}"> → ${result.levelStress}</span>
    </div>
    
	<br><a href="homeStudent" class="back-btn">Return Home</a>
	</div>
</body>
</html>