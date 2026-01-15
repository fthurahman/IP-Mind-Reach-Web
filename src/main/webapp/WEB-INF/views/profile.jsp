<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <c:set var="userRole" value="${loggedUser.role}" />

        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>My Profile - MindReach</title>
            <script src="https://cdn.tailwindcss.com"></script>
            <%@ include file="layout/css-include.jsp" %>
                <style>
                    /* Fonts and Variables - matching register.jsp */
                    @import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Work+Sans:ital,wght@0,100..900;1,100..900&display=swap');

                    :root {
                        --font-family-serif: 'DM Serif Display', serif;
                        --font-family-sans: 'Work Sans', sans-serif;
                        --background: #F7F3EF;
                        --primary: #B4C59B;
                        --primary-hover: #9AAF86;
                        --foreground: #3D3A37;
                        --muted-foreground: #8C8784;
                        --card: #FFFFFF;
                        --border: #E9E4DF;
                        --radius-xl: 0.75rem;
                    }

                    body {
                        background-color: var(--background);
                        font-family: var(--font-family-sans);
                        color: var(--foreground);
                        margin: 0;
                        padding: 0;
                    }

                    .main-content {
                        padding-top: 5rem;
                        /* Space for fixed header */
                        padding-bottom: 2rem;
                        min-height: calc(100vh - 7rem);
                        display: flex;
                        justify-content: center;
                        align-items: flex-start;
                    }

                    .profile-card {
                        background-color: var(--card);
                        border-radius: var(--radius-xl);
                        padding: 2.5rem;
                        width: 100%;
                        max-width: 600px;
                        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.02);
                        border: 1px solid var(--border);
                    }

                    .profile-header {
                        display: flex;
                        align-items: center;
                        gap: 1.5rem;
                        margin-bottom: 2rem;
                        padding-bottom: 1.5rem;
                        border-bottom: 1px solid var(--border);
                    }

                    .profile-avatar-large {
                        width: 80px;
                        height: 80px;
                        background-color: rgba(180, 197, 155, 0.2);
                        color: var(--primary);
                        border-radius: 50%;
                        display: flex;
                        align-items: center;
                        justify-content: center;
                    }

                    .profile-avatar-large i {
                        width: 40px;
                        height: 40px;
                    }

                    .profile-title h1 {
                        font-family: var(--font-family-serif);
                        font-size: 1.75rem;
                        margin: 0;
                        color: #3D3A37;
                    }

                    .profile-title p {
                        margin: 0;
                        color: var(--muted-foreground);
                        font-size: 0.95rem;
                    }

                    .form-section {
                        display: flex;
                        flex-direction: column;
                        gap: 1.25rem;
                    }

                    .form-group {
                        display: flex;
                        flex-direction: column;
                        gap: 0.5rem;
                    }

                    .form-group label {
                        font-size: 0.875rem;
                        font-weight: 500;
                        color: var(--foreground);
                    }

                    .form-group input,
                    .form-group textarea {
                        padding: 0.75rem;
                        border-radius: var(--radius-xl);
                        border: 1px solid var(--border);
                        font-family: var(--font-family-sans);
                        font-size: 0.95rem;
                        color: var(--foreground);
                        background-color: #fff;
                        transition: border-color 0.2s;
                    }

                    .form-group input:focus,
                    .form-group textarea:focus {
                        outline: none;
                        border-color: var(--primary);
                        box-shadow: 0 0 0 2px rgba(180, 197, 155, 0.2);
                    }

                    .form-group input:disabled {
                        background-color: #f9f9f9;
                        color: #999;
                        cursor: not-allowed;
                    }

                    .action-buttons {
                        margin-top: 2rem;
                        display: flex;
                        justify-content: flex-end;
                        gap: 1rem;
                    }

                    .btn-primary {
                        background-color: var(--primary);
                        color: #fff;
                        border: none;
                        padding: 0.75rem 1.5rem;
                        border-radius: var(--radius-xl);
                        font-weight: 500;
                        cursor: pointer;
                        transition: background-color 0.2s;
                        text-decoration: none;
                        font-size: 0.95rem;
                    }

                    .btn-primary:hover {
                        background-color: var(--primary-hover);
                    }

                    .btn-secondary {
                        background-color: transparent;
                        color: var(--foreground);
                        border: 1px solid var(--border);
                        padding: 0.75rem 1.5rem;
                        border-radius: var(--radius-xl);
                        font-weight: 500;
                        cursor: pointer;
                        transition: background-color 0.2s;
                        text-decoration: none;
                        font-size: 0.95rem;
                    }

                    .btn-secondary:hover {
                        background-color: #f5f5f5;
                    }

                    .alert-success {
                        padding: 1rem;
                        background-color: #d1e7dd;
                        color: #0f5132;
                        border: 1px solid #badbcc;
                        border-radius: var(--radius-xl);
                        margin-bottom: 1.5rem;
                        font-size: 0.9rem;
                    }
                </style>
                <!-- Lucide Icons -->
                <script src="https://unpkg.com/lucide@latest"></script>
        </head>

        <body>
            <!-- Include Header Conditional -->
            <c:choose>
                <c:when test="${loggedUser.role eq 'mhprofessional'}">
                    <jsp:include page="layout/headerCounselor.jsp">
                        <jsp:param name="activePage" value="profile" />
                    </jsp:include>
                </c:when>
                <c:otherwise>
                    <jsp:include page="layout/header.jsp">
                        <jsp:param name="activePage" value="profile" />
                    </jsp:include>
                </c:otherwise>
            </c:choose>

            <!-- Adjust padding for Counselor since their header is Sticky (takes space), unlike Student header which is Fixed -->
            <div class="main-content" style="${loggedUser.role eq 'mhprofessional' ? 'padding-top: 2rem;' : ''}">
                <div class="profile-card">

                    <c:if test="${not empty successMessage}">
                        <div class="alert-success">
                            ${successMessage}
                        </div>
                    </c:if>

                    <div class="profile-header">
                        <div class="profile-avatar-large">
                            <i data-lucide="user" style="width: 40px; height: 40px;"></i>
                        </div>
                        <div class="profile-title">
                            <h1>${loggedUser.name}</h1>
                            <p>${loggedUser.email}</p>
                        </div>
                    </div>

                    <form action="profile/update" method="post" class="form-section">
                        <!-- Read-Only Fields -->
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="text" value="${loggedUser.email}" disabled />
                        </div>

                        <div class="form-group">
                            <label>Role</label>
                            <input type="text" value="${loggedUser.role eq 'student' ? 'Student' : 'Counselor'}"
                                disabled />
                        </div>

                        <c:if test="${loggedUser.role eq 'student'}">
                            <div class="form-group">
                                <label>Matric Number</label>
                                <c:choose>
                                    <c:when test="${not empty loggedUser.matricNumber}">
                                        <input type="text" value="${loggedUser.matricNumber}" disabled />
                                    </c:when>
                                    <c:otherwise>
                                        <input type="text" name="matricNumber" placeholder="Enter Matric Number" />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:if>

                        <c:if test="${loggedUser.role eq 'mhprofessional'}">
                            <div class="form-group">
                                <label>Organization / Hospital</label>
                                <input type="text" name="workingPlace" value="${loggedUser.workingPlace}"
                                    placeholder="Enter Organization Name" />
                            </div>
                        </c:if>

                        <!-- Editable Fields -->
                        <div class="form-group">
                            <label for="name">Display Name (Optional)</label>
                            <input type="text" id="name" name="name" value="${loggedUser.name}"
                                placeholder="Enter your full name">
                        </div>

                        <div class="form-group">
                            <label for="phoneNumber">Phone Number (Optional)</label>
                            <input type="tel" id="phoneNumber" name="phoneNumber" value="${loggedUser.phoneNumber}"
                                placeholder="e.g. +60123456789">
                        </div>

                        <div class="form-group">
                            <label for="address">Address (Optional)</label>
                            <textarea id="address" name="address" rows="3"
                                placeholder="Enter your address">${loggedUser.address}</textarea>
                        </div>

                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/${loggedUser.role eq 'student' ? 'homeStudent' : 'homeMProfessional'}"
                                class="btn-secondary">Cancel</a>
                            <button type="submit" class="btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>

            <script>
                lucide.createIcons();
            </script>
        </body>

        </html>