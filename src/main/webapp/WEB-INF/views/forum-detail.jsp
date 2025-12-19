<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
      <!DOCTYPE html>
      <html>

      <head>
        <meta charset="UTF-8">
        <title>Discussion | MindReach</title>
        <%@ include file="layout/css-include.jsp" %>
          <style>
            :root {
              --font-family-serif: 'DM Serif Display', serif;
              --font-family-sans: 'Work Sans', sans-serif;
            }

            body {
              font-family: var(--font-family-sans);
              background-color: #F7F3EF;
              margin: 0;
              padding-bottom: 3rem;
            }
          </style>
      </head>

      <body>

        <!-- Header (Duplicated) -->
        <header class="header">
          <div class="header-container">
            <a href="homeStudent" class="logo-btn">MindReach</a>
            <nav class="nav-desktop">
              <a href="homeStudent" class="nav-item">Self-Help</a>
              <a href="resources" class="nav-item">Resources</a>
              <a href="forum" class="nav-item active">Forum</a>
              <a href="resultDASS" class="nav-item">Progress</a>
              <a href="counseling" class="nav-item">Telehealth Assistance</a>
              <a href="#" class="nav-item">Chat Support</a>
            </nav>
            <div class="user-section-desktop">
              <div class="avatar-circle">
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
                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                  style="margin-right: 8px;">
                  <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
                  <polyline points="16 17 21 12 16 7" />
                  <line x1="21" x2="9" y1="12" y2="12" />
                </svg>
                Log out
              </a>
            </div>
            <button class="mobile-menu-btn" onclick="toggleMobileMenu()">
              <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none"
                stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="4" x2="20" y1="12" y2="12" />
                <line x1="4" x2="20" y1="6" y2="6" />
                <line x1="4" x2="20" y1="18" y2="18" />
              </svg>
            </button>
          </div>
        </header>

        <!-- Mobile Menu -->
        <div id="mobileSheet" class="sheet-overlay">
          <div class="sheet-content">
            <h3 style="margin: 0 0 0.5rem 0; font-family: var(--font-family-serif); font-size: 1.25rem;">Navigation</h3>
            <p style="margin: 0; font-size: 0.875rem; color: #8C8784;">Access MindReach sections</p>
            <nav class="mobile-nav">
              <a href="homeStudent" class="mobile-nav-item">Self-Help</a>
              <a href="resources" class="mobile-nav-item">Resources</a>
              <a href="forum" class="mobile-nav-item active">Forum</a>
              <a href="resultDASS" class="mobile-nav-item">Progress</a>
              <a href="counseling" class="mobile-nav-item">Telehealth Assistance</a>
              <a href="#" class="mobile-nav-item">Chat Support</a>
            </nav>
            <div class="mobile-separator"></div>
            <a href="logout" class="mobile-nav-item" style="color: #5A5653;">Log out</a>
          </div>
        </div>

        <!-- Main Content -->
        <main class="dashboard-content" style="max-width: 800px; margin: 0 auto;">

          <!-- Back Button -->
          <c:set var="backLink" value="${param.source == 'monitor' ? 'forum-monitor' : 'forum'}" />
          <a href="${backLink}" class="btn-ghost"
            style="display: inline-flex; align-items: center; gap: 0.5rem; margin-bottom: 1.5rem; padding-left: 0; color: #6B7280;">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
              stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
              <path d="M19 12H5" />
              <path d="M12 19l-7-7 7-7" />
            </svg>
            ${param.source == 'monitor' ? 'Back to Monitor' : 'Back to Forum'}
          </a>

          <!-- Selected Post Card -->
          <div class="post-card" style="cursor: default;">
            <div style="display: flex; align-items: start; gap: 1rem; justify-content: space-between;">
              <div style="flex: 1;">
                <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem; flex-wrap: wrap;">
                  <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                    stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                    style="color: #9CA3AF;">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                    <circle cx="12" cy="7" r="4" />
                  </svg>
                  <span style="font-size: 0.875rem; color: #4B5563;">${post.author}</span>
                  <span style="font-size: 0.875rem; color: #9CA3AF;">•</span>
                  <span style="font-size: 0.875rem; color: #9CA3AF;">${post.createdAt}</span>
                  <span class="badge badge-topic">${post.topic}</span>
                </div>

                <p style="color: #1F2937; margin: 0 0 0.75rem 0; line-height: 1.5; font-size: 1rem;">${post.content}</p>
              </div>

              <c:set var="reportAction" value="${post.reported ? 'unreport' : 'report'}" />
              <a id="reportBtn" href="forum?action=report&id=${post.id}"
                onclick='return confirm("Are you sure you want to ${reportAction} this post?")'
                class="action-btn-ghost ${post.reported ? 'reported' : ''}"
                style="text-decoration: none; display: flex; align-items: center; gap: 0.25rem;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24"
                  fill="${post.reported ? 'currentColor' : 'none'}" stroke="currentColor" stroke-width="2"
                  stroke-linecap="round" stroke-linejoin="round">
                  <path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z" />
                  <line x1="4" x2="4" y1="22" y2="15" />
                </svg>
                <span style="font-size: 0.875rem;">${post.reported ? 'Reported' : 'Report'}</span>
              </a>
            </div>

            <!-- Comments Section -->
            <div style="margin-top: 1.5rem; padding-top: 1.5rem; border-top: 1px solid var(--border);">
              <h3
                style="font-family: var(--font-family-sans); font-size: 1rem; font-weight: 600; margin-bottom: 1rem; display: flex; align-items: center; gap: 0.5rem;">
                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                  stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                </svg>
                Comments (${fn:length(post.comments)})
              </h3>

              <div class="space-y-4">
                <c:forEach var="comment" items="${post.comments}">
                  <div style="background-color: #F9FAFB; padding: 1rem; border-radius: var(--radius-xl);">
                    <div style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.25rem;">
                      <svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                        style="color: #9CA3AF;">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                        <circle cx="12" cy="7" r="4" />
                      </svg>
                      <span style="font-size: 0.875rem; color: #4B5563;">${comment.author}</span>
                      <span style="font-size: 0.875rem; color: #9CA3AF;">•</span>
                      <span style="font-size: 0.875rem; color: #9CA3AF;">${comment.createdAt}</span>
                    </div>
                    <p style="font-size: 0.875rem; color: #1F2937; margin: 0;">${comment.content}</p>
                  </div>
                </c:forEach>
              </div>

              <!-- Add Comment Form (Only show if not from monitor) -->
              <c:if test="${param.source != 'monitor'}">
                <div style="margin-top: 1.5rem; display: flex; gap: 0.5rem;">
                  <form action="forum" method="post" style="display: flex; gap: 0.5rem; width: 100%;"
                    onsubmit="return confirm('Are you sure you want to post this comment?');">
                    <input type="hidden" name="action" value="comment">
                    <!-- Assuming Controller handles this if action param is present or checks for 'reply' param -->
                    <!-- Based on reading existing file, it seems the controller might just take the parameters. 
                             Wait, existing file had <input type="hidden" name="id" value="${post.id}" /> and <textarea name="reply">.
                             And action="forum". So defaults to POST /forum.
                             I should replicate that structure.
                        -->
                    <input type="hidden" name="id" value="${post.id}">

                    <input type="text" name="reply" placeholder="Write a supportive comment..." required
                      style="flex: 1; padding: 0.75rem 1rem; border-radius: var(--radius-xl); border: 1px solid var(--border); font-family: var(--font-family-sans); font-size: 0.875rem;">

                    <button type="submit"
                      style="background: var(--primary); color: white; border: none; border-radius: var(--radius-xl); padding: 0 1rem; cursor: pointer; display: flex; align-items: center; justify-content: center; transition: background 0.2s;">
                      <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <line x1="22" y1="2" x2="11" y2="13" />
                        <polygon points="22 2 15 22 11 13 2 9 22 2" />
                      </svg>
                    </button>
                  </form>
                </div>
              </c:if>

            </div>
          </div>

        </main>

        <script>
          function toggleMobileMenu() {
            const sheet = document.getElementById('mobileSheet');
            if (sheet.classList.contains('open')) {
              sheet.classList.remove('open');
            } else {
              sheet.classList.add('open');
            }
          }
          window.onclick = function (event) {
            const sheet = document.getElementById('mobileSheet');
            if (event.target == sheet) {
              sheet.classList.remove('open');
            }
          }
        </script>
      </body>

      </html>