<%--
    buyer/gallery.jsp
    Buyer-facing gallery page.

    Servlet must set:
      request.getAttribute("artworks")     → List<Art>
      request.getAttribute("categories")   → List<String>
      request.getAttribute("successMsg")   → String (optional flash)
      request.getAttribute("errorMsg")     → String (optional flash)

    Art model getters used:
      getId(), getTitle(), getDescription(), getCategory(),
      getPrice(), getImageUrl(), getArtistName(), isSold()
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.artopia1.user.model.Art" %>
<%
    List<Art>    artworks   = (List<Art>)    request.getAttribute("artworks");
    List<String> categories = (List<String>) request.getAttribute("categories");
    String       successMsg = (String)       request.getAttribute("successMsg");
    String       errorMsg   = (String)       request.getAttribute("errorMsg");
    String       ctx        = request.getContextPath();

    // Login check — adjust attribute key to match what your login servlet stores in session
    boolean isLoggedIn = (session.getAttribute("userId") != null
            || session.getAttribute("user")   != null);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery — Artopia</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,400&family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet">
    <style>

        :root {
            --bg:           #080808;
            --surface:      #0f0f0f;
            --surface-2:    #141414;
            --surface-3:    #1a1a1a;
            --border:       #1e1e1e;
            --border-2:     #2a2a2a;
            --accent:       #c9a96e;
            --accent-dim:   rgba(201,169,110,.10);
            --accent-glow:  rgba(201,169,110,.20);
            --text:         #edeae4;
            --text-2:       #9a9590;
            --text-3:       #4e4b48;
            --danger:       #b94040;
            --r:            2px;
            --ease:         cubic-bezier(.4,0,.2,1);
        }

        *,*::before,*::after { box-sizing:border-box; margin:0; padding:0; }
        html { scroll-behavior:smooth; }
        body {
            background:var(--bg);
            color:var(--text);
            font-family:'DM Mono',monospace;
            font-size:13px;
            line-height:1.65;
            min-height:100vh;
            overflow-x:hidden;
        }
        body::before {
            content:'';
            position:fixed; inset:0;
            background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='.88' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='.03'/%3E%3C/svg%3E");
            pointer-events:none; z-index:0;
        }
        a { color:inherit; text-decoration:none; }
        img { display:block; }
        button { font-family:'DM Mono',monospace; cursor:pointer; }

        /* ══ HEADER ══ */
        .pg-header {
            position:sticky; top:0;
            background:rgba(8,8,8,.95);
            backdrop-filter:blur(18px);
            -webkit-backdrop-filter:blur(18px);
            border-bottom:1px solid var(--border);
            z-index:300;
        }
        .pg-header .inner {
            max-width:1380px; margin:0 auto;
            padding:.85rem 2.5rem;
            display:flex; align-items:center; gap:.8rem;
            flex-wrap:wrap;
        }
        .pg-logo {
            font-family:'Cormorant Garamond',serif;
            font-size:1.3rem; font-weight:400;
            color:var(--text); letter-spacing:.02em;
            flex-shrink:0; margin-right:.2rem;
        }
        .pg-logo em { font-style:italic; color:var(--accent); }

        /* Search */
        .search-wrap {
            flex:1; min-width:180px; max-width:460px;
            display:flex; gap:.4rem; align-items:center;
        }
        .search-input-inner { position:relative; flex:1; }
        .search-wrap svg.search-icon {
            position:absolute; left:.85rem; top:50%;
            transform:translateY(-50%);
            color:var(--text-3); pointer-events:none; z-index:1;
        }
        #searchInput {
            width:100%;
            background:var(--surface-2); border:1px solid var(--border);
            color:var(--text); font-family:'DM Mono',monospace; font-size:12px;
            padding:.58rem .9rem .58rem 2.4rem;
            border-radius:var(--r); outline:none;
            transition:border-color .2s, box-shadow .2s;
        }
        #searchInput:focus { border-color:var(--accent); box-shadow:0 0 0 3px var(--accent-glow); }
        #searchInput::placeholder { color:var(--text-3); }

        .search-btn {
            display:inline-flex; align-items:center; gap:.35rem;
            padding:.58rem 1rem;
            background:var(--accent); color:#080808; border:none;
            font-size:9px; letter-spacing:.2em; text-transform:uppercase; font-weight:500;
            border-radius:var(--r);
            transition:opacity .2s, transform .15s;
            white-space:nowrap; flex-shrink:0;
        }
        .search-btn:hover { opacity:.85; transform:scale(1.02); }
        .search-btn:active { transform:scale(.97); }

        /* Sort */
        #sortSelect {
            background:var(--surface-2); border:1px solid var(--border);
            color:var(--text); font-family:'DM Mono',monospace; font-size:11px;
            padding:.58rem 2rem .58rem .85rem;
            border-radius:var(--r); outline:none; cursor:pointer;
            appearance:none; -webkit-appearance:none;
            background-image:url("data:image/svg+xml,%3Csvg width='10' height='6' viewBox='0 0 10 6' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%23555' stroke-width='1.5' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat:no-repeat; background-position:right .65rem center;
            transition:border-color .2s; flex-shrink:0;
        }
        #sortSelect:focus { border-color:var(--accent); }
        #sortSelect option { background:#141414; }

        /* Price range */
        .price-inline {
            display:flex; align-items:center; gap:.35rem; flex-shrink:0;
        }
        .price-inline span { font-size:9px; letter-spacing:.1em; color:var(--text-3); }
        .price-inline input {
            width:70px;
            background:var(--surface-2); border:1px solid var(--border);
            color:var(--text); font-family:'DM Mono',monospace; font-size:11px;
            padding:.53rem .6rem; border-radius:var(--r); outline:none;
            transition:border-color .2s;
        }
        .price-inline input:focus { border-color:var(--accent); }
        .price-inline input::placeholder { color:var(--text-3); }

        /* Availability */
        .avail-toggle { display:flex; gap:.3rem; flex-shrink:0; }
        .avail-btn {
            padding:.48rem .85rem;
            background:transparent; border:1px solid var(--border-2);
            color:var(--text-3); font-family:'DM Mono',monospace;
            font-size:9px; letter-spacing:.15em; text-transform:uppercase;
            border-radius:var(--r); transition:all .18s; white-space:nowrap;
        }
        .avail-btn:hover { border-color:var(--accent); color:var(--accent); }
        .avail-btn.active { background:var(--accent-dim); border-color:var(--accent); color:var(--accent); }

        /* Cart */
        .header-right { margin-left:auto; flex-shrink:0; }
        .cart-btn {
            position:relative;
            display:flex; align-items:center; gap:.5rem;
            padding:.52rem 1.2rem;
            background:var(--accent-dim);
            border:1px solid rgba(201,169,110,.25);
            color:var(--accent);
            font-size:9px; letter-spacing:.2em; text-transform:uppercase;
            border-radius:var(--r);
            transition:background .2s, border-color .2s;
        }
        .cart-btn:hover { background:rgba(201,169,110,.18); border-color:var(--accent); }
        .cart-count {
            position:absolute; top:-.4rem; right:-.4rem;
            width:16px; height:16px;
            background:var(--accent); color:#080808;
            border-radius:50%; font-size:8px; font-weight:500;
            display:none; align-items:center; justify-content:center;
        }
        .cart-count.show { display:flex; }

        /* ══ FLASH ══ */
        .flash {
            border-left:2px solid; font-size:11px; letter-spacing:.04em;
            border-radius:0 var(--r) var(--r) 0;
            max-width:1380px; margin:.8rem auto 0;
            padding:.7rem 1.2rem .7rem 2.5rem;
        }
        .flash-ok  { border-color:#4caf77; background:rgba(76,175,119,.07); color:#4caf77; }
        .flash-err { border-color:var(--danger); background:rgba(185,64,64,.1); color:#d46060; }

        /* ══ CATEGORY PILL BAR ══ */
        .cat-bar {
            position:sticky; top:60px;
            background:rgba(8,8,8,.93);
            backdrop-filter:blur(14px); -webkit-backdrop-filter:blur(14px);
            border-bottom:1px solid var(--border);
            z-index:290;
        }
        .cat-bar .inner {
            max-width:1380px; margin:0 auto;
            padding:.55rem 2.5rem;
            display:flex; align-items:center; gap:.5rem;
            overflow-x:auto; scrollbar-width:none;
        }
        .cat-bar .inner::-webkit-scrollbar { display:none; }
        .cat-pill {
            display:inline-flex; align-items:center; gap:.35rem;
            padding:.35rem .85rem;
            background:transparent; border:1px solid var(--border-2);
            color:var(--text-2); font-family:'DM Mono',monospace;
            font-size:9px; letter-spacing:.18em; text-transform:uppercase;
            border-radius:20px; cursor:pointer; white-space:nowrap;
            transition:background .18s, border-color .18s, color .18s;
            flex-shrink:0;
        }
        .cat-pill:hover { border-color:var(--accent); color:var(--accent); background:var(--accent-dim); }
        .cat-pill.active { background:var(--accent); border-color:var(--accent); color:#080808; }
        .cat-pill .pill-dot {
            width:5px; height:5px; border-radius:50%;
            background:currentColor; opacity:.6; flex-shrink:0;
        }
        .cat-pill.active .pill-dot { opacity:1; }

        /* ══ PAGE BODY ══ */
        .page-body {
            max-width:1380px; margin:0 auto;
            padding:2rem 2.5rem 6rem;
            position:relative; z-index:1;
        }

        /* ══ TOP SEARCH BAR ══ */
        .top-search-bar {
            display:flex; gap:.7rem; align-items:center;
            margin-bottom:2rem;
        }
        .top-search-wrap {
            position:relative; flex:1; max-width:640px;
        }
        .top-search-wrap svg {
            position:absolute; left:.95rem; top:50%;
            transform:translateY(-50%);
            color:var(--text-3); pointer-events:none;
        }
        #searchInputTop {
            width:100%;
            background:var(--surface-2);
            border:1px solid var(--border-2);
            color:var(--text);
            font-family:'DM Mono',monospace; font-size:13px;
            padding:.78rem 1rem .78rem 2.7rem;
            border-radius:var(--r); outline:none;
            transition:border-color .2s, box-shadow .2s;
        }
        #searchInputTop:focus {
            border-color:var(--accent);
            box-shadow:0 0 0 3px var(--accent-glow);
        }
        #searchInputTop::placeholder { color:var(--text-3); }
        .top-search-btn {
            display:inline-flex; align-items:center; gap:.5rem;
            padding:.78rem 1.6rem;
            background:var(--accent); color:#080808; border:none;
            font-family:'DM Mono',monospace;
            font-size:10px; letter-spacing:.22em; text-transform:uppercase; font-weight:500;
            border-radius:var(--r);
            transition:opacity .2s, transform .15s;
            white-space:nowrap; flex-shrink:0;
        }
        .top-search-btn:hover { opacity:.85; transform:scale(1.02); }
        .top-search-btn:active { transform:scale(.97); }

        /* ══ RESULTS BAR ══ */
        .results-bar {
            display:flex; align-items:center; justify-content:space-between;
            margin-bottom:1.6rem; flex-wrap:wrap; gap:.6rem;
        }
        .results-count { font-size:9px; letter-spacing:.25em; text-transform:uppercase; color:var(--text-3); }
        .results-count strong { color:var(--accent); font-weight:400; }
        .active-filters { display:flex; align-items:center; gap:.4rem; flex-wrap:wrap; }
        .active-filter-chip {
            display:inline-flex; align-items:center; gap:.4rem;
            padding:.2rem .65rem;
            background:var(--accent-dim); border:1px solid rgba(201,169,110,.3);
            color:var(--accent); font-size:8px; letter-spacing:.15em; text-transform:uppercase;
            border-radius:20px;
        }
        .active-filter-chip button {
            background:none; border:none; color:var(--accent);
            font-size:11px; line-height:1; padding:0; margin-left:.2rem;
            opacity:.7; transition:opacity .15s;
        }
        .active-filter-chip button:hover { opacity:1; }
        .clear-all-btn {
            background:none; border:none; color:var(--text-3);
            font-size:9px; letter-spacing:.15em; text-transform:uppercase;
            transition:color .2s; padding:0;
        }
        .clear-all-btn:hover { color:var(--accent); }

        /* View toggle */
        .view-toggle { display:flex; gap:.4rem; }
        .view-btn {
            width:30px; height:30px;
            background:transparent; border:1px solid var(--border);
            color:var(--text-3); border-radius:var(--r);
            display:flex; align-items:center; justify-content:center;
            transition:all .2s;
        }
        .view-btn.active, .view-btn:hover {
            border-color:var(--accent); color:var(--accent); background:var(--accent-dim);
        }

        /* ══ ART GRID ══ */
        #artGrid {
            display:grid;
            grid-template-columns:repeat(4,1fr);
            gap:1.3rem;
        }
        #artGrid.view-2 { grid-template-columns:repeat(2,1fr); }
        #artGrid.view-3 { grid-template-columns:repeat(3,1fr); }
        #artGrid.view-5 { grid-template-columns:repeat(5,1fr); }

        /* ── Art Card ── */
        .art-card {
            background:var(--surface); border:1px solid var(--border);
            border-radius:var(--r); overflow:hidden;
            display:flex; flex-direction:column;
            transition:border-color .3s, box-shadow .3s, transform .35s var(--ease);
            animation:fadeUp .4s both;
            cursor:pointer;
        }
        .art-card:hover {
            border-color:var(--border-2);
            box-shadow:0 10px 45px rgba(0,0,0,.55);
            transform:translateY(-3px);
        }
        .art-card.sold { opacity:.5; pointer-events:none; }
        .art-card:nth-child(1){animation-delay:.04s} .art-card:nth-child(2){animation-delay:.08s}
        .art-card:nth-child(3){animation-delay:.12s} .art-card:nth-child(4){animation-delay:.16s}
        .art-card:nth-child(5){animation-delay:.20s} .art-card:nth-child(6){animation-delay:.24s}
        .art-card:nth-child(n+7){animation-delay:.28s}

        .card-thumb { position:relative; overflow:hidden; aspect-ratio:4/3; }
        .card-thumb img {
            width:100%; height:100%; object-fit:cover;
            filter:grayscale(10%) brightness(.9);
            transition:transform .6s var(--ease), filter .4s;
        }
        .art-card:hover .card-thumb img { transform:scale(1.07); filter:none; }

        .card-sold-badge {
            position:absolute; inset:0; background:rgba(0,0,0,.62);
            display:flex; align-items:center; justify-content:center;
        }
        .card-sold-badge span {
            font-size:9px; letter-spacing:.3em; text-transform:uppercase;
            color:#d46060; border:1px solid rgba(185,64,64,.4);
            padding:.3rem .9rem; border-radius:var(--r);
        }
        .card-cat {
            position:absolute; top:.7rem; left:.7rem; padding:.2rem .6rem;
            background:rgba(0,0,0,.7); border:1px solid var(--border-2);
            font-size:8px; letter-spacing:.22em; text-transform:uppercase;
            color:var(--text-2); border-radius:var(--r);
        }
        .card-quick {
            position:absolute; bottom:.7rem; right:.7rem; padding:.3rem .75rem;
            background:rgba(0,0,0,.75); border:1px solid rgba(201,169,110,.3);
            font-size:8px; letter-spacing:.18em; text-transform:uppercase;
            color:var(--accent); border-radius:var(--r);
            opacity:0; transform:translateY(4px);
            transition:opacity .25s, transform .25s;
        }
        .art-card:hover .card-quick { opacity:1; transform:none; }

        .card-body { padding:1rem 1.1rem .7rem; flex:1; display:flex; flex-direction:column; gap:.28rem; }
        .card-artist { font-size:9px; letter-spacing:.2em; text-transform:uppercase; color:var(--accent); }
        .card-title {
            font-family:'Cormorant Garamond',serif;
            font-size:1.05rem; font-weight:400; color:var(--text); line-height:1.25;
        }
        .card-desc {
            font-size:11px; color:var(--text-2); line-height:1.5;
            display:-webkit-box; -webkit-line-clamp:2; -webkit-box-orient:vertical; overflow:hidden;
            margin-top:.1rem;
        }
        .card-foot {
            padding:.75rem 1.1rem; border-top:1px solid var(--border);
            display:flex; align-items:center; justify-content:space-between;
        }
        .card-price { font-family:'Cormorant Garamond',serif; font-size:1.15rem; color:var(--text); }
        .btn-cart {
            display:inline-flex; align-items:center; gap:.4rem;
            padding:.4rem 1rem;
            background:var(--accent); color:#080808; border:none;
            font-size:8px; letter-spacing:.18em; text-transform:uppercase; font-weight:500;
            border-radius:var(--r); transition:opacity .2s, transform .15s;
        }
        .btn-cart:hover { opacity:.85; transform:scale(1.03); }
        .btn-cart:active { transform:scale(.97); }
        .btn-cart.added { background:transparent; border:1px solid #4caf77; color:#4caf77; }

        /* ── Login-required badge on card ── */
        .btn-cart.login-req {
            background:transparent;
            border:1px solid rgba(201,169,110,.35);
            color:var(--accent);
        }
        .btn-cart.login-req:hover { opacity:1; background:var(--accent-dim); transform:none; }

        /* ══ NO RESULTS ══ */
        .no-results {
            grid-column:1/-1; text-align:center;
            padding:5rem 2rem; color:var(--text-3);
        }
        .no-results svg { margin:0 auto 1.2rem; opacity:.2; }
        .no-results h3 {
            font-family:'Cormorant Garamond',serif;
            font-size:1.3rem; font-weight:300; color:var(--text-2); margin-bottom:.4rem;
        }
        .no-results p { font-size:11px; opacity:.6; }

        /* ══ DETAIL MODAL ══ */
        .overlay {
            position:fixed; inset:0;
            background:rgba(0,0,0,.82);
            backdrop-filter:blur(10px); -webkit-backdrop-filter:blur(10px);
            z-index:500; display:none;
            align-items:center; justify-content:center; padding:1.5rem;
        }
        .overlay.open { display:flex; }
        .modal-detail {
            background:var(--surface-2); border:1px solid var(--border-2);
            border-radius:var(--r); width:100%; max-width:820px;
            max-height:92vh; overflow-y:auto;
            display:grid; grid-template-columns:1fr 1fr;
            animation:mIn .28s var(--ease);
        }
        @keyframes mIn {
            from{opacity:0;transform:translateY(18px) scale(.97)}
            to  {opacity:1;transform:none}
        }
        .modal-img { position:relative; overflow:hidden; aspect-ratio:1; min-height:320px; }
        .modal-img img { width:100%; height:100%; object-fit:cover; transition:transform .6s var(--ease); }
        .modal-detail:hover .modal-img img { transform:scale(1.03); }
        .modal-info { padding:2.2rem 2rem; display:flex; flex-direction:column; gap:.6rem; overflow-y:auto; }
        .modal-cat { font-size:8px; letter-spacing:.3em; text-transform:uppercase; color:var(--accent); }
        .modal-title {
            font-family:'Cormorant Garamond',serif;
            font-size:1.9rem; font-weight:400; line-height:1.1; color:var(--text); margin:.1rem 0 .2rem;
        }
        .modal-artist { font-size:10px; letter-spacing:.15em; color:var(--text-3); }
        .modal-divider { height:1px; background:var(--border); margin:.5rem 0; }
        .modal-desc { font-size:12px; color:var(--text-2); line-height:1.7; flex:1; }
        .modal-price { font-family:'Cormorant Garamond',serif; font-size:2rem; color:var(--text); margin:.4rem 0; }
        .modal-actions { display:flex; gap:.8rem; margin-top:.4rem; }
        .btn-cart-lg {
            flex:1; display:flex; align-items:center; justify-content:center; gap:.5rem;
            padding:.72rem; background:var(--accent); color:#080808; border:none;
            font-size:9px; letter-spacing:.2em; text-transform:uppercase; font-weight:500;
            border-radius:var(--r); transition:opacity .2s;
        }
        .btn-cart-lg:hover { opacity:.84; }
        .btn-cart-lg.added { background:transparent; border:1px solid #4caf77; color:#4caf77; }
        .btn-cart-lg.login-req {
            background:transparent;
            border:1px solid rgba(201,169,110,.4);
            color:var(--accent);
        }
        .btn-cart-lg.login-req:hover { opacity:1; background:var(--accent-dim); }
        .modal-close {
            position:absolute; top:1rem; right:1rem;
            width:32px; height:32px;
            background:rgba(0,0,0,.65); border:1px solid var(--border-2);
            color:var(--text-2); border-radius:50%;
            display:flex; align-items:center; justify-content:center;
            font-size:1rem; line-height:1; cursor:pointer; transition:all .2s;
        }
        .modal-close:hover { background:rgba(0,0,0,.9); color:var(--text); }

        /* ══ TOAST ══ */
        .toast {
            position:fixed; bottom:2rem; right:2rem;
            background:var(--surface-3); border:1px solid var(--border-2);
            color:var(--text); padding:.8rem 1.4rem;
            border-radius:var(--r); font-size:11px; letter-spacing:.05em;
            display:flex; align-items:center; gap:.6rem;
            box-shadow:0 8px 30px rgba(0,0,0,.5); z-index:600;
            transform:translateY(1rem); opacity:0;
            transition:transform .3s var(--ease), opacity .3s;
            pointer-events:none;
        }
        .toast.show { transform:none; opacity:1; }
        .toast svg { color:var(--accent); flex-shrink:0; }
        .toast.toast-warn svg { color:#e0a040; }

        /* ══ LOGIN NUDGE BANNER (shown to guests) ══ */
        .login-nudge {
            display:flex; align-items:center; justify-content:space-between;
            gap:1rem; flex-wrap:wrap;
            padding:.75rem 1.4rem;
            background:var(--accent-dim);
            border:1px solid rgba(201,169,110,.2);
            border-radius:var(--r);
            margin-bottom:1.6rem;
            font-size:11px; letter-spacing:.04em; color:var(--text-2);
        }
        .login-nudge strong { color:var(--accent); font-weight:400; }
        .login-nudge a {
            display:inline-flex; align-items:center; gap:.4rem;
            padding:.4rem 1.1rem;
            background:var(--accent); color:#080808; border-radius:var(--r);
            font-size:9px; letter-spacing:.2em; text-transform:uppercase; font-weight:500;
            transition:opacity .2s;
        }
        .login-nudge a:hover { opacity:.82; }

        ::-webkit-scrollbar { width:5px; }
        ::-webkit-scrollbar-track { background:var(--bg); }
        ::-webkit-scrollbar-thumb { background:var(--border-2); border-radius:3px; }
        ::-webkit-scrollbar-thumb:hover { background:var(--text-3); }

        @keyframes fadeUp {
            from { opacity:0; transform:translateY(14px); }
            to   { opacity:1; transform:none; }
        }

        /* ══ RESPONSIVE ══ */
        @media(max-width:1200px) {
            #artGrid { grid-template-columns:repeat(3,1fr); }
            #artGrid.view-5 { grid-template-columns:repeat(4,1fr); }
        }
        @media(max-width:900px) {
            #artGrid,#artGrid.view-3,#artGrid.view-5 { grid-template-columns:repeat(2,1fr); }
            .price-inline { display:none; }
            .avail-toggle { display:none; }
        }
        @media(max-width:700px) {
            .pg-header .inner { padding:.75rem 1.2rem; }
            .page-body { padding:1.5rem 1.2rem 5rem; }
            .cat-bar .inner { padding:.5rem 1.2rem; }
            .modal-detail { grid-template-columns:1fr; }
            .modal-img { aspect-ratio:16/9; min-height:auto; }
            .top-search-bar { flex-wrap:wrap; }
            .top-search-wrap { max-width:100%; }
        }
        @media(max-width:520px) {
            #artGrid,#artGrid.view-2,#artGrid.view-3,#artGrid.view-5 { grid-template-columns:1fr 1fr; gap:.8rem; }
        }
        @media(max-width:360px) {
            #artGrid,#artGrid.view-2,#artGrid.view-3,#artGrid.view-5 { grid-template-columns:1fr; }
        }
    </style>
</head>
<body>

<jsp:include page="../components/navbar.jsp" />

<% if (successMsg != null) { %>
<div class="flash flash-ok"><%= successMsg %></div>
<% } %>
<% if (errorMsg != null) { %>
<div class="flash flash-err"><%= errorMsg %></div>
<% } %>

<%-- ══ STICKY HEADER ══ --%>
<header class="pg-header">
    <div class="inner">

        <span class="pg-logo">Arto<em>pia</em></span>

        <%-- Header Search --%>
        <div class="search-wrap">
            <div class="search-input-inner">
                <svg class="search-icon" width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/>
                </svg>
                <input type="text" id="searchInput" placeholder="Search artworks or artists…" autocomplete="off"
                       oninput="syncSearch('header')"
                       onkeydown="if(event.key==='Enter') applyFilters()">
            </div>
            <button class="search-btn" onclick="applyFilters()">
                <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                    <circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/>
                </svg>
                Search
            </button>
        </div>

        <%-- Sort --%>
        <select id="sortSelect" onchange="applyFilters()">
            <option value="default">Sort: Default</option>
            <option value="price-asc">Price: Low → High</option>
            <option value="price-desc">Price: High → Low</option>
            <option value="name-asc">Name: A → Z</option>
            <option value="name-desc">Name: Z → A</option>
        </select>

        <%-- Price range --%>
        <div class="price-inline">
            <span>$</span>
            <input type="number" id="priceMin" placeholder="Min" min="0" onchange="applyFilters()">
            <span>–</span>
            <input type="number" id="priceMax" placeholder="Max" min="0" onchange="applyFilters()">
        </div>

        <%-- Availability --%>
        <div class="avail-toggle">
            <button class="avail-btn active" data-avail="all" onclick="setAvail(this)">All</button>
            <button class="avail-btn" data-avail="available" onclick="setAvail(this)">Available</button>
        </div>

        <%-- Cart --%>
        <div class="header-right">
            <button class="cart-btn" onclick="openCartPage()">
                <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                    <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                </svg>
                Cart
                <span class="cart-count" id="cartCount">0</span>
            </button>
        </div>

    </div>
</header>

<%-- ══ CATEGORY PILL BAR ══ --%>
<nav class="cat-bar">
    <div class="inner">
        <button class="cat-pill active" data-cat="all" onclick="setCategoryPill(this,'all')">
            <span class="pill-dot"></span>All
        </button>
        <% if (categories != null) { for (String cat : categories) { %>
        <button class="cat-pill" data-cat="<%= cat %>" onclick="setCategoryPill(this,'<%= cat %>')">
            <span class="pill-dot"></span><%= cat %>
        </button>
        <% } } %>
    </div>
</nav>

<%-- ══ PAGE BODY ══ --%>
<div class="page-body">

    <%-- ══ LOGIN NUDGE BANNER (guests only) ══ --%>
    <% if (!isLoggedIn) { %>
    <div class="login-nudge">
        <span>You're browsing as a guest. <strong>Log in to add artworks to your cart.</strong></span>
        <a href="<%= ctx %>/login">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/>
                <polyline points="10 17 15 12 10 7"/>
                <line x1="15" y1="12" x2="3" y2="12"/>
            </svg>
            Log In
        </a>
    </div>
    <% } %>

    <%-- ══ TOP SEARCH BAR ══ --%>
    <div class="top-search-bar">
        <div class="top-search-wrap">
            <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/>
            </svg>
            <input type="text"
                   id="searchInputTop"
                   placeholder="Search artworks, artists, categories…"
                   autocomplete="off"
                   oninput="syncSearch('top')"
                   onkeydown="if(event.key==='Enter') applyFilters()">
        </div>
        <button class="top-search-btn" onclick="applyFilters()">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
                <circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/>
            </svg>
            Search
        </button>
    </div>

    <%-- ══ RESULTS BAR ══ --%>
    <div class="results-bar">
        <div style="display:flex;align-items:center;gap:.8rem;flex-wrap:wrap;">
            <span class="results-count">Showing <strong id="visibleCount">0</strong> artworks</span>
            <div class="active-filters" id="activeFilters"></div>
            <button class="clear-all-btn" id="clearAllBtn" onclick="clearFilters()" style="display:none;">Clear all</button>
        </div>
        <div class="view-toggle">
            <button class="view-btn" title="2 columns" onclick="setView(2)">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="3" y="3" width="7" height="18" rx="1"/><rect x="14" y="3" width="7" height="18" rx="1"/>
                </svg>
            </button>
            <button class="view-btn" title="3 columns" onclick="setView(3)">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="3" y="3" width="4" height="18" rx="1"/><rect x="10" y="3" width="4" height="18" rx="1"/>
                    <rect x="17" y="3" width="4" height="18" rx="1"/>
                </svg>
            </button>
            <button class="view-btn active" title="4 columns" onclick="setView(4)">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="2" y="3" width="4" height="18" rx="1"/><rect x="8" y="3" width="4" height="18" rx="1"/>
                    <rect x="14" y="3" width="4" height="18" rx="1"/><rect x="20" y="3" width="4" height="18" rx="1"/>
                </svg>
            </button>
            <button class="view-btn" title="5 columns" onclick="setView(5)">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <rect x="1" y="3" width="3" height="18" rx="1"/><rect x="6" y="3" width="3" height="18" rx="1"/>
                    <rect x="11" y="3" width="3" height="18" rx="1"/><rect x="16" y="3" width="3" height="18" rx="1"/>
                    <rect x="21" y="3" width="2" height="18" rx="1"/>
                </svg>
            </button>
        </div>
    </div>

    <%--  ART GRID  --%>
    <div id="artGrid">
        <% if (artworks != null && !artworks.isEmpty()) {
            for (Art art : artworks) {
                String src = (art.getImageUrl() != null && !art.getImageUrl().isEmpty())
                        ? ctx + "/images/art/" + art.getImageUrl()
                        : ctx + "/images/default_art.webp";
                boolean sold    = art.isSold();
                String descEsc  = art.getDescription() != null
                        ? art.getDescription().replace("'", "\\'").replace("\"", "&quot;") : "";
                String titleEsc  = art.getTitle().replace("'", "\\'");
                String artistEsc = art.getArtistName() != null
                        ? art.getArtistName().replace("'", "\\'") : "Unknown";
        %>
        <article class="art-card <%= sold ? "sold" : "" %>"
                 data-title="<%= art.getTitle().toLowerCase() %>"
                 data-artist="<%= art.getArtistName() != null ? art.getArtistName().toLowerCase() : "" %>"
                 data-category="<%= art.getCategory() %>"
                 data-price="<%= art.getPrice() %>"
                 data-sold="<%= sold %>"
                 onclick="openDetail(
                         '<%= art.getId() %>',
                         '<%= titleEsc %>',
                         '<%= artistEsc %>',
                         '<%= art.getCategory() %>',
                         '<%= descEsc %>',
                         '<%= String.format("%.2f", art.getPrice()) %>',
                         '<%= src %>',
                     <%= sold %>)">

            <div class="card-thumb">
                <img src="<%= src %>" alt="<%= art.getTitle() %>"
                     onerror="this.src='<%= ctx %>/images/default_art.webp'">
                <span class="card-cat"><%= art.getCategory() %></span>
                <% if (sold) { %><div class="card-sold-badge"><span>Sold</span></div><% } %>
                <span class="card-quick">Quick View</span>
            </div>

            <div class="card-body">
                <span class="card-artist"><%= art.getArtistName() != null ? art.getArtistName() : "—" %></span>
                <h3 class="card-title"><%= art.getTitle() %></h3>
                <p class="card-desc"><%= art.getDescription() %></p>
            </div>

            <div class="card-foot" onclick="event.stopPropagation()">
                <span class="card-price">$<%= String.format("%.2f", art.getPrice()) %></span>
                <% if (!sold) { %>
                <% if (!isLoggedIn) { %>
                <%-- Guest: show "Login to Buy" button --%>
                <button class="btn-cart login-req"
                        onclick="redirectToLogin()">
                    <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/>
                        <polyline points="10 17 15 12 10 7"/>
                        <line x1="15" y1="12" x2="3" y2="12"/>
                    </svg>
                    Login to Buy
                </button>
                <% } else { %>
                <%-- Logged-in: normal add-to-cart --%>
                <button class="btn-cart"
                        id="cartBtn-<%= art.getId() %>"
                        onclick="addToCart('<%= art.getId() %>','<%= titleEsc %>','<%= String.format("%.2f", art.getPrice()) %>',this)">
                    <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                    </svg>
                    Add to Cart
                </button>
                <% } %>
                <% } %>
            </div>
        </article>
        <% } } %>

        <div class="no-results" id="noResults" style="display:none;">
            <svg width="50" height="50" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                <circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/>
                <line x1="8" y1="11" x2="14" y2="11"/>
            </svg>
            <h3>No artworks found</h3>
            <p>Try adjusting your search or filters.</p>
        </div>
    </div>

</div><%-- /.page-body --%>

<%-- DETAIL MODAL --%>
<div class="overlay" id="detailOverlay">
    <div class="modal-detail">
        <div class="modal-img">
            <button class="modal-close" onclick="closeDetail()">&times;</button>
            <img id="d-img" src="" alt="">
        </div>
        <div class="modal-info">
            <span class="modal-cat" id="d-cat"></span>
            <h2 class="modal-title" id="d-title"></h2>
            <p class="modal-artist" id="d-artist"></p>
            <div class="modal-divider"></div>
            <p class="modal-desc" id="d-desc"></p>
            <p class="modal-price" id="d-price"></p>
            <div class="modal-actions">
                <button class="btn-cart-lg" id="d-cartBtn" onclick="addToCartFromModal()">
                    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                        <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                    </svg>
                    Add to Cart
                </button>
            </div>
        </div>
    </div>
</div>

<%-- TOAST --%>
<div class="toast" id="toast">
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
        <polyline points="20 6 9 17 4 12"/>
    </svg>
    <span id="toastMsg">Added to cart</span>
</div>

<jsp:include page="../components/footer.jsp" />

<script>
    /* ══ STATE ══ */
    var cart          = JSON.parse(localStorage.getItem('artopia_cart') || '[]');
    var activeDetail  = null;
    var activePillCat = 'all';
    var activeAvail   = 'all';

    /* Server-side login status — never trust client-side alone for real auth,
       but this controls UI gating. The server servlet must also guard cart endpoints. */
    var isLoggedIn = <%= isLoggedIn %>;
    var loginUrl   = '<%= ctx %>/login';

    /* INIT */
    (function init() {
        updateCartUI();
        updateCount();
        if (isLoggedIn) {
            cart.forEach(function(item) { markCardAdded(item.id); });
        }
    })();

    /*  SYNC SEARCH (keep both inputs in step)  */
    function syncSearch(source) {
        var headerInput = document.getElementById('searchInput');
        var topInput    = document.getElementById('searchInputTop');
        if (source === 'header') {
            topInput.value = headerInput.value;
        } else {
            headerInput.value = topInput.value;
        }
    }

    /* AVAILABILITY */
    function setAvail(btn) {
        document.querySelectorAll('.avail-btn').forEach(function(b){ b.classList.remove('active'); });
        btn.classList.add('active');
        activeAvail = btn.dataset.avail;
        applyFilters();
    }

    /* CATEGORY PILLS  */
    function setCategoryPill(btn, cat) {
        document.querySelectorAll('.cat-pill').forEach(function(p){ p.classList.remove('active'); });
        btn.classList.add('active');
        activePillCat = cat;
        applyFilters();
        updateActiveFilterChips();
    }

    /*  MASTER FILTER + SORT  */
    function applyFilters() {
        var q        = document.getElementById('searchInput').value.toLowerCase().trim();
        var sort     = document.getElementById('sortSelect').value;
        var minPrice = parseFloat(document.getElementById('priceMin').value) || 0;
        var maxPrice = parseFloat(document.getElementById('priceMax').value) || Infinity;

        var cards = Array.from(document.querySelectorAll('.art-card'));

        var visible = cards.filter(function(card) {
            var title  = card.dataset.title  || '';
            var artist = card.dataset.artist || '';
            var cat    = card.dataset.category || '';
            var price  = parseFloat(card.dataset.price) || 0;
            var isSold = card.dataset.sold === 'true';

            if (q && title.indexOf(q) === -1 && artist.indexOf(q) === -1) return false;
            if (activePillCat !== 'all' && cat !== activePillCat) return false;
            if (price < minPrice || price > maxPrice) return false;
            if (activeAvail === 'available' && isSold) return false;
            return true;
        });

        visible.sort(function(a, b) {
            var pa = parseFloat(a.dataset.price), pb = parseFloat(b.dataset.price);
            var ta = a.dataset.title,              tb = b.dataset.title;
            if (sort === 'price-asc')  return pa - pb;
            if (sort === 'price-desc') return pb - pa;
            if (sort === 'name-asc')   return ta.localeCompare(tb);
            if (sort === 'name-desc')  return tb.localeCompare(ta);
            return 0;
        });

        cards.forEach(function(c){ c.style.display = 'none'; });
        var grid = document.getElementById('artGrid');
        visible.forEach(function(c){ c.style.display = ''; grid.appendChild(c); });

        document.getElementById('noResults').style.display = visible.length === 0 ? 'block' : 'none';
        updateCount(visible.length);
        updateActiveFilterChips();
    }

    /* ACTIVE FILTER CHIPS  */
    function updateActiveFilterChips() {
        var wrap = document.getElementById('activeFilters');
        wrap.innerHTML = '';
        var hasChip = false;

        var q = document.getElementById('searchInput').value.trim();
        if (q) {
            hasChip = true;
            wrap.appendChild(makeChip('Search: ' + q, function(){
                document.getElementById('searchInput').value    = '';
                document.getElementById('searchInputTop').value = '';
                applyFilters();
            }));
        }
        if (activePillCat !== 'all') {
            hasChip = true;
            (function(cat){ wrap.appendChild(makeChip(cat, function(){
                activePillCat = 'all';
                document.querySelectorAll('.cat-pill').forEach(function(p){ p.classList.remove('active'); });
                var ap = document.querySelector('.cat-pill[data-cat="all"]');
                if (ap) ap.classList.add('active');
                applyFilters();
            })); })(activePillCat);
        }
        var minV = document.getElementById('priceMin').value;
        var maxV = document.getElementById('priceMax').value;
        if (minV || maxV) {
            hasChip = true;
            wrap.appendChild(makeChip('$' + (minV||'0') + ' – ' + (maxV ? '$'+maxV : 'Any'), function(){
                document.getElementById('priceMin').value = '';
                document.getElementById('priceMax').value = '';
                applyFilters();
            }));
        }
        if (activeAvail === 'available') {
            hasChip = true;
            wrap.appendChild(makeChip('Available only', function(){
                activeAvail = 'all';
                document.querySelectorAll('.avail-btn').forEach(function(b, i){ b.classList.toggle('active', i === 0); });
                applyFilters();
            }));
        }
        document.getElementById('clearAllBtn').style.display = hasChip ? '' : 'none';
    }

    function makeChip(label, onRemove) {
        var chip = document.createElement('span');
        chip.className = 'active-filter-chip';
        chip.innerHTML = label + '<button title="Remove">&times;</button>';
        chip.querySelector('button').addEventListener('click', function(e){
            e.stopPropagation();
            onRemove();
        });
        return chip;
    }

    /* CLEAR ALL  */
    function clearFilters() {
        document.getElementById('searchInput').value    = '';
        document.getElementById('searchInputTop').value = '';
        document.getElementById('priceMin').value       = '';
        document.getElementById('priceMax').value       = '';
        document.getElementById('sortSelect').value     = 'default';
        activePillCat = 'all';
        activeAvail   = 'all';
        document.querySelectorAll('.cat-pill').forEach(function(p){ p.classList.remove('active'); });
        var ap = document.querySelector('.cat-pill[data-cat="all"]');
        if (ap) ap.classList.add('active');
        document.querySelectorAll('.avail-btn').forEach(function(b, i){ b.classList.toggle('active', i === 0); });
        applyFilters();
    }

    /* VIEW MODE */
    function setView(cols) {
        var grid = document.getElementById('artGrid');
        grid.classList.remove('view-2','view-3','view-5');
        if (cols === 2) grid.classList.add('view-2');
        if (cols === 3) grid.classList.add('view-3');
        if (cols === 5) grid.classList.add('view-5');
        document.querySelectorAll('.view-btn').forEach(function(btn, i){
            btn.classList.toggle('active', [2,3,4,5][i] === cols);
        });
    }

    function updateCount(n) {
        if (n === undefined) n = document.querySelectorAll('.art-card').length;
        document.getElementById('visibleCount').textContent = n;
    }

    /* REDIRECT GUEST TO LOGIN */
    function redirectToLogin() {
        showToast('Please log in to add artworks to your cart.', true);
        setTimeout(function(){ window.location.href = loginUrl; }, 1400);
    }

    /*  DETAIL MODAL */
    function openDetail(id, title, artist, cat, desc, price, imgSrc, sold) {
        activeDetail = { id:id, title:title, price:price };
        document.getElementById('d-img').src            = imgSrc;
        document.getElementById('d-img').alt            = title;
        document.getElementById('d-cat').textContent    = cat;
        document.getElementById('d-title').textContent  = title;
        document.getElementById('d-artist').textContent = 'by ' + artist;
        document.getElementById('d-desc').textContent   = desc || 'No description provided.';
        document.getElementById('d-price').textContent  = '$' + price;

        var dBtn = document.getElementById('d-cartBtn');
        dBtn.disabled = false;
        dBtn.style.opacity = '';
        dBtn.style.cursor  = '';

        if (sold) {
            dBtn.className = 'btn-cart-lg';
            dBtn.textContent = 'Sold Out';
            dBtn.disabled = true;
            dBtn.style.opacity = '.4';
            dBtn.style.cursor  = 'not-allowed';
        } else if (!isLoggedIn) {
            /* Guest in modal — show login prompt */
            dBtn.className = 'btn-cart-lg login-req';
            dBtn.innerHTML =
                '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">' +
                '<path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/>' +
                '<polyline points="10 17 15 12 10 7"/>' +
                '<line x1="15" y1="12" x2="3" y2="12"/></svg>' +
                ' Log In to Buy';
            dBtn.onclick = function(){ redirectToLogin(); };
        } else {
            dBtn.onclick = addToCartFromModal;
            var inCart = cart.some(function(c){ return c.id === id; });
            if (inCart) {
                dBtn.className = 'btn-cart-lg added';
                dBtn.innerHTML =
                    '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg> In Cart';
            } else {
                dBtn.className = 'btn-cart-lg';
                dBtn.innerHTML =
                    '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">' +
                    '<circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>' +
                    '<path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>' +
                    ' Add to Cart';
            }
        }

        document.getElementById('detailOverlay').classList.add('open');
        document.body.style.overflow = 'hidden';
    }

    function closeDetail() {
        document.getElementById('detailOverlay').classList.remove('open');
        document.body.style.overflow = '';
    }

    function addToCartFromModal() {
        if (!activeDetail) return;
        if (!isLoggedIn) { redirectToLogin(); return; }
        addToCart(activeDetail.id, activeDetail.title, activeDetail.price,
            document.getElementById('cartBtn-' + activeDetail.id));
        var dBtn = document.getElementById('d-cartBtn');
        dBtn.className = 'btn-cart-lg added';
        dBtn.innerHTML =
            '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg> In Cart';
    }

    document.getElementById('detailOverlay').addEventListener('click', function(e){
        if (e.target === this) closeDetail();
    });
    document.addEventListener('keydown', function(e){
        if (e.key === 'Escape') closeDetail();
    });

    /* CART */
    function addToCart(id, title, price, btn) {
        /* Guard: guest cannot add to cart */
        if (!isLoggedIn) {
            redirectToLogin();
            return;
        }
        var alreadyIn = cart.some(function(c){ return c.id == id; });
        if (alreadyIn) { showToast('"' + title + '" is already in your cart.', false); return; }
        cart.push({ id:id, title:title, price:price });
        localStorage.setItem('artopia_cart', JSON.stringify(cart));
        markCardAdded(id);
        updateCartUI();
        showToast('"' + title + '" added to cart.', false);
    }

    function markCardAdded(id) {
        var btn = document.getElementById('cartBtn-' + id);
        if (btn) {
            btn.classList.add('added');
            btn.innerHTML =
                '<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg> Added';
        }
    }

    function updateCartUI() {
        var count = cart.length;
        var badge = document.getElementById('cartCount');
        badge.textContent = count;
        badge.classList.toggle('show', count > 0);
    }

    function openCartPage() { window.location.href = '<%= ctx %>/cart'; }

    /*  TOAST  */
    var toastTimer;
    function showToast(msg, isWarn) {
        clearTimeout(toastTimer);
        document.getElementById('toastMsg').textContent = msg;
        var t = document.getElementById('toast');
        t.classList.toggle('toast-warn', !!isWarn);
        t.classList.add('show');
        toastTimer = setTimeout(function(){ t.classList.remove('show'); }, 2800);
    }

    updateCount();
</script>

</body>
</html>
