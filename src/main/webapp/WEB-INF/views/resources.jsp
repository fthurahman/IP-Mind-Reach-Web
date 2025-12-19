<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <title>Resources | MindReach</title>
        <!-- Use Tailwind CDN -->
        <script src="https://cdn.tailwindcss.com"></script>
        <%@ include file="layout/css-include.jsp" %>
          <script src="https://unpkg.com/lucide@latest"></script>
          <style>
            /* Custom Overrides if needed, though Tailwind handles most */
            .tab-active {
              background-color: rgba(180, 197, 155, 0.2);
              color: #3D3A37;
            }

            .tab-inactive {
              color: #6B7280;
            }
          </style>
      </head>

      <body class="bg-[#F7F3EF] min-h-screen">

        <!-- Header (Simple Include or Hardcoded if header.jsp is missing) -->
        <!-- Assuming header.jsp logic or simplified header -->
        <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
          <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
            <c:choose>
              <c:when test="${loggedUser.role == 'admin'}">
                <a href="${pageContext.request.contextPath}/homeAdmin"
                  class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
                <nav class="hidden lg:flex items-center gap-6">
                  <!-- Analytics (Inactive) -->
                  <a href="${pageContext.request.contextPath}/homeAdmin"
                    class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Analytics</a>

                  <!-- Resources (Active) -->
                  <a href="${pageContext.request.contextPath}/resources"
                    class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Resources</a>

                  <!-- Forum Monitor (Inactive) -->
                  <a href="${pageContext.request.contextPath}/forum-monitor"
                    class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Forum Monitor</a>

                  <!-- User Management (Inactive) -->
                  <a href="#" class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">User
                    Management</a>
                </nav>
              </c:when>
              <c:otherwise>
                <%-- Non-Admin Header (Unchanged) --%>
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
                <!-- User Icon -->
                <i data-lucide="user"></i>
              </div>
              <a href="${pageContext.request.contextPath}/logout"
                class="ml-4 text-sm text-red-500 hover:text-red-700">Logout</a>
            </div>
          </div>
        </header>

        <main class="max-w-[1200px] mx-auto px-6 pb-8 pt-4 space-y-6">
          <!-- Hero Header -->
          <div
            class="bg-gradient-to-r from-[#B4C59B] to-[#CADBB7] rounded-2xl p-8 shadow-[0_4px_20px_rgba(180,197,155,0.15)] flex items-center justify-between">
            <div>
              <h1 class="text-3xl text-white mb-2 font-serif">Mental Health Resources</h1>
              <p class="text-white/90">Explore articles and videos to support your wellbeing</p>
            </div>
            <!-- Add Resource Button (Counselor Only) -->
            <c:if test="${loggedUser.role == 'mhprofessional'}">
              <button
                onclick="document.getElementById('createDialog').classList.remove('hidden'); document.getElementById('createDialog').classList.add('flex');"
                class="bg-[#3D3A37] text-white px-5 py-2.5 rounded-xl hover:bg-[#2D2A28] transition-colors shadow-lg shadow-[#3D3A37]/10 flex items-center gap-2 font-medium">
                <i data-lucide="plus" class="w-5 h-5"></i>
                <span class="hidden sm:inline">Add Resource</span>
              </button>
            </c:if>
          </div>

          <!-- Saved Resources Section -->
          <c:if test="${loggedUser.role == 'student' || loggedUser.role == 'admin'}">
            <div id="savedSection" onclick="toggleSavedFilter()"
              class="hidden bg-gradient-to-r from-[#CADBB7]/20 to-[#B4C59B]/20 p-6 rounded-2xl mb-6 cursor-pointer hover:shadow-md transition-all group">
              <h3 class="text-lg mb-3 flex items-center gap-2 font-semibold text-[#3D3A37]">
                <i data-lucide="bookmark-check" class="text-[#B4C59B] w-5 h-5"></i>
                Saved Resources (<span id="savedCount">0</span>)
              </h3>
              <p class="text-sm text-gray-600">
                You have saved resources that you can quickly access.
              </p>
            </div>
          </c:if>

          <!-- Controls: Tabs & Search -->
          <div class="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
            <!-- Tabs -->
            <!-- Tabs -->
            <div class="bg-white rounded-xl p-1 flex flex-wrap shadow-[0_4px_12px_rgba(180,197,155,0.1)]">
              <!-- Manual Tabs to avoid fn:split issues -->
              <a href="${pageContext.request.contextPath}/resources?topic=all"
                class="capitalize px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${currentTopic == null || currentTopic == 'all' ? 'bg-[#B4C59B]/20 text-[#3D3A37]' : 'text-gray-500 hover:text-gray-900'}">All</a>
              <a href="${pageContext.request.contextPath}/resources?topic=anxiety"
                class="capitalize px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${currentTopic == 'anxiety' ? 'bg-[#B4C59B]/20 text-[#3D3A37]' : 'text-gray-500 hover:text-gray-900'}">Anxiety</a>
              <a href="${pageContext.request.contextPath}/resources?topic=stress"
                class="capitalize px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${currentTopic == 'stress' ? 'bg-[#B4C59B]/20 text-[#3D3A37]' : 'text-gray-500 hover:text-gray-900'}">Stress</a>
              <a href="${pageContext.request.contextPath}/resources?topic=sleep"
                class="capitalize px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${currentTopic == 'sleep' ? 'bg-[#B4C59B]/20 text-[#3D3A37]' : 'text-gray-500 hover:text-gray-900'}">Sleep</a>
              <a href="${pageContext.request.contextPath}/resources?topic=depression"
                class="capitalize px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${currentTopic == 'depression' ? 'bg-[#B4C59B]/20 text-[#3D3A37]' : 'text-gray-500 hover:text-gray-900'}">Depression</a>
              <a href="${pageContext.request.contextPath}/resources?topic=mindfulness"
                class="capitalize px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${currentTopic == 'mindfulness' ? 'bg-[#B4C59B]/20 text-[#3D3A37]' : 'text-gray-500 hover:text-gray-900'}">Mindfulness</a>
              <a href="${pageContext.request.contextPath}/resources?topic=self-esteem"
                class="capitalize px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${currentTopic == 'self-esteem' ? 'bg-[#B4C59B]/20 text-[#3D3A37]' : 'text-gray-500 hover:text-gray-900'}">Self-Esteem</a>
            </div>

            <!-- Search -->
            <form action="resources" method="GET" class="relative w-full sm:w-64">
              <input type="hidden" name="topic" value="${currentTopic != null ? currentTopic : 'all'}" />
              <i data-lucide="search" class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 w-5 h-5"></i>
              <input type="text" name="q" value="${param.q}" placeholder="Search resources..."
                style="padding-left: 3rem;"
                class="w-full pl-12 pr-4 py-2 rounded-xl border border-gray-200 focus:outline-none focus:ring-2 focus:ring-[#B4C59B] shadow-[0_4px_12px_rgba(180,197,155,0.1)]" />
            </form>
          </div>

          <!-- Grid -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
            <c:forEach var="resource" items="${resources}">
              <div data-id="${resource.id}"
                onclick="window.location.href='${pageContext.request.contextPath}/resources?action=detail&id=${resource.id}'"
                class="resource-card bg-gradient-to-r from-white to-[#F7FFF5] hover:shadow-2xl p-6 rounded-3xl shadow-sm transition transform hover:scale-[1.02] space-y-4 group cursor-pointer border border-[#E9E4DF] flex flex-col h-full">

                <div class="space-y-2">
                  <div class="flex items-center gap-2 text-sm text-gray-600 justify-between">
                    <div class="flex items-center gap-2 flex-wrap">
                      <c:choose>
                        <c:when test="${resource.type == 'video'}">
                          <i data-lucide="video" class="text-[#B4C59B] w-5 h-5"></i>
                        </c:when>
                        <c:otherwise>
                          <i data-lucide="book-open" class="text-[#B4C59B] w-5 h-5"></i>
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

                    <h3 class="text-lg font-semibold text-[#3D3A37] group-hover:text-black transition-colors">
                      ${resource.title}
                    </h3>
                    <p class="text-sm text-gray-600 line-clamp-2">
                      ${resource.description}
                    </p>
                  </div>
                </div>

                <div class="flex items-center gap-2 pt-2 mt-auto" onclick="event.stopPropagation();">
                  <c:if test="${loggedUser.role == 'student' || loggedUser.role == 'admin'}">
                    <button onclick="toggleBookmark('${resource.id}', this)"
                      class="bookmark-btn p-2 rounded-full hover:bg-gray-100 transition-colors"
                      data-id="${resource.id}">
                      <i data-lucide="bookmark" class="w-4 h-4 text-gray-400"></i>
                    </button>
                  </c:if>

                  <button onclick="openShareDialog('${resource.id}', '${resource.title}')"
                    class="px-3 py-1.5 rounded-xl border border-[#B4C59B]/30 hover:bg-[#B4C59B]/10 text-xs font-medium flex items-center gap-2 text-[#3D3A37]">
                    <i data-lucide="share-2" class="w-3 h-3 text-[#B4C59B]"></i>
                    Share
                  </button>

                  <c:if test="${loggedUser.role == 'mhprofessional'}">
                    <form action="resources" method="POST"
                      onsubmit="return confirm('Are you sure you want to delete this resource?');"
                      style="display:inline;">
                      <input type="hidden" name="action" value="delete">
                      <input type="hidden" name="id" value="${resource.id}">
                      <button type="submit"
                        class="px-3 py-1.5 rounded-xl border border-red-200 hover:bg-red-50 text-xs font-medium flex items-center gap-2 text-red-600">
                        <i data-lucide="trash-2" class="w-3 h-3"></i>
                        Delete
                      </button>
                    </form>
                  </c:if>
                </div>
              </div>
            </c:forEach>
          </div>

          <c:if test="${empty resources}">
            <div class="text-center py-12 text-gray-500">
              <i data-lucide="book-open" class="mx-auto mb-4 opacity-50 w-12 h-12"></i>
              <p>No resources found matching your criteria</p>
              <div class="mt-4 text-xs text-red-400 bg-red-50 p-2 rounded inline-block">
                Debug Info:
                Resources is ${resources == null ? 'NULL' : 'EMPTY'}
                (Size: ${resources != null ? resources.size() : 0})
                Topic: ${currentTopic}
              </div>
            </div>
          </c:if>

          <!-- Saved Resources Section -->


        </main>

        <!-- Create Resource Modal -->
        <div id="createDialog"
          class="hidden fixed inset-0 bg-black/50 z-[60] flex items-center justify-center p-4 backdrop-blur-sm">
          <div class="bg-white rounded-2xl w-full max-w-[500px] p-6 shadow-2xl space-y-4 max-h-[90vh] overflow-y-auto">
            <div class="mb-4">
              <h2 class="text-xl font-serif font-bold text-[#3D3A37]">Create New Resource</h2>
              <p class="text-sm text-gray-500">Add a new resource to the library.</p>
            </div>

            <form action="${pageContext.request.contextPath}/resources" method="POST" class="space-y-4">
              <input type="hidden" name="action" value="add">

              <div class="space-y-1">
                <label class="text-sm font-medium text-[#3D3A37]">Title</label>
                <input type="text" name="title" required placeholder="Resource Title"
                  class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]">
              </div>

              <div class="space-y-1">
                <label class="text-sm font-medium text-[#3D3A37]">Description</label>
                <textarea name="description" required rows="2" placeholder="Brief description"
                  class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]"></textarea>
              </div>

              <div class="space-y-1">
                <label class="text-sm font-medium text-[#3D3A37]">Content</label>
                <textarea name="content" rows="4" placeholder="Full content..."
                  class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]"></textarea>
              </div>

              <div class="grid grid-cols-2 gap-4">
                <div class="space-y-1">
                  <label class="text-sm font-medium text-[#3D3A37]">Category</label>
                  <select name="category"
                    class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B] bg-white">
                    <option value="anxiety">Anxiety</option>
                    <option value="stress">Stress</option>
                    <option value="sleep">Sleep</option>
                    <option value="depression">Depression</option>
                    <option value="mindfulness">Mindfulness</option>
                    <option value="self-esteem">Self-Esteem</option>
                  </select>
                </div>
                <div class="space-y-1">
                  <label class="text-sm font-medium text-[#3D3A37]">Type</label>
                  <select name="type" onchange="toggleTypeFields(this.value)"
                    class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B] bg-white">
                    <option value="article">Article</option>
                    <option value="video">Video</option>
                  </select>
                </div>
              </div>

              <!-- Video Specific Fields -->
              <div id="videoFields" class="hidden space-y-3">
                <div class="space-y-1">
                  <label class="text-sm font-medium text-[#3D3A37]">Duration (e.g. "10 min")</label>
                  <input type="text" name="duration" placeholder="10 min"
                    class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]">
                </div>
                <div class="space-y-1">
                  <label class="text-sm font-medium text-[#3D3A37]">Video URL / Embed Link</label>
                  <input type="text" name="videoUrl" placeholder="https://youtube.com/..."
                    class="w-full px-3 py-2 border border-gray-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-[#B4C59B]">
                </div>
              </div>

              <div class="flex gap-3 pt-4">
                <button type="button"
                  onclick="document.getElementById('createDialog').classList.add('hidden'); document.getElementById('createDialog').classList.remove('flex');"
                  class="flex-1 px-4 py-2 border border-[#E9E4DF] rounded-xl hover:bg-gray-50 text-sm font-medium">Cancel</button>
                <button type="submit"
                  class="flex-1 px-4 py-2 bg-[#B4C59B] text-white rounded-xl hover:bg-[#9AAF86] shadow-md text-sm font-medium">Publish
                  Resource</button>
              </div>
            </form>
          </div>
        </div>

        <!-- Share Modal -->
        <div id="shareDialog"
          class="hidden fixed inset-0 bg-black/50 z-[60] flex items-center justify-center p-4 backdrop-blur-sm">
          <div class="bg-white rounded-2xl w-full max-w-[400px] p-6 shadow-2xl space-y-4">
            <div class="mb-2">
              <h2 class="text-xl font-serif font-bold text-[#3D3A37]">Share Resource</h2>
              <p class="text-sm text-gray-500">Share "<span id="shareTitle" class="font-medium"></span>" with others.
              </p>
            </div>

            <div class="space-y-2">
              <button onclick="copyLink()"
                class="w-full flex items-center gap-3 px-4 py-3 border border-[#E9E4DF] rounded-xl hover:bg-[#B4C59B]/10 transition-colors text-left text-sm font-medium text-[#5A5653]">
                <i data-lucide="link-2" class="w-5 h-5"></i>
                <span id="copyLinkText">Copy Link</span>
              </button>
              <button onclick="alert('Shared to Forum!'); closeModal('shareDialog');"
                class="w-full flex items-center gap-3 px-4 py-3 border border-[#E9E4DF] rounded-xl hover:bg-[#B4C59B]/10 transition-colors text-left text-sm font-medium text-[#5A5653]">
                <i data-lucide="message-square" class="w-5 h-5"></i>
                Share to Forum
              </button>
              <button onclick="alert('Sent to Counselor!'); closeModal('shareDialog');"
                class="w-full flex items-center gap-3 px-4 py-3 border border-[#E9E4DF] rounded-xl hover:bg-[#B4C59B]/10 transition-colors text-left text-sm font-medium text-[#5A5653]">
                <i data-lucide="user-check" class="w-5 h-5"></i>
                Send to Counselor
              </button>
            </div>

            <button onclick="closeModal('shareDialog')"
              class="w-full px-4 py-2 mt-2 bg-gray-100 rounded-xl hover:bg-gray-200 text-sm font-medium">Close</button>
          </div>
        </div>

        <script>
          // Init Lucide icons
          lucide.createIcons();

          // Toggle Video Fields
          function toggleTypeFields(val) {
            const videoFields = document.getElementById('videoFields');
            if (val === 'video') {
              videoFields.classList.remove('hidden');
            } else {
              videoFields.classList.add('hidden');
            }
          }

          // Bookmark Logic
          let bookmarks = JSON.parse(localStorage.getItem('mindreach_bookmarks') || '[]');
          updateBookmarkUI();

          function toggleBookmark(id, btn) {
            if (bookmarks.includes(id.toString())) {
              bookmarks = bookmarks.filter(b => b !== id.toString());
            } else {
              bookmarks.push(id.toString());
            }
            localStorage.setItem('mindreach_bookmarks', JSON.stringify(bookmarks));
            updateBookmarkUI();
          }

          function updateBookmarkUI() {
            // Update buttons
            document.querySelectorAll('.bookmark-btn').forEach(btn => {
              const id = btn.getAttribute('data-id');
              const icon = btn.querySelector('svg');

              if (bookmarks.includes(id)) {
                icon.style.color = '#B4C59B';
                icon.style.fill = '#B4C59B'; // Filled
              } else {
                icon.style.color = '#9CA3AF'; // Gray-400
                icon.style.fill = 'none';
              }
            });

            // Update Saved Section
            const savedSection = document.getElementById('savedSection');
            const savedCount = document.getElementById('savedCount');
            if (bookmarks.length > 0) {
              savedSection.classList.remove('hidden');
              savedCount.textContent = bookmarks.length;
            } else {
              savedSection.classList.add('hidden');
            }
          }

          // Share Dialog Logic
          let currentShareId = null;
          function openShareDialog(id, title) {
            currentShareId = id;
            document.getElementById('shareTitle').textContent = title;
            document.getElementById('shareDialog').classList.remove('hidden');
            document.getElementById('shareDialog').classList.add('flex');
            document.getElementById('copyLinkText').textContent = 'Copy Link';
          }

          function closeModal(id) {
            document.getElementById(id).classList.add('hidden');
            document.getElementById(id).classList.remove('flex');
          }

          function copyLink() {
            const link = window.location.origin + '/resources?action=detail&id=' + currentShareId;
            navigator.clipboard.writeText(link).then(() => {
              document.getElementById('copyLinkText').textContent = 'Link Copied!';
              setTimeout(() => {
                document.getElementById('copyLinkText').textContent = 'Copy Link';
                closeModal('shareDialog');
              }, 1500);
            });
          }

          // Saved Filter Logic
          let isSavedFilterActive = false;

          function toggleSavedFilter() {
            isSavedFilterActive = !isSavedFilterActive;
            const cards = document.querySelectorAll('.resource-card');
            const savedSection = document.getElementById('savedSection');

            // Get latest bookmarks
            const currentBookmarks = JSON.parse(localStorage.getItem('mindreach_bookmarks') || '[]');

            if (isSavedFilterActive) {
              // Apply filter
              cards.forEach(card => {
                const id = card.getAttribute('data-id');
                if (currentBookmarks.includes(id)) {
                  card.classList.remove('hidden');
                } else {
                  card.classList.add('hidden');
                }
              });

              // Visual feedback for active state
              savedSection.classList.remove('from-[#CADBB7]/20', 'to-[#B4C59B]/20');
              savedSection.classList.add('bg-[#B4C59B]', 'shadow-lg');
              savedSection.querySelector('h3').classList.add('text-white');
              savedSection.querySelector('h3').classList.remove('text-[#3D3A37]');
              savedSection.querySelector('p').classList.add('text-white/90');
              savedSection.querySelector('p').classList.remove('text-gray-600');
              savedSection.querySelector('svg').classList.add('text-white');
              savedSection.querySelector('svg').classList.remove('text-[#B4C59B]');

            } else {
              // Clear filter
              cards.forEach(card => card.classList.remove('hidden'));

              // Revert styles
              savedSection.classList.add('from-[#CADBB7]/20', 'to-[#B4C59B]/20');
              savedSection.classList.remove('bg-[#B4C59B]', 'shadow-lg');
              savedSection.querySelector('h3').classList.remove('text-white');
              savedSection.querySelector('h3').classList.add('text-[#3D3A37]');
              savedSection.querySelector('p').classList.remove('text-white/90');
              savedSection.querySelector('p').classList.add('text-gray-600');
              savedSection.querySelector('svg').classList.remove('text-white');
              savedSection.querySelector('svg').classList.add('text-[#B4C59B]');
            }
          }
        </script>
      </body>

      </html>