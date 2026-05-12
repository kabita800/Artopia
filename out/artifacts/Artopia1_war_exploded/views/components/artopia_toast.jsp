<%--
  Shared toast popup + logout confirmation.
  Include once per page (typically after navbar or sidebar).
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.artopia1.utils.WebUtil" %>
<style id="artopia-toast-styles">
    .artopia-toast-host{
        position:fixed; z-index:100000;
        top:1.25rem; left:50%; transform:translateX(-50%);
        max-width:min(420px, calc(100vw - 2rem));
        pointer-events:none;
    }
    .artopia-toast{
        pointer-events:auto;
        padding:1rem 1.25rem;
        border-radius:10px;
        font-family:system-ui,-apple-system,Segoe UI,Roboto,sans-serif;
        font-size:14px;
        line-height:1.45;
        box-shadow:0 12px 40px rgba(0,0,0,.35);
        border:1px solid rgba(255,255,255,.12);
        animation:artopiaToastIn .35s ease;
        display:flex; align-items:flex-start; gap:.75rem;
    }
    .artopia-toast--ok{
        background:linear-gradient(145deg,#143524,#0d2818);
        color:#b8f0cd;
        border-color:rgba(80,200,120,.35);
    }
    .artopia-toast--err{
        background:linear-gradient(145deg,#351818,#281010);
        color:#f0c4c4;
        border-color:rgba(200,80,80,.4);
    }
    .artopia-toast__title{font-weight:700; font-size:12px; letter-spacing:.06em; text-transform:uppercase; opacity:.85; margin-bottom:.2rem;}
    .artopia-toast__x{
        margin-left:auto; background:transparent; border:none; color:inherit; opacity:.65;
        cursor:pointer; font-size:1.1rem; line-height:1; padding:0 .2rem;
    }
    .artopia-toast__x:hover{opacity:1}
    @keyframes artopiaToastIn{
        from{opacity:0; transform:translateY(-12px);}
        to{opacity:1; transform:translateY(0);}
    }
</style>
<script>
(function(){
    if (window.__artopiaToastBound) return;
    window.__artopiaToastBound = true;

    window.artopiaShowToast = function(message, success) {
        if (!message) return;
        var host = document.getElementById('artopia-toast-host');
        if (!host) {
            host = document.createElement('div');
            host.id = 'artopia-toast-host';
            host.className = 'artopia-toast-host';
            document.body.appendChild(host);
        }
        host.innerHTML = '';
        var el = document.createElement('div');
        el.className = 'artopia-toast artopia-toast--' + (success ? 'ok' : 'err');
        var title = document.createElement('div');
        var wrap = document.createElement('div');
        var t = document.createElement('div');
        t.className = 'artopia-toast__title';
        t.textContent = success ? 'Success' : 'Something went wrong';
        var body = document.createElement('div');
        body.textContent = message;
        wrap.appendChild(t);
        wrap.appendChild(body);
        var x = document.createElement('button');
        x.type = 'button';
        x.className = 'artopia-toast__x';
        x.setAttribute('aria-label','Dismiss');
        x.innerHTML = '&times;';
        x.onclick = function(){ host.innerHTML = ''; };
        el.appendChild(wrap);
        el.appendChild(x);
        host.appendChild(el);
        setTimeout(function(){
            if (host.firstChild === el) host.innerHTML = '';
        }, success ? 4500 : 7000);
    };

    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('a.artopia-logout-btn').forEach(function(a) {
            a.addEventListener('click', function(e) {
                e.preventDefault();
                var url = a.getAttribute('href');
                if (confirm('Log out of Artopia? You can sign in again anytime.')) {
                    window.location.href = url;
                }
            });
        });
    });
})();
</script>
<%
    /* Session flash (auth, etc.) — consumed here */
    String flashOk = (String) session.getAttribute("flashSuccess");
    String flashErr = (String) session.getAttribute("flashError");
    if (flashOk != null) session.removeAttribute("flashSuccess");
    if (flashErr != null) session.removeAttribute("flashError");

    /* URL fallbacks */
    if (flashErr == null && "invalid".equals(request.getParameter("error"))) {
        flashErr = "Invalid email or password. Please try again.";
    }
    if (flashErr == null && "failed".equals(request.getParameter("error")) && request.getRequestURI() != null && request.getRequestURI().contains("register")) {
        flashErr = "Registration failed. This email may already be in use, or the database is unavailable.";
    }
    if (flashOk == null && flashErr == null && "1".equals(request.getParameter("logout"))) {
        flashOk = "You have been logged out.";
    }
    boolean onContact = request.getRequestURI() != null && request.getRequestURI().contains("contact");
    if (flashOk == null && flashErr == null && "1".equals(request.getParameter("success")) && onContact) {
        flashOk = "Thank you! Your message has been sent. We'll get back to you soon.";
    }
    if (flashErr == null && onContact) {
        String ce = request.getParameter("error");
        if ("missing".equals(ce)) {
            flashErr = "Please fill in all required fields.";
        } else if ("server".equals(ce)) {
            flashErr = "We could not save your message. Please try again later.";
        }
    }

    /* Page-level messages (e.g. gallery forward) */
    if (flashOk == null && flashErr == null) {
        String s = (String) request.getAttribute("successMsg");
        String e = (String) request.getAttribute("errorMsg");
        if (e != null && !e.isEmpty()) {
            flashErr = e;
        } else if (s != null && !s.isEmpty()) {
            flashOk = s;
        }
    }

    if (flashOk != null && !flashOk.isEmpty()) {
        String q = WebUtil.escapeJs(flashOk);
%>
<script>
document.addEventListener('DOMContentLoaded', function() {
    if (window.__artopiaAutoToastDone) return;
    window.__artopiaAutoToastDone = true;
    artopiaShowToast('<%= q %>', true);
});
</script>
<%
    } else if (flashErr != null && !flashErr.isEmpty()) {
        String q = WebUtil.escapeJs(flashErr);
%>
<script>
document.addEventListener('DOMContentLoaded', function() {
    if (window.__artopiaAutoToastDone) return;
    window.__artopiaAutoToastDone = true;
    artopiaShowToast('<%= q %>', false);
});
</script>
<% } %>
