<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>PHQ-9 Assessment Result | MindReach</title>

            <!-- Standard CSS Environment -->
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="<c:url value='/resources/css/style.css' />">

            <style>
                html,
                body {
                    overflow-y: auto !important;
                    height: auto !important;
                    min-height: 100vh;
                }

                .fade-in {
                    animation: fadeIn 0.6s ease-out forwards;
                }

                @keyframes fadeIn {
                    from {
                        opacity: 0;
                        transform: translateY(20px);
                    }

                    to {
                        opacity: 1;
                        transform: translateY(0);
                    }
                }

                .score-card {
                    transition: all 0.3s ease;
                }

                .score-card:hover {
                    transform: translateY(-5px);
                    box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.1);
                }

                /* PHQ Color Classes */
                .phq-Minimal {
                    background-color: #d1fae5;
                    color: #065f46;
                }

                /* Green */
                .phq-Mild {
                    background-color: #fef3c7;
                    color: #92400e;
                }

                /* Yellow */
                .phq-Moderate {
                    background-color: #ffedd5;
                    color: #9a3412;
                }

                /* Light Orange */
                .phq-Moderately {
                    background-color: #ffccbc;
                    color: #bf360c;
                }

                /* Orange */
                .phq-Severe {
                    background-color: #fee2e2;
                    color: #b91c1c;
                }

                /* Red */

                .severity-badge {
                    display: inline-block;
                    padding: 0.5rem 1.5rem;
                    border-radius: 9999px;
                    font-weight: 600;
                    margin-top: 0.5rem;
                }
            </style>
        </head>

        <body>
            <!-- Standard Header -->
            <jsp:include page="layout/header.jsp">
                <jsp:param name="activePage" value="homeStudent" />
            </jsp:include>

            <!-- Main Content -->
            <main class="dashboard-content" style="padding-top: 120px !important; min-height: 100vh;">

                <div class="max-w-3xl mx-auto py-8 px-4 fade-in">

                    <!-- Header Section -->
                    <div class="text-center mb-8">
                        <div
                            class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-[#B4C59B]/20 text-[#B4C59B] mb-4">
                            <i class="fas fa-notes-medical text-2xl"></i>
                        </div>
                        <h1 class="font-serif text-3xl text-[#3D3A37] mb-2">PHQ-9 Results</h1>
                        <p class="text-[#8c8784]">
                            Completed on <span class="font-medium text-[#5a5653]">${assessmentDate}</span>
                        </p>
                    </div>

                    <!-- Score Card -->
                    <div class="score-card bg-white p-8 rounded-2xl shadow-sm border border-[#e9e4df] text-center mb-8">
                        <h3 class="text-[#8c8784] font-medium uppercase tracking-wider text-sm mb-4">Total Score</h3>
                        <div class="text-6xl font-serif text-[#3D3A37] mb-4">${result.totalScore}</div>

                        <!-- Dynamic Colored Badge -->
                        <div class="severity-badge phq-${result.severity.split(' ')[0]}">
                            ${result.severity}
                        </div>

                        <div class="text-sm text-[#8c8784] mt-4">
                            Score Range: 0-27
                        </div>
                    </div>

                    <!-- Critical Warning (Suicidal Ideation) -->
                    <c:if test="${result.flaggedSuicide}">
                        <div
                            class="bg-red-50 border border-red-200 rounded-xl p-6 mb-8 flex items-start gap-4 animate-pulse">
                            <i class="fas fa-exclamation-triangle text-red-600 mt-1 text-xl"></i>
                            <div>
                                <h4 class="font-bold text-red-900 mb-1 text-lg">Immediate Attention Recommended</h4>
                                <p class="text-red-800 text-sm leading-relaxed">
                                    Your response to Question 9 indicates you may be having thoughts of hurting
                                    yourself.
                                    Please reach out for professional help immediately.
                                </p>
                                <div class="mt-4 flex gap-3">
                                    <a href="tel:999"
                                        class="bg-red-600 text-white font-bold py-2 px-4 rounded-lg text-sm hover:bg-red-700">
                                        Call Emergency (999)
                                    </a>
                                    <a href="<c:url value='/telehealth'/>"
                                        class="bg-white border border-red-300 text-red-700 font-medium py-2 px-4 rounded-lg text-sm hover:bg-red-50">
                                        Contact Telehealth
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Supportive Feedback -->
                    <div class="bg-blue-50 border border-blue-100 rounded-xl p-6 mb-8 flex items-start gap-4">
                        <i class="fas fa-user-md text-blue-500 mt-1 text-xl"></i>
                        <div>
                            <h4 class="font-medium text-blue-900 mb-2">What This Means</h4>

                            <c:choose>
                                <c:when test="${result.totalScore >= 10}">
                                    <p class="text-blue-800 text-sm leading-relaxed mb-3">
                                        <strong>Your results show some symptoms, so let’s look a little closer & see
                                            what to do next.</strong>
                                    </p>
                                    <p class="text-blue-800 text-sm leading-relaxed mb-3">
                                        As you can see from your result, you appear to be experiencing symptoms of
                                        depression at present.
                                        <strong>This is not a diagnosis</strong> of depressive disorder.
                                    </p>
                                    <p class="text-blue-800 text-sm leading-relaxed">
                                        We suggest that you save this result and consider booking an appointment with
                                        <a href="<c:url value='/telehealth'/>"
                                            class="underline font-bold hover:text-blue-950">Telehealth Assistance</a>
                                        or visiting a professional to discuss this and any other concerns you may have.
                                    </p>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-blue-800 text-sm leading-relaxed mb-3">
                                        <strong>Your results exist within the range for minimal or mild
                                            symptoms.</strong>
                                    </p>
                                    <p class="text-blue-800 text-sm leading-relaxed">
                                        While no immediate action is suggested, it is always good to practice self-care.
                                        If you ever feel overwhelmed, our <a href="<c:url value='/chatbot'/>"
                                            class="underline font-bold hover:text-blue-950">Chat Support</a> is here for
                                        you.
                                    </p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex justify-center gap-4">
                        <a href="<c:url value='/homeStudent'/>"
                            class="bg-[#B4C59B] text-[#3D3A37] font-semibold py-3 px-8 rounded-xl hover:bg-[#9aaf86] transition-all transform hover:scale-105 shadow-md inline-flex items-center">
                            <i class="fas fa-home mr-2"></i> Return to Home
                        </a>
                    </div>

                </div>
            </main>
        </body>

        </html>