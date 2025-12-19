<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>DASS Assessment</title>
	<link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">
	<script>
		let currentQn=1;
		const totalQn=21;
		
		function showQuestion(index){
			const questions = document.getElementsByClassName("question");
			for(let q of questions){
				q.style.display = "none";
			}
			document.getElementById("Q"+index).style.display = "block";
			document.getElementById("back").style.display = index===1 ? "none" : "inline";
			document.getElementById("next").innerText = index===totalQn ? "Submit" : "Next";
		}
		
		function nextQn() {
		    if (!validateSelection(currentQn)) {
		        alert("Please select an answer before going next.");
		        return;
		    }

		    if (currentQn < totalQn) {
		        currentQn++;
		        showQuestion(currentQn);
		    } else {
		        document.getElementById("DASS").submit();
		    }
		}
		
		function previousQn() {
		    if (currentQn > 1) {
		        currentQn--;
		        showQuestion(currentQn);
		    }
		}
		
		function validateSelection(qIndex) {
		    const name = "q" + (qIndex);
		    const options = document.getElementsByName(name);
		    return Array.from(options).some(r => r.checked);
		}
		
		window.onload = function() {
		    showQuestion(1);
		};	
	</script>
	<style>
		.question { display: none; }
	</style>
</head>
<body>
	<div class="assessment-container">
	<h2>DEPRESSION ANXIETY STRESS TEST (DASS)</h2>
	<p>
		Please read each statement and select one answer that indicates how much the statement applied to you over the past week.<br>
		There are no right or wrong answers. Do not spend too much time on any statement.
	</p>
	
	<form id="DASS" action="DASS" method="post">
	
	<!-- Question 1 -->
	<div id="Q1" class="question">
	<p>Question 1 of 21</p>
	<fieldset>
		<legend>I found It hard to wind down.</legend>
		<label><input type="radio" name="q1" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q1" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q1" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q1" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 2 -->
	<div id="Q2" class="question">
	<p>Question 2 of 21</p>
	<fieldset>
		<legend>I was aware of dryness of my mouth.</legend>
		<label><input type="radio" name="q2" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q2" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q2" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q2" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 3 -->
	<div id="Q3" class="question">
	<p>Question 3 of 21</p>
	<fieldset>
		<legend>I couldn't seem to experience any positive feeling at all.</legend>
		<label><input type="radio" name="q3" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q3" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q3" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q3" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 4 -->
	<div id="Q4" class="question">
	<p>Question 4 of 21</p>
	<fieldset>
		<legend>I experienced breating difficulty (eg, excessively rapid breathing, breathlessness absenced of physical exertion).</legend>
		<label><input type="radio" name="q4" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q4" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q4" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q4" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 5 -->
	<div id="Q5" class="question">
	<p>Question 5 of 21</p>
	<fieldset>
		<legend>I found it difficult to work up the initiative to do things.</legend>
		<label><input type="radio" name="q5" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q5" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q5" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q5" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 6 -->
	<div id="Q6" class="question">
	<p>Question 6 of 21</p>
	<fieldset>
		<legend>I tended to over-react to situations.</legend>
		<label><input type="radio" name="q6" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q6" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q6" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q6" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 7 -->
	<div id="Q7" class="question">
	<p>Question 7 of 21</p>
	<fieldset>
		<legend>I experienced trembling (eg, In the hands).</legend>
		<label><input type="radio" name="q7" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q7" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q7" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q7" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 8 -->
	<div id="Q8" class="question">
	<p>Question 8 of 21</p>
	<fieldset>
		<legend>I felt that I was using a lot of nervous energy.</legend>
		<label><input type="radio" name="q8" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q8" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q8" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q8" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 9 -->
	<div id="Q9" class="question">
	<p>Question 9 of 21</p>
	<fieldset>
		<legend>I was worried about situations in which might panic and make a fool of myself.</legend>
		<label><input type="radio" name="q9" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q9" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q9" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q9" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 10 -->
	<div id="Q10" class="question">
	<p>Question 10 of 21</p>
	<fieldset>
		<legend>I felt that I had nothing to look forward to.</legend>
		<label><input type="radio" name="q10" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q10" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q10" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q10" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 11 -->
	<div id="Q11" class="question">
	<p>Question 11 of 21</p>
	<fieldset>
		<legend>I found myself getting agitated.</legend>
		<label><input type="radio" name="q11" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q11" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q11" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q11" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 12 -->
	<div id="Q12" class="question">
	<p>Question 12 of 21</p>
	<fieldset>
		<legend>I found difficult to relax.</legend>
		<label><input type="radio" name="q12" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q12" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q12" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q12" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 13 -->
	<div id="Q13" class="question">
	<p>Question 13 of 21</p>
	<fieldset>
		<legend>I felt down-hearted and blue.</legend>
		<label><input type="radio" name="q13" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q13" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q13" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q13" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 14 -->
	<div id="Q14" class="question">
	<p>Question 14 of 21</p>
	<fieldset>
		<legend>I was intolerant of anything that kept me from getting on with what I was doing.</legend>
		<label><input type="radio" name="q14" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q14" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q14" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q14" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 15 -->
	<div id="Q15" class="question">
	<p>Question 15 of 21</p>
	<fieldset>
		<legend>I felt I was close to panic.</legend>
		<label><input type="radio" name="q15" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q15" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q15" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q15" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 16 -->
	<div id="Q16" class="question">
	<p>Question 16 of 21</p>
	<fieldset>
		<legend>I was unable to become enthusiastic about anything.</legend>
		<label><input type="radio" name="q16" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q16" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q16" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q16" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 17 -->
	<div id="Q17" class="question">
	<p>Question 17 of 21</p>
	<fieldset>
		<legend>I felt I wasn't worth much as a person.</legend>
		<label><input type="radio" name="q17" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q17" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q17" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q17" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 18 -->
	<div id="Q18" class="question">
	<p>Question 18 of 21</p>
	<fieldset>
		<legend>I felt that I was rather touchy.</legend>
		<label><input type="radio" name="q18" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q18" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q18" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q18" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 19 -->
	<div id="Q19" class="question">
	<p>Question 19 of 21</p>
	<fieldset>
		<legend>I was aware of the action of my heart in the absence of physical exertion (eg, sense of heart rate increase, heart missing a beat.</legend>
		<label><input type="radio" name="q19" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q19" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q19" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q19" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 20 -->
	<div id="Q20" class="question">
	<p>Question 20 of 21</p>
	<fieldset>
		<legend>I felt scared without any good reason.</legend>
		<label><input type="radio" name="q20" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q20" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q20" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q20" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
	<!-- Question 21 -->
	<div id="Q21" class="question">
	<p>Question 21 of 21</p>
	<fieldset>
		<legend>I felt that life was meaningless.</legend>
		<label><input type="radio" name="q21" value="0">Did not apply to me at all</label><br>
		<label><input type="radio" name="q21" value="1">Applied to me to some degree, or some of the time</label><br>
		<label><input type="radio" name="q21" value="2">Applied to me to a considerable degree, good part of time</label><br>
		<label><input type="radio" name="q21" value="3">Applied to me very much, or most of the time</label><br>
	</fieldset>
	</div>
	
		<br><button type="button" id="back" onclick="previousQn()">Back</button>
		<button type="button" id="next" onclick="nextQn()">Next</button>
	</form>
	</div>
</body>
</html>