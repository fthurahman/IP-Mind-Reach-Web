<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Resources | MindReach Admin</title>
                <!-- Use Tailwind CDN -->
                <script src="https://cdn.tailwindcss.com"></script>
                <%@ include file="layout/css-include.jsp" %>
                    <script src="https://unpkg.com/lucide@latest"></script>
                    <style>
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

                <!-- Admin Header -->
                <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
                    <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
                        <a href="${pageContext.request.contextPath}/homeAdmin"
                            class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
                        <nav class="hidden lg:flex items-center gap-6">
                            <!-- Resources (Active) -->
                            <a href="${pageContext.request.contextPath}/resources"
                                class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Resources</a>

                            <!-- Monitor Discussions -->
                            <a href="${pageContext.request.contextPath}/forum-monitor"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Monitor
                                Discussions</a>

                            <!-- Analytics -->
                            <a href="${pageContext.request.contextPath}/homeAdmin"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Analytics</a>

                            <!-- User Management -->
                            <a href="#"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">User
                                Management</a>
                        </nav>
                        <div class="hidden lg:flex items-center gap-3">
                            <div class="text-right">
                                <div class="text-sm text-[#3D3A37] font-medium uppercase">${loggedUser.name}</div>
                                <div class="text-xs text-gray-500 capitalize">${loggedUser.role}</div>
                            </div>
                            <div
                                class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B]">
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
                        <!-- Admin has no Create permission in this view -->
                    </div>

                    <!-- Saved Resources Section -->
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

                    <!-- Controls: Tabs & Search -->
                    <div class="flex flex-col sm:flex-row gap-4 items-start sm:items-center justify-between">
                        <!-- Tabs -->
                        <div class="bg-white rounded-xl p-1 flex flex-wrap shadow-[0_4px_12px_rgba(180,197,155,0.1)]">
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
                            <i data-lucide="search"
                                class="absolute left-4 top-1/2 -translate-y-1/2 text-gray-400 w-5 h-5"></i>
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
                                                <span
                                                    class="text-xs border border-gray-200 px-2 py-0.5 rounded-full text-gray-600">
                                                    ${resource.duration}
                                                </span>
                                            </c:if>
                                        </div>

                                        <h3
                                            class="text-lg font-semibold text-[#3D3A37] group-hover:text-black transition-colors">
                                            ${resource.title}
                                        </h3>
                                        <p class="text-sm text-gray-600 line-clamp-2">
                                            ${resource.description}
                                        </p>
                                    </div>
                                </div>

                                <!-- Actions: Bookmark and Share ONLY -->
                                <div class="flex items-center gap-2 pt-2 mt-auto" onclick="event.stopPropagation();">
                                    <button onclick="toggleBookmark('${resource.id}', this)"
                                        class="bookmark-btn p-2 rounded-full hover:bg-gray-100 transition-colors"
                                        data-id="${resource.id}">
                                        <i data-lucide="bookmark" class="w-4 h-4 text-gray-400"></i>
                                    </button>

                                    <button onclick="openShareDialog('${resource.id}', '${resource.title}')"
                                        class="px-3 py-1.5 rounded-xl border border-[#B4C59B]/30 hover:bg-[#B4C59B]/10 text-xs font-medium flex items-center gap-2 text-[#3D3A37]">
                                        <i data-lucide="share-2" class="w-3 h-3 text-[#B4C59B]"></i>
                                        Share
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <c:if test="${empty resources}">
                        <div class="text-center py-12 text-gray-500">
                            <i data-lucide="book-open" class="mx-auto mb-4 opacity-50 w-12 h-12"></i>
                            <p>No resources found matching your criteria</p>
                        </div>
                    </c:if>
                </main>

                <!-- Share Modal -->
                <div id="shareDialog"
                    class="hidden fixed inset-0 bg-black/50 z-[60] flex items-center justify-center p-4 backdrop-blur-sm">
                    <div class="bg-white rounded-2xl w-full max-w-[400px] p-6 shadow-2xl space-y-4">
                        <div class="mb-2">
                            <h2 class="text-xl font-serif font-bold text-[#3D3A37]">Share Resource</h2>
                            <p class="text-sm text-gray-500">Share "<span id="shareTitle" class="font-medium"></span>"
                                with others.</p>
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
                        </div>

                        <button onclick="closeModal('shareDialog')"
                            class="w-full px-4 py-2 mt-2 bg-gray-100 rounded-xl hover:bg-gray-200 text-sm font-medium">Close</button>
                    </div>
                </div>

                <script>
                    lucide.createIcons();

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
                        document.querySelectorAll('.bookmark-btn').forEach(btn => {
                            const id = btn.getAttribute('data-id');
                            const icon = btn.querySelector('svg');
                            if (bookmarks.includes(id)) {
                                icon.style.color = '#B4C59B';
                                icon.style.fill = '#B4C59B';
                            } else {
                                icon.style.color = '#9CA3AF';
                                icon.style.fill = 'none';
                            }
                        });

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
                        const currentBookmarks = JSON.parse(localStorage.getItem('mindreach_bookmarks') || '[]');

                        if (isSavedFilterActive) {
                            cards.forEach(card => {
                                const id = card.getAttribute('data-id');
                                if (currentBookmarks.includes(id)) {
                                    card.classList.remove('hidden');
                                } else {
                                    card.classList.add('hidden');
                                }
                            });
                            savedSection.classList.remove('from-[#CADBB7]/20', 'to-[#B4C59B]/20');
                            savedSection.classList.add('bg-[#B4C59B]', 'shadow-lg');
                            savedSection.querySelector('h3').classList.add('text-white');
                            savedSection.querySelector('h3').classList.remove('text-[#3D3A37]');
                            savedSection.querySelector('p').classList.add('text-white/90');
                            savedSection.querySelector('p').classList.remove('text-gray-600');
                            savedSection.querySelector('svg').classList.add('text-white');
                            savedSection.querySelector('svg').classList.remove('text-[#B4C59B]');
                        } else {
                            cards.forEach(card => card.classList.remove('hidden'));
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