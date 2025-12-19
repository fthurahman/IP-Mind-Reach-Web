<%@ include file="layout/header.jsp" %>
<c:set var="pageTitle" value="Resource Detail" />

<div class="space-y-8">
  <div
    class="bg-gradient-to-r from-[#7ED957] to-[#9EEB9A] rounded-2xl p-8 shadow-xl"
  >
    <h1 class="text-3xl text-white mb-2">${resource.title}</h1>
    <p class="text-white/80">${resource.description}</p>
  </div>

  <div class="bg-white p-6 rounded-2xl shadow space-y-4">
    <div class="flex items-center gap-3 text-sm text-gray-600">
      <span class="font-medium">Type: ${resource.type}</span>
      <span
        class="bg-[#7ED957]/20 border border-[#7ED957]/30 px-2 py-1 rounded-xl text-xs"
      >
        ${resource.topic}
      </span>
      <span class="text-black cursor-pointer text-sm favorite-toggle" title="Favourite">Favorite</span>
      <button
        onclick="navigator.clipboard.writeText(window.location.href); alert('Link copied!')"
        class="text-gray-500 hover:text-gray-700 ml-auto text-sm"
        title="Share"
      >
        Share
      </button>
    </div>

    <%-- Small cheerful diagram: estimated read time based on word count --%>
    <%
      String content = resource.getContent() == null ? "" : resource.getContent();
      int words = content.trim().isEmpty() ? 0 : content.trim().split("\\s+").length;
      int minutes = Math.max(1, words / 200);
      int pct = Math.min(100, (words * 100) / 500);
    %>
    <div class="p-3 bg-[#FFF9F0] rounded-lg border border-[#FFE9C6] flex items-center gap-4">
      <div style="width:120px; height:24px; background:#e9fbd9; border-radius:12px; overflow:hidden;">
        <div style="height:100%; width:<%= pct %>%; background:#7ED957;"></div>
      </div>
      <div>
        <div class="text-sm font-medium text-[#3D3A37]">Estimated read time</div>
        <div class="text-xs text-gray-600"><%= minutes %> min • <%= words %> words</div>
      </div>
    </div>

    <p class="text-gray-900 text-base mt-3">${resource.content}</p>
  </div>

  <a href="resources" class="underline text-sm">&larr; Back to Resources</a>
</div>

<%@ include file="layout/footer.jsp" %>
<script>
// Favorite toggle for resource detail
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
