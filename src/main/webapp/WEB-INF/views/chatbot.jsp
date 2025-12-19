<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>MindReach Assistant</title>

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
      .space-y-6 > * + * {
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

    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/style.css"
    />
  </head>

  <body>
    <!-- Top Navigation Bar (same structure as other pages) -->
    <header class="header">
      <div class="header-container">
        <!-- Logo -->
        <a href="homeStudent" class="logo-btn"> MindReach </a>

        <!-- Desktop Navigation -->
        <nav class="nav-desktop">
          <a href="homeStudent" class="nav-item">Self-Help</a>
          <a href="resources" class="nav-item">Resources</a>
          <a href="forum" class="nav-item">Forum</a>
          <a href="resultDASS" class="nav-item">Progress</a>
          <a href="counseling" class="nav-item">Telehealth Assistance</a>
          <a href="chatbot" class="nav-item active">Chat Support</a>
        </nav>

        <!-- User Section / Mobile Toggle -->
        <div class="user-section-desktop">
          <div class="avatar-circle">
            <!-- User Icon SVG -->
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="24"
              height="24"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
            >
              <circle cx="12" cy="12" r="10" />
              <circle cx="12" cy="10" r="3" />
              <path d="M7 20.662V19a2 2 0 0 1 2-2h6a2 2 0 0 1 2 2v1.662" />
            </svg>
          </div>
          <div class="user-info">
            <p class="user-name">${loggedUser.name}</p>
            <p class="user-role">Student</p>
          </div>
          <a href="logout" class="btn-ghost">
            <!-- LogOut Icon -->
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              viewBox="0 0 24 24"
              fill="none"
              stroke="currentColor"
              stroke-width="2"
              stroke-linecap="round"
              stroke-linejoin="round"
              style="margin-right: 8px"
            >
              <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
              <polyline points="16 17 21 12 16 7" />
              <line x1="21" x2="9" y1="12" y2="12" />
            </svg>
            Log out
          </a>
        </div>

        <button class="mobile-menu-btn" onclick="toggleMobileMenu()">
          <!-- Menu Icon -->
          <svg
            xmlns="http://www.w3.org/2000/svg"
            width="24"
            height="24"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            stroke-width="2"
            stroke-linecap="round"
            stroke-linejoin="round"
          >
            <line x1="4" x2="20" y1="12" y2="12" />
            <line x1="4" x2="20" y1="6" y2="6" />
            <line x1="4" x2="20" y1="18" y2="18" />
          </svg>
        </button>
      </div>
    </header>

    <!-- Mobile Sheet/Menu -->
    <div id="mobileSheet" class="sheet-overlay">
      <div class="sheet-content">
        <h3
          style="
            margin: 0 0 0.5rem 0;
            font-family: var(--font-family-serif);
            font-size: 1.25rem;
          "
        >
          Navigation
        </h3>
        <p style="margin: 0; font-size: 0.875rem; color: #8c8784">
          Access MindReach sections
        </p>

        <nav class="mobile-nav">
          <a href="homeStudent" class="mobile-nav-item">Self-Help</a>
          <a href="resources" class="mobile-nav-item">Resources</a>
          <a href="forum" class="mobile-nav-item">Forum</a>
          <a href="resultDASS" class="mobile-nav-item">Progress</a>
          <a href="counseling" class="mobile-nav-item">Telehealth Assistance</a>
          <a href="chatbot" class="mobile-nav-item active">Chat Support</a>
        </nav>

        <div class="mobile-separator"></div>

        <a href="logout" class="mobile-nav-item" style="color: #5a5653"
          >Log out</a
        >
      </div>
    </div>

    <!-- Main Content -->
    <main class="dashboard-content">
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
            <input
              id="input"
              class="input"
              placeholder="Type your message..."
            />
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
          content:
            "Hi there. I'm here to support you. How would you describe today?",
          quickReplies: [
            { text: "😰 Overwhelmed", action: "stressed" },
            { text: "😟 Anxious", action: "anxious" },
            { text: "😴 Can't sleep", action: "sleep" },
            { text: "💬 Just want to talk", action: "talk" },
          ],
        },
      ];

      let messages = [...initialMessages];

      const chatEl = document.getElementById("chat");
      const inputEl = document.getElementById("input");
      const sendBtn = document.getElementById("sendBtn");

      function addMessage(type, content, quickReplies) {
        messages.push({
          id: String(Date.now()),
          type,
          content,
          quickReplies: quickReplies || null,
        });
        render();
        scrollToBottom();
      }

      function scrollToBottom() {
        chatEl.scrollTop = chatEl.scrollHeight;
      }

      function handleQuickReply(action) {
        const replyTexts = {
          stressed: "I'm feeling stressed",
          anxious: "I'm feeling anxious",
          sleep: "I'm having trouble sleeping",
          talk: "I just want to talk",
        };

        addMessage("user", replyTexts[action] || action);

        setTimeout(() => {
          if (action === "stressed") {
            addMessage(
              "bot",
              "I understand that stress can be overwhelming. Here are some things that might help:",
              [
                { text: "🧘 Try breathing exercises", action: "self-help" },
                {
                  text: "📚 Read about stress management",
                  action: "resources",
                },
                { text: "🤝 Talk to a counselor", action: "counseling" },
                { text: "🆘 This is urgent", action: "urgent" },
              ]
            );
          } else if (action === "anxious") {
            addMessage(
              "bot",
              "Anxiety is tough. Let me help you find support:",
              [
                { text: "🧘 Guided relaxation", action: "self-help" },
                { text: "📚 Learn about anxiety", action: "resources" },
                { text: "💬 Join the forum", action: "forum" },
                { text: "🆘 This is urgent", action: "urgent" },
              ]
            );
          } else if (action === "sleep") {
            addMessage(
              "bot",
              "Sleep is so important for wellbeing. Here's what can help:",
              [
                { text: "📚 Sleep hygiene tips", action: "resources" },
                { text: "🧘 Relaxation exercises", action: "self-help" },
                { text: "🤝 Speak with counselor", action: "counseling" },
              ]
            );
          } else if (action === "talk") {
            addMessage("bot", "I'm here to listen. What's on your mind?", [
              { text: "💬 Join community forum", action: "forum" },
              { text: "🤝 Book counseling", action: "counseling" },
              { text: "🧘 Try self-help", action: "self-help" },
            ]);
          } else if (action === "self-help") {
            addMessage(
              "bot",
              "Great choice! The Self-Help module has guided breathing exercises, meditation, and reflection activities. Would you like me to take you there?",
              [
                { text: "Yes, take me there", action: "navigate-self-help" },
                { text: "Tell me more", action: "more-self-help" },
              ]
            );
          } else if (action === "resources") {
            addMessage(
              "bot",
              "The Resources section has articles and videos on stress, anxiety, sleep, and more. I can guide you there!",
              [
                { text: "Yes, show me", action: "navigate-resources" },
                { text: "What topics are covered?", action: "more-resources" },
              ]
            );
          } else if (action === "counseling") {
            addMessage(
              "bot",
              "Talking to a professional counselor can be really helpful. You can book a session with one of our counselors.",
              [
                { text: "📅 Book a session", action: "navigate-counseling" },
                { text: "Tell me more", action: "more-counseling" },
              ]
            );
          } else if (action === "forum") {
            addMessage(
              "bot",
              "The forum is a safe, anonymous space where you can connect with peers who understand what you're going through.",
              [
                { text: "💬 Go to forum", action: "navigate-forum" },
                { text: "How does it work?", action: "more-forum" },
              ]
            );
          } else if (action === "urgent") {
            addMessage(
              "bot",
              "If you're in crisis or need immediate help, please reach out:\n\n🆘 National Crisis Hotline: 988\n📞 Campus Safety: (555) 123-4567\n\nWould you also like to request a callback from our counseling team?",
              [
                { text: "Yes, request callback", action: "request-callback" },
                { text: "No, I'm okay for now", action: "restart" },
              ]
            );
          } else if (action === "request-callback") {
            addMessage(
              "bot",
              "I've submitted your request. A counselor will contact you within 2 hours. In the meantime, please don't hesitate to call the crisis hotline if you need immediate support. Take care of yourself. 💙"
            );
          } else if (action === "restart") {
            addMessage(
              "bot",
              "Okay. Remember, I'm here whenever you need support. How else can I help you today?",
              initialMessages[0].quickReplies
            );
          } else if (String(action).startsWith("navigate-")) {
            addMessage(
              "bot",
              "I would navigate you to that module now. (In a real app, this would change the active module.)"
            );
          } else if (String(action).startsWith("more-")) {
            addMessage(
              "bot",
              "Here's more information about that feature. (In a real app, this would provide detailed information.)"
            );
          }
        }, 500);
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

      function handleSend() {
        const val = (inputEl.value || "").trim();
        if (!val) return;

        addMessage("user", val);
        inputEl.value = "";

        setTimeout(() => {
          addMessage(
            "bot",
            "Thanks for sharing. Based on what you've told me, I recommend exploring our Self-Help exercises or connecting with a counselor. How would you like to proceed?",
            [
              { text: "🧘 Self-Help", action: "self-help" },
              { text: "🤝 Counseling", action: "counseling" },
              { text: "📚 Resources", action: "resources" },
            ]
          );
        }, 500);
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
