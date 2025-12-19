<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
      <!DOCTYPE html>
      <html>

      <head>
        <meta charset="UTF-8" />
        <title>Discussion | MindReach</title>
        <!-- Use Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <%@ include file="layout/css-include.jsp" %>
          <script src="https://unpkg.com/lucide@latest"></script>
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

            /* Custom Badges */
            .badge-topic {
              background-color: #F3F4F6;
              color: #4B5563;
              padding: 0.125rem 0.625rem;
              border-radius: 9999px;
              font-size: 0.75rem;
              font-weight: 600;
              border: 1px solid #E5E7EB;
            }

            .badge-reported {
              background-color: #FEF2F2;
              color: #DC2626;
              padding: 0.125rem 0.625rem;
              border-radius: 9999px;
              font-size: 0.75rem;
              font-weight: 600;
              border: 1px solid #FECACA;
            }
          </style>
      </head>

      <body>

        <!-- Header -->
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
              <a href="${pageContext.request.contextPath}/progress"
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
        <div id="mobileSheet" class="hidden fixed inset-0 z-[60]">
          <div class="absolute inset-0 bg-black/20 backdrop-blur-sm" onclick="toggleMobileMenu()"></div>
          <div class="absolute right-0 top-0 bottom-0 w-[280px] bg-white p-6 shadow-2xl flex flex-col gap-6">
            <div>
              <h3 class="font-serif text-xl text-[#3D3A37] mb-2">Navigation</h3>
              <p class="text-sm text-gray-500">Access MindReach sections</p>
            </div>
            <nav class="flex flex-col gap-4">
              <a href="${pageContext.request.contextPath}/homeStudent" class="text-[#3D3A37] font-medium">Self-Help</a>
              <a href="${pageContext.request.contextPath}/resources" class="text-[#3D3A37] font-medium">Resources</a>
              <a href="${pageContext.request.contextPath}/forum" class="text-[#2D2A28] font-semibold">Forum</a>
              <a href="${pageContext.request.contextPath}/progress" class="text-[#3D3A37] font-medium">Progress</a>
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
        <main class="max-w-[800px] mx-auto px-6 pt-8 pb-8">

          <!-- Back Button -->
          <c:set var="backLink" value="${param.source == 'monitor' ? 'forum-monitor' : 'forum'}" />
          <a href="${backLink}"
            class="inline-flex items-center gap-2 text-gray-500 hover:text-gray-900 mb-6 transition-colors">
            <i data-lucide="arrow-left" class="w-5 h-5"></i>
            <span>${param.source == 'monitor' ? 'Back to Monitor' : 'Back to Forum'}</span>
          </a>

          <!-- Selected Post Card -->
          <div class="bg-white p-8 rounded-2xl border border-[#E9E4DF] shadow-sm mb-6">
            <div class="flex items-start justify-between gap-4">
              <div class="flex-1">
                <div class="flex items-center gap-2 mb-3 flex-wrap">
                  <i data-lucide="user" class="w-4 h-4 text-gray-400"></i>
                  <span class="text-sm text-gray-600 font-medium">${post.author}</span>
                  <span class="text-sm text-gray-400">•</span>
                  <span class="text-sm text-gray-400">${post.createdAt}</span>
                  <span class="badge-topic">${post.topic}</span>
                  <c:if test="${post.reported}">
                    <span class="badge-reported">⚠️ Reported Post</span>
                  </c:if>
                </div>

                <p class="text-gray-800 text-lg leading-relaxed mb-4">${post.content}</p>
              </div>

              <c:set var="reportAction" value="${post.reported ? 'unreport' : 'report'}" />
              <a href="forum?action=report&id=${post.id}"
                onclick="return confirm('Are you sure you want to ${reportAction} this post?')"
                class="flex items-center gap-1.5 text-sm ${post.reported ? 'text-red-500 font-medium' : 'text-gray-400 hover:text-red-500'} transition-colors">
                <i data-lucide="flag" class="w-4 h-4 ${post.reported ? 'fill-current' : ''}"></i>
                <span>${post.reported ? 'Reported' : 'Report'}</span>
              </a>
            </div>
          </div>

          <!-- Comments Section -->
          <div class="border-t border-[#E9E4DF] pt-8">
            <h3 class="font-sans text-lg font-semibold text-[#3D3A37] mb-6 flex items-center gap-2">
              <i data-lucide="message-circle" class="w-5 h-5"></i>
              Comments (${fn:length(post.comments)})
            </h3>

            <div class="space-y-4 mb-8">
              <c:if test="${empty post.comments}">
                <p class="text-gray-500 italic">No comments yet. Be the first to share your thoughts!</p>
              </c:if>
              <c:forEach var="comment" items="${post.comments}">
                <div class="bg-[#F9FAFB] p-4 rounded-xl">
                  <div class="flex items-center gap-2 mb-2">
                    <i data-lucide="user" class="w-3 h-3 text-gray-400"></i>
                    <span class="text-sm text-gray-600 font-medium">${comment.author}</span>
                    <span class="text-sm text-gray-400">•</span>
                    <span class="text-sm text-gray-400">${comment.createdAt}</span>
                  </div>
                  <p class="text-sm text-gray-800 leading-relaxed">${comment.content}</p>
                </div>
              </c:forEach>
            </div>

            <!-- Add Comment Form -->
            <c:if test="${param.source != 'monitor'}">
              <form action="forum" method="post" class="flex gap-3"
                onsubmit="return confirm('Are you sure you want to post this comment?');">
                <input type="hidden" name="action" value="comment">
                <input type="hidden" name="id" value="${post.id}">

                <div class="flex-1">
                  <input type="text" name="reply" placeholder="Write a supportive comment..." required
                    class="w-full px-4 py-3 rounded-xl border border-[#E9E4DF] focus:outline-none focus:ring-2 focus:ring-[#B4C59B] text-sm font-sans">
                </div>

                <button type="submit"
                  class="bg-[#B4C59B] hover:bg-[#9AAF86] text-white p-3 rounded-xl transition-colors flex items-center justify-center shadow-md">
                  <i data-lucide="send" class="w-5 h-5"></i>
                </button>
              </form>
            </c:if>
          </div>

        </main>

        <script>
          lucide.createIcons();

          function toggleMobileMenu() {
            const sheet = document.getElementById("mobileSheet");
            if (sheet.classList.contains("hidden")) {
              sheet.classList.remove("hidden");
            } else {
              sheet.classList.add("hidden");
            }
          }
        </script>
      </body>

      </html>