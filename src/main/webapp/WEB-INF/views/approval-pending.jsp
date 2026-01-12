<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Waiting for Approval | MindReach</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <%@ include file="layout/css-include.jsp" %>
            <script src="https://unpkg.com/lucide@latest"></script>
    </head>

    <body class="bg-[#F7F3EF] min-h-screen flex items-center justify-center p-4">

        <div class="bg-white p-8 rounded-2xl shadow-lg max-w-md w-full text-center">
            <div
                class="w-16 h-16 bg-yellow-100 rounded-full flex items-center justify-center mx-auto mb-6 text-yellow-600">
                <i data-lucide="clock" class="w-8 h-8"></i>
            </div>

            <h1 class="text-2xl font-serif text-[#3D3A37] mb-2">Account Pending Approval</h1>
            <p class="text-gray-600 mb-6">
                Thank you for registering as a Mental Health Professional.
                Your account is currently under review by our administrators.
            </p>

            <div class="bg-gray-50 p-4 rounded-xl border border-gray-200 mb-6 text-sm text-left">
                <p class="font-medium text-gray-800 mb-1">What happens next?</p>
                <ul class="list-disc list-inside text-gray-600 space-y-1">
                    <li>Admins will verify your credentials.</li>
                    <li>You will gain access once approved.</li>
                    <li>This process usually takes 24-48 hours.</li>
                </ul>
            </div>

            <p class="text-sm text-gray-500 mb-6">
                For urgent inquiries, please contact: <br>
                <a href="mailto:admin1@gmail.com"
                    class="text-[#B4C59B] hover:underline font-medium">admin1@gmail.com</a>
            </p>

            <a href="${pageContext.request.contextPath}/login"
                class="inline-block w-full py-3 px-4 bg-[#B4C59B] text-[#3D3A37] font-medium rounded-xl hover:bg-[#9AAF86] transition-colors">
                Back to Login
            </a>
        </div>

        <script>
            lucide.createIcons();
        </script>
    </body>

    </html>