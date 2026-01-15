<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

            <!-- Header for Counselor -->
            <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
                <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
                    <a href="${pageContext.request.contextPath}/homeMProfessional"
                        class="font-serif text-2xl text-[#3D3A37] hover:opacity-80"
                        style="text-decoration:none;">MindReach</a>
                    <nav class="hidden lg:flex items-center gap-6">
                        <a href="${pageContext.request.contextPath}/homeMProfessional"
                            class="${param.activePage == 'resources' ? 'text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1' : 'text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium'} transition-all"
                            style="text-decoration:none;">Resources</a>

                        <a href="${pageContext.request.contextPath}/telehealthCounselor"
                            class="${param.activePage == 'telehealth' ? 'text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1' : 'text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium'} transition-colors"
                            style="text-decoration:none;">Telehealth
                            Assistance</a>

                        <a href="${pageContext.request.contextPath}/counselor/student-results"
                            class="${param.activePage == 'results' ? 'text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1' : 'text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium'} transition-colors"
                            style="text-decoration:none;">Student
                            Assessment</a>
                    </nav>
                    <div class="hidden lg:flex items-center gap-3">
                        <div class="text-right">
                            <a href="${pageContext.request.contextPath}/profile" class="block"
                                style="text-decoration: none;">
                                <div class="text-sm text-[#3D3A37] font-medium transition-colors">
                                    <c:choose>
                                        <c:when test="${not empty loggedUser and not empty loggedUser.name}">
                                            ${fn:split(loggedUser.name, ' ')[0]}
                                        </c:when>
                                        <c:otherwise>Doctor</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-xs text-gray-500 capitalize">
                                    <c:choose>
                                        <c:when test="${not empty loggedUser and loggedUser.role == 'mhprofessional'}">
                                            Counselor</c:when>
                                        <c:when test="${not empty loggedUser}">${loggedUser.role}</c:when>
                                        <c:otherwise>Counselor</c:otherwise>
                                    </c:choose>
                                </div>
                            </a>
                        </div>
                        <a href="${pageContext.request.contextPath}/profile"
                            class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B] hover:bg-[#B4C59B]/30 transition-colors"
                            style="text-decoration:none;">
                            <!-- User Icon -->
                            <i data-lucide="user"></i>
                        </a>
                        <a href="${pageContext.request.contextPath}/logout" class="btn-ghost"
                            style="margin-left: 1rem; display: flex; align-items: center; text-decoration: none; color: inherit;">
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