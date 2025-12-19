<%@ include file="layout/header.jsp" %>
<c:set var="pageTitle" value="Forum" />

<div class="space-y-8">
  <!-- Header -->
  <div
    class="bg-gradient-to-r from-[#7ED957] to-[#9EEB9A] rounded-2xl p-8 shadow-md"
  >
    <h1 class="text-3xl text-white mb-2">Student Forum</h1>
    <p class="text-white/80">
      Share experiences, ask questions, and support each other — be kind and curious
    </p>
  </div>

  <!-- Section switcher -->
  <div class="mt-4 flex gap-2">
    <a href="forum" class="px-4 py-2 rounded-full text-sm bg-[#7ED957] text-white shadow-sm transition transform hover:scale-105 hover:shadow-xl">Forum</a>
    <a href="resources" class="px-4 py-2 rounded-full text-sm bg-white text-[#5A5653] border shadow-sm transition transform hover:scale-105 hover:shadow-xl">Resources</a>
  </div>

  <!-- Create post button -->
  <div>
    <a
      href="forum?action=new"
      class="bg-[#7ED957] hover:bg-[#6FCB47] text-white rounded-xl px-4 py-2 text-sm shadow-sm"
    >
      Create Post
    </a>
  </div>

  <!-- Search bar -->
  <div>
    <form method="get" action="forum" class="flex gap-2">
      <input type="hidden" name="action" value="search" />
      <input
        type="text"
        name="q"
        placeholder="Search posts..."
        class="flex-1 p-2 border rounded-xl"
        value="${param.q}"
      />
      <button
        type="submit"
        class="bg-[#7ED957] hover:bg-[#6FCB47] text-white rounded-xl px-4 py-2 shadow-sm"
      >
        Search
      </button>
    </form>
  </div>

  <!-- Post feed -->
  <div class="space-y-4">
    <c:forEach var="post" items="${posts}">
      <div class="bg-white p-6 rounded-2xl shadow-sm space-y-3 transition transform hover:scale-105 hover:shadow-xl" style="border-top:4px solid #DFF7D8;">
        <div class="flex items-center gap-3 text-sm">
          <div>
            <div class="text-sm font-semibold text-[#333]">${post.author}</div>
            <div class="text-xs text-gray-500"><span class="px-2 py-0.5 rounded-full text-xs" style="background:#7ED957;color:#123;">${post.topic}</span></div>
          </div>
        </div>

        <%
          com.example.demo.model.Post _post = (com.example.demo.model.Post) pageContext.getAttribute("post");
          String _content = (_post == null || _post.getContent() == null) ? "" : _post.getContent().replaceAll("[^\\x00-\\x7F]", "");
          String _summary = _content.length() > 60 ? _content.substring(0,60) + "..." : _content;
        %>
        <p class="text-gray-800 font-medium text-lg"><%= _summary %></p>
        <p class="text-gray-700"> <%= _content.length() > 200 ? _content.substring(0,200) + "..." : _content %></p>

        <div class="flex gap-4 items-center">
          <a href="forum?action=detail&id=${post.id}" class="text-sm text-[#3D3A37] font-medium">View Discussion &rarr;</a>
          <button class="text-sm bg-white border text-[#333] px-3 py-1 rounded-full favorite-toggle">Favourite</button>
          <a href="forum?action=report&id=${post.id}" class="text-sm text-red-500 hover:text-red-700">Report</a>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<%@ include file="layout/footer.jsp" %>
<script>
// Favorite toggle for forum page
document.addEventListener('click', function(e){
  const t = e.target.closest('.favorite-toggle');
  if(!t) return;
  e.preventDefault();
  if(t.classList.contains('is-fav')){
    t.classList.remove('is-fav');
    t.style.background = '';
    t.style.color = '';
    t.style.borderColor = '';
  } else {
    t.classList.add('is-fav');
    t.style.background = '#FFD54A';
    t.style.color = '#3D3A37';
    t.style.borderColor = '#FFD54A';
  }
});
</script>
