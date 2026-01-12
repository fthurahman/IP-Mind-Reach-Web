<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>PHQ-9 Assessment | MindReach</title>

            <!-- Standard CSS Environment -->
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">

            <style>
                .fade-in {
                    animation: fadeIn 0.4s ease-out forwards;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(10px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                /* Custom Radio Button Styling */
                .custom-radio {
                    appearance: none;
                    background-color: #fff;
                    margin: 0;
                    font: inherit;
                    color: currentColor;
                    width: 1.25em;
                    height: 1.25em;
                    border: 2px solid #e9e4df;
                    border-radius: 50%;
                    display: grid;
                    place-content: center;
                    transition: all 0.2s;
                }

                .custom-radio::before {
                    content: "";
                    width: 0.65em;
                    height: 0.65em;
                    border-radius: 50%;
                    transform: scale(0);
                    transition: 120ms transform ease-in-out;
                    box-shadow: inset 1em 1em #B4C59B;
                }

                .custom-radio:checked {
                    border-color: #B4C59B;
                }

                .custom-radio:checked::before {
                    transform: scale(1);
                }

                .option-label {
                    display: flex;
                    align-items: center;
                    padding: 1rem;
                    border: 1px solid transparent;
                    border-radius: 0.75rem;
                    cursor: pointer;
                    transition: all 0.2s;
                }

                .option-label:hover {
                    background-color: #f7f3ef;
                }

                .option-label.selected {
                    background-color: rgba(180, 197, 155, 0.1);
                    border-color: #B4C59B;
                }
            </style>

            <script>
                let currentQn = 1;
                const totalQn = 9;

                function startAssessment() {
                    document.getElementById("intro-content").classList.add("hidden");
                    document.getElementById("assessment-content").classList.remove("hidden");
                    document.getElementById("assessment-content").classList.add("fade-in");
                    showQuestion(1);
                }

                function showQuestion(index) {
                    // Hide all questions
                    const questions = document.getElementsByClassName("question-block");
                    for (let q of questions) {
                        q.classList.add("hidden");
                    }

                    // Show current question
                    const currentQ = document.getElementById("Q" + index);
                    currentQ.classList.remove("hidden");
                    currentQ.classList.add("fade-in");

                    // Update Progress Bar
                    const progress = ((index - 1) / totalQn) * 100;
                    document.getElementById("progress-bar").style.width = progress + "%";
                    document.getElementById("question-counter").innerText = "Question " + index + " of " + totalQn;

                    // Update Navigation Buttons
                    const backBtn = document.getElementById("back-btn");
                    const nextBtn = document.getElementById("next-btn");

                    // Back button logic - hide on first question
                    if (index === 1) {
                        backBtn.classList.add("hidden");
                    } else {
                        backBtn.classList.remove("hidden");
                    }

                    // Next button text logic
                    nextBtn.innerHTML = (index === totalQn)
                        ? 'Submit Assessment <i class="fas fa-check ml-2"></i>'
                        : 'Next Question <i class="fas fa-arrow-right ml-2"></i>';

                    // Validate current selection to set button state
                    validateCurrentStep();
                }

                function handleOptionSelect(element) {
                    // Highlight selected option
                    const container = element.closest('.question-block');
                    const labels = container.querySelectorAll('.option-label');
                    labels.forEach(l => l.classList.remove('selected'));
                    element.closest('.option-label').classList.add('selected');

                    // Enable next button
                    validateCurrentStep();
                }

                function validateCurrentStep() {
                    const nextBtn = document.getElementById("next-btn");
                    const isAnswered = validateSelection(currentQn);

                    if (isAnswered) {
                        nextBtn.disabled = false;
                        nextBtn.classList.remove("opacity-50", "cursor-not-allowed");
                        nextBtn.classList.add("hover:bg-[#9aaf86]", "transform", "active:scale-95");
                    } else {
                        nextBtn.disabled = true;
                        nextBtn.classList.add("opacity-50", "cursor-not-allowed");
                        nextBtn.classList.remove("hover:bg-[#9aaf86]", "transform", "active:scale-95");
                    }
                }

                function validateSelection(qIndex) {
                    const name = "q" + qIndex;
                    const options = document.getElementsByName(name);
                    return Array.from(options).some(r => r.checked);
                }

                function nextQn() {
                    if (!validateSelection(currentQn)) return;

                    if (currentQn < totalQn) {
                        currentQn++;
                        showQuestion(currentQn);
                    } else {
                        document.getElementById("PHQ").submit();
                    }
                }

                function previousQn() {
                    if (currentQn > 1) {
                        currentQn--;
                        showQuestion(currentQn);
                    }
                }
            </script>
        </head>

        <body>
            <!-- Standard Header -->
            <jsp:include page="layout/header.jsp">
                <jsp:param name="activePage" value="homeStudent" />
            </jsp:include>

            <!-- Main Content -->
            <main class="dashboard-content" style="padding-top: 120px !important; min-height: 100vh;">

                <!-- INTRO SECTION -->
                <div id="intro-content" class="max-w-2xl mx-auto py-12 px-4 text-center fade-in">
                    <div
                        class="mb-8 inline-flex items-center justify-center w-20 h-20 rounded-full bg-[#B4C59B]/20 text-[#B4C59B]">
                        <i class="fas fa-notes-medical text-3xl"></i>
                    </div>

                    <h1 class="font-serif text-4xl mb-6 text-[#3D3A37]">Patient Health Questionnaire (PHQ-9)</h1>

                    <div class="bg-white rounded-2xl shadow-sm p-8 border border-[#e9e4df] mb-8 text-left">
                        <h3 class="font-serif text-xl mb-4 text-[#3D3A37]">Instructions</h3>
                        <p class="text-[#5a5653] mb-4 leading-relaxed">
                            Over the <strong>last 2 weeks</strong>, how often have you been bothered by any of the
                            following problems?
                        </p>
                        <ul class="text-[#5a5653] space-y-2 mb-6">
                            <li class="flex items-start gap-3">
                                <i class="fas fa-check text-[#B4C59B] mt-1"></i>
                                <span>There are no right or wrong answers.</span>
                            </li>
                            <li class="flex items-start gap-3">
                                <i class="fas fa-check text-[#B4C59B] mt-1"></i>
                                <span>Your answers will help determine the severity of your symptoms.</span>
                            </li>
                        </ul>
                    </div>

                    <button onclick="startAssessment()"
                        class="bg-[#B4C59B] text-[#3D3A37] font-semibold py-4 px-12 rounded-xl text-lg hover:bg-[#9aaf86] transition-all transform hover:scale-105 shadow-md">
                        Start Assessment
                    </button>
                </div>

                <!-- QUESTIONS SECTION -->
                <div id="assessment-content" class="hidden max-w-2xl mx-auto py-8">
                    <!-- Progress Bar -->
                    <div class="mb-8">
                        <div class="flex justify-between text-sm font-medium text-[#8c8784] mb-2">
                            <span id="question-counter">Question 1 of 9</span>
                            <span>Progress</span>
                        </div>
                        <div class="w-full bg-[#e9e4df] rounded-full h-2.5">
                            <div id="progress-bar" class="bg-[#B4C59B] h-2.5 rounded-full transition-all duration-500"
                                style="width: 0%"></div>
                        </div>
                    </div>

                    <!-- Card Container -->
                    <div class="bg-white rounded-2xl shadow-md border border-[#e9e4df] overflow-hidden">
                        <form id="PHQ" action="assessmentPHQ" method="post" class="p-0">

                            <!-- Question Loop -->
                            <c:forEach var="i" begin="1" end="9">
                                <div id="Q${i}" class="question-block p-8 hidden">
                                    <h3 class="font-serif text-2xl mb-8 text-[#3D3A37] leading-snug">
                                        <c:choose>
                                            <c:when test="${i==1}">Little interest or pleasure in doing things</c:when>
                                            <c:when test="${i==2}">Feeling down, depressed, or hopeless</c:when>
                                            <c:when test="${i==3}">Trouble falling or staying asleep, or sleeping too
                                                much</c:when>
                                            <c:when test="${i==4}">Feeling tired or having little energy</c:when>
                                            <c:when test="${i==5}">Poor appetite or overeating</c:when>
                                            <c:when test="${i==6}">Feeling bad about yourself — or that you are a
                                                failure or have let yourself or your family down</c:when>
                                            <c:when test="${i==7}">Trouble concentrating on things, such as reading the
                                                newspaper or watching television</c:when>
                                            <c:when test="${i==8}">Moving or speaking so slowly that other people could
                                                have noticed? Or the opposite — being so fidgety or restless that you
                                                have been moving around a lot more than usual</c:when>
                                            <c:when test="${i==9}">Thoughts that you would be better off dead or of
                                                hurting yourself in some way</c:when>
                                        </c:choose>
                                    </h3>

                                    <div class="space-y-3">
                                        <label class="option-label group">
                                            <input type="radio" name="q${i}" value="0" class="custom-radio mr-4"
                                                onchange="handleOptionSelect(this)">
                                            <span
                                                class="text-[#5a5653] group-hover:text-[#3D3A37] transition-colors">Not
                                                at all</span>
                                        </label>
                                        <label class="option-label group">
                                            <input type="radio" name="q${i}" value="1" class="custom-radio mr-4"
                                                onchange="handleOptionSelect(this)">
                                            <span
                                                class="text-[#5a5653] group-hover:text-[#3D3A37] transition-colors">Several
                                                days</span>
                                        </label>
                                        <label class="option-label group">
                                            <input type="radio" name="q${i}" value="2" class="custom-radio mr-4"
                                                onchange="handleOptionSelect(this)">
                                            <span
                                                class="text-[#5a5653] group-hover:text-[#3D3A37] transition-colors">More
                                                than half the days</span>
                                        </label>
                                        <label class="option-label group">
                                            <input type="radio" name="q${i}" value="3" class="custom-radio mr-4"
                                                onchange="handleOptionSelect(this)">
                                            <span
                                                class="text-[#5a5653] group-hover:text-[#3D3A37] transition-colors">Nearly
                                                every day</span>
                                        </label>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Navigation Footer -->
                            <div
                                class="bg-[#fcfbf9] px-8 py-6 border-t border-[#e9e4df] flex justify-between items-center rounded-b-2xl">
                                <button type="button" id="back-btn" onclick="previousQn()"
                                    class="text-[#8c8784] hover:text-[#3D3A37] font-medium px-4 py-2 rounded-lg hover:bg-gray-100 transition-colors hidden">
                                    Back
                                </button>

                                <button type="button" id="next-btn" onclick="nextQn()" disabled
                                    class="bg-[#B4C59B] text-[#3D3A37] font-semibold py-3 px-8 rounded-xl opacity-50 cursor-not-allowed transition-all">
                                    Next Question <i class="fas fa-arrow-right ml-2"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </body>

        </html>