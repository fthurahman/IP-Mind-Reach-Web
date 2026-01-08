<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
                    <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
                        <a href="${pageContext.request.contextPath}/homeMProfessional"
                            class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
                        <nav class="hidden lg:flex items-center gap-6">
                            <a href="${pageContext.request.contextPath}/homeMProfessional"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Resources</a>
                            <a href="${pageContext.request.contextPath}/telehealthCounselor"
                                class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Telehealth
                                Assistance</a>
                        </nav>
                        <div class="hidden lg:flex items-center gap-3">
                            <div class="text-right">
                                <div class="text-sm text-[#3D3A37] font-medium">
                                    <c:choose>
                                        <c:when test="${not empty loggedUser.name}">${loggedUser.name}</c:when>
                                        <c:otherwise>Dr. Smith</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-xs text-gray-500 capitalize">
                                    <c:choose>
                                        <c:when test="${loggedUser.role == 'mhprofessional'}">Counselor</c:when>
                                        <c:otherwise>${loggedUser.role}</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div
                                class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B]">
                                <i data-lucide="user"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="ml-4 text-sm text-red-500 hover:text-red-700 flex items-center gap-1">
                                <i data-lucide="log-out" class="w-4 h-4"></i> Log out
                            </a>
                        </div>
                    </div>
                </header>

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
                                <c:if test="${appointment.status == 'upcoming'}">
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
                                                <span
                                                    class="bg-[#CADBB7] text-[#3D3A37] px-3 py-1 rounded-full text-sm font-medium">
                                                    Upcoming
                                                </span>
                                                <button
                                                    onclick="openDetailsModal('${appointment.id}', '${appointment.studentName}', '${appointment.date}', '${appointment.time}', 'upcoming')"
                                                    class="px-4 py-2 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium text-sm transition-colors">
                                                    View Details
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>

                            <c:if test="${not hasUpcoming}">
                                <!-- Mock data for upcoming sessions -->
                                <div class="session-card bg-white p-6 border-0 shadow-lg rounded-2xl">
                                    <div class="flex items-start justify-between">
                                        <div class="flex-1">
                                            <p class="font-medium text-[#3D3A37] mb-1">Alex Johnson</p>
                                            <p class="text-sm text-[#5A5653]">Saturday, November 8, 2025 at 10:00 AM</p>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <span
                                                class="bg-[#CADBB7] text-[#3D3A37] px-3 py-1 rounded-full text-sm font-medium">
                                                Upcoming
                                            </span>
                                            <button
                                                onclick="openDetailsModal('c1', 'Alex Johnson', '2025-11-08', '10:00 AM', 'upcoming')"
                                                class="px-4 py-2 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium text-sm transition-colors">
                                                View Details
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="session-card bg-white p-6 border-0 shadow-lg rounded-2xl">
                                    <div class="flex items-start justify-between">
                                        <div class="flex-1">
                                            <p class="font-medium text-[#3D3A37] mb-1">Jordan Lee</p>
                                            <p class="text-sm text-[#5A5653]">Sunday, November 9, 2025 at 2:00 PM</p>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <span
                                                class="bg-[#CADBB7] text-[#3D3A37] px-3 py-1 rounded-full text-sm font-medium">
                                                Upcoming
                                            </span>
                                            <button
                                                onclick="openDetailsModal('c2', 'Jordan Lee', '2025-11-09', '2:00 PM', 'upcoming')"
                                                class="px-4 py-2 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium text-sm transition-colors">
                                                View Details
                                            </button>
                                        </div>
                                    </div>
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
                                            </div>
                                            <div class="flex items-center gap-3">
                                                <span
                                                    class="border border-[#B4C59B] text-[#3D3A37] px-3 py-1 rounded-full text-sm font-medium">
                                                    Completed
                                                </span>
                                                <button
                                                    onclick="openDetailsModal('${appointment.id}', '${appointment.studentName}', '${appointment.date}', '${appointment.time}', 'completed')"
                                                    class="px-4 py-2 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium text-sm transition-colors">
                                                    View Details
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </c:forEach>

                            <c:if test="${not hasCompleted}">
                                <!-- Mock data for completed sessions -->
                                <div class="session-card bg-white p-6 border-0 shadow-lg rounded-2xl">
                                    <div class="flex items-start justify-between">
                                        <div class="flex-1">
                                            <p class="font-medium text-[#3D3A37] mb-1">Taylor Smith</p>
                                            <p class="text-sm text-[#5A5653]">Wednesday, November 5, 2025 at 11:00 AM
                                            </p>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <span
                                                class="border border-[#B4C59B] text-[#3D3A37] px-3 py-1 rounded-full text-sm font-medium">
                                                Completed
                                            </span>
                                            <button
                                                onclick="openDetailsModal('c3', 'Taylor Smith', '2025-11-05', '11:00 AM', 'completed')"
                                                class="px-4 py-2 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium text-sm transition-colors">
                                                View Details
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                <div class="session-card bg-white p-6 border-0 shadow-lg rounded-2xl">
                                    <div class="flex items-start justify-between">
                                        <div class="flex-1">
                                            <p class="font-medium text-[#3D3A37] mb-1">Morgan Davis</p>
                                            <p class="text-sm text-[#5A5653]">Monday, November 3, 2025 at 3:00 PM</p>
                                        </div>
                                        <div class="flex items-center gap-3">
                                            <span
                                                class="border border-[#B4C59B] text-[#3D3A37] px-3 py-1 rounded-full text-sm font-medium">
                                                Completed
                                            </span>
                                            <button
                                                onclick="openDetailsModal('c4', 'Morgan Davis', '2025-11-03', '3:00 PM', 'completed')"
                                                class="px-4 py-2 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium text-sm transition-colors">
                                                View Details
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </main>

                <!-- Session Details Modal -->
                <div id="detailsModal" class="modal">
                    <div class="modal-content p-6 max-w-lg w-full mx-4">
                        <div class="flex justify-between items-center mb-4">
                            <h2 class="text-xl font-bold text-[#3D3A37]" id="modalTitle">Session Details</h2>
                            <button onclick="closeDetailsModal()" class="text-gray-500 hover:text-gray-700">
                                <i data-lucide="x" class="w-5 h-5"></i>
                            </button>
                        </div>

                        <div class="space-y-4">
                            <div class="bg-gray-50 rounded-xl p-4">
                                <div class="flex items-center gap-3 mb-3">
                                    <div
                                        class="w-12 h-12 rounded-full bg-[#B4C59B]/20 flex items-center justify-center">
                                        <i data-lucide="user" class="w-6 h-6 text-[#B4C59B]"></i>
                                    </div>
                                    <div>
                                        <p class="font-medium text-[#3D3A37]" id="modalStudentName">Student Name</p>
                                        <p class="text-sm text-gray-500" id="modalStatus">Status</p>
                                    </div>
                                </div>

                                <div class="space-y-2">
                                    <div class="flex items-center gap-2 text-sm text-[#5A5653]">
                                        <i data-lucide="calendar" class="w-4 h-4 text-[#B4C59B]"></i>
                                        <span id="modalDate">Date</span>
                                    </div>
                                    <div class="flex items-center gap-2 text-sm text-[#5A5653]">
                                        <i data-lucide="clock" class="w-4 h-4 text-[#B4C59B]"></i>
                                        <span id="modalTime">Time</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Notes Section for Completed Sessions -->
                            <div id="notesSection" class="hidden">
                                <label class="block text-sm font-medium text-[#3D3A37] mb-2">Session Notes</label>
                                <textarea id="sessionNotes" rows="4" placeholder="Add notes about this session..."
                                    class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]"></textarea>
                            </div>

                            <!-- Action Buttons -->
                            <div class="flex gap-3 pt-2">
                                <button onclick="closeDetailsModal()"
                                    class="flex-1 px-4 py-2 border border-[#E9E4DF] rounded-xl hover:bg-gray-50 text-sm font-medium">
                                    Close
                                </button>
                                <button id="modalActionBtn" onclick="handleModalAction()"
                                    class="flex-1 px-4 py-2 bg-[#B4C59B] text-white rounded-xl hover:bg-[#9AAF86] text-sm font-medium">
                                    Start Session
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <script>
                    lucide.createIcons();

                    let currentSessionId = null;
                    let currentSessionStatus = null;

                    function formatDate(dateStr) {
                        const date = new Date(dateStr);
                        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
                        return date.toLocaleDateString('en-US', options);
                    }

                    function openDetailsModal(id, studentName, date, time, status) {
                        currentSessionId = id;
                        currentSessionStatus = status;

                        document.getElementById('modalStudentName').textContent = studentName || 'Student';
                        document.getElementById('modalDate').textContent = formatDate(date);
                        document.getElementById('modalTime').textContent = time;

                        const statusBadge = status === 'upcoming'
                            ? '<span class="bg-[#CADBB7] text-[#3D3A37] px-2 py-0.5 rounded-full text-xs">Upcoming</span>'
                            : '<span class="border border-[#B4C59B] text-[#3D3A37] px-2 py-0.5 rounded-full text-xs">Completed</span>';
                        document.getElementById('modalStatus').innerHTML = statusBadge;

                        // Show/hide notes section based on status
                        const notesSection = document.getElementById('notesSection');
                        const actionBtn = document.getElementById('modalActionBtn');

                        if (status === 'upcoming') {
                            notesSection.classList.add('hidden');
                            actionBtn.textContent = 'Start Session';
                            actionBtn.classList.remove('hidden');
                        } else {
                            notesSection.classList.remove('hidden');
                            actionBtn.textContent = 'Save Notes';
                            actionBtn.classList.remove('hidden');
                        }

                        document.getElementById('detailsModal').classList.add('show');
                        lucide.createIcons();
                    }

                    function closeDetailsModal() {
                        document.getElementById('detailsModal').classList.remove('show');
                        currentSessionId = null;
                        currentSessionStatus = null;
                    }

                    function handleModalAction() {
                        if (currentSessionStatus === 'upcoming') {
                            alert('Starting video session with student...');
                            // Here you would redirect to a video call or open a video session
                        } else {
                            const notes = document.getElementById('sessionNotes').value;
                            if (notes) {
                                alert('Notes saved successfully!');
                                closeDetailsModal();
                            } else {
                                alert('Please add some notes before saving.');
                            }
                        }
                    }

                    // Close modal when clicking outside
                    window.onclick = function (event) {
                        const modal = document.getElementById('detailsModal');
                        if (event.target === modal) {
                            closeDetailsModal();
                        }
                    }
                </script>
            </body>

            </html>