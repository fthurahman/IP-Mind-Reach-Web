<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
      <!DOCTYPE html>
      <html>

      <head>
        <meta charset="UTF-8">
        <title>Forum | MindReach</title>
        <!-- Use Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <%@ include file="layout/css-include.jsp" %>
          <script src="https://unpkg.com/lucide@latest"></script>
          <style>
            /* Ensure font variables are available if not picked up */
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

            /* Custom Badge Styles matching the dashboard */
            .badge-topic {
              background-color: #F3F4F6;
              /* gray-100 */
              color: #4B5563;
              /* gray-600 */
              padding: 0.125rem 0.625rem;
              border-radius: 9999px;
              font-size: 0.75rem;
              font-weight: 600;
              border: 1px solid #E5E7EB;
            }

            .badge-reported {
              background-color: #FEF2F2;
              /* red-50 */
              color: #DC2626;
              /* red-600 */
              padding: 0.125rem 0.625rem;
              border-radius: 9999px;
              font-size: 0.75rem;
              font-weight: 600;
              border: 1px solid #FECACA;
            }

            .bg-gradient-forum {
              background: linear-gradient(to right, #F59E0B, #FCD34D);
              /* Amber gradient */
              padding: 2rem;
              border-radius: 1rem;
              box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
            }
          </style>
      </head>

      <body>

        <!-- Top Navigation Bar -->
        <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
          <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
            <a href="${pageContext.request.contextPath}/homeStudent"
              class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
            <nav class="hidden lg:flex items-center gap-6">
              <a href="${pageContext.request.contextPath}/homeStudent"
                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Self-Help</a>
              <a href="${pageContext.request.contextPath}/resources"
                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Resources</a>
              <a href="${pageContext.request.contextPath}/forum"
                class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Forum</a>
              <a href="${pageContext.request.contextPath}/resultDASS"
                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Progress</a>
              <a href="${pageContext.request.contextPath}/counseling"
                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Telehealth
                Assistance</a>
              <a href="#" class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Chat
                Support</a>
            </nav>
            <div class="hidden lg:flex items-center gap-3">
              <div class="text-right">
                <div class="text-sm text-[#3D3A37] font-medium uppercase">${loggedUser.name}</div>
                <div class="text-xs text-gray-500 capitalize">${loggedUser.role}</div>
              </div>
              <div class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B]">
                <i data-lucide="user"></i>
              </div>
              <a href="${pageContext.request.contextPath}/logout"
                class="ml-4 text-sm text-red-500 hover:text-red-700">Logout</a>
            </div>
            <!-- Mobile Menu Button -->
            <button class="lg:hidden p-2 text-[#3D3A37]" onclick="toggleMobileMenu()">
              <i data-lucide="menu"></i>
            </button>
          </div>
        </header>

        <!-- Mobile Menu Sheet -->
        <div id="mobileSheet" class="fixed inset-0 z-[60] hidden">
          <!-- Backdrop -->
          <div class="absolute inset-0 bg-black/20 backdrop-blur-sm" onclick="toggleMobileMenu()"></div>
          <!-- Content -->
          <div class="absolute right-0 top-0 bottom-0 w-[280px] bg-white p-6 shadow-2xl flex flex-col gap-6">
            <div>
              <h3 class="font-serif text-xl text-[#3D3A37] mb-2">Navigation</h3>
              <p class="text-sm text-gray-500">Access MindReach sections</p>
            </div>
            <nav class="flex flex-col gap-4">
              <a href="${pageContext.request.contextPath}/homeStudent" class="text-[#3D3A37] font-medium">Self-Help</a>
              <a href="${pageContext.request.contextPath}/resources" class="text-[#3D3A37] font-medium">Resources</a>
              <a href="${pageContext.request.contextPath}/forum" class="text-[#2D2A28] font-semibold">Forum</a>
              <a href="${pageContext.request.contextPath}/resultDASS" class="text-[#3D3A37] font-medium">Progress</a>
              <a href="${pageContext.request.contextPath}/counseling" class="text-[#3D3A37] font-medium">Telehealth
                Assistance</a>
              <a href="#" class="text-[#3D3A37] font-medium">Chat Support</a>
            </nav>
            <div class="border-t border-gray-100 pt-6 mt-auto">
              <a href="${pageContext.request.contextPath}/logout" class="text-gray-500 hover:text-[#3D3A37]">Log out</a>
            </div>
          </div>
        </div>

        <!-- Main Content -->
        <main class="max-w-[1200px] mx-auto px-6 pt-6 pb-8 space-y-6">

          <!-- Hero Header -->
          <div class="hero-card bg-gradient-forum">
            <div style="display: flex; justify-content: space-between; align-items: start; gap: 1rem;">
              <div>
                <h1 style="font-size: 1.875rem; color: white; margin: 0 0 0.5rem 0; font-weight: 600;">Community Forum
                </h1>
                <p style="color: rgba(255,255,255,0.9); margin: 0;">Connect with peers anonymously in a safe space</p>
              </div>
              <button onclick="openCreateModal()"
                style="background: white; color: #F59E0B; border: none; padding: 0.75rem 1.5rem; border-radius: 0.75rem; font-weight: 600; cursor: pointer; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); transition: transform 0.2s;">
                Create Post
              </button>
            </div>
          </div>

          <!-- Post List -->
          <div class="space-y-4">
            <c:forEach var="post" items="${posts}">
              <!-- Make the whole card clickable -> go to detail -->
              <div onclick="location.href='forum?action=detail&id=${post.id}'"
                class="post-card bg-white p-6 rounded-2xl border border-[#E9E4DF] hover:shadow-lg transition-all cursor-pointer group">
                <div style="display: flex; align-items: start; gap: 1rem; justify-content: space-between;">
                  <div style="flex: 1;">
                    <div
                      style="display: flex; align-items: center; gap: 0.5rem; margin-bottom: 0.5rem; flex-wrap: wrap;">
                      <!-- User Icon -->
                      <i data-lucide="user" class="w-4 h-4 text-gray-400"></i>
                      <span style="font-size: 0.875rem; color: #4b5563">${post.author}</span>
                      <span style="font-size: 0.875rem; color: #9ca3af">•</span>
                      <span style="font-size: 0.875rem; color: #9ca3af">${post.createdAt}</span>
                      <span class="badge-topic">${post.topic}</span>
                      <c:if test="${post.reported}">
                        <span class="badge-reported">⚠️ Reported Post</span>
                      </c:if>
                    </div>

                    <p style="color: #1F2937; margin: 0 0 0.75rem 0; line-height: 1.5;">${post.content}</p>

                    <!-- Action Bar -->
                    <div style="display: flex; align-items: center; gap: 1rem;">
                      <div
                        style="display: flex; align-items: center; gap: 0.5rem; font-size: 0.875rem; color: #6B7280;">
                        <i data-lucide="message-circle" class="w-4 h-4"></i>
                        <span>${fn:length(post.comments)} comment${fn:length(post.comments) != 1 ? 's' : ''}</span>
                      </div>

                      <!-- Stop propagation for buttons inside the clickable div -->
                      <c:set var="reportAction" value="${post.reported ? 'unreport' : 'report'}" />
                      <a href="forum?action=report&id=${post.id}"
                        onclick="event.stopPropagation(); return confirm('Are you sure you want to ${reportAction} this post?')"
                        class="flex items-center gap-1 text-sm text-gray-400 hover:text-red-500 transition-colors z-10"
                        title="${post.reported ? 'Remove report' : 'Report as inappropriate'}">
                        <i data-lucide="flag" class="w-4 h-4 ${post.reported ? 'fill-current text-red-500' : ''}"></i>
                        <span>${post.reported ? 'Reported' : 'Report'}</span>
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>
        </main>

        <!-- Create Post Dialog -->
        <div id="createPostModal" class="fixed inset-0 z-[60] hidden flex items-center justify-center p-4">
          <div class="absolute inset-0 bg-black/50 backdrop-blur-sm" onclick="closeCreateModal()"></div>
          <div class="bg-white rounded-2xl w-full max-w-[500px] p-6 shadow-2xl relative z-10">
            <h2 class="font-serif text-2xl text-[#3D3A37] mb-2">Create a New Post</h2>
            <p class="text-sm text-gray-500 mb-6">Share your thoughts, questions, or experiences anonymously.</p>

            <form action="forum" method="post" class="space-y-4">
              <input type="hidden" name="action" value="create">
              <input type="hidden" id="authorField" name="author" value="Anonymous Student">

              <div class="space-y-1">
                <label for="topic" class="text-sm font-medium text-[#3D3A37]">Topic</label>
                <select id="topic" name="topic" required
                  class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B] bg-white">
                  <option value="general">General</option>
                  <option value="stress">Stress</option>
                  <option value="anxiety">Anxiety</option>
                  <option value="sleep">Sleep</option>
                  <option value="relationships">Relationships</option>
                  <option value="academics">Academics</option>
                </select>
              </div>

              <div class="space-y-1">
                <label for="content" class="text-sm font-medium text-[#3D3A37]">Your Post</label>
                <textarea id="content" name="content" rows="5" placeholder="Share your thoughts..." required
                  class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B] resize-none"></textarea>
              </div>

              <div class="bg-blue-50 p-3 rounded-xl text-sm text-blue-600 flex items-center gap-2">
                <i data-lucide="info" class="w-4 h-4"></i>
                Your post will be anonymous.
              </div>

              <div class="flex gap-3 pt-2">
                <button type="button" onclick="closeCreateModal()"
                  class="flex-1 px-4 py-2 border border-[#E9E4DF] rounded-xl hover:bg-gray-50 text-sm font-medium transition-colors">Cancel</button>
                <button type="submit"
                  class="flex-1 px-4 py-2 bg-[#B4C59B] text-white rounded-xl hover:bg-[#9AAF86] shadow-md text-sm font-medium transition-colors">Post
                  Anonymously</button>
              </div>
            </form>
          </div>
        </div>

        <script>
          lucide.createIcons();

          // --- Mobile Menu Logic ---
          function toggleMobileMenu() {
            const sheet = document.getElementById("mobileSheet");
            if (sheet.classList.contains("hidden")) {
              sheet.classList.remove("hidden");
            } else {
              sheet.classList.add("hidden");
            }
          }

          // --- Modal Logic ---
          function openCreateModal() {
            const animals = ["Owl", "Butterfly", "Fox", "Dolphin", "Bear", "Rabbit", "Deer", "Eagle"];
            const randomAnimal = animals[Math.floor(Math.random() * animals.length)];
            document.getElementById("authorField").value = "Anonymous " + randomAnimal;

            const modal = document.getElementById("createPostModal");
            modal.classList.remove("hidden");
          }

          function closeCreateModal() {
            const modal = document.getElementById("createPostModal");
            modal.classList.add("hidden");
          }
        </script>
      </body>

      </html>