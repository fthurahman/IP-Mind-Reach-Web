<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="UTF-8">
			<title>Admin Dashboard | MindReach</title>
			<script src="https://cdn.tailwindcss.com"></script>
			<%@ include file="layout/css-include.jsp" %>
				<script src="https://unpkg.com/lucide@latest"></script>
				<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
				<style>
					.tab-content {
						display: none;
						animation: fadeIn 0.3s ease-in-out;
					}

					.tab-content.active {
						display: block;
					}

					@keyframes fadeIn {
						from {
							opacity: 0;
							transform: translateY(5px);
						}

						to {
							opacity: 1;
							transform: translateY(0);
						}
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
						<!-- New Header Options -->
						<a href="${pageContext.request.contextPath}/homeAdmin"
							class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Analytics</a>

						<a href="${pageContext.request.contextPath}/resources"
							class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Resources</a>

						<a href="${pageContext.request.contextPath}/forum-monitor"
							class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Forum
							Monitor</a>

						<a href="#"
							class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">User
							Management</a>
					</nav>
					<div class="hidden lg:flex items-center gap-3">
						<div class="text-right">
							<div class="text-sm text-[#3D3A37] font-medium">${loggedUser.name}</div>
							<div class="text-xs text-gray-500 capitalize">${loggedUser.role}</div>
						</div>
						<div
							class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B]">
							<i data-lucide="user"></i>
						</div>
						<a href="${pageContext.request.contextPath}/logout"
							class="ml-4 text-sm text-red-500 hover:text-red-700">Logout</a>
					</div>
				</div>
			</header>

			<main class="max-w-[1200px] mx-auto px-6 py-8 space-y-6 pt-8">

				<!-- Hero Header -->
				<div
					class="bg-gradient-to-r from-[#B4C59B] to-[#CADBB7] rounded-2xl p-8 shadow-[0_4px_20px_rgba(180,197,155,0.15)]">
					<h1 class="text-3xl text-white mb-2 font-serif">Analytics Dashboard</h1>
					<p class="text-white/90">Monitor platform engagement and wellbeing metrics</p>
				</div>

				<!-- Key Metrics -->
				<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
					<!-- Active Users -->
					<div class="bg-gradient-to-br from-[#CADBB7]/20 to-[#B4C59B]/30 p-6 rounded-2xl shadow-lg border-0">
						<div class="flex items-center gap-3 mb-2">
							<i data-lucide="users" class="text-[#B4C59B] w-6 h-6"></i>
							<span class="text-sm text-gray-600">Weekly Active Users</span>
						</div>
						<div class="text-3xl font-semibold text-[#3D3A37]">342</div>
						<p class="text-sm text-green-600 mt-1">↑ 12% from last week</p>
					</div>

					<!-- Total Sessions -->
					<div class="bg-gradient-to-br from-blue-50 to-blue-100 p-6 rounded-2xl shadow-lg border-0">
						<div class="flex items-center gap-3 mb-2">
							<i data-lucide="trending-up" class="text-blue-600 w-6 h-6"></i>
							<span class="text-sm text-gray-600">Total Sessions</span>
						</div>
						<div class="text-3xl font-semibold text-[#3D3A37]">2,785</div>
						<p class="text-sm text-green-600 mt-1">↑ 8% from last week</p>
					</div>

					<!-- Counseling Bookings -->
					<div class="bg-gradient-to-br from-green-50 to-green-100 p-6 rounded-2xl shadow-lg border-0">
						<div class="flex items-center gap-3 mb-2">
							<i data-lucide="calendar" class="text-green-600 w-6 h-6"></i>
							<span class="text-sm text-gray-600">Counseling Bookings</span>
						</div>
						<div class="text-3xl font-semibold text-[#3D3A37]">67</div>
						<p class="text-sm text-green-600 mt-1">↑ 15% from last week</p>
					</div>

					<!-- Pending Reports -->
					<div class="bg-gradient-to-br from-red-50 to-red-100 p-6 rounded-2xl shadow-lg border-0">
						<div class="flex items-center gap-3 mb-2">
							<i data-lucide="flag" class="text-red-600 w-6 h-6"></i>
							<span class="text-sm text-gray-600">Pending Reports</span>
						</div>
						<div class="text-3xl font-semibold text-[#3D3A37]" id="pendingCount">2</div>
						<p class="text-sm text-gray-600 mt-1">Requires attention</p>
					</div>
				</div>

				<!-- Tabs -->
				<div class="space-y-6">
					<div class="bg-white rounded-xl p-1 inline-flex gap-1 shadow-sm">
						<button onclick="switchTab('engagement')" id="tab-engagement"
							class="tab-btn px-4 py-2 rounded-lg text-sm font-medium transition-colors bg-[#B4C59B]/20 text-[#3D3A37]">Engagement</button>
						<button onclick="switchTab('modules')" id="tab-modules"
							class="tab-btn px-4 py-2 rounded-lg text-sm font-medium transition-colors text-gray-600 hover:text-[#3D3A37] hover:bg-gray-50">Module
							Usage</button>
						<button onclick="switchTab('resources')" id="tab-resources"
							class="tab-btn px-4 py-2 rounded-lg text-sm font-medium transition-colors text-gray-600 hover:text-[#3D3A37] hover:bg-gray-50">Top
							Resources</button>
						<button onclick="switchTab('moderation')" id="tab-moderation"
							class="tab-btn px-4 py-2 rounded-lg text-sm font-medium transition-colors text-gray-600 hover:text-[#3D3A37] hover:bg-gray-50">Moderation</button>
					</div>

					<!-- Tab Contents -->

					<!-- Engagement Tab -->
					<div id="content-engagement" class="tab-content active">
						<div class="bg-white p-6 rounded-2xl shadow-lg h-[450px]">
							<h3 class="text-xl mb-4 font-serif text-[#3D3A37]">User Engagement Trend</h3>
							<canvas id="engagementChart"></canvas>
						</div>
					</div>

					<!-- Module Usage Tab -->
					<div id="content-modules" class="tab-content">
						<div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
							<div class="bg-white p-6 rounded-2xl shadow-lg">
								<h3 class="text-xl mb-4 font-serif text-[#3D3A37]">Usage by Module</h3>
								<div class="h-[300px] flex justify-center">
									<canvas id="modulePieChart"></canvas>
								</div>
							</div>
							<div class="bg-white p-6 rounded-2xl shadow-lg">
								<h3 class="text-xl mb-4 font-serif text-[#3D3A37]">Completion Rates</h3>
								<div class="h-[300px]">
									<canvas id="moduleBarChart"></canvas>
								</div>
							</div>
						</div>
					</div>

					<!-- Top Resources Tab -->
					<div id="content-resources" class="tab-content">
						<div class="bg-white p-6 rounded-2xl shadow-lg">
							<h3 class="text-xl mb-4 font-serif text-[#3D3A37]">Most Viewed Resources</h3>
							<div class="space-y-6">
								<!-- Resource Item 1 -->
								<div class="flex items-center gap-4">
									<div
										class="w-8 h-8 bg-[#B4C59B]/20 rounded-full flex items-center justify-center flex-shrink-0 text-[#3D3A37] font-bold">
										#1</div>
									<div class="flex-1">
										<p class="font-medium text-[#3D3A37]">Understanding Anxiety</p>
										<div class="w-full bg-gray-200 rounded-full h-2 mt-2">
											<div class="bg-[#B4C59B] h-2 rounded-full" style="width: 100%"></div>
										</div>
									</div>
									<div class="flex items-center gap-2 text-sm text-gray-600">
										<i data-lucide="book-open" class="w-4 h-4"></i>
										<span>234 views</span>
									</div>
								</div>
								<!-- Resource Item 2 -->
								<div class="flex items-center gap-4">
									<div
										class="w-8 h-8 bg-[#B4C59B]/20 rounded-full flex items-center justify-center flex-shrink-0 text-[#3D3A37] font-bold">
										#2</div>
									<div class="flex-1">
										<p class="font-medium text-[#3D3A37]">Sleep Hygiene Tips</p>
										<div class="w-full bg-gray-200 rounded-full h-2 mt-2">
											<div class="bg-[#B4C59B] h-2 rounded-full" style="width: 85%"></div>
										</div>
									</div>
									<div class="flex items-center gap-2 text-sm text-gray-600">
										<i data-lucide="book-open" class="w-4 h-4"></i>
										<span>198 views</span>
									</div>
								</div>
								<!-- Resource Item 3 -->
								<div class="flex items-center gap-4">
									<div
										class="w-8 h-8 bg-[#B4C59B]/20 rounded-full flex items-center justify-center flex-shrink-0 text-[#3D3A37] font-bold">
										#3</div>
									<div class="flex-1">
										<p class="font-medium text-[#3D3A37]">Managing Stress</p>
										<div class="w-full bg-gray-200 rounded-full h-2 mt-2">
											<div class="bg-[#B4C59B] h-2 rounded-full" style="width: 80%"></div>
										</div>
									</div>
									<div class="flex items-center gap-2 text-sm text-gray-600">
										<i data-lucide="book-open" class="w-4 h-4"></i>
										<span>187 views</span>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- Moderation Tab -->
					<div id="content-moderation" class="tab-content">
						<div class="space-y-4">
							<!-- Active Reports Queue -->
							<div class="bg-white p-6 rounded-2xl shadow-lg">
								<h3 class="text-xl mb-4 font-serif text-[#3D3A37]">Reported Posts Queue</h3>

								<div id="reportsList" class="space-y-4">
									<!-- Report 1 -->
									<div class="bg-gray-50 rounded-xl p-4 report-item" id="report-1">
										<div class="flex items-start justify-between gap-4 mb-3">
											<div class="flex-1">
												<div class="flex items-center gap-2 mb-2">
													<span
														class="px-2 py-0.5 rounded text-xs border border-red-300 text-red-600 font-medium">Inappropriate
														content</span>
													<span class="text-sm text-gray-500">2 hours ago</span>
												</div>
												<p class="text-gray-800 mb-2">This is a potentially inappropriate post
													that was flagged by users.</p>
												<p class="text-sm text-gray-600">Posted by: Anonymous Fox • Reported by:
													Anonymous Owl</p>
											</div>
										</div>
										<div class="flex gap-2">
											<button onclick="handleReport('1', 'hide', this)"
												class="px-3 py-1.5 rounded-lg border border-gray-300 hover:bg-gray-100 text-sm font-medium flex items-center gap-2 text-gray-700">
												<i data-lucide="eye-off" class="w-4 h-4"></i> Hide
											</button>
											<button onclick="handleReport('1', 'remove', this)"
												class="px-3 py-1.5 rounded-lg border border-red-200 hover:bg-red-50 text-sm font-medium flex items-center gap-2 text-red-600">
												<i data-lucide="flag" class="w-4 h-4"></i> Remove
											</button>
											<button onclick="handleReport('1', 'approve', this)"
												class="px-3 py-1.5 rounded-lg border border-gray-300 hover:bg-gray-100 text-sm font-medium flex items-center gap-2 text-gray-700">
												<i data-lucide="eye" class="w-4 h-4"></i> Approve
											</button>
										</div>
									</div>

									<!-- Report 2 -->
									<div class="bg-gray-50 rounded-xl p-4 report-item" id="report-2">
										<div class="flex items-start justify-between gap-4 mb-3">
											<div class="flex-1">
												<div class="flex items-center gap-2 mb-2">
													<span
														class="px-2 py-0.5 rounded text-xs border border-red-300 text-red-600 font-medium">Harmful
														advice</span>
													<span class="text-sm text-gray-500">5 hours ago</span>
												</div>
												<p class="text-gray-800 mb-2">Another post that was reported for
													containing harmful advice.</p>
												<p class="text-sm text-gray-600">Posted by: Anonymous Bear • Reported
													by: Anonymous Butterfly</p>
											</div>
										</div>
										<div class="flex gap-2">
											<button onclick="handleReport('2', 'hide', this)"
												class="px-3 py-1.5 rounded-lg border border-gray-300 hover:bg-gray-100 text-sm font-medium flex items-center gap-2 text-gray-700">
												<i data-lucide="eye-off" class="w-4 h-4"></i> Hide
											</button>
											<button onclick="handleReport('2', 'remove', this)"
												class="px-3 py-1.5 rounded-lg border border-red-200 hover:bg-red-50 text-sm font-medium flex items-center gap-2 text-red-600">
												<i data-lucide="flag" class="w-4 h-4"></i> Remove
											</button>
											<button onclick="handleReport('2', 'approve', this)"
												class="px-3 py-1.5 rounded-lg border border-gray-300 hover:bg-gray-100 text-sm font-medium flex items-center gap-2 text-gray-700">
												<i data-lucide="eye" class="w-4 h-4"></i> Approve
											</button>
										</div>
									</div>
								</div>

								<div id="noReports" class="hidden text-center py-8 text-gray-500">
									<i data-lucide="check-circle"
										class="w-12 h-12 mx-auto mb-3 opacity-30 text-green-500"></i>
									<p>All caught up! No pending reports.</p>
								</div>
							</div>

							<!-- Resolved (Placeholder) -->
							<div class="bg-white p-6 rounded-2xl shadow-lg hidden" id="resolvedSection">
								<h3 class="text-xl mb-4 font-serif text-[#3D3A37]">Resolved Reports</h3>
								<div id="resolvedList" class="space-y-3"></div>
							</div>
						</div>
					</div>

				</div>
			</main>

			<script>
				lucide.createIcons();

				// -- TAB LOGIC --
				function switchTab(tabId) {
					// Buttons
					document.querySelectorAll('.tab-btn').forEach(btn => {
						btn.classList.remove('bg-[#B4C59B]/20', 'text-[#3D3A37]');
						btn.classList.add('text-gray-600', 'hover:bg-gray-50');
					});
					const activeBtn = document.getElementById('tab-' + tabId);
					activeBtn.classList.remove('text-gray-600', 'hover:bg-gray-50');
					activeBtn.classList.add('bg-[#B4C59B]/20', 'text-[#3D3A37]');

					// Content
					document.querySelectorAll('.tab-content').forEach(content => {
						content.classList.remove('active');
					});
					document.getElementById('content-' + tabId).classList.add('active');
				}

				// -- CHART INITIALIZATION --
				document.addEventListener('DOMContentLoaded', () => {
					// 1. Engagement Chart (Line)
					const ctx1 = document.getElementById('engagementChart').getContext('2d');
					new Chart(ctx1, {
						type: 'line',
						data: {
							labels: ['11/1', '11/2', '11/3', '11/4', '11/5', '11/6'],
							datasets: [{
								label: 'Active Users',
								data: [245, 268, 290, 310, 325, 342],
								borderColor: '#B4C59B',
								backgroundColor: '#B4C59B',
								tension: 0.4,
								borderWidth: 3
							}, {
								label: 'Sessions',
								data: [380, 420, 450, 485, 510, 540],
								borderColor: '#3b82f6',
								backgroundColor: '#3b82f6',
								tension: 0.4,
								borderWidth: 3
							}]
						},
						options: {
							responsive: true,
							maintainAspectRatio: false,
							plugins: {
								legend: { position: 'top' }
							},
							scales: {
								y: { beginAtZero: false, grid: { borderDash: [2, 2] } },
								x: { grid: { display: false } }
							}
						}
					});

					// 2. Module Usage (Pie)
					const ctx2 = document.getElementById('modulePieChart').getContext('2d');
					new Chart(ctx2, {
						type: 'pie',
						data: {
							labels: ['Self-Help', 'Resources', 'Forum', 'Progress', 'Counseling', 'Chatbot'],
							datasets: [{
								data: [450, 380, 290, 420, 180, 520],
								backgroundColor: ['#B4C59B', '#3b82f6', '#10b981', '#f59e0b', '#ef4444', '#8b5cf6']
							}]
						},
						options: {
							responsive: true,
							plugins: { legend: { position: 'right' } }
						}
					});

					// 3. Completion Rates (Bar)
					const ctx3 = document.getElementById('moduleBarChart').getContext('2d');
					new Chart(ctx3, {
						type: 'bar',
						data: {
							labels: ['Self-Help', 'Resources', 'Forum', 'Progress', 'Counseling', 'Chatbot'],
							datasets: [{
								label: 'Completion',
								data: [450, 380, 290, 420, 180, 520],
								backgroundColor: '#B4C59B',
								borderRadius: 6
							}]
						},
						options: {
							responsive: true,
							maintainAspectRatio: false,
							scales: {
								y: { beginAtZero: true },
								x: { grid: { display: false } }
							}
						}
					});
				});

				// -- MODERATION LOGIC --
				function handleReport(id, action, btn) {
					// UI Simulate removal
					const row = document.getElementById('report-' + id);

					// Update Stats
					const pendingCountEl = document.getElementById('pendingCount');
					let count = parseInt(pendingCountEl.innerText);
					pendingCountEl.innerText = Math.max(0, count - 1);

					// Animate removal
					row.style.opacity = '0';
					setTimeout(() => {
						row.style.display = 'none';
						// Check if all gone
						const remaining = document.querySelectorAll('.report-item[style*="display: none"]').length;
						const total = document.querySelectorAll('.report-item').length;
						if (remaining === total) {
							document.getElementById('noReports').classList.remove('hidden');
						}

						// Add to resolved list (visual only)
						const resolvedSection = document.getElementById('resolvedSection');
						resolvedSection.classList.remove('hidden');
						const list = document.getElementById('resolvedList');
						const div = document.createElement('div');
						div.className = "bg-green-50 rounded-xl p-3 flex justify-between items-center";
						div.innerHTML = `
                <div class="text-sm">
                    <span class="font-medium text-gray-800">Report #${id}</span> 
                    <span class="text-gray-500 mx-2">•</span> 
                    <span class="text-gray-600">${action === 'remove' ? 'Removed' : action === 'hide' ? 'Hidden' : 'Approved'}</span>
                </div>
                <span class="text-xs bg-green-100 text-green-700 px-2 py-1 rounded">Resolved</span>
            `;
						list.prepend(div);

					}, 300);

					// In a real app, you would fetch('/admin/moderate', {method: 'POST', body: ...})
				}
			</script>
		</body>

		</html>