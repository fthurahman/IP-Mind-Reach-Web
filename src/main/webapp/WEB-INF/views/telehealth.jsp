<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
      <!DOCTYPE html>
      <html lang="en">

      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>MindReach - Telehealth Assistance</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css" />
        <style>
          /* Override global body styles from style.css that lock scrolling */
          body {
            display: block !important;
            overflow-y: auto !important;
            height: auto !important;
          }

          .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
          }

          .modal.show {
            display: flex;
            align-items: center;
            justify-content: center;
          }

          .modal-content {
            background-color: white;
            border-radius: 1rem;
            max-width: 90%;
            max-height: 90vh;
            overflow-y: auto;
          }

          .time-slot {
            transition: all 0.3s ease;
          }

          .time-slot:hover {
            border-color: #B4C59B;
          }

          .time-slot.selected {
            border-color: #B4C59B;
            background-color: rgba(180, 197, 155, 0.1);
          }

          .counselor-card {
            transition: all 0.3s ease;
          }

          .counselor-card:hover {
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
          }
        </style>
      </head>

      <body class="bg-gray-50 min-h-screen">
        <!-- Top Navigation Bar -->
        <jsp:include page="layout/header.jsp">
          <jsp:param name="activePage" value="telehealth" />
        </jsp:include>

        <main class="dashboard-content">
          <c:choose>
            <c:when test="${showHistory}">
              <!-- Past Sessions Content -->
              <div class="w-full">
                <div class="mb-6">
                  <h1 class="text-3xl font-serif text-[#3D3A37] mb-2">Past Sessions</h1>
                  <p class="text-[#5A5653]">Review your completed counseling sessions</p>
                </div>

                <h2 class="text-xl font-medium text-[#3D3A37] mb-4">Past Sessions</h2>

                <div class="space-y-4 mb-6">
                  <c:set var="hasCompleted" value="false" />
                  <c:forEach var="appointment" items="${appointments}">
                    <c:if test="${appointment.status == 'completed'}">
                      <c:set var="hasCompleted" value="true" />
                      <div class="bg-white p-6 border-0 shadow-sm rounded-2xl">
                        <div class="flex items-start justify-between mb-6">
                          <div>
                            <p class="font-medium text-[#3D3A37] text-lg">${appointment.counselorName}</p>
                            <p class="text-sm text-[#5A5653]">
                              <fmt:parseDate value="${appointment.date}" pattern="yyyy-MM-dd" var="parsedDate" />
                              <fmt:formatDate value="${parsedDate}" pattern="EEEE, MMMM d, yyyy" /> at
                              ${appointment.time}
                            </p>
                          </div>
                          <span
                            class="border border-gray-200 text-gray-600 px-3 py-1 rounded-full text-xs font-medium">Completed</span>
                        </div>
                        <c:if test="${not empty appointment.summary}">
                          <div class="bg-[#F9FAFB] rounded-xl p-6 space-y-4">
                            <div>
                              <p class="text-sm text-[#5A5653] font-medium mb-1">Session Summary:</p>
                              <p class="text-sm text-[#3D3A37] leading-relaxed">${appointment.summary}</p>
                            </div>
                            <c:if test="${not empty appointment.recommendations}">
                              <div>
                                <p class="text-sm text-[#5A5653] font-medium mb-1">Recommendations:</p>
                                <p class="text-sm text-[#3D3A37] leading-relaxed">
                                  ${appointment.recommendations}</p>
                              </div>
                            </c:if>
                          </div>
                        </c:if>
                      </div>
                    </c:if>
                  </c:forEach>

                  <c:if test="${not hasCompleted}">
                    <div class="bg-white p-8 border-0 shadow-sm rounded-2xl text-center">
                      <div class="w-16 h-16 bg-[#F7F3EF] rounded-full flex items-center justify-center mx-auto mb-4">
                        <i class="fas fa-history text-[#B4C59B] text-2xl"></i>
                      </div>
                      <h3 class="text-lg font-medium text-[#3D3A37] mb-2">No Past Sessions</h3>
                      <p class="text-[#5A5653]">You haven't completed any telehealth sessions yet.</p>
                    </div>
                  </c:if>
                </div>

                <a href="<c:url value='/telehealth'/>"
                  class="block w-full py-3 px-4 rounded-xl bg-[#E5E7EB] hover:bg-gray-300 text-[#3D3A37] font-medium text-center transition-colors">
                  Book a New Session
                </a>
              </div>
            </c:when>
            <c:otherwise>
              <!-- Hero Header -->
              <div
                class="bg-gradient-to-r from-[#B4C59B] to-[#CADBB7] rounded-2xl p-8 shadow-[0_4px_20px_rgba(180,197,155,0.15)] mb-6">
                <h1 class="text-3xl text-white mb-2">Telehealth Assistance</h1>
                <p class="text-white/90">Connect with professional support providers</p>
              </div>

              <!-- Main Booking Content -->
              <div>
                <!-- Upcoming Appointments -->
                <c:set var="hasUpcoming" value="false" />
                <c:forEach var="appointment" items="${appointments}">
                  <c:if test="${appointment.status == 'upcoming'}">
                    <c:set var="hasUpcoming" value="true" />
                  </c:if>
                </c:forEach>

                <c:if test="${hasUpcoming}">
                  <div class="bg-gradient-to-r from-green-50 to-blue-50 p-6 border-0 shadow-lg rounded-2xl mb-6">
                    <h3 class="text-lg mb-4 flex items-center gap-2">
                      <i class="fas fa-calendar text-green-600" style="font-size: 20px;"></i>
                      Upcoming Appointments
                    </h3>
                    <div class="space-y-3">
                      <c:forEach var="appointment" items="${appointments}">
                        <c:if test="${appointment.status == 'upcoming'}">
                          <div class="bg-white rounded-xl p-4">
                            <div class="flex items-start justify-between">
                              <div>
                                <p class="font-medium">${appointment.counselorName}</p>
                                <p class="text-sm text-gray-600 mt-1">
                                  <fmt:parseDate value="${appointment.date}" pattern="yyyy-MM-dd" var="parsedDate" />
                                  <fmt:formatDate value="${parsedDate}" pattern="MMMM d, yyyy" /> at ${appointment.time}
                                </p>
                              </div>
                              <span class="bg-green-100 text-green-700 px-3 py-1 rounded-full text-sm">Confirmed</span>
                            </div>
                          </div>
                        </c:if>
                      </c:forEach>
                    </div>
                  </div>
                </c:if>

                <!-- Book a Session Section -->
                <div class="mb-6">
                  <h2 class="text-xl mb-4">Book a Session</h2>
                  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
                    <c:forEach var="counselor" items="${counselors}">
                      <div class="counselor-card bg-white p-6 border-0 shadow-lg rounded-2xl">
                        <div class="space-y-4">
                          <img src="${counselor.profileImage}" alt="${counselor.name}"
                            class="w-20 h-20 rounded-full object-cover border-2 border-[#B4C59B]/30 mx-auto"
                            onerror="this.src='https://via.placeholder.com/80x80/CCCCCC/FFFFFF?text=${counselor.name.charAt(0)}'">
                          <div class="text-center">
                            <h3 class="text-lg mb-1">${counselor.name}</h3>
                            <span
                              class="bg-[#B4C59B]/20 text-[#3D3A37] border border-[#B4C59B]/30 px-3 py-1 rounded-full text-sm mb-2 inline-block">
                              ${counselor.specialty}
                            </span>
                            <p class="text-sm text-gray-600">${counselor.bio}</p>
                          </div>
                          <button onclick="openBookingModal('${counselor.name}', '${counselor.id}')"
                            class="w-full py-2 px-4 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium">
                            View Available Times
                          </button>
                        </div>
                      </div>
                    </c:forEach>
                  </div>
                </div>

                <!-- View Past Sessions Button -->
                <a href="<c:url value='/telehealth/history'/>"
                  class="block w-full py-2 px-4 rounded-xl bg-gray-200 hover:bg-gray-300 text-gray-700 font-medium text-center">
                  View Past Sessions
                </a>
              </div>
            </c:otherwise>
          </c:choose>
        </main>

        <!-- Booking Modal -->
        <div id="bookingModal" class="modal">
          <div class="modal-content p-6 max-w-md w-full">
            <div class="flex justify-between items-center mb-4">
              <h2 class="text-xl font-bold" id="modalTitle">Book Appointment</h2>
              <button onclick="closeBookingModal()" class="text-gray-500 hover:text-gray-700">
                <i class="fas fa-times"></i>
              </button>
            </div>
            <p class="text-sm text-gray-600 mb-4">Select an available time slot for your session</p>

            <form id="bookingForm" action="<c:url value='/telehealth/book'/>" method="post">
              <input type="hidden" id="counselorId" name="counselorId">
              <input type="hidden" id="counselorName" name="counselorName">
              <input type="hidden" id="slotId" name="slotId">
              <input type="hidden" id="slotDate" name="slotDate">
              <input type="hidden" id="slotTime" name="slotTime">

              <div id="timeSlots" class="space-y-2 mb-4">
                <!-- Time slots will be populated here -->
              </div>

              <button type="submit" id="confirmBooking"
                class="w-full py-2 px-4 rounded-xl bg-[#B4C59B] hover:bg-[#9AAF86] text-white font-medium disabled:bg-gray-300 disabled:cursor-not-allowed"
                disabled>
                Confirm Booking
              </button>
            </form>
          </div>
        </div>

        <script id="counselorData" type="application/json">
          {
            <c:forEach var="counselor" items="${counselors}" varStatus="cLoop">
              "${counselor.id}": [
              <c:forEach var="slot" items="${counselor.availableSlots}" varStatus="sLoop">
                {
                "id": "${slot.id}",
                "date": "${slot.date}",
                "time": "${slot.time}",
                "available": ${slot.available}
                }<c:if test="${!sLoop.last}">,</c:if>
              </c:forEach>
              ]<c:if test="${!cLoop.last}">,</c:if>
            </c:forEach>
          }
        </script>
        <script>
          // Time slots data parsed from the JSON block
          const counselorTimeSlots = JSON.parse(document.getElementById('counselorData').textContent);

          let selectedCounselor = null;
          let selectedCounselorId = null;
          let selectedSlot = null;

          // Function to format date
          function formatDate(dateStr) {
            const date = new Date(dateStr);
            return date.toLocaleDateString("en-US", {
              weekday: "long",
              year: "numeric",
              month: "long",
              day: "numeric"
            });
          }

          // Open booking modal
          function openBookingModal(counselorName, counselorId) {
            selectedCounselor = counselorName;
            selectedCounselorId = counselorId;
            selectedSlot = null;

            document.getElementById('modalTitle').textContent = 'Book with ' + counselorName;
            document.getElementById('counselorId').value = counselorId;
            document.getElementById('counselorName').value = counselorName;

            // Populate time slots
            const timeSlotsContainer = document.getElementById('timeSlots');
            timeSlotsContainer.innerHTML = '';

            const slots = counselorTimeSlots[counselorId];
            for (let i = 0; i < slots.length; i++) {
              const slot = slots[i];
              const slotElement = document.createElement('button');
              slotElement.type = 'button';
              slotElement.className = 'time-slot w-full p-3 rounded-xl border-2 border-gray-200 text-left';
              slotElement.onclick = function () { selectTimeSlot(slot); };

              slotElement.innerHTML =
                '<div class="flex items-center gap-2">' +
                '<i class="fas fa-calendar text-gray-400" style="font-size: 16px;"></i>' +
                '<span class="text-sm">' + formatDate(slot.date) + '</span>' +
                '</div>' +
                '<div class="flex items-center gap-2 mt-1">' +
                '<i class="fas fa-clock text-gray-400" style="font-size: 16px;"></i>' +
                '<span class="text-sm">' + slot.time + '</span>' +
                '</div>';

              timeSlotsContainer.appendChild(slotElement);
            }

            document.getElementById('bookingModal').classList.add('show');
            document.getElementById('confirmBooking').disabled = true;
          }

          // Close booking modal
          function closeBookingModal() {
            document.getElementById('bookingModal').classList.remove('show');
            selectedCounselor = null;
            selectedCounselorId = null;
            selectedSlot = null;
          }

          // Select time slot
          function selectTimeSlot(slot) {
            selectedSlot = slot;

            // Update UI
            const timeSlots = document.querySelectorAll('.time-slot');
            for (let i = 0; i < timeSlots.length; i++) {
              timeSlots[i].classList.remove('selected');
            }
            event.target.closest('.time-slot').classList.add('selected');

            // Update form fields
            document.getElementById('slotId').value = slot.id;
            document.getElementById('slotDate').value = slot.date;
            document.getElementById('slotTime').value = slot.time;

            // Enable confirm button
            document.getElementById('confirmBooking').disabled = false;
          }

          // Confirm booking
          function confirmBooking() {
            if (selectedSlot) {
              alert('Appointment confirmed with ' + selectedCounselor + ' on ' + formatDate(selectedSlot.date) + ' at ' + selectedSlot.time);
              closeBookingModal();
            }
          }

          // Close modal when clicking outside
          window.onclick = function (event) {
            const modal = document.getElementById('bookingModal');
            if (event.target === modal) {
              closeBookingModal();
            }
          }
        </script>
      </body>

      </html>