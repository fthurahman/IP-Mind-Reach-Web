<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="UTF-8">
                <title>Forum Monitor | MindReach</title>
                <script src="https://cdn.tailwindcss.com"></script>
                <%@ include file="layout/css-include.jsp" %>
                    <style>
                        .badge {
                            display: inline-flex;
                            align-items: center;
                            padding: 0.25rem 0.75rem;
                            border-radius: 9999px;
                            font-size: 0.75rem;
                            font-weight: 500;
                            line-height: 1;
                            border: 1px solid transparent;
                        }

                        .badge-topic {
                            background-color: rgba(180, 197, 155, 0.2);
                            color: #3D3A37;
                            border-color: rgba(180, 197, 155, 0.3);
                            text-transform: capitalize;
                        }

                        .badge-visible {
                            background-color: #dcfce7;
                            /* green-100 */
                            color: #15803d;
                            /* green-700 */
                            border-color: #86efac;
                            /* green-300 */
                        }

                        .badge-hidden {
                            background-color: #f3f4f6;
                            /* gray-100 */
                            color: #374151;
                            /* gray-700 */
                            border-color: #d1d5db;
                            /* gray-300 */
                        }

                        .badge-reported {
                            background-color: #fee2e2;
                            /* red-100 */
                            color: #b91c1c;
                            /* red-700 */
                            border-color: #fca5a5;
                            /* red-300 */
                        }

                        .btn-sm {
                            padding: 0.5rem 0.75rem;
                            font-size: 0.875rem;
                            border-radius: 0.75rem;
                            cursor: pointer;
                            transition: all 0.2s;
                            font-weight: 500;
                        }
                    </style>
            </head>

            <body class="bg-[#F7F3EF] min-h-screen pb-12">

                <!-- Header (simplified from other pages) -->
                <header class="bg-white border-b border-[#E9E4DF] sticky top-0 z-50 h-[72px] flex justify-center">
                    <div class="w-full max-w-[1200px] px-8 flex items-center justify-between h-full">
                        <a href="${pageContext.request.contextPath}/homeAdmin"
                            class="font-serif text-2xl text-[#3D3A37] hover:opacity-80">MindReach</a>
                        <nav class="hidden lg:flex items-center gap-6">
                            <a href="${pageContext.request.contextPath}/homeAdmin"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Analytics</a>
                            <a href="${pageContext.request.contextPath}/resources"
                                class="text-sm text-[#3D3A37] hover:text-[#2D2A28] font-medium transition-colors">Resources</a>
                            <a href="${pageContext.request.contextPath}/forum-monitor"
                                class="text-sm text-[#2D2A28] font-semibold border-b-2 border-[#B4C59B] pb-1 transition-all">Forum
                                Monitor</a>
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
                                <script src="https://unpkg.com/lucide@latest"></script>
                                <i data-lucide="user"></i>
                            </div>
                            <a href="${pageContext.request.contextPath}/logout"
                                class="ml-4 text-sm text-red-500 hover:text-red-700">Logout</a>
                        </div>
                    </div>
                </header>

                <main class="dashboard-content" style="max-width: 1000px; margin: 0 auto; padding-top: 20px;">

                    <div class="space-y-6">
                        <!-- Hero Header -->
                        <div class="hero-card bg-gradient-forum" style="padding: 1.5rem;">
                            <h1 style="font-size: 1.875rem; color: white; margin: 0 0 0.5rem 0; font-weight: 600;">
                                Monitor Forum Discussions
                            </h1>
                            <p style="color: rgba(255,255,255,0.9); margin: 0;">
                                Review and moderate community posts
                            </p>
                        </div>

                        <!-- Posts List -->
                        <div class="card p-6 border-0 shadow-lg rounded-3xl bg-white"
                            style="padding: 1.5rem; border-radius: 1rem; box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);">

                            <!-- Filter Toggle -->
                            <div
                                style="display: flex; gap: 1rem; margin-bottom: 1.5rem; border-bottom: 1px solid #e5e7eb; padding-bottom: 1rem;">
                                <c:choose>
                                    <c:when test="${currentView == 'active' || empty currentView}">
                                        <a href="forum-monitor?view=active"
                                            style="text-decoration: none; padding: 0.5rem 1rem; border-radius: 0.5rem; font-weight: 500; font-size: 0.875rem; transition: all 0.2s; background-color: #F59E0B; color: white;">
                                            Active Posts
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="forum-monitor?view=active"
                                            style="text-decoration: none; padding: 0.5rem 1rem; border-radius: 0.5rem; font-weight: 500; font-size: 0.875rem; transition: all 0.2s; color: #6B7280; background-color: transparent;">
                                            Active Posts
                                        </a>
                                    </c:otherwise>
                                </c:choose>

                                <c:choose>
                                    <c:when test="${currentView == 'archived'}">
                                        <a href="forum-monitor?view=archived"
                                            style="text-decoration: none; padding: 0.5rem 1rem; border-radius: 0.5rem; font-weight: 500; font-size: 0.875rem; transition: all 0.2s; background-color: #F59E0B; color: white;">
                                            Hidden Posts
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="forum-monitor?view=archived"
                                            style="text-decoration: none; padding: 0.5rem 1rem; border-radius: 0.5rem; font-weight: 500; font-size: 0.875rem; transition: all 0.2s; color: #6B7280; background-color: transparent;">
                                            Hidden Posts
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="space-y-4">
                                <c:forEach var="post" items="${posts}">
                                    <c:set var="isArchived"
                                        value="${post.status == 'hidden' || post.status == 'removed'}" />
                                    <c:set var="showArchived"
                                        value="${currentView == 'archived' || param.view == 'archived'}" />

                                    <%-- Robust filtering: works if backend filters OR if backend returns all --%>
                                        <c:if test="${(showArchived && isArchived) || (!showArchived && !isArchived)}">

                                            <div class="p-4 bg-gray-50 rounded-xl space-y-3"
                                                onclick="location.href='forum?action=detail&id=${post.id}&source=monitor'"
                                                style="cursor: pointer; padding: 1rem; background-color: #fafafa; border-radius: 0.75rem; display: flex; flex-direction: column; gap: 0.75rem; border: 1px solid var(--border); transition: border-color 0.2s;">
                                                <div
                                                    style="display: flex; align-items: start; justify-content: space-between; gap: 1rem;">

                                                    <div
                                                        style="flex: 1; display: flex; flex-direction: column; gap: 0.5rem;">
                                                        <div
                                                            style="display: flex; align-items: center; gap: 0.5rem; flex-wrap: wrap;">
                                                            <span
                                                                style="font-size: 0.875rem; color: #4B5563;">${post.author}</span>
                                                            <span class="badge badge-topic">${post.topic}</span>

                                                            <c:choose>
                                                                <c:when test="${post.status == 'hidden'}">
                                                                    <span class="badge badge-hidden">Hidden</span>
                                                                </c:when>
                                                                <c:when test="${post.status == 'removed'}">
                                                                    <span class="badge badge-reported"
                                                                        style="background-color: #fee2e2; color: #991b1b;">Removed</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span class="badge badge-visible">Visible</span>
                                                                </c:otherwise>
                                                            </c:choose>

                                                            <c:if test="${post.reported}">
                                                                <span class="badge badge-reported">Reported</span>
                                                            </c:if>
                                                        </div>

                                                        <p style="font-size: 0.875rem; color: #1F2937; margin: 0;">
                                                            ${post.content}</p>

                                                        <div
                                                            style="display: flex; align-items: center; gap: 1rem; font-size: 0.75rem; color: #6B7280;">
                                                            <span>${post.createdAt}</span>
                                                            <span>•</span>
                                                            <span>${fn:length(post.comments)} ${fn:length(post.comments)
                                                                == 1 ?
                                                                'reply' : 'replies'}</span>
                                                        </div>
                                                    </div>

                                                    <div style="display: flex; align-items: center; gap: 0.5rem;"
                                                        onclick="event.stopPropagation()">
                                                        <!-- Toggle Hide/Restore (Restoring only allowed for hidden, not removed) -->
                                                        <c:if test="${post.status != 'removed'}">
                                                            <form action="forum-monitor" method="post" style="margin:0;"
                                                                onsubmit="return confirmHide('${post.status}');">
                                                                <input type="hidden" name="action"
                                                                    value="${post.status == 'removed' ? 'restore' : 'toggle'}">
                                                                <input type="hidden" name="id" value="${post.id}">
                                                                <input type="hidden" name="view" value="${currentView}">
                                                                <button class="btn-sm"
                                                                    style="background: white; border: 1px solid #d1d5db; color: #374151;">
                                                                    ${post.status == 'hidden' ? 'Restore' : 'Hide'}
                                                                </button>
                                                            </form>
                                                        </c:if>

                                                        <!-- If removed, show a disabled indicator or just nothing. maybe just nothing as the badge covers it. -->
                                                        <c:if test="${post.status == 'removed'}">
                                                            <button class="btn-sm" disabled
                                                                style="background: #f3f4f6; border: 1px solid #e5e7eb; color: #9ca3af; cursor: not-allowed;">
                                                                Permanently Removed
                                                            </button>
                                                        </c:if>

                                                        <!-- Remove (only show for active posts) -->
                                                        <c:if test="${post.status == 'visible'}">
                                                            <form action="forum-monitor" method="post" style="margin:0;"
                                                                onsubmit="return confirm('Are you sure you want to remove this post?');">
                                                                <input type="hidden" name="action" value="remove">
                                                                <input type="hidden" name="id" value="${post.id}">
                                                                <input type="hidden" name="view" value="${currentView}">
                                                                <button class="btn-sm"
                                                                    style="background: white; border: 1px solid #fca5a5; color: #dc2626;">
                                                                    Remove
                                                                </button>
                                                            </form>

                                                            <!-- Warn User -->
                                                            <button class="btn-sm"
                                                                style="background: #F59E0B; color: white; border: none;"
                                                                data-id="${post.id}" data-author="${post.author}"
                                                                data-content="${fn:escapeXml(post.content)}"
                                                                onclick="openWarnModal(this)">
                                                                Warn User
                                                            </button>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:if>
                                </c:forEach>

                                <c:if test="${empty posts}">
                                    <div style="text-align: center; padding: 3rem; color: #6B7280;">
                                        <p>No posts to monitor</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </main>

                <!-- Warn User Dialog -->
                <div id="warnDialog" class="dialog-backdrop">
                    <div class="dialog-content">
                        <h2 class="dialog-title">Send Friendly Reminder to User</h2>
                        <p class="dialog-description">Send a gentle reminder about community guidelines</p>

                        <div
                            style="margin-top: 1rem; margin-bottom: 1.5rem; display: flex; flex-direction: column; gap: 1rem;">
                            <div
                                style="padding: 1rem; background-color: #fafafa; border-radius: 0.75rem; font-size: 0.875rem;">
                                <p style="margin: 0 0 0.5rem 0; color: #4B5563;">User: <strong
                                        id="warnUserAuthor"></strong></p>
                                <p style="margin: 0; color: #1F2937;" id="warnUserContent"></p>
                            </div>

                            <div
                                style="background-color: rgba(180, 197, 155, 0.1); padding: 1rem; border-radius: 0.75rem; font-size: 0.875rem; color: #374151;">
                                <p style="margin: 0 0 0.5rem 0;">This will send a friendly message reminding the user
                                    to:</p>
                                <ul
                                    style="margin: 0; padding-left: 1.25rem; font-size: 0.75rem; list-style-type: disc;">
                                    <li>Keep discussions respectful and supportive</li>
                                    <li>Follow community guidelines</li>
                                    <li>Maintain a safe space for everyone</li>
                                </ul>
                            </div>
                        </div>

                        <form action="forum-monitor" method="post">
                            <input type="hidden" name="action" value="warn">
                            <input type="hidden" id="warnPostId" name="id">

                            <div style="margin-bottom: 1.5rem;">
                                <label
                                    style="display: block; font-size: 0.875rem; font-weight: 500; color: #374151; margin-bottom: 0.5rem;">
                                    Admin Note (Optional)
                                </label>
                                <textarea name="note" rows="3"
                                    style="width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 0.75rem; font-size: 0.875rem; color: #1f2937; resize: vertical; box-sizing: border-box;"
                                    placeholder="Add a specific note for the user..."></textarea>
                            </div>

                            <div class="dialog-actions">
                                <button type="button" class="btn-outline" onclick="closeWarnModal()">Cancel</button>
                                <button type="submit" class="btn-primary">Send Friendly Reminder</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    function openWarnModal(btn) {
                        const id = btn.getAttribute('data-id');
                        const author = btn.getAttribute('data-author');
                        const content = btn.getAttribute('data-content');

                        document.getElementById('warnPostId').value = id;
                        document.getElementById('warnUserAuthor').textContent = author;
                        document.getElementById('warnUserContent').textContent = '"' + content.substring(0, 100) + (content.length > 100 ? '...' : '') + '"';

                        const dialog = document.getElementById('warnDialog');
                        dialog.classList.add('open');
                    }

                    function closeWarnModal() {
                        const dialog = document.getElementById('warnDialog');
                        dialog.classList.remove('open');
                    }

                    // Close on click outside
                    window.onclick = function (event) {
                        const dialog = document.getElementById('warnDialog');
                        if (event.target == dialog) {
                            closeWarnModal();
                        }
                    }

                    // Robust confirmation for Hide action
                    function confirmHide(status) {
                        if (status === 'visible') {
                            return confirm('Are you sure you want to hide this post?');
                        } else if (status === 'hidden') {
                            return confirm('Are you sure you want to restore this post?');
                        }
                        return true;
                    }
                </script>
            </body>

            </html>