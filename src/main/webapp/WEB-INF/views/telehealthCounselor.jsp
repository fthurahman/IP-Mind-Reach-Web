<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Telehealth Assistance | MindReach Counselor</title>
                    <script src="https://cdn.tailwindcss.com"></script>
                    <%@ include file="layout/css-include.jsp" %>
                        <script src="https://unpkg.com/lucide@latest"></script>
                        <style>
                            .session-card {
                                transition: all 0.3s ease;
                            }

                            .session-card:hover {
                                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
                            }

                            .modal {
                                display: none;
                                position: fixed;
                                z-index: 1000;
                                left: 0;
                                top: 0;
                                width: 100%;
                                height: 100%;
                                background-color: rgba(0, 0, 0, 0.5);
                            }

                            .modal.show {
                                display: flex;
                                align-items: center;
                                justify-content: center;
                            }

                            .modal-content {
                                background-color: white;
                                border-radius: 1rem;
                                max-width: 90%;
                                max-height: 90vh;
                                overflow-y: auto;
                            }
                        </style>
                </head>

                <body class="bg-[#F7F3EF] min-h-screen">

                    <!-- Header for Counselor -->
                    <jsp:include page="layout/headerCounselor.jsp">
                        <jsp:param name="activePage" value="telehealth" />
                    </jsp:include>

                    <main class="max-w-[1200px] mx-auto px-6 pb-8 pt-4 space-y-6">
                        <!-- Green Gradient Header -->
                        <div
                            class="bg-gradient-to-r from-[#B4C59B] to-[#CADBB7] rounded-2xl p-8 shadow-[0_4px_20px_rgba(180,197,155,0.15)]">
                            <h1 class="text-3xl text-white mb-2 font-serif">Telehealth Assistance</h1>
                            <p class="text-white/90">Manage your telehealth sessions</p>
                        </div>

                        <!-- Upcoming Sessions Section -->
                        <div>
                            <h2 class="text-xl mb-4 font-medium text-[#3D3A37]">Upcoming Sessions</h2>
                            <div class="space-y-4">
                                <c:set var="hasUpcoming" value="false" />
                                <c:forEach var="appointment" items="${appointments}">
                                    <c:if
                                        test="${appointment.status == 'upcoming' || appointment.status == 'in_progress'}">
                                        <c:set var="hasUpcoming" value="true" />
                                        <div class="session-card bg-white p-6 border-0 shadow-lg rounded-2xl">
                                            <div class="flex items-start justify-between">
                                                <div class="flex-1">
                                                    <p class="font-medium text-[#3D3A37] mb-1">
                                                        ${not empty appointment.studentName ? appointment.studentName :
                                                        'Student'}
                                                    </p>
                                                    <p class="text-sm text-[#5A5653]">
                                                        <fmt:parseDate value="${appointment.date}" pattern="yyyy-MM-dd"
                                                            var="parsedDate" />
                                                        <fmt:formatDate value="${parsedDate}"
                                                            pattern="EEEE, MMMM d, yyyy" /> at ${appointment.time}
                                                    </p>
                                                </div>
                                                <div class="flex items-center gap-3">
                                                    <span id="status-badge-${appointment.id}"
                                                        class="bg-[#CADBB7] text-[#3D3A37] px-3 py-1 rounded-full text-sm font-medium">
                                                        <c:choose>
                                                            <c:when test="${appointment.status == 'in_progress'}">In
                                                                Progress</c:when>
                                                            <c:otherwise>Upcoming</c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                    <button id="view-details-btn-${appointment.id}"
                                                        data-id="${appointment.id}"
                                                        data-student-name="${fn:escapeXml(appointment.studentName)}"
                                                        data-date="${appointment.date}" data-time="${appointment.time}"
                                                        data-status="${appointment.status}"
                                                        onclick="openDetailsModal(this)"
                                                        class="px-4 py-2 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium text-sm transition-colors">
                                                        View Details
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <c:if test="${not hasUpcoming}">
                                    <div class="bg-white p-6 border-0 shadow-lg rounded-2xl text-center py-8">
                                        <p class="text-[#5A5653]">No upcoming sessions scheduled</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Completed Sessions Section -->
                        <div>
                            <h2 class="text-xl mb-4 font-medium text-[#3D3A37]">Completed Sessions</h2>
                            <div class="space-y-4">
                                <c:set var="hasCompleted" value="false" />
                                <c:forEach var="appointment" items="${appointments}">
                                    <c:if test="${appointment.status == 'completed'}">
                                        <c:set var="hasCompleted" value="true" />
                                        <div class="session-card bg-white p-6 border-0 shadow-lg rounded-2xl">
                                            <div class="flex items-start justify-between">
                                                <div class="flex-1">
                                                    <p class="font-medium text-[#3D3A37] mb-1">
                                                        ${not empty appointment.studentName ? appointment.studentName :
                                                        'Student'}
                                                    </p>
                                                    <p class="text-sm text-[#5A5653]">
                                                        <fmt:parseDate value="${appointment.date}" pattern="yyyy-MM-dd"
                                                            var="parsedDate" />
                                                        <fmt:formatDate value="${parsedDate}"
                                                            pattern="EEEE, MMMM d, yyyy" /> at ${appointment.time}
                                                    </p>
                                                    <c:if test="${not empty appointment.summary}">
                                                        <p class="text-sm text-gray-500 mt-2"><strong>Notes:</strong>
                                                            ${appointment.summary}</p>
                                                    </c:if>
                                                </div>
                                                <div class="flex items-center gap-3">
                                                    <span
                                                        class="border border-[#B4C59B] text-[#3D3A37] px-3 py-1 rounded-full text-sm font-medium">
                                                        Completed
                                                    </span>
                                                    <button data-id="${appointment.id}"
                                                        data-student-name="${fn:escapeXml(appointment.studentName)}"
                                                        data-date="${appointment.date}" data-time="${appointment.time}"
                                                        data-summary="${fn:escapeXml(appointment.summary)}"
                                                        data-recommendations="${fn:escapeXml(appointment.recommendations)}"
                                                        onclick="openNotesModal(this)"
                                                        class="px-4 py-2 rounded-xl border border-[#B4C59B] hover:bg-[#B4C59B]/10 text-[#3D3A37] font-medium text-sm transition-colors">
                                                        <i data-lucide="edit-3" class="w-4 h-4 inline mr-1"></i>
                                                        Edit Notes
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                                <c:if test="${not hasCompleted}">
                                    <div class="bg-white p-6 border-0 shadow-lg rounded-2xl text-center py-8">
                                        <p class="text-[#5A5653]">No completed sessions yet</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </main>

                    <!-- Session Details Modal (for upcoming sessions) -->
                    <div id="detailsModal" class="modal">
                        <div class="modal-content p-6 max-w-lg w-full mx-4">
                            <div class="flex justify-between items-center mb-4">
                                <h2 class="text-xl font-bold text-[#3D3A37]">Session Details</h2>
                                <button onclick="closeDetailsModal()" class="text-gray-500 hover:text-gray-700">
                                    <i data-lucide="x" class="w-5 h-5"></i>
                                </button>
                            </div>

                            <div class="bg-gray-50 rounded-xl p-4 mb-4">
                                <div class="flex items-center gap-3 mb-3">
                                    <div
                                        class="w-12 h-12 rounded-full bg-[#B4C59B]/20 flex items-center justify-center">
                                        <i data-lucide="user" class="w-6 h-6 text-[#B4C59B]"></i>
                                    </div>
                                    <div>
                                        <p class="font-medium text-[#3D3A37]" id="detailsStudentName">Student Name</p>
                                        <span
                                            class="bg-[#CADBB7] text-[#3D3A37] px-2 py-0.5 rounded-full text-xs">Upcoming</span>
                                    </div>
                                </div>

                                <div class="space-y-2">
                                    <div class="flex items-center gap-2 text-sm text-[#5A5653]">
                                        <i data-lucide="calendar" class="w-4 h-4 text-[#B4C59B]"></i>
                                        <span id="detailsDate">Date</span>
                                    </div>
                                    <div class="flex items-center gap-2 text-sm text-[#5A5653]">
                                        <i data-lucide="clock" class="w-4 h-4 text-[#B4C59B]"></i>
                                        <span id="detailsTime">Time</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Action Buttons -->
                            <div class="space-y-3">
                                <button id="startSessionBtn" onclick="startTelehealthSession()"
                                    class="w-full px-4 py-3 bg-[#B4C59B] text-white rounded-xl hover:bg-[#9AAF86] font-medium transition-colors flex items-center justify-center gap-2">
                                    <i data-lucide="video" class="w-5 h-5"></i>
                                    Start Telehealth Session
                                </button>
                                <button id="completeSessionBtn" onclick="openCompleteModal()" disabled
                                    class="w-full px-4 py-3 border border-[#E9E4DF] text-gray-400 rounded-xl font-medium transition-colors flex items-center justify-center gap-2 cursor-not-allowed opacity-60">
                                    <i data-lucide="check-circle" class="w-5 h-5"></i>
                                    Complete Session & Add Notes
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Complete Session Modal -->
                    <div id="completeModal" class="modal">
                        <div class="modal-content p-6 max-w-lg w-full mx-4">
                            <div class="flex justify-between items-center mb-4">
                                <h2 class="text-xl font-bold text-[#3D3A37]">Complete Session & Add Notes</h2>
                                <button onclick="closeCompleteModal()" class="text-gray-500 hover:text-gray-700">
                                    <i data-lucide="x" class="w-5 h-5"></i>
                                </button>
                            </div>

                            <form action="${pageContext.request.contextPath}/telehealthCounselor/complete"
                                method="post">
                                <input type="hidden" name="sessionId" id="completeSessionId">

                                <div class="bg-gray-50 rounded-xl p-4 mb-4">
                                    <div class="flex items-center gap-3 mb-3">
                                        <div
                                            class="w-12 h-12 rounded-full bg-[#B4C59B]/20 flex items-center justify-center">
                                            <i data-lucide="user" class="w-6 h-6 text-[#B4C59B]"></i>
                                        </div>
                                        <div>
                                            <p class="font-medium text-[#3D3A37]" id="completeStudentName">Student Name
                                            </p>
                                            <span
                                                class="bg-[#CADBB7] text-[#3D3A37] px-2 py-0.5 rounded-full text-xs">Upcoming</span>
                                        </div>
                                    </div>

                                    <div class="space-y-2">
                                        <div class="flex items-center gap-2 text-sm text-[#5A5653]">
                                            <i data-lucide="calendar" class="w-4 h-4 text-[#B4C59B]"></i>
                                            <span id="completeDate">Date</span>
                                        </div>
                                        <div class="flex items-center gap-2 text-sm text-[#5A5653]">
                                            <i data-lucide="clock" class="w-4 h-4 text-[#B4C59B]"></i>
                                            <span id="completeTime">Time</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-sm font-medium text-[#3D3A37] mb-2">Session Summary
                                            <span class="text-red-500">*</span></label>
                                        <textarea name="summary" id="completeSummary" rows="3" required
                                            placeholder="Brief summary of the session discussion..."
                                            class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]"></textarea>
                                    </div>
                                    <div>
                                        <label
                                            class="block text-sm font-medium text-[#3D3A37] mb-2">Recommendations</label>
                                        <textarea name="recommendations" id="completeRecommendations" rows="3"
                                            placeholder="Any recommendations for the student..."
                                            class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]"></textarea>
                                    </div>
                                </div>

                                <div class="flex gap-3 pt-4">
                                    <button type="button" onclick="closeCompleteModal()"
                                        class="flex-1 px-4 py-2 border border-[#E9E4DF] rounded-xl hover:bg-gray-50 text-sm font-medium">
                                        Cancel
                                    </button>
                                    <button type="submit"
                                        class="flex-1 px-4 py-2 bg-[#B4C59B] text-white rounded-xl hover:bg-[#9AAF86] text-sm font-medium flex items-center justify-center gap-2">
                                        <i data-lucide="check-circle" class="w-4 h-4"></i>
                                        Complete Session
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <!-- Edit Notes Modal -->
                    <div id="notesModal" class="modal">
                        <div class="modal-content p-6 max-w-lg w-full mx-4">
                            <div class="flex justify-between items-center mb-4">
                                <h2 class="text-xl font-bold text-[#3D3A37]">Edit Session Notes</h2>
                                <button onclick="closeNotesModal()" class="text-gray-500 hover:text-gray-700">
                                    <i data-lucide="x" class="w-5 h-5"></i>
                                </button>
                            </div>

                            <form action="${pageContext.request.contextPath}/telehealthCounselor/updateNotes"
                                method="post">
                                <input type="hidden" name="sessionId" id="notesSessionId">

                                <div class="bg-gray-50 rounded-xl p-4 mb-4">
                                    <div class="flex items-center gap-3 mb-3">
                                        <div
                                            class="w-12 h-12 rounded-full bg-[#B4C59B]/20 flex items-center justify-center">
                                            <i data-lucide="user" class="w-6 h-6 text-[#B4C59B]"></i>
                                        </div>
                                        <div>
                                            <p class="font-medium text-[#3D3A37]" id="notesStudentName">Student Name</p>
                                            <span
                                                class="border border-[#B4C59B] text-[#3D3A37] px-2 py-0.5 rounded-full text-xs">Completed</span>
                                        </div>
                                    </div>

                                    <div class="space-y-2">
                                        <div class="flex items-center gap-2 text-sm text-[#5A5653]">
                                            <i data-lucide="calendar" class="w-4 h-4 text-[#B4C59B]"></i>
                                            <span id="notesDate">Date</span>
                                        </div>
                                        <div class="flex items-center gap-2 text-sm text-[#5A5653]">
                                            <i data-lucide="clock" class="w-4 h-4 text-[#B4C59B]"></i>
                                            <span id="notesTime">Time</span>
                                        </div>
                                    </div>
                                </div>

                                <div class="space-y-4">
                                    <div>
                                        <label class="block text-sm font-medium text-[#3D3A37] mb-2">Session
                                            Summary</label>
                                        <textarea name="summary" id="notesSummary" rows="3"
                                            placeholder="Brief summary of the session discussion..."
                                            class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]"></textarea>
                                    </div>
                                    <div>
                                        <label
                                            class="block text-sm font-medium text-[#3D3A37] mb-2">Recommendations</label>
                                        <textarea name="recommendations" id="notesRecommendations" rows="3"
                                            placeholder="Any recommendations for the student..."
                                            class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]"></textarea>
                                    </div>
                                </div>

                                <div class="flex gap-3 pt-4">
                                    <button type="button" onclick="closeNotesModal()"
                                        class="flex-1 px-4 py-2 border border-[#E9E4DF] rounded-xl hover:bg-gray-50 text-sm font-medium">
                                        Cancel
                                    </button>
                                    <button type="submit"
                                        class="flex-1 px-4 py-2 bg-[#B4C59B] text-white rounded-xl hover:bg-[#9AAF86] text-sm font-medium flex items-center justify-center gap-2">
                                        <i data-lucide="save" class="w-4 h-4"></i>
                                        Save Notes
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script>
                        lucide.createIcons();

                        let currentSessionId = null;
                        let currentStudentName = null;
                        let currentDate = null;
                        let currentTime = null;

                        function formatDate(dateStr) {
                            const date = new Date(dateStr);
                            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                            return date.toLocaleDateString('en-US', options);
                        }


                        // Details Modal Functions (for upcoming sessions)
                        function openDetailsModal(btn) {
                            const dataset = btn.dataset;
                            currentSessionId = dataset.id;
                            currentStudentName = dataset.studentName;
                            currentDate = dataset.date;
                            currentTime = dataset.time;
                            const status = dataset.status;

                            document.getElementById('detailsStudentName').textContent = currentStudentName || 'Student';
                            document.getElementById('detailsDate').textContent = formatDate(currentDate);
                            document.getElementById('detailsTime').textContent = currentTime;

                            // Reset buttons to initial state or in-progress state based on status
                            if (status === 'in_progress') {
                                setSessionStartedState();
                            } else {
                                resetDetailsModalButtons();
                            }

                            document.getElementById('detailsModal').classList.add('show');
                            lucide.createIcons();
                        }

                        function setSessionStartedState() {
                            // Set Start Session button to started state
                            const startBtn = document.getElementById('startSessionBtn');
                            startBtn.innerHTML = '<i data-lucide="check" class="w-5 h-5"></i> Session Started';
                            startBtn.classList.remove('bg-[#B4C59B]', 'hover:bg-[#9AAF86]');
                            startBtn.classList.add('bg-gray-400', 'cursor-default');
                            startBtn.onclick = null;

                            // Enable Complete Session button
                            const completeBtn = document.getElementById('completeSessionBtn');
                            completeBtn.disabled = false;
                            completeBtn.classList.remove('text-gray-400', 'cursor-not-allowed', 'opacity-60');
                            completeBtn.classList.add('text-[#3D3A37]', 'hover:bg-gray-50');
                        }

                        function resetDetailsModalButtons() {
                            // Reset Start Session button
                            const startBtn = document.getElementById('startSessionBtn');
                            startBtn.innerHTML = '<i data-lucide="video" class="w-5 h-5"></i> Start Telehealth Session';
                            startBtn.classList.add('bg-[#B4C59B]', 'hover:bg-[#9AAF86]');
                            startBtn.classList.remove('bg-gray-400', 'cursor-default');
                            startBtn.onclick = startTelehealthSession;

                            // Reset Complete Session button to disabled
                            const completeBtn = document.getElementById('completeSessionBtn');
                            completeBtn.disabled = true;
                            completeBtn.classList.add('text-gray-400', 'cursor-not-allowed', 'opacity-60');
                            completeBtn.classList.remove('text-[#3D3A37]', 'hover:bg-gray-50');
                        }

                        function closeDetailsModal() {
                            document.getElementById('detailsModal').classList.remove('show');
                        }

                        function startTelehealthSession() {
                            // Integrate with video call platform
                            if (!confirm('Start telehealth video session with the student?\n\nThis will mark the session as started.')) {
                                return;
                            }

                            // Update backend via AJAX
                            fetch('${pageContext.request.contextPath}/telehealthCounselor/start', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'sessionId=' + currentSessionId
                            })
                                .then(response => {
                                    if (response.ok) {
                                        // Update UI only if backend update succeeds (or optimistically)
                                        setSessionStartedState();
                                        lucide.createIcons();

                                        // Update session card in the list immediately (no refresh needed)
                                        const badge = document.getElementById('status-badge-' + currentSessionId);
                                        if (badge) {
                                            badge.textContent = 'In Progress';
                                        }

                                        const detailsBtn = document.getElementById('view-details-btn-' + currentSessionId);
                                        if (detailsBtn) {
                                            // Update the data-status attribute
                                            detailsBtn.dataset.status = 'in_progress';
                                        }
                                    } else {
                                        console.error('Failed to start session on server');
                                    }
                                })
                                .catch(error => console.error('Error:', error));
                        }

                        // Complete Session Modal Functions
                        function openCompleteModal() {
                            // Close details modal first
                            closeDetailsModal();

                            // Populate complete modal with current session data
                            document.getElementById('completeSessionId').value = currentSessionId;
                            document.getElementById('completeStudentName').textContent = currentStudentName || 'Student';
                            document.getElementById('completeDate').textContent = formatDate(currentDate);
                            document.getElementById('completeTime').textContent = currentTime;
                            document.getElementById('completeSummary').value = '';
                            document.getElementById('completeRecommendations').value = '';

                            document.getElementById('completeModal').classList.add('show');
                            lucide.createIcons();
                        }

                        function closeCompleteModal() {
                            document.getElementById('completeModal').classList.remove('show');
                        }


                        // Edit Notes Modal Functions (for completed sessions)
                        function openNotesModal(btn) {
                            const dataset = btn.dataset;
                            const id = dataset.id;
                            const studentName = dataset.studentName;
                            const date = dataset.date;
                            const time = dataset.time;
                            const summary = dataset.summary;
                            const recommendations = dataset.recommendations;

                            document.getElementById('notesSessionId').value = id;
                            document.getElementById('notesStudentName').textContent = studentName || 'Student';
                            document.getElementById('notesDate').textContent = formatDate(date);
                            document.getElementById('notesTime').textContent = time;

                            // Handle null or undefined values
                            document.getElementById('notesSummary').value = (summary && summary !== 'null') ? summary : '';
                            document.getElementById('notesRecommendations').value = (recommendations && recommendations !== 'null') ? recommendations : '';

                            document.getElementById('notesModal').classList.add('show');
                            lucide.createIcons();
                        }

                        function closeNotesModal() {
                            document.getElementById('notesModal').classList.remove('show');
                        }

                        // Close modal when clicking outside
                        window.onclick = function (event) {
                            const detailsModal = document.getElementById('detailsModal');
                            const completeModal = document.getElementById('completeModal');
                            const notesModal = document.getElementById('notesModal');

                            if (event.target === detailsModal) {
                                closeDetailsModal();
                            }
                            if (event.target === completeModal) {
                                closeCompleteModal();
                            }
                            if (event.target === notesModal) {
                                closeNotesModal();
                            }
                        }
                    </script>
                </body>

                </html>