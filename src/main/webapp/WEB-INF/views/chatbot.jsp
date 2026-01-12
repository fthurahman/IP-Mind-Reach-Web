<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <!DOCTYPE html>
    <html>

    <head>
      <meta charset="UTF-8" />
      <title>Chat Support | MindReach</title>
      <script src="https://cdn.tailwindcss.com"></script>
      <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
      <style>
        /* Fonts */
        @import url("https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Work+Sans:ital,wght@0,100..900;1,100..900&display=swap");

        :root {
          /* Colors from global.css */
          --font-family-serif: "DM Serif Display", serif;
          --font-family-sans: "Work Sans", sans-serif;

          --background: #f7f3ef;
          --foreground: #3d3a37;
          --card: #ffffff;
          --card-foreground: #5a5653;
          --primary: #b4c59b;
          --primary-hover: #9aaf86;
          --primary-foreground: #3d3a37;
          --muted-foreground: #8c8784;
          --border: #e9e4df;

          --radius-xl: 0.75rem;

          /* Chatbot specific */
          --olive: #b4c59b;
          --olive-2: #cadbb7;
          --ink: #3d3a37;
          --text: #5a5653;
          --paper: #f7f3ef;
          --rose: #d8a79e;
          --shadow: 0 4px 20px rgba(180, 197, 155, 0.15);
          --radius: 24px;
        }

        body {
          margin: 0;
          padding: 0;
          font-family: var(--font-family-sans);
          background-color: var(--background);
          color: var(--foreground);
          min-height: 100vh;
        }

        /* Chatbot styles */
        * {
          box-sizing: border-box;
        }

        .wrap {
          max-width: 900px;
          margin: 32px auto;
          padding: 0 16px;
        }

        .space-y-6>*+* {
          margin-top: 24px;
        }

        .chat-card {
          background: #fff;
          border: 1px solid var(--border);
          border-radius: var(--radius);
          box-shadow: var(--shadow);
          overflow: hidden;
        }

        /* ✅ IMPORTANT: renamed from .header to .chat-header to avoid clashing with navbar .header */
        .chat-header {
          padding: 24px;
          background: linear-gradient(135deg, var(--olive), var(--olive-2));
        }

        .chat-header-row {
          display: flex;
          align-items: center;
          gap: 12px;
        }

        .bot-badge {
          width: 48px;
          height: 48px;
          background: rgba(255, 255, 255, 0.4);
          border-radius: 999px;
          display: flex;
          align-items: center;
          justify-content: center;
          font-weight: 900;
          color: #fff;
        }

        .chat-header h1 {
          margin: 0;
          font-size: 32px;
          color: #fff;
        }

        .chat-header p {
          margin: 4px 0 0 0;
          font-size: 13px;
          color: rgba(255, 255, 255, 0.9);
        }

        .chat {
          height: 500px;
          overflow-y: auto;
          padding: 24px;
          background: rgba(247, 243, 239, 0.5);
        }

        .msg {
          margin-bottom: 14px;
        }

        .msg-row {
          display: flex;
          gap: 12px;
          align-items: flex-start;
        }

        .msg-row.user {
          flex-direction: row-reverse;
        }

        .avatar {
          width: 32px;
          height: 32px;
          border-radius: 999px;
          display: flex;
          align-items: center;
          justify-content: center;
          flex-shrink: 0;
          color: var(--ink);
          font-weight: 900;
        }

        .avatar.bot {
          background: rgba(202, 219, 183, 0.4);
        }

        .avatar.user {
          background: rgba(216, 167, 158, 0.4);
        }

        .bubble {
          max-width: 70%;
          border-radius: 24px;
          padding: 14px 16px;
          box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
          border: 1px solid var(--border);
          font-size: 13px;
          line-height: 1.55;
          white-space: pre-line;
        }

        .bubble.bot {
          background: #fff;
          color: var(--text);
        }

        .bubble.user {
          background: #d9e4cc;
          color: #2a2928;
        }

        .quick {
          margin-left: 44px;
          margin-top: 10px;
          display: flex;
          flex-wrap: wrap;
          gap: 10px;
        }

        .pill {
          border: 1px solid var(--border);
          background: #fff;
          border-radius: 999px;
          padding: 8px 12px;
          cursor: pointer;
          font-weight: 700;
          font-size: 12px;
          color: var(--ink);
        }

        .pill:hover {
          background: rgba(202, 219, 183, 0.3);
        }

        .composer {
          padding: 16px;
          background: #fff;
          border-top: 1px solid var(--border);
          display: flex;
          gap: 10px;
        }

        .input {
          flex: 1;
          border: 1px solid var(--border);
          border-radius: 14px;
          padding: 10px 12px;
          font-size: 14px;
          outline: none;
        }

        .send {
          border: 0;
          border-radius: 14px;
          background: var(--olive);
          color: var(--ink);
          font-weight: 900;
          padding: 10px 14px;
          cursor: pointer;
          box-shadow: 0 4px 12px rgba(180, 197, 155, 0.25);
        }

        .send:hover {
          background: #9aaf86;
        }

        .crisis {
          background: rgba(216, 167, 158, 0.1);
          padding: 24px;
          border-radius: var(--radius);
          border: 1px solid var(--border);
          box-shadow: var(--shadow);
        }

        .crisis h3 {
          margin: 0 0 12px 0;
          display: flex;
          align-items: center;
          gap: 10px;
        }

        .crisis p {
          margin: 6px 0;
          color: var(--text);
          font-size: 13px;
        }
      </style>

      <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
    </head>

    <body>
      <!-- Top Navigation Bar -->
      <jsp:include page="layout/header.jsp">
        <jsp:param name="activePage" value="chatbot" />
      </jsp:include>

      <!-- Main Content -->
      <main class="dashboard-content" style="padding-top: 96px !important; height: calc(100vh - 72px);">
        <div class="wrap space-y-6">
          <div class="chat-card">
            <div class="chat-header">
              <div class="chat-header-row">
                <div class="bot-badge">B</div>
                <div>
                  <h1>MindReach Assistant</h1>
                  <p>Get gentle guidance and support anytime</p>
                </div>
              </div>
            </div>

            <div class="chat" id="chat"></div>

            <div class="composer">
              <input id="input" class="input" placeholder="Type your message..." />
              <button id="sendBtn" class="send" type="button">➤</button>
            </div>
          </div>

          <div class="crisis">
            <h3>📞 Crisis Resources</h3>
            <p>🆘 <strong>National Crisis Hotline:</strong> 988 (24/7)</p>
            <p>📞 <strong>Campus Safety:</strong> (555) 123-4567</p>
            <p>💬 <strong>Crisis Text Line:</strong> Text HOME to 741741</p>
          </div>
        </div>
      </main>

      <script>
        function toggleMobileMenu() {
          const sheet = document.getElementById("mobileSheet");
          if (sheet.classList.contains("open")) {
            sheet.classList.remove("open");
          } else {
            sheet.classList.add("open");
          }
        }

        // Close on click outside
        window.onclick = function (event) {
          const sheet = document.getElementById("mobileSheet");
          if (event.target == sheet) {
            sheet.classList.remove("open");
          }
        };
      </script>

      <script>
        const initialMessages = [
          {
            id: "1",
            type: "bot",
            content: "Hi there. I'm here to support you. How would you describe today?",
            quickReplies: [
              { text: "😰 Overwhelmed", action: "stressed" },
              { text: "😟 Anxious", action: "anxious" },
              { text: "😴 Can't sleep", action: "sleep" },
              { text: "💬 Just want to talk", action: "talk" },
            ],
          },
        ];

        let messages = [].concat(initialMessages);

        const chatEl = document.getElementById("chat");
        const inputEl = document.getElementById("input");
        const sendBtn = document.getElementById("sendBtn");

        function addMessage(type, content, quickReplies) {
          messages.push({
            id: String(Date.now()),
            type: type,
            content: content,
            quickReplies: quickReplies || null,
          });
          render();
          scrollToBottom();
        }

        function scrollToBottom() {
          chatEl.scrollTop = chatEl.scrollHeight;
        }

        function render() {
          chatEl.innerHTML = "";

          messages.forEach((m) => {
            const msg = document.createElement("div");
            msg.className = "msg";

            const row = document.createElement("div");
            row.className = "msg-row " + (m.type === "user" ? "user" : "");

            const avatar = document.createElement("div");
            avatar.className = "avatar " + (m.type === "user" ? "user" : "bot");
            avatar.textContent = m.type === "user" ? "U" : "B";

            const bubble = document.createElement("div");
            bubble.className = "bubble " + (m.type === "user" ? "user" : "bot");
            bubble.textContent = m.content;

            row.appendChild(avatar);
            row.appendChild(bubble);
            msg.appendChild(row);

            if (m.quickReplies && Array.isArray(m.quickReplies)) {
              const quick = document.createElement("div");
              quick.className = "quick";

              m.quickReplies.forEach((q) => {
                const b = document.createElement("button");
                b.className = "pill";
                b.type = "button";
                b.textContent = q.text;
                b.addEventListener("click", () => handleQuickReply(q.action));
                quick.appendChild(b);
              });

              msg.appendChild(quick);
            }

            chatEl.appendChild(msg);
          });
        }

        async function fetchBotReply(userText) {
          const res = await fetch("${pageContext.request.contextPath}/chatbot/message", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ message: userText }),
          });

          const data = await res.json();
          return data.reply || "Sorry — no reply.";
        }

        async function sendToAI(userText) {
          // show typing
          addMessage("bot", "…");
          const typingIndex = messages.length - 1;

          try {
            const reply = await fetchBotReply(userText);

            // replace typing bubble
            messages[typingIndex].content = reply;

            // add action pills after reply (optional)
            messages[typingIndex].quickReplies = [
              { text: "🧘 Self-Help", action: "navigate-self-help" },
              { text: "🤝 Counseling", action: "navigate-counseling" },
              { text: "📚 Resources", action: "navigate-resources" },
              { text: "🆘 Urgent", action: "urgent" },
            ];

            render();
            scrollToBottom();
          } catch (e) {
            messages[typingIndex].content =
              "Sorry — I’m having trouble replying right now. Please try again in a moment.";
            render();
            scrollToBottom();
          }
        }

        function handleQuickReply(action) {
          // map initial emotion pills to user text
          const replyTexts = {
            stressed: "I'm feeling stressed and overwhelmed.",
            anxious: "I'm feeling anxious.",
            sleep: "I'm having trouble sleeping.",
            talk: "I just want to talk.",
          };

          // navigation actions (you can wire to real pages later)
          if (String(action).startsWith("navigate-")) {
            if (action === "navigate-self-help") window.location.href = "homeStudent";
            else if (action === "navigate-resources") window.location.href = "resources";
            else if (action === "navigate-counseling") window.location.href = "telehealth";
            return;
          }

          if (action === "urgent") {
            addMessage(
              "bot",
              "If you’re in immediate danger or feel you might harm yourself, please contact local emergency services right now.\n\nIf you can, reach out to a trusted person nearby.\n\nWould you like to tell me what’s happening in one sentence?",
              [
                { text: "I’m safe, just overwhelmed", action: "stressed" },
                { text: "I need help now", action: "talk" },
              ]
            );
            return;
          }

          const userText = replyTexts[action] || String(action);
          addMessage("user", userText);

          // send that userText to AI
          sendToAI(userText);
        }

        async function handleSend() {
          const val = (inputEl.value || "").trim();
          if (!val) return;

          addMessage("user", val);
          inputEl.value = "";

          await sendToAI(val);
        }

        sendBtn.addEventListener("click", handleSend);
        inputEl.addEventListener("keydown", (e) => {
          if (e.key === "Enter") handleSend();
        });

        render();
        scrollToBottom();
      </script>

    </body>

    </html>