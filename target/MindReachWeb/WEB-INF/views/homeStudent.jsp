<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Home Student</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
	<!-- OVERRIDE ONLY FOR THIS PAGE -->
    <style>
    body {
        display: block !important;
        height: auto !important;
    }
    </style>
</head>
<body class="">
	
	<!-- HEADER / NAVIGATION -->
    <header class="header">
        <div class="nav-left">
            <div class="logo">MindReach</div>
            <nav class="menu">
                <a href="studentHome" class="active">Self-Assessment</a>
                <a href="resultDASS">Self-Assessment Result</a>
            </nav>
        </div>
        
    	<div class="profile">
            <img src="<c:url value='/resources/img/icon.jpg' />" class="profile-img" />
            <div class="profile-info">
                <p class="profile-name">${student.name}</p>
                <p class="profile-role">Student</p>
            </div>
            <a class="logout-btn" href="logout">Log out</a>
        </div>
    </header>
    
    <!-- PAGE TITLE -->
    <section class="page-header">
        <h1>Mental Health Self-Assessment</h1>
        <p>Take the first step towards understanding your mental wellbeing</p>
    </section>
    
    <!-- CARDS CONTAINER -->
    <section class="assessment-options">

        <!-- DASS CARD -->
        <div class="assessment-card">
            <div class="icon lightning">⚡</div>
            <h3>Depression, Anxiety & Stress Scale (DASS)</h3>
            <p>
                Measure the current mental health and emotional states, 
                identifying Depression, Anxiety or Stress.
            </p>
            <a href="DASS" class="start-btn">Start Assessment →</a>
        </div>

        <!-- PHQ CARD -->
        <div class="assessment-card">
            <div class="icon smile">😊</div>
            <h3>Patient Health Questionnaire (PHQ-9)</h3>
            <p>
                Screen for presence and severity of depression. 
                For diagnosis, consultation is recommended.
            </p>
            <a href="assessmentPHQ" class="start-btn">Start Assessment →</a>
        </div>

    </section>	
</body>
</html>