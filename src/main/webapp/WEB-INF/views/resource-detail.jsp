<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8">
      <title>${resource.title} | MindReach</title>
      <!-- Tailwind CDN -->
      <script src="https://cdn.tailwindcss.com"></script>
      <%@ include file="layout/css-include.jsp" %>
        <script src="https://unpkg.com/lucide@latest"></script>
        <style>
          .prose p {
            margin-bottom: 1rem;
            line-height: 1.75;
          }
        </style>
    </head>

    <body class="bg-[#F7F3EF] min-h-screen">

      <!-- Header (Consistent with Resources) -->
      <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
        <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
          <c:choose>
            <c:when test="${loggedUser.role == 'admin'}">
              <a href="${pageContext.request.contextPath}/homeAdmin"
                class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
              <nav class="hidden lg:flex items-center gap-6">
                <a href="${pageContext.request.contextPath}/homeAdmin"
                  class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Analytics</a>
                <a href="${pageContext.request.contextPath}/resources"
                  class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Resources</a>
                <a href="${pageContext.request.contextPath}/forum-monitor"
                  class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Forum Monitor</a>
                <a href="#" class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">User
                  Management</a>
              </nav>
            </c:when>
            <c:otherwise>
              <a href="${pageContext.request.contextPath}/homeStudent"
                class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
              <nav class="hidden lg:flex items-center gap-6">
                <a href="${pageContext.request.contextPath}/homeStudent"
                  class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Self-Help</a>
                <a href="${pageContext.request.contextPath}/resources"
                  class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Resources</a>
                <a href="${pageContext.request.contextPath}/forum"
                  class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Forum</a>
                <a href="${pageContext.request.contextPath}/resultDASS"
                  class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Progress</a>
                <a href="${pageContext.request.contextPath}/counseling"
                  class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Telehealth
                  Assistance</a>
                <a href="#" class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Chat
                  Support</a>
              </nav>
            </c:otherwise>
          </c:choose>
          <div class="hidden lg:flex items-center gap-3">
            <div class="text-right">
              <div class="text-sm text-[#3D3A37] font-medium">${loggedUser.name}</div>
              <div class="text-xs text-gray-500 capitalize">${loggedUser.role}</div>
            </div>
            <div class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B]">
              <i data-lucide="user"></i>
            </div>
          </div>
        </div>
      </header>

      <main class="max-w-[1000px] mx-auto px-6 pb-8 pt-4 space-y-6">

        <!-- Back Button -->
        <a href="${pageContext.request.contextPath}/resources"
          class="inline-flex items-center gap-2 text-sm text-[#3D3A37] hover:bg-[#B4C59B]/10 px-3 py-2 rounded-xl transition-colors">
          <i data-lucide="arrow-left" class="w-4 h-4"></i>
          Back to Resources
        </a>

        <!-- Content Card -->
        <div class="bg-white p-8 rounded-2xl shadow-[0_4px_12px_rgba(180,197,155,0.1)] space-y-6">

          <!-- Header -->
          <div class="flex items-start justify-between gap-4">
            <div class="flex-1">
              <div class="flex items-center gap-2 mb-3">
                <c:choose>
                  <c:when test="${resource.type == 'video'}">
                    <i data-lucide="video" class="text-[#B4C59B] w-6 h-6"></i>
                  </c:when>
                  <c:otherwise>
                    <i data-lucide="book-open" class="text-[#B4C59B] w-6 h-6"></i>
                  </c:otherwise>
                </c:choose>

                <span
                  class="capitalize bg-[#B4C59B]/20 text-[#3D3A37] border border-[#B4C59B]/30 px-2.5 py-0.5 rounded-full text-xs font-semibold">
                  ${resource.topic}
                </span>

                <c:if test="${not empty resource.duration}">
                  <span class="text-xs border border-gray-200 px-2 py-0.5 rounded-full text-gray-600">
                    ${resource.duration}
                  </span>
                </c:if>
              </div>

              <h1 class="text-3xl font-serif text-[#3D3A37] mb-3 leading-tight">${resource.title}</h1>
              <p class="text-gray-600 text-lg">${resource.description}</p>
            </div>

            <div class="flex gap-2">
              <c:if test="${loggedUser.role == 'student' || loggedUser.role == 'admin'}">
                <button onclick="toggleBookmark('${resource.id}', this)"
                  class="p-2 rounded-full hover:bg-gray-100 transition-colors" id="bookmarkBtn">
                  <i data-lucide="bookmark" class="w-6 h-6 text-gray-400"></i>
                </button>
              </c:if>
            </div>
          </div>

          <!-- Content Body -->
          <div class="prose max-w-none text-gray-700">
            <c:choose>
              <c:when test="${resource.type == 'video'}">
                <!-- Video Placeholder -->
                <div class="aspect-video bg-gray-200 rounded-xl flex items-center justify-center mb-6">
                  <div class="text-center text-gray-500">
                    <i data-lucide="video" class="mx-auto mb-2 w-12 h-12 opacity-50"></i>
                    <p class="font-medium">Video Player Placeholder</p>
                  </div>
                </div>
                <div class="space-y-4">
                  <h3 class="text-xl font-semibold text-[#3D3A37]">About this Video</h3>
                  <p>${resource.content}</p>
                </div>
              </c:when>
              <c:otherwise>
                <!-- Article Content -->
                <div class="space-y-4 text-lg leading-relaxed">
                  <p>${resource.content}</p>

                  <!-- Static content simulation from React demo -->
                  <p>This is a comprehensive guide that covers various aspects of the topic. In a real application, this
                    would contain full article content with proper formatting, images, and references.</p>
                  <p>Key takeaways include understanding the fundamentals, recognizing signs and symptoms, implementing
                    practical strategies, and knowing when to seek professional help.</p>

                  <h3 class="text-xl font-semibold text-[#3D3A37] mt-8 mb-4">Practical Steps</h3>
                  <ul class="list-disc pl-5 space-y-2">
                    <li>Identify your triggers and patterns.</li>
                    <li>Practice regular self-care routines.</li>
                    <li>Build a support network of friends and family.</li>
                    <li>Monitor your progress and adjust strategies as needed.</li>
                  </ul>
                </div>
              </c:otherwise>
            </c:choose>
          </div>

        </div>

        <div class="text-center pt-8">
          <p class="text-sm text-gray-500">Need professional help?</p>
          <a href="${pageContext.request.contextPath}/counseling"
            class="inline-block mt-2 text-[#B4C59B] font-medium hover:underline">Connect with a Counselor</a>
        </div>

      </main>

      <script>
        lucide.createIcons();

        // Check bookmark status
        const bookmarks = JSON.parse(localStorage.getItem('mindreach_bookmarks') || '[]');
        const resourceId = '${resource.id}';
        const bookmarkBtn = document.getElementById('bookmarkBtn');
        const icon = bookmarkBtn.querySelector('svg');

        if (bookmarks.includes(resourceId)) {
          icon.style.color = '#B4C59B';
          icon.style.fill = '#B4C59B';
          bookmarkBtn.classList.add('bg-[#B4C59B]/10');
        }

        function toggleBookmark(id, btn) {
          let bookmarks = JSON.parse(localStorage.getItem('mindreach_bookmarks') || '[]');
          const icon = btn.querySelector('svg');

          if (bookmarks.includes(id)) {
            bookmarks = bookmarks.filter(b => b !== id);
            icon.style.color = '#9CA3AF';
            icon.style.fill = 'none';
            btn.classList.remove('bg-[#B4C59B]/10');
          } else {
            bookmarks.push(id);
            icon.style.color = '#B4C59B';
            icon.style.fill = '#B4C59B';
            btn.classList.add('bg-[#B4C59B]/10');
          }
          localStorage.setItem('mindreach_bookmarks', JSON.stringify(bookmarks));
        }
      </script>
    </body>

    </html>