<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">


            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>MindReach - Your Progress</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <!-- Include global styles -->
                <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />

                <style>
                    .mood-button {
                        transition: all 0.3s ease;
                    }

                    .mood-button:hover {
                        transform: scale(1.05);
                    }

                    .mood-button.selected {
                        border-color: #B4C59B;
                        background-color: rgba(180, 197, 155, 0.1);
                        transform: scale(1.05);
                    }

                    .progress-bar {
                        transition: width 0.5s ease;
                    }

                    .chart-container {
                        position: relative;
                        height: 300px;
                        width: 100%;
                    }

                    /* Override global body styles from style.css that lock scrolling */
                    body {
                        display: block !important;
                        overflow-y: auto !important;
                        height: auto !important;
                    }
                </style>
            </head>

            <body class="bg-gray-50 min-h-screen">
                <!-- Top Navigation Bar -->
                <header class="header">
                    <div class="header-container">
                        <!-- Logo -->
                        <a href="homeStudent" class="logo-btn"> MindReach </a>

                        <!-- Desktop Navigation -->
                        <nav class="nav-desktop">
                            <a href="<c:url value='/homeStudent'/>" class="nav-item">Self-Help</a>
                            <a href="<c:url value='/resources'/>" class="nav-item">Resources</a>
                            <a href="<c:url value='/forum'/>" class="nav-item">Forum</a>
                            <a href="<c:url value='/progress'/>" class="nav-item active">Progress</a>
                            <a href="<c:url value='/counseling'/>" class="nav-item">Telehealth Assistance</a>
                            <a href="<c:url value='/chatbot'/>" class="nav-item">Chat Support</a>
                        </nav>


                        <!-- User Section / Mobile Toggle -->
                        <div class="user-section-desktop">
                            <div class="avatar-circle">
                                <!-- User Icon SVG -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round">
                                    <circle cx="12" cy="12" r="10" />
                                    <circle cx="12" cy="10" r="3" />
                                    <path d="M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662" />
                                </svg>
                            </div>
                            <div class="user-info">
                                <p class="user-name">${loggedUser.name}</p>
                                <p class="user-role">Student</p>
                            </div>
                            <a href="logout" class="btn-ghost">
                                <!-- LogOut Icon -->
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                                    fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                    stroke-linejoin="round" style="margin-right: 8px">
                                    <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                                    <polyline points="16 17 21 12 16 7" />
                                    <line x1="21" x2="9" y1="12" y2="12" />
                                </svg>
                                Log out
                            </a>
                        </div>

                        <button class="mobile-menu-btn" onclick="toggleMobileMenu()">
                            <!-- Menu Icon -->
                            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"
                                fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                stroke-linejoin="round">
                                <line x1="4" x2="20" y1="12" y2="12" />
                                <line x1="4" x2="20" y1="6" y2="6" />
                                <line x1="4" x2="20" y1="18" y2="18" />
                            </svg>
                        </button>
                    </div>
                </header>

                <!-- Mobile Sheet/Menu -->
                <div id="mobileSheet" class="sheet-overlay">
                    <div class="sheet-content">
                        <h3 style="
            margin: 0 0 0.5rem 0;
            font-family: var(--font-family-serif);
            font-size: 1.25rem;
          ">
                            Navigation
                        </h3>
                        <p style="margin: 0; font-size: 0.875rem; color: #8c8784">
                            Access MindReach sections
                        </p>

                        <nav class="mobile-nav">
                            <a href="<c:url value='/homeStudent'/>" class="mobile-nav-item">Self-Help</a>
                            <a href="<c:url value='/resources'/>" class="mobile-nav-item">Resources</a>
                            <a href="<c:url value='/forum'/>" class="mobile-nav-item">Forum</a>
                            <a href="<c:url value='/progress'/>" class="mobile-nav-item active">Progress</a>
                            <a href="<c:url value='/counseling'/>" class="mobile-nav-item">Telehealth Assistance</a>
                            <a href="<c:url value='/chatbot'/>" class="mobile-nav-item">Chat Support</a>
                        </nav>


                        <div class="mobile-separator"></div>

                        <a href="logout" class="mobile-nav-item" style="color: #5a5653">Log out</a>
                    </div>
                </div>

                <main class="dashboard-content">
                    <!-- Hero Header -->
                    <div
                        class="bg-gradient-to-r from-[#B4C59B] to-[#CADBB7] rounded-2xl p-8 shadow-[0_4px_20px_rgba(180,197,155,0.15)] mb-6">
                        <h1 class="text-3xl text-white mb-2">Your Progress</h1>
                        <p class="text-white/90">Track your wellbeing journey</p>
                    </div>

                    <!-- Stats Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-6">
                        <div
                            class="bg-white p-6 border-0 shadow-lg rounded-2xl bg-gradient-to-br from-[#CADBB7]/20 to-[#B4C59B]/30">
                            <div class="flex items-center gap-3 mb-2">
                                <i class="fas fa-chart-line text-[#B4C59B]" style="font-size: 24px;"></i>
                                <span class="text-sm text-gray-600">Average Mood</span>
                            </div>
                            <div class="text-3xl">${averageMood}/10</div>
                        </div>

                        <div
                            class="bg-white p-6 border-0 shadow-lg rounded-2xl bg-gradient-to-br from-blue-50 to-blue-100">
                            <div class="flex items-center gap-3 mb-2">
                                <i class="fas fa-trophy text-blue-600" style="font-size: 24px;"></i>
                                <span class="text-sm text-gray-600">Current Streak</span>
                            </div>
                            <div class="text-3xl">${currentStreak} days</div>
                        </div>

                        <div
                            class="bg-white p-6 border-0 shadow-lg rounded-2xl bg-gradient-to-br from-green-50 to-green-100">
                            <div class="flex items-center gap-3 mb-2">
                                <i class="fas fa-calendar text-green-600" style="font-size: 24px;"></i>
                                <span class="text-sm text-gray-600">Total Activities</span>
                            </div>
                            <div class="text-3xl">${totalActivities}</div>
                        </div>
                    </div>

                    <!-- Tabs -->
                    <div class="bg-white rounded-xl p-1 mb-6">
                        <div class="flex flex-wrap">
                            <button id="moodTab" class="px-4 py-2 rounded-lg bg-[#B4C59B]/20 text-[#3D3A37] font-medium"
                                onclick="showTab('mood')">
                                Mood Tracking
                            </button>
                            <button id="activitiesTab" class="px-4 py-2 rounded-lg text-gray-600 font-medium ml-2"
                                onclick="showTab('activities')">
                                Activity Completion
                            </button>
                        </div>
                    </div>

                    <!-- Mood Tab Content -->
                    <div id="moodContent" class="space-y-6">
                        <!-- Log Today's Mood -->
                        <div class="bg-white p-6 border-0 shadow-lg rounded-2xl">
                            <h3 class="text-xl mb-4">Log Today's Mood</h3>
                            <form action="<c:url value='/progress/logMood'/>" method="post" id="moodForm">
                                <input type="hidden" id="moodValue" name="moodValue">
                                <input type="hidden" id="moodEmoji" name="moodEmoji">
                                <div class="grid grid-cols-5 gap-3 mb-4">
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(1, '😢')">
                                        <div class="text-3xl mb-1">😢</div>
                                        <div class="text-xs text-gray-600">1</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(2, '😟')">
                                        <div class="text-3xl mb-1">😟</div>
                                        <div class="text-xs text-gray-600">2</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(3, '😕')">
                                        <div class="text-3xl mb-1">😕</div>
                                        <div class="text-xs text-gray-600">3</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(4, '😐')">
                                        <div class="text-3xl mb-1">😐</div>
                                        <div class="text-xs text-gray-600">4</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(5, '😶')">
                                        <div class="text-3xl mb-1">😶</div>
                                        <div class="text-xs text-gray-600">5</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(6, '🙂')">
                                        <div class="text-3xl mb-1">🙂</div>
                                        <div class="text-xs text-gray-600">6</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(7, '😊')">
                                        <div class="text-3xl mb-1">😊</div>
                                        <div class="text-xs text-gray-600">7</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(8, '😄')">
                                        <div class="text-3xl mb-1">😄</div>
                                        <div class="text-xs text-gray-600">8</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(9, '😁')">
                                        <div class="text-3xl mb-1">😁</div>
                                        <div class="text-xs text-gray-600">9</div>
                                    </button>
                                    <button type="button"
                                        class="mood-button p-4 rounded-xl border-2 border-gray-200 text-center"
                                        onclick="selectMood(10, '🤩')">
                                        <div class="text-3xl mb-1">🤩</div>
                                        <div class="text-xs text-gray-600">10</div>
                                    </button>
                                </div>
                                <button type="submit" id="saveMoodBtn"
                                    class="w-full py-2 px-4 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium disabled:bg-gray-300 disabled:cursor-not-allowed"
                                    disabled>
                                    Save Mood Entry
                                </button>
                            </form>
                        </div>

                        <!-- Mood Trend Chart -->
                        <div class="bg-white p-6 border-0 shadow-lg rounded-2xl">
                            <h3 class="text-xl mb-4">Mood Trend (Last 7 Days)</h3>
                            <div class="chart-container">
                                <canvas id="moodChart"></canvas>
                            </div>
                        </div>
                    </div>

                    <!-- Activities Tab Content -->
                    <div id="activitiesContent" class="space-y-6 hidden">
                        <!-- Activity Chart -->
                        <div class="bg-white p-6 border-0 shadow-lg rounded-2xl">
                            <h3 class="text-xl mb-4">Completion by Module</h3>
                            <div class="chart-container" style="height: 400px;">
                                <canvas id="activityChart"></canvas>
                            </div>
                        </div>

                        <!-- Activity Progress Cards -->
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                            <c:forEach var="activity" items="${activities}">
                                <div class="bg-white p-6 border-0 shadow-lg rounded-2xl">
                                    <div class="flex items-center justify-between mb-3">
                                        <h4>${activity.fullName}</h4>
                                        <span
                                            class="text-sm text-gray-600">${activity.completed}/${activity.total}</span>
                                    </div>
                                    <div class="w-full bg-gray-200 rounded-full h-3 overflow-hidden">
                                        <div class="bg-[#B4C59B] h-full rounded-full progress-bar"
                                            style="width: ${activity.percentage}%"></div>
                                    </div>
                                    <p class="text-sm text-gray-600 mt-2">${activity.percentage}% complete</p>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </main>

                <script>
                    // Initialize mood data from server
                    const moodData = [
                        <c:forEach var="entry" items="${moodData}" varStatus="status">
                            {date: "${entry.date}", mood: ${entry.mood}, emoji: "${entry.emoji}"}<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ];

                    const activityData = [
                        <c:forEach var="activity" items="${activities}" varStatus="status">
                            {name: "${activity.name}", fullName: "${activity.fullName}", completed: ${activity.completed}, total: ${activity.total}}<c:if test="${!status.last}">,</c:if>
                        </c:forEach>
                    ];

                    let selectedMoodValue = null;
                    let selectedMoodEmoji = null;

                    // Tab switching function
                    function showTab(tab) {
                        if (tab === 'mood') {
                            document.getElementById('moodContent').classList.remove('hidden');
                            document.getElementById('activitiesContent').classList.add('hidden');
                            document.getElementById('moodTab').classList.add('bg-[#B4C59B]/20', 'text-[#3D3A37]');
                            document.getElementById('moodTab').classList.remove('text-gray-600');
                            document.getElementById('activitiesTab').classList.remove('bg-[#B4C59B]/20', 'text-[#3D3A37]');
                            document.getElementById('activitiesTab').classList.add('text-gray-600');
                        } else {
                            document.getElementById('moodContent').classList.add('hidden');
                            document.getElementById('activitiesContent').classList.remove('hidden');
                            document.getElementById('activitiesTab').classList.add('bg-[#B4C59B]/20', 'text-[#3D3A37]');
                            document.getElementById('activitiesTab').classList.remove('text-gray-600');
                            document.getElementById('moodTab').classList.remove('bg-[#B4C59B]/20', 'text-[#3D3A37]');
                            document.getElementById('moodTab').classList.add('text-gray-600');
                        }
                    }

                    // Mood selection function
                    function selectMood(value, emoji) {
                        selectedMoodValue = value;
                        selectedMoodEmoji = emoji;

                        // Update button states
                        document.querySelectorAll('.mood-button').forEach(btn => {
                            btn.classList.remove('selected');
                        });

                        event.target.closest('.mood-button').classList.add('selected');

                        // Update hidden form fields
                        document.getElementById('moodValue').value = value;
                        document.getElementById('moodEmoji').value = emoji;

                        // Enable save button
                        document.getElementById('saveMoodBtn').disabled = false;
                    }

                    // Initialize charts
                    document.addEventListener('DOMContentLoaded', function () {
                        // Mood Chart
                        const moodCtx = document.getElementById('moodChart').getContext('2d');
                        window.moodChart = new Chart(moodCtx, {
                            type: 'line',
                            data: {
                                labels: moodData.map(item => item.date),
                                datasets: [{
                                    label: 'Mood',
                                    data: moodData.map(item => item.mood),
                                    borderColor: '#B4C59B',
                                    backgroundColor: 'rgba(180, 197, 155, 0.1)',
                                    borderWidth: 3,
                                    pointBackgroundColor: '#B4C59B',
                                    pointRadius: 6,
                                    pointHoverRadius: 8,
                                    fill: true,
                                    tension: 0.4
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        max: 10,
                                        ticks: {
                                            color: '#9ca3af'
                                        },
                                        grid: {
                                            color: '#f0f0f0',
                                            borderDash: [3, 3]
                                        }
                                    },
                                    x: {
                                        ticks: {
                                            color: '#9ca3af'
                                        },
                                        grid: {
                                            display: false
                                        }
                                    }
                                },
                                plugins: {
                                    legend: {
                                        display: false
                                    },
                                    tooltip: {
                                        backgroundColor: 'white',
                                        titleColor: '#3D3A37',
                                        bodyColor: '#5A5653',
                                        borderColor: '#e5e7eb',
                                        borderWidth: 1,
                                        borderRadius: 12,
                                        boxPadding: 6,
                                        usePointStyle: true,
                                        callbacks: {
                                            label: function (context) {
                                                return `Mood: ${context.raw}`;
                                            }
                                        }
                                    }
                                }
                            }
                        });

                        // Activity Chart
                        const activityCtx = document.getElementById('activityChart').getContext('2d');
                        window.activityChart = new Chart(activityCtx, {
                            type: 'bar',
                            data: {
                                labels: activityData.map(item => item.name),
                                datasets: [{
                                    label: 'Completed',
                                    data: activityData.map(item => item.completed),
                                    backgroundColor: '#B4C59B',
                                    borderRadius: 8,
                                    barPercentage: 0.6
                                }]
                            },
                            options: {
                                responsive: true,
                                maintainAspectRatio: false,
                                scales: {
                                    y: {
                                        beginAtZero: true,
                                        ticks: {
                                            color: '#9ca3af'
                                        },
                                        grid: {
                                            color: '#f0f0f0',
                                            borderDash: [3, 3]
                                        }
                                    },
                                    x: {
                                        ticks: {
                                            color: '#5A5653',
                                            font: {
                                                size: 20
                                            }
                                        },
                                        grid: {
                                            display: false
                                        }
                                    }
                                },
                                plugins: {
                                    legend: {
                                        display: false
                                    },
                                    tooltip: {
                                        backgroundColor: 'white',
                                        titleColor: '#3D3A37',
                                        bodyColor: '#5A5653',
                                        borderColor: '#e5e7eb',
                                        borderWidth: 1,
                                        borderRadius: 12,
                                        boxPadding: 6,
                                        callbacks: {
                                            title: function (tooltipItems) {
                                                const index = tooltipItems[0].dataIndex;
                                                return activityData[index].fullName;
                                            },
                                            label: function (context) {
                                                const index = context.dataIndex;
                                                return `Completed: ${context.raw}/${activityData[index].total}`;
                                            }
                                        }
                                    }
                                }
                            }
                        });
                    });
                </script>
                <script>
                    function toggleMobileMenu() {
                        const sheet = document.getElementById("mobileSheet");
                        if (sheet.classList.contains("open")) {
                            sheet.classList.remove("open");
                        } else {
                            sheet.classList.add("open");
                        }
                    }

                    // Close on click outside
                    window.onclick = function (event) {
                        const sheet = document.getElementById("mobileSheet");
                        // Also close modal if it exists (from counseling.jsp logic if copy-pasted, but mostly for sheet here)
                        // But wait, window.onclick might overwrite existing window.onclick handlers if not careful.
                        // progress.jsp doesn't seem to have another window.onclick in the snippet I saw.
                        // Wait, Step 34 snippet didn't show one.

                        if (event.target == sheet) {
                            sheet.classList.remove("open");
                        }
                    };
                </script>
            </body>

            </html>