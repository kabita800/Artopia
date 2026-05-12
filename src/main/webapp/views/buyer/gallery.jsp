<%--
    buyer/gallery.jsp
    Buyer-facing gallery page.

    Servlet must set:
      request.getAttribute("artworks")     → List<Art>    (all available artworks)
      request.getAttribute("categories")   → List<String> (distinct categories for filter)
      request.getAttribute("successMsg")   → String       (optional flash)
      request.getAttribute("errorMsg")     → String       (optional flash)

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
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery — Artopia</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,400&family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet">
    <style>

        /* ══════════════════════════════════════════════════════════
           TOKENS
        ══════════════════════════════════════════════════════════ */
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
            --sidebar-w:    260px;
        }

        /* ══════════════════════════════════════════════════════════
           RESET
        ══════════════════════════════════════════════════════════ */
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

        /* ══════════════════════════════════════════════════════════
           STICKY HEADER
        ══════════════════════════════════════════════════════════ */
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
            padding:.95rem 2.5rem;
            display:flex; align-items:center; gap:1.2rem;
        }
        .pg-logo {
            font-family:'Cormorant Garamond',serif;
            font-size:1.3rem; font-weight:400;
            color:var(--text); letter-spacing:.02em;
            margin-right:.5rem; flex-shrink:0;
        }
        .pg-logo em { font-style:italic; color:var(--accent); }

        /* search bar */
        .search-wrap {
            flex:1; max-width:420px;
            position:relative;
        }
        .search-wrap svg {
            position:absolute; left:.9rem; top:50%;
            transform:translateY(-50%);
            color:var(--text-3); pointer-events:none;
        }
        #searchInput {
            width:100%;
            background:var(--surface-2);
            border:1px solid var(--border);
            color:var(--text);
            font-family:'DM Mono',monospace;
            font-size:12px;
            padding:.6rem .9rem .6rem 2.4rem;
            border-radius:var(--r);
            outline:none;
            transition:border-color .2s, box-shadow .2s;
        }
        #searchInput:focus {
            border-color:var(--accent);
            box-shadow:0 0 0 3px var(--accent-glow);
        }
        #searchInput::placeholder { color:var(--text-3); }

        /* sort */
        #sortSelect {
            background:var(--surface-2);
            border:1px solid var(--border);
            color:var(--text);
            font-family:'DM Mono',monospace;
            font-size:11px;
            padding:.6rem 2rem .6rem .9rem;
            border-radius:var(--r);
            outline:none;
            cursor:pointer;
            appearance:none;
            -webkit-appearance:none;
            background-image:url("data:image/svg+xml,%3Csvg width='10' height='6' viewBox='0 0 10 6' fill='none' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M1 1l4 4 4-4' stroke='%23555' stroke-width='1.5' stroke-linecap='round'/%3E%3C/svg%3E");
            background-repeat:no-repeat;
            background-position:right .7rem center;
            transition:border-color .2s;
            flex-shrink:0;
        }
        #sortSelect:focus { border-color:var(--accent); outline:none; }
        #sortSelect option { background:#141414; }

        /* header right */
        .header-right { display:flex; align-items:center; gap:.9rem; margin-left:auto; }

        /* cart button */
        .cart-btn {
            position:relative;
            display:flex; align-items:center; gap:.5rem;
            padding:.55rem 1.2rem;
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
            border-radius:50%;
            font-size:8px; font-weight:500;
            display:flex; align-items:center; justify-content:center;
            display:none;
        }
        .cart-count.show { display:flex; }

        /* filter toggle (mobile) */
        .filter-toggle {
            display:none;
            align-items:center; gap:.4rem;
            padding:.55rem 1rem;
            background:transparent;
            border:1px solid var(--border-2);
            color:var(--text-2);
            font-size:9px; letter-spacing:.2em; text-transform:uppercase;
            border-radius:var(--r);
            transition:all .2s;
        }
        .filter-toggle:hover { border-color:var(--accent); color:var(--accent); }

        /* ══════════════════════════════════════════════════════════
           FLASH
        ══════════════════════════════════════════════════════════ */
        .flash {
            border-left:2px solid; padding:.75rem 1.2rem;
            font-size:11px; letter-spacing:.04em;
            border-radius:0 var(--r) var(--r) 0;
            max-width:1380px; margin:.8rem auto 0; padding-left:2.5rem;
        }
        .flash-ok  { border-color:#4caf77; background:rgba(76,175,119,.07); color:#4caf77; }
        .flash-err { border-color:var(--danger); background:rgba(185,64,64,.1); color:#d46060; }

        /* ══════════════════════════════════════════════════════════
           PAGE BODY — sidebar + grid
        ══════════════════════════════════════════════════════════ */
        .page-body {
            max-width:1380px; margin:0 auto;
            padding:2rem 2.5rem 6rem;
            display:grid;
            grid-template-columns:var(--sidebar-w) 1fr;
            gap:2.5rem;
            position:relative; z-index:1;
            align-items:start;
        }

        /* ══════════════════════════════════════════════════════════
           SIDEBAR — filters
        ══════════════════════════════════════════════════════════ */
        .sidebar {
            position:sticky; top:70px;
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:var(--r);
            overflow:hidden;
        }
        .sidebar-head {
            padding:1rem 1.25rem .75rem;
            border-bottom:1px solid var(--border);
            display:flex; align-items:center; justify-content:space-between;
        }
        .sidebar-head span {
            font-size:9px; letter-spacing:.3em; text-transform:uppercase; color:var(--accent);
        }
        .clear-btn {
            background:none; border:none; color:var(--text-3);
            font-size:9px; letter-spacing:.15em; text-transform:uppercase;
            transition:color .2s; padding:0;
        }
        .clear-btn:hover { color:var(--accent); }

        .filter-section { padding:.85rem 1.25rem; border-bottom:1px solid var(--border); }
        .filter-section:last-child { border-bottom:none; }
        .filter-label {
            font-size:8px; letter-spacing:.3em; text-transform:uppercase;
            color:var(--text-3); margin-bottom:.7rem; display:block;
        }

        /* category pills */
        .cat-list { display:flex; flex-direction:column; gap:.3rem; }
        .cat-item {
            display:flex; align-items:center; gap:.6rem;
            padding:.38rem .6rem;
            border-radius:var(--r);
            cursor:pointer;
            transition:background .15s;
            user-select:none;
        }
        .cat-item:hover { background:var(--surface-3); }
        .cat-item.active { background:var(--accent-dim); }
        .cat-item input[type=checkbox] { display:none; }
        .cat-dot {
            width:7px; height:7px; border-radius:50%;
            border:1px solid var(--border-2);
            flex-shrink:0; transition:background .15s, border-color .15s;
        }
        .cat-item.active .cat-dot { background:var(--accent); border-color:var(--accent); }
        .cat-name {
            font-size:11px; color:var(--text-2); flex:1;
            transition:color .15s;
        }
        .cat-item.active .cat-name { color:var(--text); }

        /* price range */
        .price-inputs { display:grid; grid-template-columns:1fr 1fr; gap:.6rem; }
        .price-input-wrap { display:flex; flex-direction:column; gap:.3rem; }
        .price-input-wrap label { font-size:8px; letter-spacing:.2em; text-transform:uppercase; color:var(--text-3); }
        .price-input-wrap input {
            background:var(--surface-2); border:1px solid var(--border);
            color:var(--text); font-family:'DM Mono',monospace; font-size:11px;
            padding:.5rem .65rem; border-radius:var(--r); outline:none; width:100%;
            transition:border-color .2s;
        }
        .price-input-wrap input:focus { border-color:var(--accent); }

        /* availability toggle */
        .avail-opts { display:flex; flex-direction:column; gap:.3rem; }
        .avail-item {
            display:flex; align-items:center; gap:.6rem;
            padding:.38rem .6rem; border-radius:var(--r); cursor:pointer;
            transition:background .15s; user-select:none;
        }
        .avail-item:hover { background:var(--surface-3); }
        .avail-item.active { background:var(--accent-dim); }
        .avail-item input { display:none; }
        .avail-item span { font-size:11px; color:var(--text-2); transition:color .15s; }
        .avail-item.active span { color:var(--text); }

        /* apply filter btn */
        .apply-btn {
            width:100%; padding:.65rem;
            background:var(--accent); color:#080808; border:none;
            font-size:9px; letter-spacing:.2em; text-transform:uppercase; font-weight:500;
            transition:opacity .2s;
        }
        .apply-btn:hover { opacity:.82; }

        /* ══════════════════════════════════════════════════════════
           RESULTS BAR
        ══════════════════════════════════════════════════════════ */
        .results-bar {
            display:flex; align-items:center; justify-content:space-between;
            margin-bottom:1.6rem; flex-wrap:wrap; gap:.6rem;
        }
        .results-count {
            font-size:9px; letter-spacing:.25em; text-transform:uppercase; color:var(--text-3);
        }
        .results-count strong { color:var(--accent); font-weight:400; }

        /* view-mode toggle */
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

        /* ══════════════════════════════════════════════════════════
           ARTWORK GRID — default 3 cols
        ══════════════════════════════════════════════════════════ */
        #artGrid {
            display:grid;
            grid-template-columns:repeat(3,1fr);
            gap:1.3rem;
        }
        #artGrid.view-2 { grid-template-columns:repeat(2,1fr); }
        #artGrid.view-4 { grid-template-columns:repeat(4,1fr); }

        /* ── Art Card ────────────────────────────────────────────── */
        .art-card {
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:var(--r);
            overflow:hidden;
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

        /* stagger */
        .art-card:nth-child(1){animation-delay:.04s}
        .art-card:nth-child(2){animation-delay:.08s}
        .art-card:nth-child(3){animation-delay:.12s}
        .art-card:nth-child(4){animation-delay:.16s}
        .art-card:nth-child(5){animation-delay:.20s}
        .art-card:nth-child(6){animation-delay:.24s}
        .art-card:nth-child(n+7){animation-delay:.28s}

        .card-thumb {
            position:relative; overflow:hidden;
            aspect-ratio:4/3;
        }
        .card-thumb img {
            width:100%; height:100%; object-fit:cover;
            filter:grayscale(10%) brightness(.9);
            transition:transform .6s var(--ease), filter .4s;
        }
        .art-card:hover .card-thumb img {
            transform:scale(1.07); filter:none;
        }

        .card-sold-badge {
            position:absolute; inset:0;
            background:rgba(0,0,0,.62);
            display:flex; align-items:center; justify-content:center;
        }
        .card-sold-badge span {
            font-size:9px; letter-spacing:.3em; text-transform:uppercase;
            color:#d46060; border:1px solid rgba(185,64,64,.4);
            padding:.3rem .9rem; border-radius:var(--r);
        }

        .card-cat {
            position:absolute; top:.7rem; left:.7rem;
            padding:.2rem .6rem;
            background:rgba(0,0,0,.7);
            border:1px solid var(--border-2);
            font-size:8px; letter-spacing:.22em; text-transform:uppercase;
            color:var(--text-2); border-radius:var(--r);
        }

        .card-quick {
            position:absolute; bottom:.7rem; right:.7rem;
            padding:.3rem .75rem;
            background:rgba(0,0,0,.75);
            border:1px solid rgba(201,169,110,.3);
            font-size:8px; letter-spacing:.18em; text-transform:uppercase;
            color:var(--accent); border-radius:var(--r);
            opacity:0; transform:translateY(4px);
            transition:opacity .25s, transform .25s;
        }
        .art-card:hover .card-quick { opacity:1; transform:none; }

        .card-body {
            padding:1rem 1.1rem .7rem;
            flex:1; display:flex; flex-direction:column; gap:.28rem;
        }
        .card-artist {
            font-size:9px; letter-spacing:.2em; text-transform:uppercase; color:var(--accent);
        }
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
            padding:.75rem 1.1rem;
            border-top:1px solid var(--border);
            display:flex; align-items:center; justify-content:space-between;
        }
        .card-price {
            font-family:'Cormorant Garamond',serif;
            font-size:1.15rem; color:var(--text);
        }

        .btn-cart {
            display:inline-flex; align-items:center; gap:.4rem;
            padding:.4rem 1rem;
            background:var(--accent); color:#080808; border:none;
            font-size:8px; letter-spacing:.18em; text-transform:uppercase; font-weight:500;
            border-radius:var(--r); transition:opacity .2s, transform .15s;
        }
        .btn-cart:hover { opacity:.85; transform:scale(1.03); }
        .btn-cart:active { transform:scale(.97); }
        .btn-cart.added {
            background:transparent;
            border:1px solid #4caf77; color:#4caf77;
        }

        /* ══════════════════════════════════════════════════════════
           NO RESULTS
        ══════════════════════════════════════════════════════════ */
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

        /* ══════════════════════════════════════════════════════════
           VIEW / DETAIL MODAL
        ══════════════════════════════════════════════════════════ */
        .overlay {
            position:fixed; inset:0;
            background:rgba(0,0,0,.82);
            backdrop-filter:blur(10px); -webkit-backdrop-filter:blur(10px);
            z-index:500; display:none;
            align-items:center; justify-content:center; padding:1.5rem;
        }
        .overlay.open { display:flex; }

        .modal-detail {
            background:var(--surface-2);
            border:1px solid var(--border-2);
            border-radius:var(--r);
            width:100%; max-width:820px;
            max-height:92vh; overflow-y:auto;
            display:grid; grid-template-columns:1fr 1fr;
            animation:mIn .28s var(--ease);
        }
        @keyframes mIn {
            from{opacity:0;transform:translateY(18px) scale(.97)}
            to  {opacity:1;transform:none}
        }

        .modal-img {
            position:relative; overflow:hidden;
            aspect-ratio:1; min-height:320px;
        }
        .modal-img img {
            width:100%; height:100%; object-fit:cover;
            transition:transform .6s var(--ease);
        }
        .modal-detail:hover .modal-img img { transform:scale(1.03); }

        .modal-info {
            padding:2.2rem 2rem;
            display:flex; flex-direction:column; gap:.6rem;
            overflow-y:auto;
        }
        .modal-cat {
            font-size:8px; letter-spacing:.3em; text-transform:uppercase; color:var(--accent);
        }
        .modal-title {
            font-family:'Cormorant Garamond',serif;
            font-size:1.9rem; font-weight:400; line-height:1.1; color:var(--text);
            margin:.1rem 0 .2rem;
        }
        .modal-artist {
            font-size:10px; letter-spacing:.15em; color:var(--text-3);
        }
        .modal-divider { height:1px; background:var(--border); margin:.5rem 0; }
        .modal-desc {
            font-size:12px; color:var(--text-2); line-height:1.7; flex:1;
        }
        .modal-price {
            font-family:'Cormorant Garamond',serif;
            font-size:2rem; color:var(--text); margin:.4rem 0;
        }
        .modal-actions { display:flex; gap:.8rem; margin-top:.4rem; }
        .btn-cart-lg {
            flex:1; display:flex; align-items:center; justify-content:center; gap:.5rem;
            padding:.72rem;
            background:var(--accent); color:#080808; border:none;
            font-size:9px; letter-spacing:.2em; text-transform:uppercase; font-weight:500;
            border-radius:var(--r); transition:opacity .2s;
        }
        .btn-cart-lg:hover { opacity:.84; }
        .btn-cart-lg.added { background:transparent; border:1px solid #4caf77; color:#4caf77; }

        .modal-close {
            position:absolute; top:1rem; right:1rem;
            width:32px; height:32px;
            background:rgba(0,0,0,.65); border:1px solid var(--border-2);
            color:var(--text-2); border-radius:50%;
            display:flex; align-items:center; justify-content:center;
            font-size:1rem; line-height:1; cursor:pointer;
            transition:all .2s;
        }
        .modal-close:hover { background:rgba(0,0,0,.9); color:var(--text); }

        /* ══════════════════════════════════════════════════════════
           CART TOAST
        ══════════════════════════════════════════════════════════ */
        .toast {
            position:fixed; bottom:2rem; right:2rem;
            background:var(--surface-3); border:1px solid var(--border-2);
            color:var(--text);
            padding:.8rem 1.4rem;
            border-radius:var(--r);
            font-size:11px; letter-spacing:.05em;
            display:flex; align-items:center; gap:.6rem;
            box-shadow:0 8px 30px rgba(0,0,0,.5);
            z-index:600;
            transform:translateY(1rem); opacity:0;
            transition:transform .3s var(--ease), opacity .3s;
            pointer-events:none;
        }
        .toast.show { transform:none; opacity:1; }
        .toast svg { color:var(--accent); flex-shrink:0; }

        /* ══════════════════════════════════════════════════════════
           SCROLLBAR
        ══════════════════════════════════════════════════════════ */
        ::-webkit-scrollbar { width:5px; }
        ::-webkit-scrollbar-track { background:var(--bg); }
        ::-webkit-scrollbar-thumb { background:var(--border-2); border-radius:3px; }
        ::-webkit-scrollbar-thumb:hover { background:var(--text-3); }

        /* ══════════════════════════════════════════════════════════
           ANIMATION
        ══════════════════════════════════════════════════════════ */
        @keyframes fadeUp {
            from { opacity:0; transform:translateY(14px); }
            to   { opacity:1; transform:none; }
        }

        /* ══════════════════════════════════════════════════════════
           RESPONSIVE
        ══════════════════════════════════════════════════════════ */
        @media(max-width:1100px) {
            :root { --sidebar-w:220px; }
            #artGrid { grid-template-columns:repeat(2,1fr); }
            #artGrid.view-4 { grid-template-columns:repeat(3,1fr); }
        }
        @media(max-width:860px) {
            .page-body { grid-template-columns:1fr; }
            .sidebar {
                position:fixed; left:0; top:0; bottom:0; z-index:400;
                width:280px; border-radius:0;
                transform:translateX(-100%);
                transition:transform .3s var(--ease);
                overflow-y:auto;
            }
            .sidebar.open { transform:none; }
            .sidebar-backdrop {
                display:none; position:fixed; inset:0;
                background:rgba(0,0,0,.6); z-index:390;
            }
            .sidebar-backdrop.show { display:block; }
            .filter-toggle { display:flex; }
            .modal-detail { grid-template-columns:1fr; }
            .modal-img { aspect-ratio:16/9; min-height:auto; }
        }
        @media(max-width:600px) {
            .pg-header .inner { padding:.8rem 1.2rem; flex-wrap:wrap; }
            .search-wrap { order:3; max-width:none; width:100%; }
            .page-body { padding:1.5rem 1.2rem 5rem; }
            #artGrid,#artGrid.view-2,#artGrid.view-4 { grid-template-columns:1fr 1fr; gap:.8rem; }
        }
        @media(max-width:400px) {
            #artGrid,#artGrid.view-2,#artGrid.view-4 { grid-template-columns:1fr; }
        }

    </style>
</head>
<body>

<jsp:include page="../components/navbar.jsp" />

<%--  STICKY HEADER--%>
<header class="pg-header">
    <div class="inner">
        <span class="pg-logo">Arto<em>pia</em></span>

        <div class="search-wrap">
            <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                <circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/>
            </svg>
            <input type="text" id="searchInput" placeholder="Search artworks or artists…" autocomplete="off">
        </div>

        <select id="sortSelect">
            <option value="default">Sort: Default</option>
            <option value="price-asc">Price: Low to High</option>
            <option value="price-desc">Price: High to Low</option>
            <option value="name-asc">Name: A → Z</option>
            <option value="name-desc">Name: Z → A</option>
        </select>

        <div class="header-right">
            <button class="filter-toggle" onclick="toggleSidebar()">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <line x1="4" y1="6" x2="20" y2="6"/><line x1="8" y1="12" x2="16" y2="12"/>
                    <line x1="11" y1="18" x2="13" y2="18"/>
                </svg>
                Filters
            </button>

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

<%-- SIDEBAR BACKDROP (mobile) --%>
<div class="sidebar-backdrop" id="sidebarBackdrop" onclick="toggleSidebar()"></div>

<%-- PAGE BODY --%>
<div class="page-body">

    <%-- SIDEBAR FILTERS --%>
    <aside class="sidebar" id="sidebar">

        <div class="sidebar-head">
            <span>Filters</span>
            <button class="clear-btn" onclick="clearFilters()">Clear all</button>
        </div>

        <%-- Category --%>
        <div class="filter-section">
            <span class="filter-label">Category</span>
            <div class="cat-list" id="catList">
                <% if (categories != null) {
                    for (String cat : categories) { %>
                <label class="cat-item" data-cat="<%= cat %>">
                    <input type="checkbox" value="<%= cat %>">
                    <span class="cat-dot"></span>
                    <span class="cat-name"><%= cat %></span>
                </label>
                <%   }
                } %>
            </div>
        </div>

        <%-- Price range --%>
        <div class="filter-section">
            <span class="filter-label">Price Range</span>
            <div class="price-inputs">
                <div class="price-input-wrap">
                    <label>Min ($)</label>
                    <input type="number" id="priceMin" placeholder="0" min="0">
                </div>
                <div class="price-input-wrap">
                    <label>Max ($)</label>
                    <input type="number" id="priceMax" placeholder="Any" min="0">
                </div>
            </div>
        </div>

        <%-- Availability --%>
        <div class="filter-section">
            <span class="filter-label">Availability</span>
            <div class="avail-opts">
                <label class="avail-item active" data-avail="all">
                    <input type="radio" name="avail" value="all" checked>
                    <span>All artworks</span>
                </label>
                <label class="avail-item" data-avail="available">
                    <input type="radio" name="avail" value="available">
                    <span>Available only</span>
                </label>
            </div>
        </div>

        <button class="apply-btn" onclick="applyFilters()">Apply Filters</button>
    </aside>

    <%-- ── MAIN CONTENT ─────────────────────────────── --%>
    <div class="main-content">

        <div class="results-bar">
            <span class="results-count">
                Showing <strong id="visibleCount">0</strong> artworks
            </span>
            <div class="view-toggle">
                <button class="view-btn" title="2 columns" onclick="setView(2)">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="7" height="18" rx="1"/><rect x="14" y="3" width="7" height="18" rx="1"/>
                    </svg>
                </button>
                <button class="view-btn active" title="3 columns" onclick="setView(3)">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="3" y="3" width="4" height="18" rx="1"/><rect x="10" y="3" width="4" height="18" rx="1"/>
                        <rect x="17" y="3" width="4" height="18" rx="1"/>
                    </svg>
                </button>
                <button class="view-btn" title="4 columns" onclick="setView(4)">
                    <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <rect x="2" y="3" width="4" height="18" rx="1"/><rect x="8" y="3" width="4" height="18" rx="1"/>
                        <rect x="14" y="3" width="4" height="18" rx="1"/><rect x="20" y="3" width="4" height="18" rx="1"/>
                    </svg>
                </button>
            </div>
        </div>

        <%-- ART GRID — fully from backend --%>
        <div id="artGrid">
            <% if (artworks != null && !artworks.isEmpty()) {
                for (Art art : artworks) {
                    String src = (art.getImageUrl() != null && !art.getImageUrl().isEmpty())
                            ? ctx + "/images/art/" + art.getImageUrl()
                            : ctx + "/images/default_art.webp";
                    boolean sold = art.isSold();
                    String descEsc = art.getDescription() != null
                            ? art.getDescription().replace("'", "\\'").replace("\"", "&quot;")
                            : "";
                    String titleEsc = art.getTitle().replace("'", "\\'");
                    String artistEsc = art.getArtistName() != null
                            ? art.getArtistName().replace("'", "\\'")
                            : "Unknown";
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
                         <%= sold %>
                             )">

                <div class="card-thumb">
                    <img src="<%= src %>"
                         alt="<%= art.getTitle() %>"
                         onerror="this.src='<%= ctx %>/images/default_art.webp'">
                    <span class="card-cat"><%= art.getCategory() %></span>
                    <% if (sold) { %>
                    <div class="card-sold-badge"><span>Sold</span></div>
                    <% } %>
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
                    <button class="btn-cart"
                            id="cartBtn-<%= art.getId() %>"
                            onclick="addToCart('<%= art.getId() %>', '<%= titleEsc %>', '<%= String.format("%.2f", art.getPrice()) %>', this)">
                        <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                            <path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/>
                        </svg>
                        Add to Cart
                    </button>
                    <% } %>
                </div>

            </article>
            <%   }
            } %>

            <%-- no-results placeholder (shown by JS) --%>
            <div class="no-results" id="noResults" style="display:none;">
                <svg width="50" height="50" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                    <circle cx="11" cy="11" r="8"/><path d="M21 21l-4.35-4.35"/>
                    <line x1="8" y1="11" x2="14" y2="11"/>
                </svg>
                <h3>No artworks found</h3>
                <p>Try adjusting your search or filters.</p>
            </div>
        </div>

    </div><%-- /.main-content --%>
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

<%-- ════════════════════════════════════════════════════
     CART TOAST
════════════════════════════════════════════════════ --%>
<div class="toast" id="toast">
    <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
        <polyline points="20 6 9 17 4 12"/>
    </svg>
    <span id="toastMsg">Added to cart</span>
</div>

<jsp:include page="../components/footer.jsp" />

<script>
    /* ══════════════════════════════════════════════════
       STATE
    ══════════════════════════════════════════════════ */
    var cart = JSON.parse(localStorage.getItem('artopia_cart') || '[]');
    var activeDetail = null; // { id, title, price }

    /* ══════════════════════════════════════════════════
       INIT
    ══════════════════════════════════════════════════ */
    (function init() {
        updateCartUI();
        updateCount();
        // restore cart button states
        cart.forEach(function(item) {
            markCardAdded(item.id);
        });
    })();

    /* ══════════════════════════════════════════════════
       SEARCH  (live, client-side)
    ══════════════════════════════════════════════════ */
    document.getElementById('searchInput').addEventListener('input', function() {
        applyFilters();
    });

    /* ══════════════════════════════════════════════════
       SORT
    ══════════════════════════════════════════════════ */
    document.getElementById('sortSelect').addEventListener('change', function() {
        applyFilters();
    });

    /* ══════════════════════════════════════════════════
       FILTER SIDEBAR TOGGLE (mobile)
    ══════════════════════════════════════════════════ */
    function toggleSidebar() {
        var sb = document.getElementById('sidebar');
        var bd = document.getElementById('sidebarBackdrop');
        sb.classList.toggle('open');
        bd.classList.toggle('show');
    }

    /* ══════════════════════════════════════════════════
       CATEGORY PILL TOGGLE
    ══════════════════════════════════════════════════ */
    document.querySelectorAll('.cat-item').forEach(function(item) {
        item.addEventListener('click', function() {
            item.classList.toggle('active');
            item.querySelector('input').checked = item.classList.contains('active');
        });
    });

    /* ══════════════════════════════════════════════════
       AVAILABILITY RADIO
    ══════════════════════════════════════════════════ */
    document.querySelectorAll('.avail-item').forEach(function(item) {
        item.addEventListener('click', function() {
            document.querySelectorAll('.avail-item').forEach(function(a){ a.classList.remove('active'); });
            item.classList.add('active');
            item.querySelector('input').checked = true;
        });
    });

    /* ══════════════════════════════════════════════════
       APPLY FILTERS (search + filter + sort together)
    ══════════════════════════════════════════════════ */
    function applyFilters() {
        var q        = document.getElementById('searchInput').value.toLowerCase().trim();
        var sort     = document.getElementById('sortSelect').value;
        var minPrice = parseFloat(document.getElementById('priceMin').value) || 0;
        var maxPrice = parseFloat(document.getElementById('priceMax').value) || Infinity;
        var avail    = document.querySelector('.avail-item.active').dataset.avail;

        // selected categories
        var selCats = [];
        document.querySelectorAll('.cat-item.active').forEach(function(c){ selCats.push(c.dataset.cat); });

        var cards = Array.from(document.querySelectorAll('.art-card'));

        // filter
        var visible = cards.filter(function(card) {
            var title   = card.dataset.title   || '';
            var artist  = card.dataset.artist  || '';
            var cat     = card.dataset.category || '';
            var price   = parseFloat(card.dataset.price) || 0;
            var isSold  = card.dataset.sold === 'true';

            if (q && title.indexOf(q) === -1 && artist.indexOf(q) === -1) return false;
            if (selCats.length && selCats.indexOf(cat) === -1) return false;
            if (price < minPrice || price > maxPrice) return false;
            if (avail === 'available' && isSold) return false;
            return true;
        });

        // sort
        visible.sort(function(a, b) {
            var pa = parseFloat(a.dataset.price);
            var pb = parseFloat(b.dataset.price);
            var ta = a.dataset.title;
            var tb = b.dataset.title;
            if (sort === 'price-asc')  return pa - pb;
            if (sort === 'price-desc') return pb - pa;
            if (sort === 'name-asc')   return ta.localeCompare(tb);
            if (sort === 'name-desc')  return tb.localeCompare(ta);
            return 0;
        });

        // hide all first
        cards.forEach(function(c){ c.style.display = 'none'; });

        // re-append in sorted order
        var grid = document.getElementById('artGrid');
        visible.forEach(function(c){
            c.style.display = '';
            grid.appendChild(c);
        });

        // no results
        var nr = document.getElementById('noResults');
        nr.style.display = visible.length === 0 ? 'block' : 'none';

        updateCount(visible.length);
    }

    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('priceMin').value    = '';
        document.getElementById('priceMax').value    = '';
        document.getElementById('sortSelect').value  = 'default';
        document.querySelectorAll('.cat-item').forEach(function(c){ c.classList.remove('active'); c.querySelector('input').checked = false; });
        document.querySelectorAll('.avail-item').forEach(function(a, i){ a.classList.toggle('active', i===0); });
        applyFilters();
    }

    /* ══════════════════════════════════════════════════
       VIEW MODE
    ══════════════════════════════════════════════════ */
    function setView(cols) {
        var grid = document.getElementById('artGrid');
        grid.classList.remove('view-2','view-4');
        if (cols === 2) grid.classList.add('view-2');
        if (cols === 4) grid.classList.add('view-4');
        document.querySelectorAll('.view-btn').forEach(function(btn, i){
            btn.classList.toggle('active', [2,3,4][i] === cols);
        });
    }

    /* ══════════════════════════════════════════════════
       COUNT
    ══════════════════════════════════════════════════ */
    function updateCount(n) {
        if (n === undefined) {
            n = document.querySelectorAll('.art-card:not([style*="display: none"])').length;
            if (n === 0) n = document.querySelectorAll('.art-card').length;
        }
        document.getElementById('visibleCount').textContent = n;
    }

    /* ══════════════════════════════════════════════════
       DETAIL MODAL
    ══════════════════════════════════════════════════ */
    function openDetail(id, title, artist, cat, desc, price, imgSrc, sold) {
        activeDetail = { id: id, title: title, price: price };
        document.getElementById('d-img').src          = imgSrc;
        document.getElementById('d-img').alt          = title;
        document.getElementById('d-cat').textContent  = cat;
        document.getElementById('d-title').textContent = title;
        document.getElementById('d-artist').textContent = 'by ' + artist;
        document.getElementById('d-desc').textContent = desc || 'No description provided.';
        document.getElementById('d-price').textContent = '$' + price;

        var dBtn = document.getElementById('d-cartBtn');
        if (sold) {
            dBtn.textContent = 'Sold Out';
            dBtn.disabled = true;
            dBtn.style.opacity = '.4';
            dBtn.style.cursor  = 'not-allowed';
        } else {
            dBtn.disabled = false;
            dBtn.style.opacity = '';
            dBtn.style.cursor  = '';
            var inCart = cart.some(function(c){ return c.id === id; });
            if (inCart) {
                dBtn.classList.add('added');
                dBtn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg> In Cart';
            } else {
                dBtn.classList.remove('added');
                dBtn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg> Add to Cart';
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
        addToCart(activeDetail.id, activeDetail.title, activeDetail.price,
            document.getElementById('cartBtn-' + activeDetail.id));
        var dBtn = document.getElementById('d-cartBtn');
        dBtn.classList.add('added');
        dBtn.innerHTML = '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg> In Cart';
    }

    /* close overlay on backdrop */
    document.getElementById('detailOverlay').addEventListener('click', function(e){
        if (e.target === this) closeDetail();
    });
    document.addEventListener('keydown', function(e){
        if (e.key === 'Escape') closeDetail();
    });

    /* ══════════════════════════════════════════════════
       CART
    ══════════════════════════════════════════════════ */
    function addToCart(id, title, price, btn) {
        var alreadyIn = cart.some(function(c){ return c.id == id; });
        if (alreadyIn) { showToast('"' + title + '" is already in your cart.'); return; }

        cart.push({ id: id, title: title, price: price });
        localStorage.setItem('artopia_cart', JSON.stringify(cart));
        markCardAdded(id);
        updateCartUI();
        showToast('"' + title + '" added to cart.');
    }

    function markCardAdded(id) {
        var btn = document.getElementById('cartBtn-' + id);
        if (btn) {
            btn.classList.add('added');
            btn.innerHTML = '<svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polyline points="20 6 9 17 4 12"/></svg> Added';
        }
    }

    function updateCartUI() {
        var count = cart.length;
        var badge = document.getElementById('cartCount');
        badge.textContent = count;
        badge.classList.toggle('show', count > 0);
    }

    function openCartPage() {
        window.location.href = '<%= ctx %>/cart';
    }

    /* ══════════════════════════════════════════════════
       TOAST
    ══════════════════════════════════════════════════ */
    var toastTimer;
    function showToast(msg) {
        clearTimeout(toastTimer);
        document.getElementById('toastMsg').textContent = msg;
        var t = document.getElementById('toast');
        t.classList.add('show');
        toastTimer = setTimeout(function(){ t.classList.remove('show'); }, 2800);
    }

    /* initial count */
    updateCount();
</script>

</body>
</html>
