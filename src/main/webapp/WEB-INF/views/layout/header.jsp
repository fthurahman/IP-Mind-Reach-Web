<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!-- Top Navigation Bar -->
        <header class="header">
            <div class="header-container">
                <!-- Logo -->
                <a href="${pageContext.request.contextPath}/homeStudent" class="logo-btn"> MindReach </a>

                <!-- Desktop Navigation -->
                <nav class="nav-desktop">
                    <a href="<c:url value='/homeStudent'/>"
                        class="nav-item ${param.activePage == 'homeStudent' ? 'active' : ''}">Self-Assessment</a>
                    <a href="<c:url value='/resources'/>"
                        class="nav-item ${param.activePage == 'resources' ? 'active' : ''}">Resources</a>
                    <a href="<c:url value='/forum'/>"
                        class="nav-item ${param.activePage == 'forum' ? 'active' : ''}">Forum</a>
                    <a href="<c:url value='/progress'/>"
                        class="nav-item ${param.activePage == 'progress' ? 'active' : ''}">Progress</a>
                    <a href="<c:url value='/telehealth'/>"
                        class="nav-item ${param.activePage == 'telehealth' ? 'active' : ''}">Telehealth Assistance</a>
                    <a href="<c:url value='/chatbot'/>"
                        class="nav-item ${param.activePage == 'chatbot' ? 'active' : ''}">Chat Support</a>
                </nav>

                <!-- User Section / Mobile Toggle -->
                <div class="user-section-desktop">
                    <div class="avatar-circle">
                        <!-- User Icon SVG -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <circle cx="12" cy="12" r="10" />
                            <circle cx="12" cy="10" r="3" />
                            <path d="M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662" />
                        </svg>
                    </div>
                    <div class="user-info">
                        <p class="user-name">${loggedUser.name}</p>
                        <p class="user-role" style="text-transform: capitalize;">${loggedUser.role}</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="btn-ghost">
                        <!-- LogOut Icon -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                            stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                            style="margin-right: 8px">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                            <polyline points="16 17 21 12 16 7" />
                            <line x1="21" x2="9" y1="12" y2="12" />
                        </svg>
                        Log out
                    </a>
                </div>

                <button class="mobile-menu-btn" onclick="toggleMobileMenu()">
                    <!-- Menu Icon -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
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
                <h3 style="margin: 0 0 0.5rem 0; font-family: var(--font-family-serif); font-size: 1.25rem;">
                    Navigation
                </h3>
                <p style="margin: 0; font-size: 0.875rem; color: #8c8784">
                    Access MindReach sections
                </p>

                <nav class="mobile-nav">
                    <a href="<c:url value='/homeStudent'/>"
                        class="mobile-nav-item ${param.activePage == 'homeStudent' ? 'active' : ''}">Self-Assessment</a>
                    <a href="<c:url value='/resources'/>"
                        class="mobile-nav-item ${param.activePage == 'resources' ? 'active' : ''}">Resources</a>
                    <a href="<c:url value='/forum'/>"
                        class="mobile-nav-item ${param.activePage == 'forum' ? 'active' : ''}">Forum</a>
                    <a href="<c:url value='/progress'/>"
                        class="mobile-nav-item ${param.activePage == 'progress' ? 'active' : ''}">Progress</a>
                    <a href="<c:url value='/telehealth'/>"
                        class="mobile-nav-item ${param.activePage == 'telehealth' ? 'active' : ''}">Telehealth
                        Assistance</a>
                    <a href="<c:url value='/chatbot'/>"
                        class="mobile-nav-item ${param.activePage == 'chatbot' ? 'active' : ''}">Chat Support</a>
                </nav>

                <div class="mobile-separator"></div>

                <a href="${pageContext.request.contextPath}/logout" class="mobile-nav-item" style="color: #5a5653">Log
                    out</a>
            </div>
        </div>

        <script>
            function toggleMobileMenu() {
                const sheet = document.getElementById("mobileSheet");
                if (sheet.classList.contains("open")) {
                    sheet.classList.remove("open");
                } else {
                    sheet.classList.add("open");
                }
            }
        </script>