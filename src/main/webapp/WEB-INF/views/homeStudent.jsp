<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8" />
      <title>Dashboard | MindReach</title>
      <!-- Use the embedded CSS approach since we appended dashboard styles to style.css -->
      <!-- But also include the updated style.css linkage -->
      <style>
        /* Fonts */
        @import url("https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Work+Sans:ital,wght@0,100..900;1,100..900&display=swap");

        :root {
          /* Colors from global.css */
          --font-family-serif: "DM Serif Display", serif;
          --font-family-sans: "Work Sans", sans-serif;

          --background: #f7f3ef;
          --foreground: #3d3a37;
          --card: #ffffff;
          --card-foreground: #5a5653;
          --primary: #b4c59b;
          --primary-hover: #9aaf86;
          --primary-foreground: #3d3a37;
          --muted-foreground: #8c8784;
          --border: #e9e4df;

          --radius-xl: 0.75rem;
        }

        body {
          margin: 0;
          padding: 0;
          font-family: var(--font-family-sans);
          background-color: var(--background);
          color: var(--foreground);
          min-height: 100vh;
        }

        /* Include the dashboard styles directly here if strictly needed, 
           but relying on style.css is better if the file update worked. 
           For safety/speed, I will rely on the style.css update I just did. */
      </style>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
    </head>

    <body>
      <!-- Top Navigation Bar -->
      <header class="header">
        <div class="header-container">
          <!-- Logo -->
          <a href="homeStudent" class="logo-btn"> MindReach </a>

          <!-- Desktop Navigation -->
          <nav class="nav-desktop">
            <a href="<c:url value='/homeStudent'/>" class="nav-item active">Self-Help</a>
            <a href="<c:url value='/resources'/>" class="nav-item">Resources</a>
            <a href="<c:url value='/forum'/>" class="nav-item">Forum</a>
            <a href="<c:url value='/progress'/>" class="nav-item">Progress</a>
            <a href="<c:url value='/counseling'/>" class="nav-item">Telehealth Assistance</a>
            <a href="<c:url value='/chatbot'/>" class="nav-item">Chat Support</a>
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
              <p class="user-role">Student</p>
            </div>
            <a href="logout" class="btn-ghost">
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
            <a href="<c:url value='/homeStudent'/>" class="mobile-nav-item active">Self-Help</a>
            <a href="<c:url value='/resources'/>" class="mobile-nav-item">Resources</a>
            <a href="<c:url value='/forum'/>" class="mobile-nav-item">Forum</a>
            <a href="<c:url value='/progress'/>" class="mobile-nav-item">Progress</a>
            <a href="<c:url value='/counseling'/>" class="mobile-nav-item">Telehealth Assistance</a>
            <a href="<c:url value='/chatbot'/>" class="mobile-nav-item">Chat Support</a>
          </nav>


          <div class="mobile-separator"></div>

          <a href="logout" class="mobile-nav-item" style="color: #5a5653">Log out</a>
        </div>
      </div>

      <!-- Main Content -->
      <main class="dashboard-content">
        <!-- Re-implementing the original "Self Assessment" content within the new layout -->

        <div style="text-align: center; margin-bottom: 3rem">
          <h1 style="
            font-family: var(--font-family-serif);
            font-size: 2.5rem;
            color: var(--foreground);
            margin-bottom: 0.5rem;
          ">
            Mental Health Self-Assessment
          </h1>
          <p style="color: var(--muted-foreground)">
            Take the first step towards understanding your mental wellbeing
          </p>
        </div>

        <div style="
          display: flex;
          justify-content: center;
          gap: 2rem;
          flex-wrap: wrap;
        ">
          <!-- DASS Card -->
          <div style="
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            width: 100%;
            max-width: 380px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--border);
          ">
            <div style="font-size: 2rem; margin-bottom: 1rem">⚡</div>
            <h3 style="
              margin-top: 0;
              font-family: var(--font-family-serif);
              font-size: 1.5rem;
              margin-bottom: 0.5rem;
            ">
              Depression, Anxiety & Stress Scale
            </h3>
            <p style="
              color: var(--card-foreground);
              font-size: 0.875rem;
              line-height: 1.5;
              margin-bottom: 1.5rem;
            ">
              Measure the current mental health and emotional states, identifying
              Depression, Anxiety or Stress.
            </p>
            <a href="DASS" style="
              display: block;
              width: 100%;
              padding: 0.75rem;
              text-align: center;
              background: var(--primary);
              color: var(--primary-foreground);
              text-decoration: none;
              border-radius: 0.5rem;
              font-weight: 500;
              transition: background 0.2s;
            ">
              Start Assessment →
            </a>
          </div>

          <!-- PHQ Card -->
          <div style="
            background: white;
            padding: 2rem;
            border-radius: 1rem;
            width: 100%;
            max-width: 380px;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            border: 1px solid var(--border);
          ">
            <div style="font-size: 2rem; margin-bottom: 1rem">😊</div>
            <h3 style="
              margin-top: 0;
              font-family: var(--font-family-serif);
              font-size: 1.5rem;
              margin-bottom: 0.5rem;
            ">
              Patient Health Questionnaire
            </h3>
            <p style="
              color: var(--card-foreground);
              font-size: 0.875rem;
              line-height: 1.5;
              margin-bottom: 1.5rem;
            ">
              Screen for presence and severity of depression. For diagnosis,
              professional consultation is recommended.
            </p>
            <a href="assessmentPHQ" style="
              display: block;
              width: 100%;
              padding: 0.75rem;
              text-align: center;
              background: var(--primary);
              color: var(--primary-foreground);
              text-decoration: none;
              border-radius: 0.5rem;
              font-weight: 500;
              transition: background 0.2s;
            ">
              Start Assessment →
            </a>
          </div>
        </div>
      </main>

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
          if (event.target == sheet) {
            sheet.classList.remove("open");
          }
        };
      </script>
    </body>

    </html>