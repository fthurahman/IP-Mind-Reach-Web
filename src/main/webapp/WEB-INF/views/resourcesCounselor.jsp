<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <title>Resources | MindReach Counselor</title>
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

                <!-- Header for Counselor -->
                <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
                    <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
                        <a href="${pageContext.request.contextPath}/homeMProfessional"
                            class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
                        <nav class="hidden lg:flex items-center gap-6">
                            <!-- Resources (Active) -->
                            <a href="${pageContext.request.contextPath}/homeMProfessional"
                                class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Resources</a>
                            <a href="${pageContext.request.contextPath}/counseling"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Telehealth
                                Assistance</a>
                        </nav>
                        <div class="hidden lg:flex items-center gap-3">
                            <div class="text-right">
                                <div class="text-sm text-[#3D3A37] font-medium">
                                    <c:choose>
                                        <c:when test="${not empty loggedUser.name}">${loggedUser.name}</c:when>
                                        <c:otherwise>Dr. Smith</c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="text-xs text-gray-500 capitalize">
                                    <c:choose>
                                        <c:when test="${loggedUser.role == 'mhprofessional'}">Counselor</c:when>
                                        <c:otherwise>${loggedUser.role}</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                            <div
                                class="w-10 h-10 rounded-full bg-[#B4C59B]/20 flex items-center justify-center text-[#B4C59B]">
                                <!-- User Icon -->
                                <i data-lucide="user"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="ml-4 text-sm text-red-500 hover:text-red-700 flex items-center gap-1">
                                <i data-lucide="log-out" class="w-4 h-4"></i> Log out
                            </a>
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
                        <!-- Add Resource Button -->
                        <button
                            onclick="document.getElementById('createDialog').classList.remove('hidden'); document.getElementById('createDialog').classList.add('flex');"
                            class="bg-white/90 text-[#5A7C57] px-5 py-2.5 rounded-xl hover:bg-white transition-colors shadow-lg shadow-black/5 flex items-center gap-2 font-semibold text-sm backdrop-blur-sm">
                            <i data-lucide="plus" class="w-4 h-4"></i>
                            <span class="hidden sm:inline">Add New Resource</span>
                        </button>
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
                                class="bg-gradient-to-r from-white to-[#F7FFF5] hover:shadow-2xl p-6 rounded-3xl shadow-sm transition transform hover:scale-[1.02] space-y-4 group border border-[#E9E4DF] flex flex-col h-full">

                                <div class="space-y-2">
                                    <div class="flex items-center gap-2 text-sm text-gray-600 justify-between">
                                        <div class="flex items-center gap-2 flex-wrap">
                                            <c:choose>
                                                <c:when test="${resource.type == 'video'}">
                                                    <i data-lucide="video" class="text-[#B4C59B] w-5 h-5"></i>
                                                    <span
                                                        class="capitalize bg-gray-100 text-gray-600 border border-gray-200 px-2.5 py-0.5 rounded-full text-xs font-semibold">
                                                        ${resource.topic}
                                                    </span>
                                                    <c:if test="${not empty resource.duration}">
                                                        <span
                                                            class="text-xs border border-gray-200 px-2 py-0.5 rounded-full text-gray-600">
                                                            ${resource.duration}
                                                        </span>
                                                    </c:if>
                                                </c:when>
                                                <c:otherwise>
                                                    <i data-lucide="book-open" class="text-[#B4C59B] w-5 h-5"></i>
                                                    <span
                                                        class="capitalize bg-[#B4C59B]/20 text-[#3D3A37] border border-[#B4C59B]/30 px-2.5 py-0.5 rounded-full text-xs font-semibold">
                                                        ${resource.topic}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>

                                    <h3
                                        class="text-lg font-semibold text-[#3D3A37] group-hover:text-black transition-colors">
                                        ${resource.title}
                                    </h3>
                                    <p class="text-sm text-gray-600 line-clamp-2">
                                        ${resource.description}
                                    </p>
                                </div>

                                <!-- Actions: Bookmark, Share, Delete -->
                                <div class="flex items-center gap-2 pt-2 mt-auto">
                                    <!-- Bookmark (Icon only per screenshot) -->
                                    <button class="p-2 rounded-full hover:bg-gray-100 transition-colors">
                                        <i data-lucide="bookmark" class="w-5 h-5 text-gray-400"></i>
                                    </button>

                                    <!-- Share Button -->
                                    <button onclick="openShareDialog('${resource.id}', '${resource.title}')"
                                        class="px-3 py-1.5 rounded-xl bg-[#F0F5EB] text-[#4A6445] hover:bg-[#E1EAD8] text-sm font-medium flex items-center gap-2 transition-colors">
                                        <i data-lucide="share-2" class="w-4 h-4"></i>
                                        Share
                                    </button>

                                    <!-- Delete Button -->
                                    <form action="${pageContext.request.contextPath}/resources" method="POST"
                                        onsubmit="return confirm('Are you sure you want to delete this resource?');"
                                        style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="id" value="${resource.id}">
                                        <button type="submit"
                                            class="px-3 py-1.5 rounded-xl bg-[#FEE2E2] text-[#DC2626] hover:bg-[#FECACA] text-sm font-medium flex items-center gap-2 transition-colors">
                                            <i data-lucide="trash-2" class="w-4 h-4"></i>
                                            Delete
                                        </button>
                                    </form>
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

                <!-- Create Resource Modal -->
                <div id="createDialog"
                    class="hidden fixed inset-0 bg-black/50 z-[60] flex items-center justify-center p-4 backdrop-blur-sm">
                    <div
                        class="bg-white rounded-2xl w-full max-w-[500px] p-6 shadow-2xl space-y-4 max-h-[90vh] overflow-y-auto">
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

                <!-- Share Dialog (Client Side Only for now) -->
                <script>
                    lucide.createIcons();

                    function toggleTypeFields(val) {
                        const videoFields = document.getElementById('videoFields');
                        if (val === 'video') {
                            videoFields.classList.remove('hidden');
                        } else {
                            videoFields.classList.add('hidden');
                        }
                    }

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
                        const link = window.location.origin + '${pageContext.request.contextPath}/resources?action=detail&id=' + currentShareId;
                        navigator.clipboard.writeText(link).then(() => {
                            document.getElementById('copyLinkText').textContent = 'Link Copied!';
                            setTimeout(() => {
                                document.getElementById('copyLinkText').textContent = 'Copy Link';
                                closeModal('shareDialog');
                            }, 1500);
                        });
                    }
                </script>
            </body>

            </html>