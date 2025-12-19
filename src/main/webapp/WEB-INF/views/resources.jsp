<%@ include file="layout/header.jsp" %>
<c:set var="pageTitle" value="Resources" />

<div class="space-y-8">
  <div
    class="bg-gradient-to-r from-[#7ED957] to-[#9EEB9A] rounded-2xl p-8 shadow-xl"
  >
    <h1 class="text-3xl text-white mb-2">Self-Help Resources</h1>
    <p class="text-white/80">Guided help & mental wellness content by genre</p>
  </div>

  <div class="bg-white rounded-2xl p-6 shadow mt-4">
    <h2 class="text-2xl font-semibold text-[#3D3A37] mb-3">About Mental Health</h2>
    <p class="text-gray-700 mb-2">Mental health is an essential part of overall well‑being. It affects how we think, feel, and act, and helps determine how we handle stress, relate to others, and make choices. Everyone experiences ups and downs — and there are effective, practical steps and resources to improve resilience and cope with difficulties.</p>

    <p class="text-gray-700 mb-2">Use the resources below for learning, self-care practices, and finding professional help when needed. If you are in crisis or feel you might harm yourself or others, contact local emergency services or a crisis hotline immediately.</p>

    <div class="grid md:grid-cols-2 gap-4 mt-3">
      <div>
        <h3 class="font-medium text-[#3D3A37]">Quick self-care tips</h3>
        <ul class="list-disc list-inside text-gray-700">
          <li>Keep a regular sleep schedule and stay active.</li>
          <li>Practice breathing or grounding exercises for 5–10 minutes daily.</li>
          <li>Limit alcohol and drug use; reach out to friends or family for support.</li>
          <li>Break tasks into small steps and celebrate progress.</li>
        </ul>
      </div>

      <div>
        <h3 class="font-medium text-[#3D3A37]">Finding help</h3>
        <ul class="list-disc list-inside text-gray-700">
          <li>Start with trusted resources: national mental health services, educational sites, and evidence‑based apps.</li>
          <li>For therapy or counseling, search licensed providers and check accessibility options (sliding scale, telehealth).</li>
          <li>Use crisis lines if you are unsafe — keep local emergency numbers and suicide prevention hotlines handy.</li>
        </ul>
      </div>
    </div>

    <p class="text-sm text-gray-600 mt-3">Below are curated resources organized by topic — click any item to read more and access guided exercises, articles, or local support options.</p>
  </div>

  <!-- Section switcher -->
  <div class="mt-4 flex gap-2">
    <a href="forum" class="px-4 py-2 rounded-xl text-sm bg-white text-[#5A5653] border">Forum</a>
    <a href="resources" class="px-4 py-2 rounded-xl text-sm bg-[#7ED957] text-white">Resources</a>
  </div>

  <!-- Search bar -->
  <div>
    <form method="get" action="resources" class="flex gap-2">
      <input type="hidden" name="action" value="search" />
      <input
        type="text"
        name="q"
        placeholder="Search resources..."
        class="flex-1 p-2 border rounded-xl"
        value="${param.q}"
      />
      <button
        type="submit"
        class="bg-[#7ED957] hover:bg-[#6FCB47] text-white rounded-xl px-4 py-2"
      >
        Search
      </button>
    </form>
  </div>

  <div class="grid md:grid-cols-2 gap-4">
    <c:forEach var="resource" items="${resources}">
      <div
        class="bg-gradient-to-r from-white to-[#F7FFF5] hover:shadow-2xl p-6 rounded-3xl shadow-sm transition transform hover:scale-105 space-y-2"
      >
        <div class="flex items-center gap-2 text-sm text-gray-600">
          <span>${resource.type}</span>
          <span
            data-topic="${resource.topic}"
            class="bg-[#7ED957]/20 border border-[#7ED957]/30 rounded-xl px-2 py-1 text-xs"
          >
            ${resource.topic}
          </span>
        </div>

        <h3 class="font-semibold text-lg text-[#3D3A37]"><span style="display:inline-block;width:10px;height:10px;background:#A3F7B1;border-radius:50%;margin-right:8px;vertical-align:middle;"></span>${resource.title}</h3>

        <p class="text-sm text-gray-600">${resource.description}</p>

        <div class="flex gap-4 items-center pt-2">
          <a
            href="resources?action=detail&id=${resource.id}"
            class="text-sm underline text-[#5A5653] hover:text-[#3D3A37]"
            >View Resource &rarr;</a>
          <span class="text-black cursor-pointer text-sm favorite-toggle" title="Favourite">Favorite</span>
        </div>
      </div>
    </c:forEach>
  </div>
</div>

<%@ include file="layout/footer.jsp" %>
<!-- Chart removed per request -->

<script>
// Favorite toggle: turns yellow when clicked
document.addEventListener('click', function(e){
  const t = e.target.closest('.favorite-toggle');
  if(!t) return;
  e.preventDefault();
  // toggle favorite state visually
  if(t.classList.contains('is-fav')){
    t.classList.remove('is-fav');
    // reset styles
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
