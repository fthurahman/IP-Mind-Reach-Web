<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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

            <!-- Admin Header -->
            <jsp:include page="layout/header.jsp">
                <jsp:param name="activePage" value="user-management" />
            </jsp:include>

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
                        <h2 class="text-xl font-serif text-[#3D3A37]">Pending Approvals (${pendingCounselors.size()})
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

                                <form action="${pageContext.request.contextPath}/approve-user" method="post">
                                    <input type="hidden" name="email" value="${user.email}">
                                    <button type="submit"
                                        class="w-full py-2 px-4 bg-[#B4C59B] text-[#3D3A37] font-medium rounded-xl hover:bg-[#9AAF86] transition-colors flex items-center justify-center gap-2">
                                        <i data-lucide="check" class="w-4 h-4"></i> Approve Access
                                    </button>
                                </form>
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