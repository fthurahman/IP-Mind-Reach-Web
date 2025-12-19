<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Analytics Dashboard</title>

    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"
      rel="stylesheet"
    />

    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>

    <style>
      :root {
        --bg: #f7f3ef;
        --card: #ffffff;
        --text: #2a2928;
        --muted: #5a5653;
        --border: #e9e4df;
        --green: #b4c59b;
        --green2: #cadbb7;
        --blue: #3b82f6;
        --red: #ef4444;
        --shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
        --radius: 18px;
      }

      * {
        box-sizing: border-box;
      }

      body {
        margin: 0;
        font-family: Inter, system-ui, -apple-system, Segoe UI, Roboto, Arial,
          sans-serif;
        background: var(--bg);
        color: var(--text);
      }

      .wrap {
        max-width: 1100px;
        margin: 32px auto;
        padding: 0 18px 48px;
      }

      .hero {
        background: linear-gradient(90deg, var(--green), var(--green2));
        border-radius: 22px;
        padding: 28px 28px;
        box-shadow: 0 10px 30px rgba(180, 197, 155, 0.18);
        color: white;
        margin-bottom: 18px;
      }
      .hero h1 {
        margin: 0 0 6px;
        font-size: 28px;
        font-weight: 700;
      }
      .hero p {
        margin: 0;
        opacity: 0.92;
      }

      .grid {
        display: grid;
        grid-template-columns: repeat(12, 1fr);
        gap: 16px;
        margin-top: 18px;
        margin-bottom: 20px;
      }

      .card {
        background: var(--card);
        border: 1px solid var(--border);
        border-radius: var(--radius);
        box-shadow: var(--shadow);
      }

      .metric {
        padding: 18px;
        grid-column: span 12;
        background: linear-gradient(
          145deg,
          rgba(202, 219, 183, 0.2),
          rgba(180, 197, 155, 0.22)
        );
        border: 0;
      }
      .metric.blue {
        background: linear-gradient(
          145deg,
          rgba(59, 130, 246, 0.1),
          rgba(59, 130, 246, 0.16)
        );
      }
      .metric.green {
        background: linear-gradient(
          145deg,
          rgba(16, 185, 129, 0.1),
          rgba(16, 185, 129, 0.14)
        );
      }
      .metric.red {
        background: linear-gradient(
          145deg,
          rgba(239, 68, 68, 0.1),
          rgba(239, 68, 68, 0.14)
        );
      }

      .metricTop {
        display: flex;
        align-items: center;
        gap: 10px;
        margin-bottom: 8px;
        color: var(--muted);
        font-size: 12px;
        font-weight: 500;
      }
      .dot {
        width: 10px;
        height: 10px;
        border-radius: 999px;
        background: var(--green);
      }
      .dot.blue {
        background: var(--blue);
      }
      .dot.green {
        background: #10b981;
      }
      .dot.red {
        background: var(--red);
      }

      .metricValue {
        font-size: 28px;
        font-weight: 700;
        margin: 0;
      }
      .metricNote {
        margin: 6px 0 0;
        font-size: 12px;
        color: #168a4f;
        font-weight: 600;
      }
      .metricNote.muted {
        color: var(--muted);
        font-weight: 500;
      }

      @media (min-width: 900px) {
        .metric {
          grid-column: span 3;
        }
      }

      .tabs {
        display: flex;
        gap: 8px;
        padding: 8px;
        background: white;
        border: 1px solid var(--border);
        border-radius: 14px;
        box-shadow: var(--shadow);
        margin-bottom: 14px;
        width: fit-content;
      }
      .tabBtn {
        border: 0;
        background: transparent;
        padding: 10px 12px;
        border-radius: 12px;
        font-weight: 600;
        color: var(--muted);
        cursor: pointer;
      }
      .tabBtn.active {
        background: rgba(180, 197, 155, 0.22);
        color: var(--text);
      }

      /* ✅ IMPORTANT: keep your animation classes,
         BUT don't leave charts stuck at 0-size. We'll resize charts on tab change (JS). */
      .panel {
        display: none;
        opacity: 0;
        transform: translateY(6px);
      }

      .panel.active {
        display: block;
      }

      .panel.is-animating-in {
        opacity: 1;
        transform: translateY(0);
        transition: opacity 280ms cubic-bezier(0.2, 0.8, 0.2, 1),
          transform 280ms cubic-bezier(0.2, 0.8, 0.2, 1);
      }

      .panel.is-animating-out {
        opacity: 0;
        transform: translateY(8px);
        transition: opacity 200ms ease, transform 200ms ease;
      }

      .panelCard {
        padding: 18px;
        margin-bottom: 16px;
      }
      .panelTitle {
        margin: 0 0 12px;
        font-size: 18px;
        font-weight: 700;
      }

      .twoCol {
        display: grid;
        grid-template-columns: 1fr;
        gap: 16px;
      }
      @media (min-width: 900px) {
        .twoCol {
          grid-template-columns: 1fr 1fr;
        }
      }

      .listItem {
        display: flex;
        align-items: flex-start;
        justify-content: space-between;
        gap: 12px;
        padding: 12px;
        border-radius: 14px;
        background: #f5f5f5;
        border: 1px solid var(--border);
        margin-bottom: 10px;
      }
      .badge {
        display: inline-flex;
        align-items: center;
        gap: 8px;
        padding: 6px 10px;
        border-radius: 999px;
        border: 1px solid rgba(239, 68, 68, 0.35);
        color: #b91c1c;
        font-weight: 700;
        font-size: 12px;
        background: rgba(239, 68, 68, 0.06);
      }
      .small {
        font-size: 12px;
        color: var(--muted);
        margin-top: 6px;
      }
      .actions {
        display: flex;
        gap: 8px;
        flex-wrap: wrap;
        margin-top: 10px;
      }
      .btn {
        border: 1px solid var(--border);
        background: white;
        padding: 9px 12px;
        border-radius: 12px;
        cursor: pointer;
        font-weight: 700;
        font-size: 12px;
        color: var(--text);
      }
      .btn.danger {
        border-color: rgba(239, 68, 68, 0.4);
        color: #b91c1c;
        background: rgba(239, 68, 68, 0.06);
      }
      .btn:hover {
        filter: brightness(0.98);
      }
      .empty {
        text-align: center;
        padding: 28px 10px;
        color: var(--muted);
      }

      /* ✅ FIX GRAPH pecah: set height on parent, NOT canvas */
      .chartBox {
        position: relative;
        width: 100%;
        height: 420px;
      }
      .chartBox.small {
        height: 320px;
      }
      .chartBox canvas {
        width: 100% !important;
        height: 100% !important;
      }
    </style>
  </head>

  <body>
    <div class="wrap">
      <div class="hero">
        <h1>Analytics Dashboard</h1>
        <p>Monitor platform engagement and wellbeing metrics</p>
      </div>

      <!-- Key Metrics -->
      <div class="grid">
        <div class="card metric">
          <div class="metricTop">
            <span class="dot"></span>
            <span>Weekly Active Users</span>
          </div>
          <p class="metricValue">342</p>
          <p class="metricNote">↑ 12% from last week</p>
        </div>

        <div class="card metric blue">
          <div class="metricTop">
            <span class="dot blue"></span>
            <span>Total Sessions</span>
          </div>
          <p class="metricValue">2,785</p>
          <p class="metricNote">↑ 8% from last week</p>
        </div>

        <div class="card metric green">
          <div class="metricTop">
            <span class="dot green"></span>
            <span>Counseling Bookings</span>
          </div>
          <p class="metricValue">67</p>
          <p class="metricNote">↑ 15% from last week</p>
        </div>

        <div class="card metric red">
          <div class="metricTop">
            <span class="dot red"></span>
            <span>Pending Reports</span>
          </div>
          <p class="metricValue">${pendingReports}</p>
          <p class="metricNote muted">Requires attention</p>
        </div>
      </div>

      <!-- Tabs -->
      <div class="tabs">
        <button class="tabBtn active" data-tab="engagement">Engagement</button>
        <button class="tabBtn" data-tab="modules">Module Usage</button>
        <button class="tabBtn" data-tab="resources">Top Resources</button>
        <button class="tabBtn" data-tab="moderation">Moderation</button>
      </div>

      <!-- Engagement -->
      <div class="panel active" id="tab-engagement">
        <div class="card panelCard">
          <h3 class="panelTitle">User Engagement Trend</h3>
          <div class="chartBox">
            <canvas id="lineChart"></canvas>
          </div>
        </div>
      </div>

      <!-- Modules -->
      <div class="panel" id="tab-modules">
        <div class="twoCol">
          <div class="card panelCard">
            <h3 class="panelTitle">Usage by Module</h3>
            <div class="chartBox small">
              <canvas id="pieChart"></canvas>
            </div>
          </div>

          <div class="card panelCard">
            <h3 class="panelTitle">Completion Rates</h3>
            <div class="chartBox small">
              <canvas id="barChart"></canvas>
            </div>
          </div>
        </div>
      </div>

      <!-- Resources -->
      <div class="panel" id="tab-resources">
        <div class="card panelCard">
          <h3 class="panelTitle">Most Viewed Resources</h3>

          <div class="listItem">
            <div>
              <strong>Understanding Anxiety</strong>
              <div class="small">234 views</div>
            </div>
          </div>

          <div class="listItem">
            <div>
              <strong>Sleep Hygiene Tips</strong>
              <div class="small">198 views</div>
            </div>
          </div>

          <div class="listItem">
            <div>
              <strong>Managing Stress</strong>
              <div class="small">187 views</div>
            </div>
          </div>

          <div class="listItem">
            <div>
              <strong>Mindfulness Guide</strong>
              <div class="small">165 views</div>
            </div>
          </div>
        </div>
      </div>

      <!-- Moderation -->
      <div class="panel" id="tab-moderation">
        <div class="card panelCard">
          <h3 class="panelTitle">Reported Posts Queue</h3>

          <c:choose>
            <c:when test="${empty reportedPosts}">
              <div class="empty">No pending reports</div>
            </c:when>
            <c:otherwise>
              <c:set var="hasPending" value="false" />
              <c:forEach var="p" items="${reportedPosts}">
                <c:if test="${p.status eq 'pending'}">
                  <c:set var="hasPending" value="true" />
                  <div class="listItem" data-post-id="${p.id}">
                    <div style="flex: 1">
                      <span class="badge">${p.reason}</span>
                      <div class="small">
                        <fmt:formatDate
                          value="${p.date}"
                          pattern="MMM d, hh:mm a"
                        />
                      </div>
                      <div style="margin-top: 10px; color: #3d3a37">
                        ${p.content}
                      </div>
                      <div class="small">
                        Posted by: ${p.author} • Reported by: ${p.reportedBy}
                      </div>

                      <div class="actions">
                        <button
                          class="btn"
                          onclick="moderate('${p.id}','hide')"
                        >
                          Hide
                        </button>
                        <button
                          class="btn danger"
                          onclick="moderate('${p.id}','remove')"
                        >
                          Remove
                        </button>
                        <button
                          class="btn"
                          onclick="moderate('${p.id}','approve')"
                        >
                          Approve
                        </button>
                      </div>
                    </div>
                  </div>
                </c:if>
              </c:forEach>

              <c:if test="${hasPending eq false}">
                <div class="empty">No pending reports</div>
              </c:if>
            </c:otherwise>
          </c:choose>
        </div>

        <div class="card panelCard" id="resolvedCard" style="display: none">
          <h3 class="panelTitle">Resolved Reports</h3>
          <div id="resolvedList"></div>
        </div>
      </div>
    </div>

    <script>
      // ===== Chart instances (global) =====
      let lineChartInstance = null;
      let pieChartInstance = null;
      let barChartInstance = null;

      // ✅ helper: resize charts after tab becomes visible (fix Chart.js weird render)
      function resizeAllCharts() {
        if (lineChartInstance) lineChartInstance.resize();
        if (pieChartInstance) pieChartInstance.resize();
        if (barChartInstance) barChartInstance.resize();
      }

      // Tabs (animated + chart-safe)
      (function () {
        const btns = document.querySelectorAll(".tabBtn");

        function showPanel(tab) {
          const next = document.getElementById("tab-" + tab);
          const current = document.querySelector(".panel.active");

          if (current === next) return;

          // animate out current
          if (current) {
            current.classList.remove("is-animating-in");
            current.classList.add("is-animating-out");

            setTimeout(() => {
              current.classList.remove("active", "is-animating-out");
              current.style.display = "none";
            }, 200);
          }

          // animate in next
          next.style.display = "block";
          next.classList.add("active");
          next.classList.remove("is-animating-out");

          // force reflow so transition kicks in
          void next.offsetWidth;
          next.classList.add("is-animating-in");

          // ✅ IMPORTANT: chart resize after it becomes visible + after animation settles
          requestAnimationFrame(() => {
            resizeAllCharts();
            setTimeout(resizeAllCharts, 320);
          });
        }

        btns.forEach((btn) => {
          btn.addEventListener("click", () => {
            btns.forEach((b) => b.classList.remove("active"));
            btn.classList.add("active");
            showPanel(btn.getAttribute("data-tab"));
          });
        });

        // initial panel animate in
        const first = document.querySelector(".panel.active");
        if (first) {
          first.style.display = "block";
          void first.offsetWidth;
          first.classList.add("is-animating-in");
        }
      })();

      // ===== Data =====
      const engagementData = [
        { date: "11/1", users: 245, sessions: 380 },
        { date: "11/2", users: 268, sessions: 420 },
        { date: "11/3", users: 290, sessions: 450 },
        { date: "11/4", users: 310, sessions: 485 },
        { date: "11/5", users: 325, sessions: 510 },
        { date: "11/6", users: 342, sessions: 540 },
      ];

      const moduleUsageData = [
        { name: "Self-Help", value: 450 },
        { name: "Resources", value: 380 },
        { name: "Forum", value: 290 },
        { name: "Progress", value: 420 },
        { name: "Counseling", value: 180 },
        { name: "Chatbot", value: 520 },
      ];

      // ✅ Completion Rates should be % (0–100), not same as usage counts
      const completionRatesData = [
        { name: "Self-Help", value: 78 },
        { name: "Resources", value: 64 },
        { name: "Forum", value: 58 },
        { name: "Progress", value: 71 },
        { name: "Counseling", value: 49 },
        { name: "Chatbot", value: 83 },
      ];

      const COLORS = [
        "#B4C59B",
        "#3b82f6",
        "#10b981",
        "#f59e0b",
        "#ef4444",
        "#8b5cf6",
      ];

      // ===== Chart.js defaults (smoother animation) =====
      Chart.defaults.animation.duration = 520;
      Chart.defaults.animation.easing = "easeOutQuart";
      Chart.defaults.plugins.legend.labels.usePointStyle = true;

      // Line chart (✅ stable sizing)
      lineChartInstance = new Chart(document.getElementById("lineChart"), {
        type: "line",
        data: {
          labels: engagementData.map((d) => d.date),
          datasets: [
            {
              label: "Active Users",
              data: engagementData.map((d) => d.users),
              borderColor: "#B4C59B",
              backgroundColor: "rgba(180,197,155,0.18)",
              tension: 0.35,
              borderWidth: 3,
              pointRadius: 3,
            },
            {
              label: "Sessions",
              data: engagementData.map((d) => d.sessions),
              borderColor: "#3b82f6",
              backgroundColor: "rgba(59,130,246,0.12)",
              tension: 0.35,
              borderWidth: 3,
              pointRadius: 3,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: {
            legend: { display: true },
            tooltip: { enabled: true },
          },
          scales: {
            x: { grid: { color: "rgba(0,0,0,0.05)" } },
            y: { grid: { color: "rgba(0,0,0,0.05)" } },
          },
        },
      });

      // Pie chart (✅ better legend spacing so it doesn't look stupid)
      pieChartInstance = new Chart(document.getElementById("pieChart"), {
        type: "doughnut",
        data: {
          labels: moduleUsageData.map((d) => d.name),
          datasets: [
            {
              data: moduleUsageData.map((d) => d.value),
              backgroundColor: COLORS,
              borderWidth: 0,
              hoverOffset: 6,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          cutout: "62%",
          plugins: {
            legend: {
              position: "bottom",
              labels: {
                boxWidth: 10,
                padding: 14,
              },
            },
            tooltip: { enabled: true },
          },
        },
      });

      // Bar chart (✅ now it shows % completion, looks logical)
      barChartInstance = new Chart(document.getElementById("barChart"), {
        type: "bar",
        data: {
          labels: completionRatesData.map((d) => d.name),
          datasets: [
            {
              label: "Completion %",
              data: completionRatesData.map((d) => d.value),
              backgroundColor: "#B4C59B",
              borderRadius: 10,
              maxBarThickness: 44,
            },
          ],
        },
        options: {
          responsive: true,
          maintainAspectRatio: false,
          plugins: { legend: { display: false } },
          scales: {
            x: { ticks: { maxRotation: 0, minRotation: 0 } },
            y: {
              beginAtZero: true,
              suggestedMax: 100,
              ticks: {
                callback: (v) => v + "%",
              },
              grid: { color: "rgba(0,0,0,0.05)" },
            },
          },
        },
      });

      // ✅ once at start (in case browser loads fonts late)
      setTimeout(resizeAllCharts, 250);

      // Moderation (front-end only)
      function moderate(id, action) {
        const card = document.querySelector('[data-post-id="' + id + '"]');
        if (!card) return;

        card.remove();

        const resolvedCard = document.getElementById("resolvedCard");
        const resolvedList = document.getElementById("resolvedList");
        resolvedCard.style.display = "block";

        const item = document.createElement("div");
        item.className = "listItem";
        item.style.background = "rgba(16,185,129,0.10)";
        item.innerHTML =
          '<div style="flex:1"><strong>Post ' +
          id +
          '</strong><div class="small">Resolved (' +
          action +
          ")</div></div>";
        resolvedList.appendChild(item);
      }
      window.moderate = moderate;
    </script>
  </body>
</html>
