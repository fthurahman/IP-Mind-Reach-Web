<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
      <!DOCTYPE html>
      <html>

      <head>
        <meta charset="UTF-8" />
        <title>Forum | MindReach</title>
        <!-- Use embedded CSS approach for speed/reliability, plus link to main style -->
        <!-- Embedded CSS -->
        <%@ include file="layout/css-include.jsp" %>
          <style>
            /* Ensure font variables are available if not picked up */
            :root {
              --font-family-serif: "DM Serif Display", serif;
              --font-family-sans: "Work Sans", sans-serif;
            }

            body {
              font-family: var(--font-family-sans);
              background-color: #f7f3ef;
              margin: 0;
              padding-bottom: 3rem;
            }
          </style>
      </head>

      <body>
        <!-- Top Navigation Bar (Duplicated from homeStudent.jsp for standalone reliability) -->
        <header class="header">
          <div class="header-container">
            <a href="homeStudent" class="logo-btn">MindReach</a>
            <nav class="nav-desktop">
              <a href="homeStudent" class="nav-item">Self-Help</a>
              <a href="resources" class="nav-item">Resources</a>
              <a href="forum" class="nav-item active">Forum</a>
              <a href="progress" class="nav-item">Progress</a>
              <a href="counseling" class="nav-item">Telehealth Assistance</a>
              <a href="chatbot" class="nav-item">Chat Support</a>
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
                  style="margin-right: 8px">
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
              <a href="homeStudent" class="mobile-nav-item">Self-Help</a>
              <a href="resources" class="mobile-nav-item">Resources</a>
              <a href="forum" class="mobile-nav-item active">Forum</a>
              <a href="resultDASS" class="mobile-nav-item">Progress</a>
              <a href="counseling" class="mobile-nav-item">Telehealth Assistance</a>
              <a href="chatbot" class="mobile-nav-item">Chat Support</a>
            </nav>
            <div class="mobile-separator"></div>
            <a href="logout" class="mobile-nav-item" style="color: #5a5653">Log out</a>
          </div>
        </div>

        <!-- Main Content -->
        <main class="dashboard-content">
          <!-- Hero Header -->
          <div class="hero-card bg-gradient-forum">
            <div style="
            display: flex;
            justify-content: space-between;
            align-items: start;
            gap: 1rem;
          ">
              <div>
                <h1 style="
                font-size: 1.875rem;
                color: white;
                margin: 0 0 0.5rem 0;
                font-weight: 600;
              ">
                  Community Forum
                </h1>
                <p style="color: rgba(255, 255, 255, 0.9); margin: 0">
                  Connect with peers anonymously in a safe space
                </p>
              </div>
              <button onclick="openCreateModal()" style="
              background: white;
              color: #3d3a37;
              border: none;
              padding: 0.75rem 1rem;
              border-radius: 0.75rem;
              font-weight: 500;
              cursor: pointer;
              box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
              transition: background 0.2s;
            ">
                Create Post
              </button>
            </div>
          </div>

          <!-- Post List -->
          <div class="space-y-4">
            <c:forEach var="post" items="${posts}">
              <!-- Make the whole card clickable -> go to detail -->
              <a href="forum?action=detail&id=${post.id}" class="post-card" style="display: block; color: inherit">
                <div style="
                display: flex;
                align-items: start;
                gap: 1rem;
                justify-content: space-between;
              ">
                  <div style="flex: 1">
                    <div style="
                    display: flex;
                    align-items: center;
                    gap: 0.5rem;
                    margin-bottom: 0.5rem;
                    flex-wrap: wrap;
                  ">
                      <!-- User Icon -->
                      <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                        stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
                        style="color: #9ca3af">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
                        <circle cx="12" cy="7" r="4" />
                      </svg>

                      <span style="font-size: 0.875rem; color: #4b5563">${post.author}</span>
                      <span style="font-size: 0.875rem; color: #9ca3af">•</span>
                      <!-- Approx time logic (simplified for JSP) -->
                      <span style="font-size: 0.875rem; color: #9ca3af">${post.createdAt}</span>
                      <!-- Should ideally format to "2 hours ago" -->

                      <span class="badge badge-topic">${post.topic}</span>

                      <c:if test="${post.reported}">
                        <span class="badge badge-reported">⚠️ Reported Post</span>
                      </c:if>
                    </div>

                    <p style="
                    color: #1f2937;
                    margin: 0 0 0.75rem 0;
                    line-height: 1.5;
                  ">
                      ${post.content}
                    </p>

                    <!-- Action Bar -->
                    <div style="display: flex; items: center; gap: 1rem">
                      <div style="
                      display: flex;
                      align-items: center;
                      gap: 0.5rem;
                      font-size: 0.875rem;
                      color: #6b7280;
                    ">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none"
                          stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                          <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z" />
                        </svg>
                        <span>${fn:length(post.comments)}
                          comment${fn:length(post.comments) != 1 ? 's' : ''}</span>
                      </div>

                      <!-- Stop propagation for buttons inside the anchor -->
                      <object>
                        <a href="forum?action=report&id=${post.id}"
                          onclick='return confirm("Are you sure you want to ${post.reported ? "unreport" : "report"} this post?")'
                          class="action-btn-ghost ${post.reported ? 'reported' : ''}"
                          title="${post.reported ? 'Remove report' : 'Report as inappropriate'}"
                          style="text-decoration: none">
                          <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24"
                            fill="${post.reported ? 'currentColor' : 'none'}" stroke="currentColor" stroke-width="2"
                            stroke-linecap="round" stroke-linejoin="round">
                            <path d="M4 15s1-1 4-1 5 2 8 2 4-1 4-1V3s-1 1-4 1-5-2-8-2-4 1-4 1z" />
                            <line x1="4" x2="4" y1="22" y2="15" />
                          </svg>
                          <span style="font-size: 0.875rem">${post.reported ? 'Reported' : 'Report'}</span>
                        </a>
                      </object>
                    </div>
                  </div>
                </div>
              </a>
            </c:forEach>
          </div>
        </main>

        <!-- Create Post Dialog -->
        <div id="createPostModal" class="dialog-backdrop">
          <div class="dialog-content" style="max-width: 500px">
            <h2 class="dialog-title" style="text-align: left; margin-bottom: 0.25rem">
              Create a New Post
            </h2>
            <p class="dialog-description" style="text-align: left; margin-bottom: 1.5rem">
              Share your thoughts, questions, or experiences anonymously.
            </p>

            <form action="forum" method="post">
              <input type="hidden" name="action" value="create" />
              <!-- Anonymous Handle Generator Logic would go here or backend. 
                     For now, we let backend handle it, or pass a hidden client-generated one.
                     The controller expects 'author', 'topic', 'content'. 
                -->
              <!-- Simulating React's anonymous handle on client side submission -->
              <input type="hidden" id="authorField" name="author" value="Anonymous Student" />

              <div class="form-group">
                <label for="topic">Topic</label>
                <div class="input-wrapper">
                  <!-- Custom Select styling is hard in pure CSS, using standard select styled to match -->
                  <select id="topic" name="topic" required style="
                  width: 100%;
                  padding: 0.75rem;
                  border-radius: var(--radius-xl);
                  border: 1px solid var(--border);
                  font-family: var(--font-family-sans);
                  background: white;
                ">
                    <option value="general">General</option>
                    <option value="stress">Stress</option>
                    <option value="anxiety">Anxiety</option>
                    <option value="sleep">Sleep</option>
                    <option value="relationships">Relationships</option>
                    <option value="academics">Academics</option>
                  </select>
                </div>
              </div>

              <div class="form-group">
                <label for="content">Your Post</label>
                <textarea id="content" name="content" rows="5" placeholder="Share your thoughts..." required style="
                width: 100%;
                padding: 0.75rem;
                border-radius: var(--radius-xl);
                border: 1px solid var(--border);
                font-family: var(--font-family-sans);
                resize: vertical;
                box-sizing: border-box;
              "></textarea>
              </div>

              <div style="
              background-color: #eff6ff;
              padding: 0.75rem;
              border-radius: var(--radius-xl);
              font-size: 0.875rem;
              color: #4b5563;
              margin-bottom: 1.5rem;
            ">
                💡 Your post will be anonymous.
              </div>

              <div class="dialog-actions">
                <button type="button" class="btn-outline" onclick="closeCreateModal()">
                  Cancel
                </button>
                <button type="submit" class="btn-primary" style="box-shadow: none">
                  Post Anonymously
                </button>
              </div>
            </form>
          </div>
        </div>

        <script>
          // --- Mobile Menu Logic ---
          function toggleMobileMenu() {
            const sheet = document.getElementById("mobileSheet");
            if (sheet.classList.contains("open")) {
              sheet.classList.remove("open");
            } else {
              sheet.classList.add("open");
            }
          }

          // --- Modal Logic ---
          function openCreateModal() {
            // Generate random anonymous handle client-side for UX
            const animals = [
              "Owl",
              "Butterfly",
              "Fox",
              "Dolphin",
              "Bear",
              "Rabbit",
              "Deer",
              "Eagle",
            ];
            const randomAnimal =
              animals[Math.floor(Math.random() * animals.length)];
            document.getElementById("authorField").value =
              "Anonymous " + randomAnimal;

            const modal = document.getElementById("createPostModal");
            modal.classList.add("open");
          }

          function closeCreateModal() {
            const modal = document.getElementById("createPostModal");
            modal.classList.remove("open");
          }

          // Close on click outside
          window.onclick = function (event) {
            const sheet = document.getElementById("mobileSheet");
            const modal = document.getElementById("createPostModal");

            if (event.target == sheet) {
              sheet.classList.remove("open");
            }
            if (event.target == modal) {
              closeCreateModal();
            }
          };
        </script>
      </body>

      </html>