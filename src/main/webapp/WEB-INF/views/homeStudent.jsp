<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8" />
      <title>Dashboard | MindReach</title>
      <script src="https://cdn.tailwindcss.com"></script>
      <!-- Use the embedded CSS approach since we appended dashboard styles to style.css -->
      <!-- But also include the updated style.css linkage -->
      <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
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
      <jsp:include page="layout/header.jsp">
        <jsp:param name="activePage" value="homeStudent" />
      </jsp:include>

      <!-- Main Content -->
      <main class="dashboard-content" style="padding-top: 96px !important;">
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
            <c:choose>
              <c:when test="${hasAssessment}">
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
                  Retake Assessment
                </a>
                <div style="text-align: center; margin-top: 10px;">
                  <a href="resultDASS" style="font-size: 0.875rem; color: #5a5653; text-decoration: underline;">
                    View Latest Result
                  </a>
                  <div style="font-size: 0.75rem; color: #8c8784; margin-top: 4px;">
                    Last taken: ${latestAssessmentDate}
                  </div>
                </div>
              </c:when>
              <c:otherwise>
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
              </c:otherwise>
            </c:choose>
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