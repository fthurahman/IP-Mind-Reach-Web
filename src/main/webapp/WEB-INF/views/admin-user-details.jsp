<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <title>User Details | MindReach Admin</title>
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

                            /* Read-only inputs */
                            input:disabled {
                                background-color: #F9FAFB;
                                color: #6B7280;
                                border-color: #E5E7EB;
                            }
                        </style>
                </head>

                <body class="bg-[#F7F3EF] min-h-screen">

                    <!-- Admin Header -->
                    <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
                        <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
                            <a href="${pageContext.request.contextPath}/homeAdmin"
                                class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
                            <nav class="hidden lg:flex items-center gap-6">
                                <a href="${pageContext.request.contextPath}/homeAdmin"
                                    class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Analytics</a>
                                <a href="${pageContext.request.contextPath}/resources"
                                    class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Resources</a>
                                <a href="${pageContext.request.contextPath}/forum-monitor"
                                    class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Forum
                                    Monitor</a>
                                <a href="${pageContext.request.contextPath}/user-management"
                                    class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">User
                                    Management</a>
                            </nav>
                            <div class="hidden lg:flex items-center gap-3">
                                <div class="text-right">
                                    <div class="text-sm text-[#3D3A37] font-medium">${fn:split(loggedUser.name, ' ')[0]}
                                    </div>
                                    <div class="text-xs text-gray-500 capitalize">${loggedUser.role}</div>
                                </div>
                                <div
                                    class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B]">
                                    <i data-lucide="user"></i>
                                </div>
                                <a href="${pageContext.request.contextPath}/logout" class="btn-ghost"
                                    style="margin-left: 1rem;">
                                    Log out
                                </a>
                            </div>
                        </div>
                    </header>

                    <main class="max-w-[1200px] mx-auto px-6 py-8 space-y-8">

                        <!-- Back Button -->
                        <a href="${pageContext.request.contextPath}/user-management"
                            class="inline-flex items-center gap-2 text-sm text-gray-500 hover:text-gray-900 transition-colors mb-4">
                            <i data-lucide="arrow-left" class="w-4 h-4"></i> Back to User List
                        </a>

                        <!-- Basic User Profile Card -->
                        <div class="bg-white rounded-2xl p-8 border border-[#E9E4DF] shadow-sm">
                            <h1 class="text-2xl font-serif text-[#3D3A37] mb-6">User Profile Details</h1>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                <!-- Name -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Full Name</label>
                                    <input type="text" value="${targetUser.name}" disabled
                                        class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none">
                                </div>

                                <!-- Email -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Email Address</label>
                                    <input type="text" value="${targetUser.email}" disabled
                                        class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none">
                                </div>

                                <!-- Role -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Role</label>
                                    <input type="text" value="${targetUser.role}" disabled
                                        class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none capitalize">
                                </div>

                                <!-- Status -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Status</label>
                                    <input type="text" value="${targetUser.status}" disabled
                                        class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none capitalize">
                                </div>

                                <!-- Phone -->
                                <div>
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Phone Number</label>
                                    <input type="text"
                                        value="${targetUser.phoneNumber != null ? targetUser.phoneNumber : 'Not set'}"
                                        disabled
                                        class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none">
                                </div>

                                <!-- Matrics / Working Place -->
                                <c:choose>
                                    <c:when test="${targetUser.role eq 'student'}">
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-2">Matric
                                                Number</label>
                                            <input type="text"
                                                value="${targetUser.matricNumber != null ? targetUser.matricNumber : 'Not set'}"
                                                disabled
                                                class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none">
                                        </div>
                                    </c:when>
                                    <c:when test="${targetUser.role eq 'mhprofessional'}">
                                        <div>
                                            <label class="block text-sm font-medium text-gray-700 mb-2">Organization /
                                                Hospital</label>
                                            <input type="text"
                                                value="${targetUser.workingPlace != null ? targetUser.workingPlace : 'Not set'}"
                                                disabled
                                                class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none">
                                        </div>
                                    </c:when>
                                </c:choose>

                                <!-- Address -->
                                <div class="md:col-span-2">
                                    <label class="block text-sm font-medium text-gray-700 mb-2">Address</label>
                                    <textarea disabled rows="2"
                                        class="w-full px-4 py-2 rounded-xl border border-gray-200 focus:outline-none">${targetUser.address != null ? targetUser.address : 'Not set'}</textarea>
                                </div>
                            </div>
                        </div>

                        <!-- Student Assessment Results (Only for Students) -->
                        <c:if test="${targetUser.role eq 'student'}">
                            <div class="bg-white rounded-2xl p-8 border border-[#E9E4DF] shadow-sm">
                                <h2 class="text-xl font-serif text-[#3D3A37] mb-6">Assessment History</h2>

                                <!-- Tabs -->
                                <div class="flex gap-4 mb-6">
                                    <button onclick="showTab('dass')" id="btn-dass"
                                        class="result-box-active px-4 py-2 rounded-lg font-medium transition-colors">
                                        DASS-21
                                    </button>
                                    <button onclick="showTab('phq')" id="btn-phq"
                                        class="result-box-inactive px-4 py-2 rounded-lg font-medium transition-colors">
                                        PHQ-9
                                    </button>
                                </div>

                                <!-- DASS Results -->
                                <div id="content-dass" class="space-y-4">
                                    <c:if test="${empty dassResults}">
                                        <p class="text-gray-500 text-center py-4">No DASS-21 records found for this
                                            student.</p>
                                    </c:if>
                                    <c:forEach var="res" items="${dassResults}">
                                        <div class="bg-gray-50 p-4 rounded-xl border border-gray-100">
                                            <div class="flex justify-between items-center mb-3">
                                                <span class="text-sm font-medium text-gray-600">
                                                    <i data-lucide="calendar" class="w-4 h-4 inline mr-1"></i>
                                                    <fmt:formatDate value="${res.assessment_date}"
                                                        pattern="dd MMM yyyy, hh:mm a" />
                                                </span>
                                            </div>
                                            <div class="grid grid-cols-3 gap-4">
                                                <div class="bg-red-50/50 rounded-xl p-4">
                                                    <div
                                                        class="text-xs text-gray-500 uppercase tracking-wider font-semibold mb-1">
                                                        Depression</div>
                                                    <div class="flex items-baseline gap-2">
                                                        <span
                                                            class="text-2xl font-bold text-gray-800">${res.depression_score}</span>
                                                        <span
                                                            class="text-sm font-medium
                                            ${res.level_depression == 'Normal' ? 'text-green-600' : 
                                              res.level_depression == 'Mild' ? 'text-yellow-600' : 
                                              res.level_depression == 'Moderate' ? 'text-orange-600' : 'text-red-600'}">
                                                            ${res.level_depression}
                                                        </span>
                                                    </div>
                                                </div>
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

                                <!-- PHQ Results -->
                                <div id="content-phq" class="space-y-4 hidden">
                                    <c:if test="${empty phqResults}">
                                        <p class="text-gray-500 text-center py-4">No PHQ-9 records found for this
                                            student.</p>
                                    </c:if>
                                    <c:forEach var="res" items="${phqResults}">
                                        <div
                                            class="bg-gray-50 p-4 rounded-xl border border-gray-100 relative overflow-hidden">
                                            <c:if test="${res.flagged_suicide}">
                                                <div
                                                    class="absolute top-0 right-0 bg-red-500 text-white text-[10px] px-2 py-0.5 font-bold rounded-bl-lg">
                                                    High Risk</div>
                                            </c:if>
                                            <div class="flex justify-between items-center mb-3">
                                                <span class="text-sm font-medium text-gray-600">
                                                    <i data-lucide="calendar" class="w-4 h-4 inline mr-1"></i>
                                                    <fmt:formatDate value="${res.assessment_date}"
                                                        pattern="dd MMM yyyy, hh:mm a" />
                                                </span>
                                            </div>
                                            <div class="flex gap-8">
                                                <div class="bg-gray-50 rounded-xl p-4 flex-1">
                                                    <div
                                                        class="text-xs text-gray-500 uppercase tracking-wider font-semibold mb-1">
                                                        Total Score</div>
                                                    <div class="text-3xl font-bold text-gray-800">${res.total_score}
                                                    </div>
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

                            </div>
                        </c:if>

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