<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>Student Assessment Result | MindReach</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <%@ include file="layout/css-include.jsp" %>
                        <script src="https://unpkg.com/lucide@latest"></script>
                        <style>
                            .result-box-active {
                                background-color: #B4C59B;
                                color: white;
                                border-color: #B4C59B;
                            }

                            .result-box-inactive {
                                background-color: white;
                                color: #3D3A37;
                                border-color: #E9E4DF;
                            }

                            .result-box-inactive:hover {
                                border-color: #B4C59B;
                                background-color: #F7FFF5;
                            }
                        </style>
                </head>

                <body class="bg-[#F7F3EF] min-h-screen">

                    <!-- Header (Copied from homeMProfessional.jsp to maintain consistency) -->
                    <!-- Header (Copied from homeMProfessional.jsp to maintain consistency) -->
                    <jsp:include page="layout/headerCounselor.jsp">
                        <jsp:param name="activePage" value="results" />
                    </jsp:include>

                    <main class="max-w-[1200px] mx-auto px-6 pb-8 pt-4 space-y-6">

                        <!-- Hero Header -->
                        <div
                            class="bg-gradient-to-r from-[#B4C59B] to-[#CADBB7] rounded-2xl p-8 mb-8 shadow-[0_4px_20px_rgba(180,197,155,0.15)] flex items-center justify-between">
                            <div>
                                <h1 class="text-3xl text-white mb-2 font-serif">Student Assessment Result</h1>
                                <p class="text-white/90">View assessment history and results</p>
                            </div>
                        </div>

                        <!-- Search Bar -->
                        <div class="mb-8 max-w-2xl mx-auto">
                            <form action="${pageContext.request.contextPath}/counselor/student-results" method="get"
                                class="relative">
                                <input type="text" name="search" value="${searchQuery}"
                                    placeholder="Search by student name..." style="padding-left: 3.5rem !important;"
                                    class="w-full pl-16 pr-12 py-3 rounded-xl border border-gray-200 focus:outline-none focus:border-[#B4C59B] focus:ring-1 focus:ring-[#B4C59B] shadow-sm">
                                <i data-lucide="search"
                                    class="w-5 h-5 text-gray-400 absolute left-4 top-1/2 transform -translate-y-1/2"></i>
                                <c:if test="${not empty searchQuery}">
                                    <a href="${pageContext.request.contextPath}/counselor/student-results"
                                        class="absolute right-4 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600">
                                        <i data-lucide="x" class="w-5 h-5"></i>
                                    </a>
                                </c:if>
                            </form>
                        </div>

                        <!-- Assessment Type Selection (2 Boxes) -->
                        <div class="grid grid-cols-2 gap-6 mb-10 max-w-2xl mx-auto">
                            <button onclick="showTab('dass')" id="btn-dass"
                                class="result-box-active p-6 rounded-2xl border-2 flex flex-col items-center justify-center transition-all shadow-sm">
                                <span class="text-xl font-serif font-bold mb-1">DASS-21</span>
                                <span class="text-sm opacity-90">Depression, Anxiety, Stress</span>
                            </button>
                            <button onclick="showTab('phq')" id="btn-phq"
                                class="result-box-inactive p-6 rounded-2xl border-2 flex flex-col items-center justify-center transition-all shadow-sm">
                                <span class="text-xl font-serif font-bold mb-1">PHQ-9</span>
                                <span class="text-sm opacity-90">Patient Health Questionnaire</span>
                            </button>
                        </div>

                        <!-- DASS Content -->
                        <div id="content-dass" class="space-y-4">
                            <h2 class="text-lg font-semibold text-[#3D3A37] mb-4">All DASS-21 Results</h2>

                            <c:if test="${empty dassResults}">
                                <div class="bg-white p-8 rounded-2xl text-center border border-[#E9E4DF] text-gray-500">
                                    <c:choose>
                                        <c:when test="${not empty searchQuery}">
                                            No data available for the searched name "${searchQuery}".
                                        </c:when>
                                        <c:otherwise>
                                            No DASS records found.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>

                            <c:forEach var="res" items="${dassResults}">
                                <div
                                    class="bg-white p-6 rounded-2xl border border-[#E9E4DF] shadow-sm hover:shadow-md transition-shadow">
                                    <div
                                        class="flex flex-col md:flex-row justify-between md:items-center gap-4 mb-4 border-b border-gray-100 pb-4">
                                        <div class="flex items-center gap-3">
                                            <div
                                                class="w-10 h-10 rounded-full bg-blue-50 text-blue-600 flex items-center justify-center">
                                                <i data-lucide="user" class="w-5 h-5"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-medium text-[#3D3A37] text-lg">${res.name}</h3>
                                                <p class="text-sm text-gray-500">${res.email}</p>
                                            </div>
                                        </div>
                                        <div
                                            class="flex items-center gap-2 text-sm text-gray-500 bg-gray-50 px-3 py-1.5 rounded-lg">
                                            <i data-lucide="calendar" class="w-4 h-4"></i>
                                            <fmt:formatDate value="${res.assessment_date}"
                                                pattern="dd MMM yyyy, hh:mm a" />
                                        </div>
                                    </div>

                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                        <!-- Depression -->
                                        <div class="bg-red-50/50 rounded-xl p-4">
                                            <div
                                                class="text-xs text-gray-500 uppercase tracking-wider font-semibold mb-1">
                                                Depression</div>
                                            <div class="flex items-baseline gap-2">
                                                <span
                                                    class="text-2xl font-bold text-gray-800">${res.depression_score}</span>
                                                <span class="text-sm font-medium
                                    ${res.level_depression == 'Normal' ? 'text-green-600' : 
                                      res.level_depression == 'Mild' ? 'text-yellow-600' : 
                                      res.level_depression == 'Moderate' ? 'text-orange-600' : 'text-red-600'}">
                                                    ${res.level_depression}
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Anxiety -->
                                        <div class="bg-yellow-50/50 rounded-xl p-4">
                                            <div
                                                class="text-xs text-gray-500 uppercase tracking-wider font-semibold mb-1">
                                                Anxiety</div>
                                            <div class="flex items-baseline gap-2">
                                                <span
                                                    class="text-2xl font-bold text-gray-800">${res.anxiety_score}</span>
                                                <span class="text-sm font-medium
                                    ${res.level_anxiety == 'Normal' ? 'text-green-600' : 
                                      res.level_anxiety == 'Mild' ? 'text-yellow-600' : 
                                      res.level_anxiety == 'Moderate' ? 'text-orange-600' : 'text-red-600'}">
                                                    ${res.level_anxiety}
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Stress -->
                                        <div class="bg-blue-50/50 rounded-xl p-4">
                                            <div
                                                class="text-xs text-gray-500 uppercase tracking-wider font-semibold mb-1">
                                                Stress</div>
                                            <div class="flex items-baseline gap-2">
                                                <span
                                                    class="text-2xl font-bold text-gray-800">${res.stress_score}</span>
                                                <span class="text-sm font-medium
                                    ${res.level_stress == 'Normal' ? 'text-green-600' : 
                                      res.level_stress == 'Mild' ? 'text-yellow-600' : 
                                      res.level_stress == 'Moderate' ? 'text-orange-600' : 'text-red-600'}">
                                                    ${res.level_stress}
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- PHQ Content -->
                        <div id="content-phq" class="space-y-4 hidden">
                            <h2 class="text-lg font-semibold text-[#3D3A37] mb-4">All PHQ-9 Results</h2>

                            <c:if test="${empty phqResults}">
                                <div class="bg-white p-8 rounded-2xl text-center border border-[#E9E4DF] text-gray-500">
                                    <c:choose>
                                        <c:when test="${not empty searchQuery}">
                                            No data available for the searched name "${searchQuery}".
                                        </c:when>
                                        <c:otherwise>
                                            No PHQ records found.
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:if>

                            <c:forEach var="res" items="${phqResults}">
                                <div
                                    class="bg-white p-6 rounded-2xl border border-[#E9E4DF] shadow-sm hover:shadow-md transition-shadow relative overflow-hidden">

                                    <c:if test="${res.flagged_suicide}">
                                        <div
                                            class="absolute top-0 right-0 bg-red-500 text-white text-xs px-3 py-1 font-bold rounded-bl-xl">
                                            High Risk</div>
                                    </c:if>

                                    <div
                                        class="flex flex-col md:flex-row justify-between md:items-center gap-4 mb-4 border-b border-gray-100 pb-4">
                                        <div class="flex items-center gap-3">
                                            <div
                                                class="w-10 h-10 rounded-full bg-indigo-50 text-indigo-600 flex items-center justify-center">
                                                <i data-lucide="user" class="w-5 h-5"></i>
                                            </div>
                                            <div>
                                                <h3 class="font-medium text-[#3D3A37] text-lg">${res.name}</h3>
                                                <p class="text-sm text-gray-500">${res.email}</p>
                                            </div>
                                        </div>
                                        <div
                                            class="flex items-center gap-2 text-sm text-gray-500 bg-gray-50 px-3 py-1.5 rounded-lg">
                                            <i data-lucide="calendar" class="w-4 h-4"></i>
                                            <fmt:formatDate value="${res.assessment_date}"
                                                pattern="dd MMM yyyy, hh:mm a" />
                                        </div>
                                    </div>

                                    <div class="flex items-center gap-6">
                                        <div class="bg-gray-50 rounded-xl p-4 flex-1">
                                            <div
                                                class="text-xs text-gray-500 uppercase tracking-wider font-semibold mb-1">
                                                Total Score</div>
                                            <div class="text-3xl font-bold text-gray-800">${res.total_score}</div>
                                        </div>
                                        <div class="bg-gray-50 rounded-xl p-4 flex-[2]">
                                            <div
                                                class="text-xs text-gray-500 uppercase tracking-wider font-semibold mb-1">
                                                Severity Level</div>
                                            <div class="text-xl font-medium 
                                ${res.severity == 'Severe' ? 'text-red-600' : 
                                  res.severity == 'Moderately Severe' ? 'text-orange-600' : 
                                  res.severity == 'Moderate' ? 'text-yellow-600' : 'text-green-600'}">
                                                ${res.severity}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                    </main>

                    <script>
                        lucide.createIcons();

                        function showTab(tabName) {
                            const btnDass = document.getElementById('btn-dass');
                            const btnPhq = document.getElementById('btn-phq');
                            const contentDass = document.getElementById('content-dass');
                            const contentPhq = document.getElementById('content-phq');

                            if (tabName === 'dass') {
                                btnDass.classList.add('result-box-active');
                                btnDass.classList.remove('result-box-inactive');
                                btnPhq.classList.add('result-box-inactive');
                                btnPhq.classList.remove('result-box-active');

                                contentDass.classList.remove('hidden');
                                contentPhq.classList.add('hidden');
                            } else {
                                btnPhq.classList.add('result-box-active');
                                btnPhq.classList.remove('result-box-inactive');
                                btnDass.classList.add('result-box-inactive');
                                btnDass.classList.remove('result-box-active');

                                contentPhq.classList.remove('hidden');
                                contentDass.classList.add('hidden');
                            }
                        }
                    </script>
                </body>

                </html>