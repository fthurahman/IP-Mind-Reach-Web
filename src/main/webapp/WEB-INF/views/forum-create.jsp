<%@ include file="layout/header.jsp" %>
<c:set var="pageTitle" value="Create Post" />

<div class="space-y-8">
  <!-- Header -->
  <div
    class="bg-gradient-to-r from-[#B4C59B] to-[#CADBB7] rounded-2xl p-8 shadow-xl"
  >
    <h1 class="text-3xl text-white mb-2">Create New Post</h1>
    <p class="text-white/80">Share your thoughts and experiences</p>
  </div>

  <!-- Create form -->
  <div class="bg-white p-6 rounded-2xl shadow">
    <form method="post" action="forum">
      <input type="hidden" name="action" value="create" />

      <div class="space-y-4">
        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1"
            >Author</label
          >
          <input
            type="text"
            name="author"
            class="w-full p-3 border rounded-xl"
            placeholder="Your name or anonymous"
            required
          />
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1"
            >Topic</label
          >
          <select name="topic" class="w-full p-3 border rounded-xl" required>
            <option value="">Select a topic</option>
            <option value="Stress">Stress</option>
            <option value="Anxiety">Anxiety</option>
            <option value="Sleep">Sleep</option>
            <option value="Motivation">Motivation</option>
            <option value="Other">Other</option>
          </select>
        </div>

        <div>
          <label class="block text-sm font-medium text-gray-700 mb-1"
            >Content</label
          >
          <textarea
            name="content"
            class="w-full p-3 border rounded-xl"
            rows="5"
            placeholder="Share your thoughts..."
            required
          ></textarea>
        </div>

        <div class="flex gap-4">
          <button
            type="submit"
            class="bg-[#B4C59B] hover:bg-[#9AAF86] text-white rounded-xl px-4 py-2"
          >
            Create Post
          </button>
          <a href="forum" class="text-gray-500 hover:text-gray-700">Cancel</a>
        </div>
      </div>
    </form>
  </div>
</div>

<%@ include file="layout/footer.jsp" %>
