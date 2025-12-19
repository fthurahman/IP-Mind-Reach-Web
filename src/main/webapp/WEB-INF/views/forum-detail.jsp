<%@ include file="layout/header.jsp" %>
<c:set var="pageTitle" value="Forum Discussion" />

<div class="space-y-6">
  <div class="bg-white p-6 rounded-2xl shadow space-y-4">
    <!-- post header -->
    <div class="flex items-center gap-3 text-sm text-gray-600">
      <span class="font-medium">${post.author}</span>
      <span
        class="bg-[#B4C59B]/20 border border-[#B4C59B]/30 px-2 py-1 rounded-xl text-xs"
      >
        ${post.topic}
      </span>
      <button
        onclick="navigator.clipboard.writeText(window.location.href); alert('Link copied!')"
        class="text-gray-500 hover:text-gray-700 ml-auto text-sm"
        title="Share"
      >
        Share
      </button>
    </div>

    <%
      com.example.demo.model.Post _post = (com.example.demo.model.Post) pageContext.getAttribute("post");
      String _content = (_post == null || _post.getContent() == null) ? "" : _post.getContent().replaceAll("[^\\x00-\\x7F]", "");
    %>
    <p class="text-gray-900 text-base"><%= _content %></p>
  </div>

  <!-- replies -->
  <div class="bg-white p-6 rounded-2xl shadow space-y-4">
    <h3 class="font-semibold text-lg">Replies</h3>

    <c:forEach var="comment" items="${post.comments}">
      <div class="bg-gray-50 p-4 rounded-xl space-y-1">
        <p class="font-medium text-sm">${comment.author}</p>
        <p class="text-gray-800 text-sm">${comment.content}</p>
        <p class="text-xs text-gray-500">${comment.createdAt}</p>
      </div>
    </c:forEach>

    <!-- reply form -->
    <form method="post" action="forum">
      <input type="hidden" name="id" value="${post.id}" />

      <textarea
        name="reply"
        class="w-full p-3 border rounded-xl"
        placeholder="Write a reply..."
        required
      ></textarea>

      <button
        class="bg-[#B4C59B] hover:bg-[#9AAF86] text-white rounded-xl px-4 py-2 mt-2"
      >
        Submit Reply
      </button>
    </form>
  </div>

  <a href="forum" class="underline text-sm">&larr; Back to Forum</a>
</div>

<%@ include file="layout/footer.jsp" %>
