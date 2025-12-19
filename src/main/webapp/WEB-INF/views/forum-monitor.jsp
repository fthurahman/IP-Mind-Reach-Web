<%@ include file="layout/header.jsp" %>
<c:set var="pageTitle" value="Forum Moderation Panel"/>

<div class="space-y-8">

    <div class="bg-gradient-to-r from-[#B4C59B] to-[#CADBB7] 
        rounded-2xl p-8 shadow-xl">
        <h1 class="text-3xl text-white font-semibold mb-2">
            Forum Moderation Panel
        </h1>
        <p class="text-white/80">Review and moderate reported posts</p>
    </div>

    <div class="bg-white p-6 rounded-2xl shadow-xl space-y-6">

        <c:forEach var="post" items="${posts}">
            <div class="bg-gray-50 rounded-xl p-5 space-y-4">

                <div class="flex justify-between gap-4">

                    <div class="flex-1 space-y-2">

                        <div class="flex items-center gap-2">
                            <span class="font-medium">${post.author}</span>
                            <span class="text-sm bg-[#B4C59B]/20 px-2 rounded-xl">
                                ${post.topic}
                            </span>

                            <c:if test="${post.status=='visible'}">
                                <span class="text-xs bg-green-100 text-green-700 px-2 rounded-xl">Visible</span>
                            </c:if>

                            <c:if test="${post.status=='hidden'}">
                                <span class="text-xs bg-gray-200 text-gray-700 px-2 rounded-xl">Hidden</span>
                            </c:if>

                            <c:if test="${post.reported}">
                                <span class="text-xs bg-red-100 text-red-700 px-2 rounded-xl">Reported</span>
                            </c:if>

                        </div>

                                                <%
                                                    com.example.demo.model.Post _post = (com.example.demo.model.Post) pageContext.getAttribute("post");
                                                    String _content = (_post == null || _post.getContent() == null) ? "" : _post.getContent().replaceAll("[^\\x00-\\x7F]", "");
                                                %>
                                                <p class="text-gray-800 text-sm"><%= _content %></p>

                        <div class="text-xs text-gray-500">
                            ${post.comments.size()} replies
                        </div>

                    </div>


                    <div class="flex gap-2">

                        <form action="forum-monitor">
                            <input type="hidden" name="id" value="${post.id}">
                            <input type="hidden" name="action" value="toggle">
                            <button class="border rounded-xl px-3 py-1 text-sm text-gray-700">
                                <c:choose>
                                    <c:when test="${post.status=='visible'}">Hide</c:when>
                                    <c:otherwise>Restore</c:otherwise>
                                </c:choose>
                            </button>
                        </form>

                        <form action="forum-monitor" onsubmit="return confirm('Remove permanently?')">
                            <input type="hidden" name="id" value="${post.id}">
                            <input type="hidden" name="action" value="remove">
                            <button class="border border-red-300 text-red-600 rounded-xl px-3 py-1 text-sm">
                                Remove
                            </button>
                        </form>

                        <button 
                            onclick="openModal('${post.id}')"
                            class="rounded-xl bg-[#B4C59B] text-white px-3 py-1 text-sm">
                            Warn User
                        </button>

                    </div>

                </div>
            </div>
        </c:forEach>

    </div>

</div>


<!-- modal -->
<div id="warnModal" class="modal">
    <div class="bg-white rounded-xl p-6 w-80 space-y-4">

        <h3 class="text-lg font-semibold">Send Reminder</h3>

        <form method="post" action="forum-monitor">
            <input type="hidden" id="modalPostId" name="id">
            <input type="hidden" name="action" value="warn">

            <p class="text-sm text-gray-600">
                Send friendly reminder to follow community guidelines.
            </p>

            <div class="flex gap-2">
                <button type="button"
                    onclick="closeModal()"
                    class="border rounded-lg px-3 py-1 w-full">
                    Cancel
                </button>
                <button 
                    class="bg-[#B4C59B] text-white 
                    rounded-lg px-3 py-1 w-full">
                    Send
                </button>
            </div>

        </form>
    </div>
</div>


<script>
function openModal(postId) {
    document.getElementById("warnModal").classList.add("active");
    document.getElementById("modalPostId").value = postId;
}
function closeModal() {
    document.getElementById("warnModal").classList.remove("active");
}
</script>


<%@ include file="layout/footer.jsp" %>
