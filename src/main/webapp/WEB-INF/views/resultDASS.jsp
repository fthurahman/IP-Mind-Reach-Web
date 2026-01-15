<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Assessment Result | MindReach</title>

            <!-- Standard CSS Environment -->
            <script src="https://cdn.tailwindcss.com"></script>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <%@ include file="layout/css-include.jsp" %>

                <style>
                    /* FORCE SCROLLING: Override any potential legacy styles causing lock-up */
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

                    .level-badge {
                        display: inline-flex;
                        align-items: center;
                        padding: 0.25rem 0.75rem;
                        border-radius: 9999px;
                        font-size: 0.875rem;
                        font-weight: 500;
                    }

                    .level-Normal {
                        background-color: #d1fae5;
                        color: #065f46;
                    }

                    /* Green */
                    .level-Mild {
                        background-color: #fef3c7;
                        color: #92400e;
                    }

                    /* Yellow */
                    .level-Moderate {
                        background-color: #ffedd5;
                        color: #9a3412;
                    }

                    /* Light Orange */
                    .level-Severe {
                        background-color: #ffccbc;
                        color: #bf360c;
                    }

                    /* Orange (Distinct from Red) */
                    .level-Extremely {
                        background-color: #fee2e2;
                        color: #b91c1c;
                    }

                    /* Red */
                </style>
        </head>

        <body>
            <!-- Standard Header -->
            <jsp:include page="layout/header.jsp">
                <jsp:param name="activePage" value="homeStudent" />
            </jsp:include>

            <!-- Main Content -->
            <!-- Increased padding-top to 120px to prevent header overlap -->
            <main class="dashboard-content" style="min-height: 100vh;">

                <div class="max-w-4xl mx-auto py-8 px-4 fade-in">

                    <!-- Header Section -->
                    <div class="text-center mb-8">
                        <div
                            class="inline-flex items-center justify-center w-16 h-16 rounded-full bg-[#B4C59B]/20 text-[#B4C59B] mb-4">
                            <i class="fas fa-chart-pie text-2xl"></i>
                        </div>
                        <!-- User manually corrected title in previous step, kept here -->
                        <h1 class="font-serif text-4xl text-[#3D3A37] mb-2">DASS Assessment Results</h1>
                        <p class="text-[#8c8784]">
                            Completed on <span class="font-medium text-[#5a5653]">${assessmentDate}</span>
                        </p>
                    </div>

                    <!-- Results Grid -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">

                        <!-- Depression Card -->
                        <div class="score-card bg-white p-6 rounded-2xl shadow-sm border border-[#e9e4df] text-center">
                            <h3 class="text-[#8c8784] font-medium uppercase tracking-wider text-xs mb-3">Depression</h3>
                            <div class="text-4xl font-serif text-[#3D3A37] mb-3">${result.depression}</div>
                            <div class="level-badge level-${result.levelDepression.split(' ')[0]}">
                                ${result.levelDepression}
                            </div>
                        </div>

                        <!-- Anxiety Card -->
                        <div class="score-card bg-white p-6 rounded-2xl shadow-sm border border-[#e9e4df] text-center">
                            <h3 class="text-[#8c8784] font-medium uppercase tracking-wider text-xs mb-3">Anxiety</h3>
                            <div class="text-4xl font-serif text-[#3D3A37] mb-3">${result.anxiety}</div>
                            <div class="level-badge level-${result.levelAnxiety.split(' ')[0]}">
                                ${result.levelAnxiety}
                            </div>
                        </div>

                        <!-- Stress Card -->
                        <div class="score-card bg-white p-6 rounded-2xl shadow-sm border border-[#e9e4df] text-center">
                            <h3 class="text-[#8c8784] font-medium uppercase tracking-wider text-xs mb-3">Stress</h3>
                            <div class="text-4xl font-serif text-[#3D3A37] mb-3">${result.stress}</div>
                            <div class="level-badge level-${result.levelStress.split(' ')[0]}">
                                ${result.levelStress}
                            </div>
                        </div>
                    </div>

                    <!-- Info / Disclaimer Box -->
                    <!-- Reduced margin-bottom to move button closer -->
                    <div class="bg-blue-50 border border-blue-100 rounded-xl p-6 mb-8 flex items-start gap-4">
                        <i class="fas fa-info-circle text-blue-500 mt-1"></i>
                        <div>
                            <h4 class="font-medium text-blue-900 mb-1">Understanding Your Results</h4>
                            <p class="text-blue-800 text-sm leading-relaxed">
                                These scores specifically reflect how you have felt over the past week.
                                They are not a diagnosis. If you are concerned about your results, consider reaching out
                                via
                                <a href="<c:url value='/telehealth'/>"
                                    class="underline font-medium hover:text-blue-950">Telehealth Assistance</a>
                                or using our <a href="<c:url value='/chatbot'/>"
                                    class="underline font-medium hover:text-blue-950">Chat Support</a>.
                            </p>
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