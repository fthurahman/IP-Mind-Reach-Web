<style>
    /* Fonts */
    @import url('https://fonts.googleapis.com/css2?family=DM+Serif+Display:ital@0;1&family=Work+Sans:ital,wght@0,100..900;1,100..900&display=swap');

    :root {
        /* Colors from global.css */
        --font-family-serif: 'DM Serif Display', serif;
        --font-family-sans: 'Work Sans', sans-serif;

        --background: #F7F3EF;
        --foreground: #3D3A37;
        --card: #FFFFFF;
        --card-foreground: #5A5653;
        --primary: #B4C59B;
        /* Muted Olive */
        --primary-hover: #9AAF86;
        --primary-foreground: #3D3A37;
        --secondary: #D8A79E;
        /* Clay Blush */
        --muted-foreground: #8C8784;
        --border: #E9E4DF;
        --error-bg: rgba(216, 167, 158, 0.2);
        --error-text: #3D3A37;
        --error-border: rgba(216, 167, 158, 0.3);

        --radius-xl: 0.75rem;
        /* rounded-xl */
        --radius-3xl: 1.5rem;
        /* rounded-3xl */
    }

    body {
        margin: 0;
        padding: 0;
        font-family: var(--font-family-sans);
        background-color: var(--background);
        color: var(--foreground);
        min-height: 100vh;
        display: block;
    }

    /* Auth Page Centering (Login/Register) */
    .auth-page {
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
        overflow: hidden;
    }

    /* Background Image Layer */
    .login-bg {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-image: url('https://images.unsplash.com/photo-1710685375110-3b1f3bf8bb1a?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwZWFjZWZ1bCUyMG5hdHVyZSUyMGJhY2tncm91bmR8ZW58MXx8fHwxNzYyNTA5MDQ4fDA&ixlib=rb-4.1.0&q=80&w=1080');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
        z-index: -1;
    }

    .login-overlay {
        position: absolute;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.4);
        z-index: 0;
    }

    /* Card Container */
    .login-card {
        background: var(--card);
        width: 100%;
        max-width: 28rem;
        /* max-w-md */
        padding: 2rem;
        border-radius: var(--radius-3xl);
        box-shadow: 0 4px 20px rgba(180, 197, 155, 0.15);
        border: 1px solid var(--border);
        position: relative;
        z-index: 10;
        box-sizing: border-box;
    }

    /* Typography */
    h1.brand-title {
        font-family: var(--font-family-serif);
        font-size: 2rem;
        text-align: center;
        margin: 0 0 0.5rem 0;
        color: #3D3A37;
    }

    p.subtitle {
        text-align: center;
        color: var(--muted-foreground);
        margin: 0 0 1.5rem 0;
        font-size: 1rem;
    }

    /* Forms */
    .form-group {
        margin-bottom: 1rem;
    }

    label {
        display: block;
        font-size: 0.875rem;
        /* text-sm */
        font-weight: 500;
        margin-bottom: 0.5rem;
        color: var(--foreground);
    }

    .input-wrapper {
        position: relative;
    }

    input[type="text"],
    input[type="email"],
    input[type="password"] {
        width: 100%;
        padding: 0.75rem 1rem;
        border-radius: var(--radius-xl);
        border: 1px solid var(--border);
        font-family: var(--font-family-sans);
        font-size: 0.875rem;
        background: #fff;
        box-sizing: border-box;
        /* Crucial for width: 100% */
    }

    input:focus {
        outline: 2px solid var(--primary);
        outline-offset: 2px;
        border-color: var(--primary);
    }

    /* Links and Buttons */
    .password-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-bottom: 0.5rem;
    }

    .forgot-link {
        font-size: 0.75rem;
        /* text-xs */
        color: var(--primary);
        text-decoration: none;
        background: none;
        border: none;
        cursor: pointer;
        padding: 0;
    }

    .forgot-link:hover {
        color: var(--primary-hover);
    }

    .btn-primary {
        width: 100%;
        padding: 0.75rem;
        border-radius: var(--radius-xl);
        background-color: var(--primary);
        color: var(--primary-foreground);
        font-weight: 500;
        font-size: 0.875rem;
        border: none;
        cursor: pointer;
        box-shadow: 0 4px 12px rgba(180, 197, 155, 0.25);
        transition: background-color 0.2s;
    }

    .btn-primary:hover {
        background-color: var(--primary-hover);
    }

    .error-alert {
        background-color: var(--error-bg);
        color: var(--error-text);
        padding: 0.75rem;
        border-radius: var(--radius-xl);
        font-size: 0.875rem;
        border: 1px solid var(--error-border);
        margin-bottom: 1rem;
    }

    /* Footer */
    .footer-text {
        text-align: center;
        font-size: 0.875rem;
        color: var(--muted-foreground);
        margin-top: 1.5rem;
    }

    .create-account-link {
        color: var(--foreground);
        text-decoration: none;
        background: none;
        border: none;
        cursor: pointer;
        font-weight: 500;
        padding: 0;
    }

    .create-account-link:hover {
        color: var(--primary);
    }

    .demo-accounts {
        margin-top: 1rem;
        padding-top: 1rem;
        border-top: 1px solid var(--border);
        font-size: 0.75rem;
        color: var(--muted-foreground);
        text-align: center;
        line-height: 1.5;
    }

    .demo-accounts p {
        margin: 0;
    }

    /* Modal/Dialog */
    .dialog-backdrop {
        display: none;
        /* Hidden by default */
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.5);
        z-index: 50;
        justify-content: center;
        align-items: center;
        opacity: 0;
        transition: opacity 0.2s ease-in-out;
    }

    .dialog-backdrop.open {
        display: flex;
        opacity: 1;
    }

    .dialog-content {
        background: white;
        width: 90%;
        max-width: 425px;
        padding: 1.5rem;
        border-radius: 1rem;
        /* rounded-2xl */
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        transform: scale(0.95);
        transition: transform 0.2s ease;
    }

    .dialog-backdrop.open .dialog-content {
        transform: scale(1);
    }

    .dialog-icon {
        width: 3rem;
        height: 3rem;
        background: rgba(180, 197, 155, 0.2);
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        margin: 0 auto 1rem auto;
        color: var(--primary);
    }

    .dialog-title {
        text-align: center;
        font-family: var(--font-family-serif);
        font-size: 1.25rem;
        margin: 0 0 0.5rem 0;
    }

    .dialog-description {
        text-align: center;
        color: var(--card-foreground);
        font-size: 0.875rem;
        margin-bottom: 1.5rem;
    }

    .dialog-actions {
        display: flex;
        gap: 0.5rem;
        margin-top: 1.5rem;
    }

    .btn-outline {
        flex: 1;
        padding: 0.75rem;
        border-radius: var(--radius-xl);
        border: 1px solid var(--border);
        background: white;
        cursor: pointer;
        font-weight: 500;
    }

    .btn-outline:hover {
        background: #f9f9f9;
    }

    /* ===== Dashboard Layout ===== */

    /* Navigation Bar */
    .header {
        background-color: white;
        border-bottom: 1px solid #E9E4DF;
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        z-index: 50;
        height: 72px;
        display: flex;
        justify-content: center;
    }

    .header-container {
        width: 100%;
        max-width: 1200px;
        padding: 0 2rem;
        display: flex;
        align-items: center;
        justify-content: space-between;
        height: 100%;
    }

    .logo-btn {
        background: none;
        border: none;
        cursor: pointer;
        padding: 0;
        font-family: 'DM Serif Display', serif;
        font-size: 1.5rem;
        color: #3D3A37;
        text-decoration: none;
        display: flex;
        align-items: center;
    }

    .logo-btn:hover {
        opacity: 0.8;
    }

    /* Desktop Navigation */
    .nav-desktop {
        display: none;
        /* Mobile first */
    }

    @media (min-width: 1024px) {
        .nav-desktop {
            display: flex;
            align-items: center;
            gap: 2rem;
        }
    }

    .nav-item {
        position: relative;
        padding-bottom: 0.25rem;
        font-size: 0.875rem;
        color: #3D3A37;
        text-decoration: none;
        transition: all 0.2s;
        background: none;
        border: none;
        cursor: pointer;
    }

    .nav-item:hover {
        color: #2D2A28;
    }

    .nav-item.active {
        color: #2D2A28;
        font-weight: 600;
    }

    .nav-item.active::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        right: 0;
        height: 2px;
        background-color: #B4C59B;
    }

    /* User Section */
    .user-section-desktop {
        display: none;
    }

    @media (min-width: 1024px) {
        .user-section-desktop {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }
    }

    .avatar-circle {
        width: 2.5rem;
        height: 2.5rem;
        border-radius: 50%;
        background-color: rgba(180, 197, 155, 0.2);
        display: flex;
        align-items: center;
        justify-content: center;
        color: #B4C59B;
    }

    .user-info {
        text-align: left;
    }

    .user-name {
        font-size: 0.875rem;
        color: #3D3A37;
        margin: 0;
        font-weight: 500;
    }

    .user-role {
        font-size: 0.75rem;
        color: #8C8784;
        margin: 0;
        text-transform: capitalize;
    }

    .btn-ghost {
        background: transparent;
        border: none;
        color: #5A5653;
        font-size: 0.875rem;
        cursor: pointer;
        display: flex;
        align-items: center;
        padding: 0.5rem;
        border-radius: 0.375rem;
        transition: background-color 0.2s;
        text-decoration: none;
        /* Ensure link looks like button */
    }

    .btn-ghost:hover {
        background-color: #F7F3EF;
        color: #3D3A37;
    }

    /* Mobile Menu Button */
    .mobile-menu-btn {
        display: flex;
        align-items: center;
        justify-content: center;
        background: transparent;
        border: none;
        padding: 0.5rem;
        color: #3D3A37;
        cursor: pointer;
    }

    @media (min-width: 1024px) {
        .mobile-menu-btn {
            display: none;
        }
    }

    /* Mobile Sheet/Drawer */
    .sheet-overlay {
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: rgba(0, 0, 0, 0.4);
        z-index: 100;
        display: none;
        opacity: 0;
        transition: opacity 0.3s;
    }

    .sheet-overlay.open {
        display: block;
        opacity: 1;
    }

    .sheet-content {
        position: fixed;
        top: 0;
        right: 0;
        bottom: 0;
        width: 16rem;
        /* w-64 */
        background-color: white;
        z-index: 101;
        transform: translateX(100%);
        transition: transform 0.3s ease-in-out;
        padding: 1.5rem;
        box-shadow: -4px 0 15px rgba(0, 0, 0, 0.1);
        display: flex;
        flex-direction: column;
    }

    .sheet-overlay.open .sheet-content {
        transform: translateX(0);
    }

    .mobile-nav {
        display: flex;
        flex-direction: column;
        gap: 0.25rem;
        margin-top: 2rem;
    }

    .mobile-nav-item {
        text-align: left;
        padding: 0.75rem 1rem;
        border-radius: 0.5rem;
        font-size: 0.875rem;
        color: #3D3A37;
        text-decoration: none;
        transition: all 0.2s;
    }

    .mobile-nav-item:hover {
        background-color: #F7F3EF;
    }

    .mobile-nav-item.active {
        background-color: #F7F3EF;
        color: #2D2A28;
        font-weight: 600;
    }

    .mobile-separator {
        height: 1px;
        background-color: #E9E4DF;
        margin: 1rem 0;
    }

    /* Main Content Padding Adjustment */
    main.dashboard-content {
        padding-top: 96px;
        /* 72px header + spacing */
        padding-left: 1.5rem;
        padding-right: 1.5rem;
        padding-bottom: 3rem;
        max-width: 1200px;
        margin: 0 auto;
    }

    /* ===== Forum Module Styles ===== */

    .bg-gradient-forum {
        background: linear-gradient(to right, #B4C59B, #CADBB7);
    }

    .badge {
        display: inline-flex;
        align-items: center;
        padding: 0.25rem 0.75rem;
        border-radius: 9999px;
        /* rounded-full */
        font-size: 0.75rem;
        font-weight: 500;
        line-height: 1;
        text-transform: capitalize;
    }

    .badge-topic {
        background-color: rgba(180, 197, 155, 0.2);
        color: #3D3A37;
        border: 1px solid rgba(180, 197, 155, 0.3);
    }

    .badge-reported {
        background-color: #FEF2F2;
        /* red-50 */
        color: #DC2626;
        /* red-600 */
        border: 1px solid #FECACA;
        /* red-300 */
    }

    .badge-yours {
        background-color: rgba(180, 197, 155, 0.1);
        color: #B4C59B;
        border: 1px solid rgba(180, 197, 155, 0.3);
    }

    .post-card {
        background: white;
        padding: 1.5rem;
        border-radius: 1rem;
        /* rounded-2xl */
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
        /* shadow-lg */
        border: none;
        transition: transform 0.2s, box-shadow 0.2s;
        cursor: pointer;
        text-decoration: none;
        /* For wrapping anchor */
        display: block;
        margin-bottom: 1rem;
    }

    .post-card:hover {
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        /* shadow-xl */
    }

    .avatar-small {
        width: 2rem;
        /* 8 * 0.25rem = 2rem approx for size 16 icon context? No, generally w-8 h-8 */
        height: 2rem;
        border-radius: 50%;
        background-color: #f3f4f6;
        display: flex;
        align-items: center;
        justify-content: center;
        color: #9ca3af;
    }

    .hero-card {
        border-radius: 1rem;
        /* rounded-2xl */
        padding: 2rem;
        box-shadow: 0 4px 20px rgba(180, 197, 155, 0.15);
        margin-bottom: 1.5rem;
        /* Gradient applied via utility class */
    }

    .action-btn-ghost {
        background: transparent;
        border: none;
        color: #6B7280;
        /* gray-500 */
        padding: 0.5rem;
        border-radius: 0.75rem;
        /* rounded-xl */
        cursor: pointer;
        display: flex;
        align-items: center;
        gap: 0.5rem;
        transition: background 0.2s;
    }

    .action-btn-ghost:hover {
        background-color: #F3F4F6;
        /* gray-50 */
        color: #374151;
        /* gray-700 */
    }

    .action-btn-ghost.reported {
        color: #DC2626;
        /* red-600 */
    }

    .action-btn-ghost.reported:hover {
        background-color: #FEF2F2;
        /* red-50 */
        color: #B91C1C;
        /* red-700 */
    }

    /* Toast Notifications */
    .toast-container {
        position: fixed;
        bottom: 2rem;
        left: 50%;
        transform: translateX(-50%);
        z-index: 1000;
        display: flex;
        flex-direction: column;
        gap: 0.75rem;
        pointer-events: none;
    }

    .toast {
        background-color: #3D3A37;
        color: white;
        padding: 0.75rem 1.5rem;
        border-radius: 9999px;
        font-size: 0.875rem;
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
        display: flex;
        align-items: center;
        gap: 0.5rem;
        opacity: 0;
        transform: translateY(1rem);
        transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        pointer-events: auto;
    }

    .toast.show {
        opacity: 1;
        transform: translateY(0);
    }

    .toast-success {
        border-left: 4px solid #B4C59B;
    }

    .toast-info {
        border-left: 4px solid #CADBB7;
    }
</style>


<script>
    // Create Toast Container dynamically if it doesn't exist
    function ensureToastContainer() {
        if (!document.getElementById('toastContainer')) {
            const container = document.createElement('div');
            container.id = 'toastContainer';
            container.className = 'toast-container';
            document.body.appendChild(container); // Append to body, not head
        }
    }

    function showToast(message, type) {
        if (!type) type = 'success';

        ensureToastContainer();
        const container = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        // Fix for JSP EL collision
        toast.className = 'toast toast-' + type;

        let icon = '';
        if (type === 'success') {
            icon = '<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="color: #65a30d;"><polyline points="20 6 9 17 4 12"/></svg>';
        } else {
            icon = '<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="color: #0284c7;"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>';
        }

        // Fix for JSP EL collision
        toast.innerHTML = '<div style="display:flex; align-items:center; gap:0.75rem;">' + icon + ' <span style="font-weight:500;">' + message + '</span></div>';
        container.appendChild(toast);

        // Trigger animation
        setTimeout(function () { toast.classList.add('show'); }, 10);

        // Remove after 3.5 seconds
        setTimeout(function () {
            toast.classList.remove('show');
            setTimeout(function () { toast.remove(); }, 400);
        }, 3500);
    }

    // Auto-trigger toasts based on URL status parameter
    (function () {
        function triggerToast() {
            try {
                // Ensure container exists before trying to show
                if (document.body) {
                    ensureToastContainer();
                }

                const urlParams = new URLSearchParams(window.location.search);
                const status = urlParams.get('status');

                if (!status) return;

                console.log('Toast system initialized. Status param:', status);

                const statusMessages = {
                    'created': 'Post shared successfully!',
                    'commented': 'Comment added successfully!',
                    'reported': 'Post reported for review. Thank you!',
                    'unreported': 'Report withdrawn. Post reset to normal.',
                    'warned': 'Friendly reminder sent to user.'
                };

                if (statusMessages[status]) {
                    const isInfo = (status === 'reported' || status === 'unreported');

                    // Delay slightly to ensure DOM is ready if called early
                    setTimeout(() => {
                        showToast(statusMessages[status], isInfo ? 'info' : 'success');
                    }, 100);

                    // Clean up URL without reload
                    try {
                        const url = new URL(window.location.href);
                        url.searchParams.delete('status');
                        window.history.replaceState({}, document.title, url.pathname + url.search);
                    } catch (e) {
                        console.warn('Could not clean URL:', e);
                    }
                }
            } catch (error) {
                console.error('Toast trigger error:', error);
            }
        }

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', triggerToast);
        } else {
            // DOM already loaded
            triggerToast();
        }
    })();
</script>