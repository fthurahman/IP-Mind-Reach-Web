<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>User Management | MindReach Admin</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <%@ include file="layout/css-include.jsp" %>
                    <script src="https://unpkg.com/lucide@latest"></script>
            </head>

            <body class="bg-[#F7F3EF] min-h-screen">

                <!-- Admin Header (Matching homeAdmin.jsp) -->
                <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
                    <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
                        <a href="${pageContext.request.contextPath}/homeAdmin"
                            class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
                        <nav class="hidden lg:flex items-center gap-6">
                            <!-- Analytics -->
                            <a href="${pageContext.request.contextPath}/homeAdmin"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Analytics</a>

                            <!-- Resources -->
                            <a href="${pageContext.request.contextPath}/resources"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Resources</a>

                            <!-- Forum Monitor -->
                            <a href="${pageContext.request.contextPath}/forum-monitor"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Forum
                                Monitor</a>

                            <!-- User Management (Active) -->
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
                    </div>
                </header>

                <main class="max-w-[1200px] mx-auto px-6 py-8 space-y-8 pt-8">

                    <!-- Header -->
                    <div class="flex items-center justify-between">
                        <div>
                            <h1 class="text-3xl font-serif text-[#3D3A37]">User Management</h1>
                            <p class="text-gray-600">Manage counselor approvals and student accounts</p>
                        </div>
                    </div>

                    <!-- Pending Approvals Section -->
                    <section>
                        <div class="flex items-center gap-3 mb-4">
                            <div
                                class="w-8 h-8 rounded-full bg-yellow-100 flex items-center justify-center text-yellow-600">
                                <i data-lucide="alert-circle" class="w-5 h-5"></i>
                            </div>
                            <h2 class="text-xl font-serif text-[#3D3A37]">Pending Approvals
                                (${pendingCounselors.size()})
                            </h2>
                        </div>

                        <c:if test="${empty pendingCounselors}">
                            <div
                                class="bg-white p-8 rounded-2xl shadow-sm text-center border border-dashed border-gray-300">
                                <p class="text-gray-500">No pending counselor approvals at the moment.</p>
                            </div>
                        </c:if>

                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                            <c:forEach var="user" items="${pendingCounselors}">
                                <div class="bg-white p-6 rounded-2xl shadow-lg border-l-4 border-yellow-400">
                                    <div class="flex items-start justify-between mb-4">
                                        <div
                                            class="w-12 h-12 rounded-full bg-gray-100 flex items-center justify-center text-gray-500">
                                            <i data-lucide="user" class="w-6 h-6"></i>
                                        </div>
                                        <span
                                            class="px-2 py-1 rounded bg-yellow-50 text-yellow-700 text-xs font-medium border border-yellow-100">Pending</span>
                                    </div>
                                    <h3 class="font-medium text-lg text-[#3D3A37] mb-1">${user.name}</h3>
                                    <p class="text-sm text-gray-500 mb-4">${user.email}</p>

                                    <div class="flex flex-col gap-3 mt-4">
                                        <form action="${pageContext.request.contextPath}/approve-user" method="post"
                                            class="w-full">
                                            <input type="hidden" name="email" value="${user.email}">
                                            <button type="submit"
                                                class="w-full py-2 px-4 bg-[#B4C59B] text-[#3D3A37] font-medium rounded-xl hover:bg-[#9AAF86] transition-colors flex items-center justify-center gap-2">
                                                <i data-lucide="check" class="w-4 h-4"></i> Approve Access
                                            </button>
                                        </form>

                                        <form action="${pageContext.request.contextPath}/reject-user" method="post"
                                            class="w-full"
                                            onsubmit="return confirm('Are you sure you want to reject this user?');">
                                            <input type="hidden" name="email" value="${user.email}">
                                            <button type="submit"
                                                class="w-full py-2 px-4 bg-red-50 text-red-600 font-medium rounded-xl border border-red-100 hover:bg-red-100 transition-colors flex items-center justify-center gap-2">
                                                <i data-lucide="x" class="w-4 h-4"></i> Reject Request
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>

                    <hr class="border-[#E9E4DF]">

                    <!-- Active Users Section -->
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                        <!-- Counselors List -->
                        <section>
                            <h2 class="text-xl font-serif text-[#3D3A37] mb-4">Active Counselors</h2>
                            <div class="bg-white rounded-2xl shadow-sm overflow-hidden border border-[#E9E4DF]">
                                <c:if test="${empty activeCounselors}">
                                    <div class="p-6 text-center text-gray-500">No active counselors found.</div>
                                </c:if>
                                <c:forEach var="user" items="${activeCounselors}">
                                    <div class="p-4 border-b border-gray-100 last:border-0 flex items-center gap-4">
                                        <div
                                            class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B]">
                                            <i data-lucide="stethoscope" class="w-5 h-5"></i>
                                        </div>
                                        <div>
                                            <p class="font-medium text-[#3D3A37]">${user.name}</p>
                                            <p class="text-xs text-gray-500">${user.email}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </section>

                        <!-- Students List -->
                        <section>
                            <h2 class="text-xl font-serif text-[#3D3A37] mb-4">Students</h2>
                            <div class="bg-white rounded-2xl shadow-sm overflow-hidden border border-[#E9E4DF]">
                                <c:if test="${empty students}">
                                    <div class="p-6 text-center text-gray-500">No students found.</div>
                                </c:if>
                                <c:forEach var="user" items="${students}">
                                    <div class="p-4 border-b border-gray-100 last:border-0 flex items-center gap-4">
                                        <div
                                            class="w-10 h-10 rounded-full bg-blue-50 flex items-center justify-center text-blue-500">
                                            <i data-lucide="graduation-cap" class="w-5 h-5"></i>
                                        </div>
                                        <div>
                                            <p class="font-medium text-[#3D3A37]">${user.name}</p>
                                            <p class="text-xs text-gray-500">${user.email}</p>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </section>
                    </div>

                </main>

                <script>
                    lucide.createIcons();
                </script>
            </body>

            </html>