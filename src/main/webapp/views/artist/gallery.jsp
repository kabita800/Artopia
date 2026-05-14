<%--
    artist/gallery.jsp
    Two-tab gallery page for artists:
      Tab 1 — All Artworks  : browse every artwork in the system
      Tab 2 — My Collection : manage own artworks (add / edit / delete)

    Servlet must set:
      request.getAttribute("allArtworks")  → List<Art>   (all artworks)
      request.getAttribute("myArtworks")   → List<Art>   (this artist's artworks)
      request.getAttribute("successMsg")   → String      (optional flash)
      request.getAttribute("errorMsg")     → String      (optional flash)

    Art model getters used:
      getId(), getTitle(), getDescription(), getCategory(),
      getPrice(), getImageUrl(), getArtistName(),
      getViewCount(), getSoldCount(), isSold()
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.artopia1.user.model.Art" %>
<%
    List<Art> allArtworks = (List<Art>) request.getAttribute("allArtworks");
    List<Art> myArtworks  = (List<Art>) request.getAttribute("myArtworks");
    String    successMsg  = (String)    request.getAttribute("successMsg");
    String    errorMsg    = (String)    request.getAttribute("errorMsg");
    String    ctx         = request.getContextPath();
    String    userRole    = (String) session.getAttribute("userRole");
    boolean   isArtist    = userRole != null && "artist".equalsIgnoreCase(userRole);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gallery — Artopia</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,400&family=DM+Mono:wght@300;400;500&display=swap" rel="stylesheet">
    <style>

        /* TOKENS */
        :root {
            --bg:          #080808;
            --surface:     #0f0f0f;
            --surface-2:   #151515;
            --border:      #1e1e1e;
            --border-2:    #2a2a2a;
            --accent:      #c9a96e;
            --accent-dim:  rgba(201,169,110,.10);
            --accent-glow: rgba(201,169,110,.20);
            --danger:      #b94040;
            --danger-dim:  rgba(185,64,64,.10);
            --text:        #edeae4;
            --text-2:      #9a9590;
            --text-3:      #555;
            --r:           2px;
            --ease:        cubic-bezier(.4,0,.2,1);
        }

        /*  RESET */
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
        html{scroll-behavior:smooth}
        body{
            background:var(--bg);
            color:var(--text);
            font-family:'DM Mono',monospace;
            font-size:13px;
            line-height:1.6;
            min-height:100vh;
            overflow-x:hidden;
        }
        /* grain texture */
        body::before{
            content:'';
            position:fixed;inset:0;
            background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='.88' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='.032'/%3E%3C/svg%3E");
            pointer-events:none;
            z-index:0;
        }
        a{color:inherit;text-decoration:none}
        img{display:block}
        button{font-family:'DM Mono',monospace;cursor:pointer}

        /*  LAYOUT WRAPPER */
        .wrap{
            max-width:1340px;
            margin:0 auto;
            padding:0 2.5rem;
            position:relative;
            z-index:1;
        }

        /* STICKY PAGE HEADER */
        .pg-header{
            position:sticky;
            top:0;
            background:rgba(8,8,8,.94);
            backdrop-filter:blur(16px);
            -webkit-backdrop-filter:blur(16px);
            border-bottom:1px solid var(--border);
            z-index:200;
        }
        .pg-header .wrap{
            display:flex;
            align-items:center;
            justify-content:space-between;
            gap:1.5rem;
            padding-top:1.1rem;
            padding-bottom:1.1rem;
        }
        .header-left{display:flex;align-items:center;gap:1.8rem}
        .back-link{
            display:flex;
            align-items:center;
            gap:.4rem;
            font-size:9px;
            letter-spacing:.3em;
            text-transform:uppercase;
            color:var(--text-3);
            transition:color .2s;
        }
        .back-link:hover{color:var(--accent)}
        .back-link:hover svg{transform:translateX(-3px)}
        .back-link svg{transition:transform .2s;flex-shrink:0}
        .pg-title{
            font-family:'Cormorant Garamond',serif;
            font-size:1.45rem;
            font-weight:400;
            letter-spacing:-.01em;
            color:var(--text);
        }

        /* tab switcher */
        .tabs{
            display:flex;
            border:1px solid var(--border);
            border-radius:var(--r);
            overflow:hidden;
        }
        .tab-btn{
            padding:.5rem 1.5rem;
            font-size:9px;
            letter-spacing:.22em;
            text-transform:uppercase;
            background:transparent;
            color:var(--text-3);
            border:none;
            transition:background .2s,color .2s;
        }
        .tab-btn+.tab-btn{border-left:1px solid var(--border)}
        .tab-btn.is-active,.tab-btn:hover{
            background:var(--accent-dim);
            color:var(--accent);
        }

        /* add button */
        .btn-add{
            display:inline-flex;
            align-items:center;
            gap:.5rem;
            padding:.55rem 1.4rem;
            background:var(--accent);
            color:#080808;
            border:none;
            font-size:9px;
            font-weight:500;
            letter-spacing:.2em;
            text-transform:uppercase;
            border-radius:var(--r);
            transition:opacity .2s;
        }
        .btn-add:hover{opacity:.82}
        .header-slot-end{
            width:10.5rem;
            flex-shrink:0;
            min-height:1px;
        }

        /* ARTIST SIDEBAR (logged-in artist only) */
        .page-studio{
            display:flex;
            align-items:flex-start;
            gap:2rem;
            max-width:1520px;
            margin:0 auto;
            padding:0 1.5rem 4rem;
            position:relative;
            z-index:1;
        }
        .artist-sidebar{
            flex:0 0 260px;
            position:sticky;
            top:5.5rem;
            align-self:flex-start;
            padding:1.35rem 1.25rem 1.5rem;
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:var(--r);
        }
        .artist-sidebar__eyebrow{
            font-size:8px;
            letter-spacing:.28em;
            text-transform:uppercase;
            color:var(--text-3);
            margin-bottom:.5rem;
        }
        .artist-sidebar__title{
            font-family:'Cormorant Garamond',serif;
            font-size:1.35rem;
            font-weight:400;
            color:var(--text);
            margin-bottom:.75rem;
        }
        .artist-sidebar__hint{
            font-size:11px;
            line-height:1.55;
            color:var(--text-2);
            margin-bottom:1.25rem;
        }
        .artist-sidebar__btn-add{
            display:flex;
            align-items:center;
            justify-content:center;
            gap:.45rem;
            width:100%;
            padding:.75rem 1rem;
            margin-bottom:.85rem;
            background:var(--accent);
            color:#080808;
            border:none;
            font-size:9px;
            font-weight:600;
            letter-spacing:.18em;
            text-transform:uppercase;
            border-radius:var(--r);
            transition:opacity .2s;
        }
        .artist-sidebar__btn-add:hover{opacity:.88}
        .artist-sidebar__btn-tab{
            display:block;
            width:100%;
            padding:.55rem .75rem;
            background:transparent;
            border:1px solid var(--border);
            color:var(--text-2);
            font-size:9px;
            letter-spacing:.16em;
            text-transform:uppercase;
            border-radius:var(--r);
            transition:border-color .2s,color .2s,background .2s;
        }
        .artist-sidebar__btn-tab:hover{
            border-color:var(--border-2);
            color:var(--text);
            background:var(--surface-2);
        }
        .gallery-main{flex:1;min-width:0}

        /*  FLASH MESSAGES */
        .flash{
            border-left:2px solid;
            padding:.8rem 1.2rem;
            font-size:11px;
            letter-spacing:.04em;
            border-radius:0 var(--r) var(--r) 0;
            margin:1.4rem 0 0;
        }
        .flash-ok { border-color:#4caf77; background:rgba(76,175,119,.07); color:#4caf77; }
        .flash-err{ border-color:var(--danger); background:var(--danger-dim); color:#d46060; }

        /* TAB PANELS */
        .tab-panel{display:none;padding:3rem 0 7rem}
        .tab-panel.is-active{display:block}

        /* section heading row */
        .sec-head{
            display:flex;
            align-items:center;
            gap:1rem;
            margin-bottom:2.5rem;
        }
        .sec-head h2{
            font-family:'Cormorant Garamond',serif;
            font-size:1.2rem;
            font-weight:400;
            color:var(--text);
            white-space:nowrap;
        }
        .sec-head .rule{flex:1;height:1px;background:var(--border)}
        .sec-head .pill{
            font-size:9px;
            letter-spacing:.25em;
            text-transform:uppercase;
            color:var(--text-3);
        }

        /* ALL-ARTWORKS — masonry columns */
        .masonry{
            columns:4;
            column-gap:1.2rem;
        }
        @media(max-width:1100px){.masonry{columns:3}}
        @media(max-width:720px) {.masonry{columns:2}}
        @media(max-width:460px) {.masonry{columns:1}}

        .m-card{
            break-inside:avoid;
            margin-bottom:1.2rem;
            position:relative;
            overflow:hidden;
            border:1px solid var(--border);
            border-radius:var(--r);
            background:var(--surface);
            transition:border-color .3s,transform .35s var(--ease);
        }
        .m-card:hover{
            border-color:var(--border-2);
            transform:translateY(-4px);
        }
        .m-card img{
            width:100%;
            height:auto;
            display:block;
            filter:grayscale(12%) brightness(.92);
            transition:filter .5s,transform .6s var(--ease);
        }
        .m-card:hover img{
            filter:none;
            transform:scale(1.04);
        }
        .m-card__price{
            position:absolute;
            top:.7rem;
            right:.7rem;
            padding:.22rem .65rem;
            background:rgba(0,0,0,.72);
            border:1px solid rgba(201,169,110,.28);
            border-radius:var(--r);
            font-size:10px;
            letter-spacing:.06em;
            color:var(--accent);
        }
        .m-card__overlay{
            position:absolute;
            inset:0;
            background:linear-gradient(0deg,rgba(0,0,0,.88) 0%,transparent 55%);
            opacity:0;
            transition:opacity .3s;
            display:flex;
            flex-direction:column;
            justify-content:flex-end;
            padding:1.1rem;
            pointer-events:none;
        }
        .m-card:hover .m-card__overlay{opacity:1}
        .m-card__name{
            font-family:'Cormorant Garamond',serif;
            font-size:1rem;
            font-weight:400;
            color:#fff;
            margin-bottom:.2rem;
        }
        .m-card__sub{
            font-size:9px;
            letter-spacing:.2em;
            text-transform:uppercase;
            color:var(--accent);
        }

        /* MY COLLECTION — structured grid */
        .my-grid{
            display:grid;
            grid-template-columns:repeat(auto-fill,minmax(285px,1fr));
            gap:1.4rem;
        }

        .my-card{
            background:var(--surface);
            border:1px solid var(--border);
            border-radius:var(--r);
            overflow:hidden;
            display:flex;
            flex-direction:column;
            transition:border-color .3s,box-shadow .3s;
            animation:fadeUp .45s both;
        }
        .my-card:hover{
            border-color:var(--border-2);
            box-shadow:0 10px 50px rgba(0,0,0,.55);
        }

        /* staggered delay */
        .my-card:nth-child(1){animation-delay:.04s}
        .my-card:nth-child(2){animation-delay:.08s}
        .my-card:nth-child(3){animation-delay:.12s}
        .my-card:nth-child(4){animation-delay:.16s}
        .my-card:nth-child(5){animation-delay:.20s}
        .my-card:nth-child(6){animation-delay:.24s}
        .my-card:nth-child(n+7){animation-delay:.28s}

        .my-card__thumb{
            position:relative;
            overflow:hidden;
            aspect-ratio:4/3;
        }
        .my-card__thumb img{
            width:100%;
            height:100%;
            object-fit:cover;
            filter:grayscale(10%) brightness(.9);
            transition:transform .55s var(--ease),filter .4s;
        }
        .my-card:hover .my-card__thumb img{
            transform:scale(1.06);
            filter:none;
        }
        .my-card__idx{
            position:absolute;
            bottom:.7rem;
            left:.7rem;
            width:24px;
            height:24px;
            background:rgba(0,0,0,.65);
            border:1px solid var(--border-2);
            border-radius:50%;
            display:flex;
            align-items:center;
            justify-content:center;
            font-size:9px;
            color:var(--text-3);
        }
        .my-card__status{
            position:absolute;
            top:.7rem;
            right:.7rem;
            padding:.2rem .6rem;
            font-size:8px;
            letter-spacing:.22em;
            text-transform:uppercase;
            border:1px solid;
            border-radius:var(--r);
        }
        .status-available{
            background:rgba(76,175,119,.1);
            border-color:rgba(76,175,119,.35);
            color:#4caf77;
        }
        .status-sold{
            background:rgba(185,64,64,.1);
            border-color:rgba(185,64,64,.35);
            color:#d46060;
        }

        .my-card__body{
            padding:1.1rem 1.25rem;
            flex:1;
            display:flex;
            flex-direction:column;
            gap:.35rem;
        }
        .my-card__cat{
            font-size:8px;
            letter-spacing:.3em;
            text-transform:uppercase;
            color:var(--accent);
        }
        .my-card__title{
            font-family:'Cormorant Garamond',serif;
            font-size:1.05rem;
            font-weight:400;
            color:var(--text);
            line-height:1.25;
        }
        .my-card__desc{
            font-size:11px;
            color:var(--text-2);
            line-height:1.55;
            display:-webkit-box;
            -webkit-line-clamp:2;
            -webkit-box-orient:vertical;
            overflow:hidden;
            margin-top:.15rem;
        }
        .my-card__stats{
            display:flex;
            gap:1.5rem;
            margin-top:auto;
            padding-top:.85rem;
        }
        .stat-item{display:flex;flex-direction:column;gap:2px}
        .stat-val{
            font-family:'Cormorant Garamond',serif;
            font-size:1.2rem;
            color:var(--accent);
            line-height:1;
        }
        .stat-lbl{
            font-size:8px;
            letter-spacing:.25em;
            text-transform:uppercase;
            color:var(--text-3);
        }

        .my-card__foot{
            padding:.85rem 1.25rem;
            border-top:1px solid var(--border);
            display:flex;
            align-items:center;
            justify-content:space-between;
        }
        .my-card__price{
            font-family:'Cormorant Garamond',serif;
            font-size:1.15rem;
            color:var(--text);
            letter-spacing:.01em;
        }
        .card-actions{display:flex;gap:.5rem}

        /* action icon buttons */
        .ibtn{
            display:inline-flex;
            align-items:center;
            gap:.35rem;
            padding:.38rem .85rem;
            font-size:8px;
            letter-spacing:.18em;
            text-transform:uppercase;
            border:1px solid var(--border-2);
            border-radius:var(--r);
            background:transparent;
            color:var(--text-3);
            transition:all .2s;
        }
        .ibtn-edit:hover{border-color:var(--accent);color:var(--accent);background:var(--accent-dim)}
        .ibtn-del:hover{border-color:var(--danger);color:#d46060;background:var(--danger-dim)}

        /* EMPTY STATE */
        .empty{
            grid-column:1/-1;
            text-align:center;
            padding:6rem 2rem;
            color:var(--text-3);
        }
        .empty svg{margin:0 auto 1.5rem;opacity:.2}
        .empty h3{
            font-family:'Cormorant Garamond',serif;
            font-size:1.3rem;
            font-weight:300;
            color:var(--text-2);
            margin-bottom:.4rem;
        }
        .empty p{font-size:11px;opacity:.6}

        /* MODALS */
        .overlay{
            position:fixed;inset:0;
            background:rgba(0,0,0,.80);
            backdrop-filter:blur(8px);
            -webkit-backdrop-filter:blur(8px);
            z-index:500;
            display:none;
            align-items:center;
            justify-content:center;
            padding:1.5rem;
        }
        .overlay.open{display:flex}

        .modal{
            background:var(--surface-2);
            border:1px solid var(--border-2);
            border-radius:var(--r);
            width:100%;
            max-width:520px;
            max-height:90vh;
            overflow-y:auto;
            animation:mIn .28s var(--ease);
        }
        .modal-sm{max-width:380px}

        @keyframes mIn{
            from{opacity:0;transform:translateY(20px) scale(.97)}
            to  {opacity:1;transform:none}
        }

        .modal-head{
            display:flex;
            align-items:center;
            justify-content:space-between;
            padding:1.4rem 1.6rem 1rem;
            border-bottom:1px solid var(--border);
        }
        .modal-head h3{
            font-family:'Cormorant Garamond',serif;
            font-size:1.1rem;
            font-weight:400;
            color:var(--text);
        }
        .modal-x{
            background:none;
            border:none;
            color:var(--text-3);
            font-size:1.2rem;
            line-height:1;
            cursor:pointer;
            transition:color .2s;
            padding:.2rem .4rem;
        }
        .modal-x:hover{color:var(--text)}

        .modal-body{padding:1.4rem 1.6rem 1.8rem}

        /* form */
        .fg{display:flex;flex-direction:column;gap:.4rem;margin-bottom:1.1rem}
        .fg:last-child{margin-bottom:0}
        .fg label{
            font-size:8px;
            letter-spacing:.3em;
            text-transform:uppercase;
            color:var(--accent);
        }
        .fg input,.fg textarea,.fg select{
            background:var(--surface);
            border:1px solid var(--border);
            color:var(--text);
            font-family:'DM Mono',monospace;
            font-size:12.5px;
            padding:.7rem .9rem;
            border-radius:var(--r);
            outline:none;
            width:100%;
            transition:border-color .2s,box-shadow .2s;
        }
        .fg input:focus,.fg textarea:focus,.fg select:focus{
            border-color:var(--accent);
            box-shadow:0 0 0 3px var(--accent-glow);
        }
        .fg textarea{resize:vertical;min-height:85px;line-height:1.55}
        .fg select option{background:#141414}
        .fg-row{display:grid;grid-template-columns:1fr 1fr;gap:1rem}
        .fg-hint{font-size:9px;color:var(--text-3);margin-top:.3rem}

        .modal-foot{
            display:flex;
            justify-content:flex-end;
            gap:.7rem;
            padding-top:1.3rem;
            border-top:1px solid var(--border);
            margin-top:1.4rem;
        }

        .mbtn{
            padding:.58rem 1.4rem;
            font-size:8px;
            letter-spacing:.2em;
            text-transform:uppercase;
            border:1px solid;
            border-radius:var(--r);
            transition:all .2s;
        }
        .mbtn-cancel{
            background:transparent;
            border-color:var(--border-2);
            color:var(--text-3);
        }
        .mbtn-cancel:hover{border-color:var(--text-2);color:var(--text)}
        .mbtn-submit{
            background:var(--accent);
            border-color:var(--accent);
            color:#080808;
            font-weight:500;
        }
        .mbtn-submit:hover{opacity:.82}
        .mbtn-danger{
            background:var(--danger);
            border-color:var(--danger);
            color:#fff;
        }
        .mbtn-danger:hover{opacity:.82}

        /* delete confirm modal */
        .del-body{padding:2rem 1.6rem;text-align:center}
        .del-body svg{margin:0 auto 1rem;opacity:.5}
        .del-body h4{
            font-family:'Cormorant Garamond',serif;
            font-size:1.15rem;
            font-weight:400;
            margin-bottom:.5rem;
        }
        .del-body p{font-size:11px;color:var(--text-2);margin-bottom:0}
        .del-foot{
            display:flex;
            justify-content:center;
            gap:.75rem;
            padding:1.2rem 1.6rem 1.6rem;
            border-top:1px solid var(--border);
        }

        /* ══════════════════════════════════════════════════════════
           SCROLLBAR
        ══════════════════════════════════════════════════════════ */
        ::-webkit-scrollbar{width:5px}
        ::-webkit-scrollbar-track{background:var(--bg)}
        ::-webkit-scrollbar-thumb{background:var(--border-2);border-radius:3px}
        ::-webkit-scrollbar-thumb:hover{background:var(--text-3)}

        /* ══════════════════════════════════════════════════════════
           ANIMATION
        ══════════════════════════════════════════════════════════ */
        @keyframes fadeUp{
            from{opacity:0;transform:translateY(14px)}
            to  {opacity:1;transform:none}
        }

        /* ══════════════════════════════════════════════════════════
           RESPONSIVE
        ══════════════════════════════════════════════════════════ */
        @media(max-width:900px){
            .page-studio{flex-direction:column;gap:1.25rem;padding:0 1.2rem 3rem}
            .artist-sidebar{
                position:relative;
                top:auto;
                flex:1 1 auto;
                width:100%;
            }
        }
        @media(max-width:640px){
            .wrap{padding:0 1.2rem}
            .fg-row{grid-template-columns:1fr}
            .tab-btn{padding:.45rem .9rem;font-size:8px}
            .pg-title{font-size:1.2rem}
        }

    </style>
</head>
<body>

<jsp:include page="../components/navbar.jsp" />

<% if (isArtist) { %>
<div class="page-studio">
    <aside class="artist-sidebar" aria-label="Artist tools">
        <p class="artist-sidebar__eyebrow">Your studio</p>
        <h2 class="artist-sidebar__title">Your artworks</h2>
        <p class="artist-sidebar__hint">Click <strong>Add artwork</strong> to enter the <strong>name</strong>, <strong>type</strong> (category), and a <strong>short description</strong>. Then add price and an image to publish.</p>
        <button type="button" class="artist-sidebar__btn-add" onclick="openModal('addOverlay')">
            <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M12 5v14M5 12h14"/></svg>
            Add artwork
        </button>
        <button type="button" class="artist-sidebar__btn-tab" onclick="artopiaGoMyCollection()">Open My collection</button>
    </aside>
    <div class="gallery-main">
<% } %>

<%-- ════════════════════════════════════════════════════════
     PAGE HEADER
════════════════════════════════════════════════════════ --%>
<header class="pg-header">
    <div class="wrap">
        <div class="header-left">
            <a href="<%= ctx %>/home" class="back-link">
                <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M19 12H5M12 5l-7 7 7 7"/></svg>
                Home
            </a>
            <span class="pg-title">Gallery</span>
        </div>

        <nav class="tabs" role="tablist">
            <button class="tab-btn is-active" role="tab" data-target="panel-all">All Artworks</button>
            <button class="tab-btn"           role="tab" data-target="panel-mine">My Collection</button>
        </nav>

        <div class="header-slot-end" aria-hidden="true"></div>
    </div>
</header>

<main class="wrap">

    <%-- ══════════════════════════════════════════════════════
         TAB 1 — ALL ARTWORKS
    ══════════════════════════════════════════════════════ --%>
    <section class="tab-panel is-active" id="panel-all">

        <div class="sec-head">
            <h2>All Artworks</h2>
            <span class="rule"></span>
            <span class="pill"><%= (allArtworks != null ? allArtworks.size() : 0) %> pieces</span>
        </div>

        <div class="masonry">
            <% if (allArtworks != null && !allArtworks.isEmpty()) {
                for (Art art : allArtworks) {
                    String src = (art.getImageUrl() != null && !art.getImageUrl().isEmpty())
                            ? ctx + "/images/art/" + art.getImageUrl()
                            : ctx + "/images/default_art.webp";
            %>
            <div class="m-card">
                <img src="<%= src %>"
                     alt="<%= art.getTitle() %>"
                     onerror="this.src='<%= ctx %>/images/default_art.webp'">
                <span class="m-card__price">$<%= String.format("%.2f", art.getPrice()) %></span>
                <div class="m-card__overlay">
                    <p class="m-card__name"><%= art.getTitle() %></p>
                    <p class="m-card__sub"><%= art.getCategory() %> &middot; <%= art.getArtistName() %></p>
                </div>
            </div>
            <%   }
            } else { %>
            <div class="empty" style="column-span:all">
                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                    <rect x="3" y="3" width="18" height="18" rx="2"/><path d="M3 9h18M9 21V9"/>
                </svg>
                <h3>No artworks yet</h3>
                <% if (isArtist) { %>
                <p>The gallery is empty — use <strong style="color:var(--accent)">Add artwork</strong> in the sidebar to publish the first piece.</p>
                <% } else { %>
                <p>The gallery is empty — check back soon.</p>
                <% } %>
            </div>
            <% } %>
        </div>
    </section>

    <%-- ══════════════════════════════════════════════════════
         TAB 2 — MY COLLECTION
    ══════════════════════════════════════════════════════ --%>
    <section class="tab-panel" id="panel-mine">

        <div class="sec-head">
            <h2>My Collection</h2>
            <span class="rule"></span>
            <span class="pill"><%= (myArtworks != null ? myArtworks.size() : 0) %> works</span>
        </div>

        <div class="my-grid">
            <% if (myArtworks != null && !myArtworks.isEmpty()) {
                int n = 1;
                for (Art art : myArtworks) {
                    String src = (art.getImageUrl() != null && !art.getImageUrl().isEmpty())
                            ? ctx + "/images/art/" + art.getImageUrl()
                            : ctx + "/images/default_art.webp";
                    boolean sold = art.isSold();
            %>
            <article class="my-card">

                <div class="my-card__thumb">
                    <span class="my-card__idx"><%= n %></span>
                    <img src="<%= src %>"
                         alt="<%= art.getTitle() %>"
                         onerror="this.src='<%= ctx %>/images/default_art.webp'">
                    <span class="my-card__status <%= sold ? "status-sold" : "status-available" %>">
                        <%= sold ? "Sold" : "Available" %>
                    </span>
                </div>

                <div class="my-card__body">
                    <span class="my-card__cat"><%= art.getCategory() %></span>
                    <h3 class="my-card__title"><%= art.getTitle() %></h3>
                    <p class="my-card__desc"><%= art.getDescription() %></p>

                    <div class="my-card__stats">
                        <div class="stat-item">
                            <span class="stat-val"><%= art.getViewCount() %></span>
                            <span class="stat-lbl">Views</span>
                        </div>
                        <div class="stat-item">
                            <span class="stat-val"><%= art.getSoldCount() %></span>
                            <span class="stat-lbl">Sold</span>
                        </div>
                    </div>
                </div>

                <div class="my-card__foot">
                    <span class="my-card__price">$<%= String.format("%.2f", art.getPrice()) %></span>
                    <div class="card-actions">
                        <button class="ibtn ibtn-edit"
                                onclick="openEdit(
                                        '<%= art.getId() %>',
                                        '<%= art.getTitle().replace("'","\\'") %>',
                                        '<%= art.getDescription().replace("'","\\'") %>',
                                        '<%= art.getPrice() %>',
                                        '<%= art.getCategory() %>'
                                        )">
                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/>
                                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"/>
                            </svg>
                            Edit
                        </button>
                        <button class="ibtn ibtn-del"
                                onclick="openDelete('<%= art.getId() %>', '<%= art.getTitle().replace("'","\\'") %>')">
                            <svg width="10" height="10" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <polyline points="3 6 5 6 21 6"/><path d="M19 6l-1 14H6L5 6"/>
                                <path d="M10 11v6M14 11v6M9 6V4h6v2"/>
                            </svg>
                            Delete
                        </button>
                    </div>
                </div>

            </article>
            <%     n++;
            }
            } else { %>
            <div class="empty">
                <svg width="52" height="52" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1">
                    <rect x="3" y="3" width="18" height="18" rx="2"/>
                    <circle cx="8.5" cy="8.5" r="1.5"/>
                    <path d="M21 15l-5-5L5 21"/>
                </svg>
                <h3>No artworks yet</h3>
                <% if (isArtist) { %>
                <p>Use <strong style="color:var(--accent)">Add artwork</strong> in the sidebar to publish your first piece.</p>
                <% } else { %>
                <p>Sign in as an artist to publish works here.</p>
                <% } %>
            </div>
            <% } %>
        </div>
    </section>

</main>

<% if (isArtist) { %>
    </div>
</div>
<% } %>

<%-- ════════════════════════════════════════════════════════
     MODAL: ADD ARTWORK
════════════════════════════════════════════════════════ --%>
<div class="overlay" id="addOverlay">
    <div class="modal">
        <div class="modal-head">
            <h3>Add New Artwork</h3>
            <button class="modal-x" onclick="closeModal('addOverlay')">&times;</button>
        </div>
        <div class="modal-body">
            <form method="POST" action="<%= ctx %>/art/add" enctype="multipart/form-data">
                <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">

                <div class="fg">
                    <label for="add_title">Artwork name</label>
                    <input type="text" id="add_title" name="title"
                           placeholder="Name of your piece" required>
                </div>

                <div class="fg">
                    <label for="add_cat">Type (category)</label>
                    <select id="add_cat" name="category" required>
                        <option value="" disabled selected>— Select type —</option>
                        <option value="Painting">Painting</option>
                        <option value="Digital Art">Digital Art</option>
                        <option value="Photography">Photography</option>
                        <option value="Sculpture">Sculpture</option>
                        <option value="Watercolour">Watercolour</option>
                        <option value="Illustration">Illustration</option>
                        <option value="Mixed Media">Mixed Media</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="fg">
                    <label for="add_desc">Short description</label>
                    <textarea id="add_desc" name="description" rows="3"
                              placeholder="A few lines about the artwork…"></textarea>
                </div>

                <div class="fg">
                    <label for="add_price">Price (USD)</label>
                    <input type="number" id="add_price" name="price"
                           step="0.01" min="0" placeholder="0.00" required>
                </div>

                <div class="fg">
                    <label for="add_img">Artwork Image</label>
                    <input type="file" id="add_img" name="image"
                           accept="image/jpeg,image/png,image/webp" required>
                    <span class="fg-hint">JPEG, PNG or WebP · max 5 MB</span>
                </div>

                <div class="modal-foot">
                    <button type="button" class="mbtn mbtn-cancel" onclick="closeModal('addOverlay')">Cancel</button>
                    <button type="submit" class="mbtn mbtn-submit">Publish Artwork</button>
                </div>
            </form>
        </div>
    </div>
</div>


<%-- ════════════════════════════════════════════════════════
     MODAL: EDIT ARTWORK
════════════════════════════════════════════════════════ --%>
<div class="overlay" id="editOverlay">
    <div class="modal">
        <div class="modal-head">
            <h3>Edit Artwork</h3>
            <button class="modal-x" onclick="closeModal('editOverlay')">&times;</button>
        </div>
        <div class="modal-body">
            <form method="POST" action="<%= ctx %>/art/update" enctype="multipart/form-data">
                <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
                <input type="hidden" id="edit_id" name="artId">

                <div class="fg">
                    <label for="edit_title">Artwork name</label>
                    <input type="text" id="edit_title" name="title" required>
                </div>

                <div class="fg">
                    <label for="edit_cat">Type (category)</label>
                    <select id="edit_cat" name="category" required>
                        <option value="Painting">Painting</option>
                        <option value="Digital Art">Digital Art</option>
                        <option value="Photography">Photography</option>
                        <option value="Sculpture">Sculpture</option>
                        <option value="Watercolour">Watercolour</option>
                        <option value="Illustration">Illustration</option>
                        <option value="Mixed Media">Mixed Media</option>
                        <option value="Other">Other</option>
                    </select>
                </div>

                <div class="fg">
                    <label for="edit_desc">Short description</label>
                    <textarea id="edit_desc" name="description"></textarea>
                </div>

                <div class="fg">
                    <label for="edit_price">Price (USD)</label>
                    <input type="number" id="edit_price" name="price"
                           step="0.01" min="0" required>
                </div>

                <div class="fg">
                    <label for="edit_img">Replace Image <span class="fg-hint" style="display:inline">(optional)</span></label>
                    <input type="file" id="edit_img" name="image"
                           accept="image/jpeg,image/png,image/webp">
                </div>

                <div class="modal-foot">
                    <button type="button" class="mbtn mbtn-cancel" onclick="closeModal('editOverlay')">Cancel</button>
                    <button type="submit" class="mbtn mbtn-submit">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>


<%-- ════════════════════════════════════════════════════════
     MODAL: DELETE CONFIRM
════════════════════════════════════════════════════════ --%>
<div class="overlay" id="delOverlay">
    <div class="modal modal-sm">
        <div class="del-body">
            <svg width="44" height="44" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.2">
                <circle cx="12" cy="12" r="10"/>
                <line x1="12" y1="8" x2="12" y2="12"/>
                <line x1="12" y1="16" x2="12.01" y2="16"/>
            </svg>
            <h4>Delete Artwork?</h4>
            <p id="del_label">This action cannot be undone.</p>
        </div>
        <form method="POST" action="<%= ctx %>/art/delete">
            <input type="hidden" name="csrfToken" value="${sessionScope.csrfToken}">
            <input type="hidden" id="del_id" name="artId">
            <div class="del-foot">
                <button type="button" class="mbtn mbtn-cancel" onclick="closeModal('delOverlay')">Cancel</button>
                <button type="submit" class="mbtn mbtn-danger">Yes, Delete</button>
            </div>
        </form>
    </div>
</div>


<jsp:include page="../components/footer.jsp" />

<script>
    function artopiaGoMyCollection() {
        document.querySelectorAll('.tab-btn').forEach(function(b){ b.classList.remove('is-active'); });
        document.querySelectorAll('.tab-panel').forEach(function(p){ p.classList.remove('is-active'); });
        var mineBtn = document.querySelector('.tab-btn[data-target="panel-mine"]');
        var minePanel = document.getElementById('panel-mine');
        if (mineBtn) mineBtn.classList.add('is-active');
        if (minePanel) minePanel.classList.add('is-active');
        minePanel && minePanel.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    /* ── Tab switching ─────────────────────────────────────── */
    document.querySelectorAll('.tab-btn').forEach(function(btn) {
        btn.addEventListener('click', function() {
            document.querySelectorAll('.tab-btn').forEach(function(b){ b.classList.remove('is-active'); });
            document.querySelectorAll('.tab-panel').forEach(function(p){ p.classList.remove('is-active'); });
            btn.classList.add('is-active');
            document.getElementById(btn.dataset.target).classList.add('is-active');
        });
    });

    /* ── Modal helpers ─────────────────────────────────────── */
    function openModal(id)  { document.getElementById(id).classList.add('open'); document.body.style.overflow='hidden'; }
    function closeModal(id) { document.getElementById(id).classList.remove('open'); document.body.style.overflow=''; }

    /* close on backdrop click */
    document.querySelectorAll('.overlay').forEach(function(ov) {
        ov.addEventListener('click', function(e) {
            if (e.target === ov) closeModal(ov.id);
        });
    });

    /* close on Escape */
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            document.querySelectorAll('.overlay.open').forEach(function(ov){ closeModal(ov.id); });
        }
    });

    /* ── Open Edit modal with existing data ────────────────── */
    function openEdit(id, title, desc, price, category) {
        document.getElementById('edit_id').value    = id;
        document.getElementById('edit_title').value = title;
        document.getElementById('edit_desc').value  = desc;
        document.getElementById('edit_price').value = price;
        var sel = document.getElementById('edit_cat');
        for (var i = 0; i < sel.options.length; i++) {
            sel.options[i].selected = (sel.options[i].value === category);
        }
        openModal('editOverlay');
    }

    /* ── Open Delete confirm ────────────────────────────────── */
    function openDelete(id, title) {
        document.getElementById('del_id').value    = id;
        document.getElementById('del_label').textContent =
            '"' + title + '" will be permanently removed.';
        openModal('delOverlay');
    }
</script>

</body>
</html>
