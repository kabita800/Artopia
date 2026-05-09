<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Artists</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;0,600;1,400&family=DM+Mono:wght@300;400&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg:         #0a0a0a;
            --surface:    #111111;
            --border:     #1e1e1e;
            --accent:     #c8a97e;
            --accent-2:   #e8c99e;
            --text:       #ede9e2;
            --text-sub:   #7a7470;
            --text-muted: #3c3a38;
            --ease:       cubic-bezier(0.4, 0, 0.2, 1);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        html { scroll-behavior: smooth; }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: 'DM Mono', monospace;
            font-size: 13px;
            line-height: 1.7;
            min-height: 100vh;
        }

        /* ── PAGE HEADER (centered) ── */
        .page-header {
            padding: 5rem 2rem 3.5rem;
            border-bottom: 1px solid var(--border);
            text-align: center;
        }

        .page-header__eyebrow {
            font-size: 9px;
            letter-spacing: 0.48em;
            text-transform: uppercase;
            color: var(--accent);
            margin-bottom: 0.75rem;
        }

        .page-header__title {
            font-family: 'Cormorant Garamond', serif;
            font-size: clamp(2.4rem, 5vw, 3.8rem);
            font-weight: 300;
            letter-spacing: -0.02em;
            color: var(--text);
            line-height: 1.08;
            margin-bottom: 0.75rem;
        }
        .page-header__title em {
            font-style: italic;
            color: var(--accent);
        }

        .page-header__sub {
            font-size: 9px;
            letter-spacing: 0.32em;
            text-transform: uppercase;
            color: var(--text-muted);
        }

        .page-header__rule {
            width: 36px;
            height: 1px;
            background: var(--accent);
            margin: 1.6rem auto 0;
            opacity: 0.45;
        }

        /* ── GRID ── */
        .artists-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(290px, 1fr));
            gap: 1.5rem;
            padding: 2.5rem 2rem;
            background: var(--bg);
        }

        /* ── CARD ── */
        .artist-card {
            background: var(--surface);
            display: flex;
            flex-direction: column;
            overflow: hidden;
            border: 1px solid var(--border);
            transition: background 0.35s var(--ease), border-color 0.35s var(--ease);
        }
        .artist-card:hover {
            background: #151515;
            border-color: #2a2a2a;
        }

        /* Image */
        .artist-card__img-wrap {
            position: relative;
            aspect-ratio: 4/3;
            overflow: hidden;
            background: #141414;
        }
        .artist-card__img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: top center;
            display: block;
            filter: grayscale(22%) contrast(1.04) brightness(0.85);
            transition: transform 0.8s var(--ease), filter 0.5s;
        }
        .artist-card:hover .artist-card__img {
            transform: scale(1.04);
            filter: grayscale(0%) contrast(1.05) brightness(0.92);
        }

        /* Number badge */
        .artist-card__badge {
            position: absolute;
            top: 0.85rem;
            right: 0.85rem;
            background: rgba(8,8,8,0.65);
            border: 1px solid rgba(255,255,255,0.08);
            font-size: 8px;
            letter-spacing: 0.35em;
            color: rgba(255,255,255,0.3);
            padding: 0.22rem 0.55rem;
            backdrop-filter: blur(4px);
        }

        /* Art type pill */
        .artist-card__type-badge {
            position: absolute;
            bottom: 0.85rem;
            left: 0.85rem;
            background: rgba(200,169,126,0.1);
            border: 1px solid rgba(200,169,126,0.35);
            font-size: 8px;
            letter-spacing: 0.22em;
            text-transform: uppercase;
            color: var(--accent);
            padding: 0.22rem 0.7rem;
            backdrop-filter: blur(4px);
        }

        /* Card body */
        .artist-card__body {
            padding: 1.5rem 1.5rem 1.1rem;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 0.7rem;
            border-top: 1px solid var(--border);
        }

        .artist-card__name {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.45rem;
            font-weight: 400;
            color: var(--text);
            letter-spacing: -0.01em;
            line-height: 1.1;
        }
        .artist-card__name em {
            font-style: italic;
            color: var(--accent);
        }

        .artist-card__origin {
            display: flex;
            align-items: center;
            gap: 0.4rem;
            font-size: 8px;
            letter-spacing: 0.22em;
            color: var(--text-muted);
            text-transform: uppercase;
        }
        .artist-card__origin svg { flex-shrink: 0; opacity: 0.38; }

        .artist-card__desc {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1rem;
            font-weight: 300;
            color: var(--text-sub);
            line-height: 1.82;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .artist-card__tags {
            display: flex;
            flex-wrap: wrap;
            gap: 0.3rem;
        }
        .tag {
            font-size: 7px;
            letter-spacing: 0.2em;
            text-transform: uppercase;
            color: var(--text-muted);
            border: 1px solid var(--border);
            padding: 0.22rem 0.55rem;
            transition: border-color 0.2s, color 0.2s;
        }
        .artist-card:hover .tag {
            border-color: #282828;
            color: #504e4b;
        }

        /* Card footer — stats centered with divider */
        .artist-card__footer {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 2.5rem;
            padding: 1rem 1.5rem;
            border-top: 1px solid var(--border);
        }

        .stat-divider {
            width: 1px;
            height: 28px;
            background: var(--border);
            flex-shrink: 0;
        }

        .stat-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.1rem;
        }
        .stat-item__val {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.25rem;
            font-weight: 600;
            color: var(--accent);
            line-height: 1;
        }
        .stat-item__lbl {
            font-size: 7px;
            letter-spacing: 0.32em;
            text-transform: uppercase;
            color: var(--text-muted);
        }

        /* ── RESPONSIVE ── */
        @media (max-width: 900px) {
            .artists-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 1.25rem;
                padding: 2rem 1.5rem;
            }
        }
        @media (max-width: 560px) {
            .artists-grid {
                grid-template-columns: 1fr;
                gap: 1rem;
                padding: 1.5rem 1rem;
            }
            .page-header { padding: 3rem 1.5rem 2.5rem; }
        }
    </style>
</head>
<body>

<jsp:include page="/views/components/navbar.jsp" />

<!-- PAGE HEADER -->
<header class="page-header">
    <p class="page-header__eyebrow">Discover</p>
    <h1 class="page-header__title">Our <em>Artists</em></h1>
    <p class="page-header__sub">7 Featured Artists</p>
    <div class="page-header__rule"></div>
</header>

<!-- ARTISTS GRID -->
<div class="artists-grid">

    <!-- CARD 1 -->
    <div class="artist-card">
        <div class="artist-card__img-wrap">
            <img src="https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=600&q=80"
                 alt="Elena Vasquez" class="artist-card__img"
                 onerror="this.src='images/default_artist.webp'">
            <span class="artist-card__badge">001</span>
            <span class="artist-card__type-badge">Oil Painting</span>
        </div>
        <div class="artist-card__body">
            <h2 class="artist-card__name">Elena <em>Vasquez</em></h2>
            <p class="artist-card__origin">
                <svg width="9" height="9" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                Seville, Spain
            </p>
            <p class="artist-card__desc">Born in Seville, Elena spent two decades studying the tension between classical technique and raw emotional instinct. Her canvases — dense with layered pigment — speak a language of things half-remembered.</p>
            <div class="artist-card__tags">
                <span class="tag">Figurative</span>
                <span class="tag">Expressionism</span>
                <span class="tag">Portrait</span>
            </div>
        </div>
        <div class="artist-card__footer">
            <div class="stat-item">
                <span class="stat-item__val">84</span>
                <span class="stat-item__lbl">Works</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-item__val">12</span>
                <span class="stat-item__lbl">Exhibits</span>
            </div>
        </div>
    </div>

    <!-- CARD 2 -->
    <div class="artist-card">
        <div class="artist-card__img-wrap">
            <img src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=600&q=80"
                 alt="Marcus Adler" class="artist-card__img"
                 onerror="this.src='images/default_artist.webp'">
            <span class="artist-card__badge">002</span>
            <span class="artist-card__type-badge">Sculpture</span>
        </div>
        <div class="artist-card__body">
            <h2 class="artist-card__name">Marcus <em>Adler</em></h2>
            <p class="artist-card__origin">
                <svg width="9" height="9" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                Berlin, Germany
            </p>
            <p class="artist-card__desc">Marcus transforms raw bronze and stone into meditations on human fragility. His monumental sculptures have stood in public spaces across Europe, each a dialogue between permanence and decay.</p>
            <div class="artist-card__tags">
                <span class="tag">Sculpture</span>
                <span class="tag">Bronze</span>
                <span class="tag">Abstract</span>
            </div>
        </div>
        <div class="artist-card__footer">
            <div class="stat-item">
                <span class="stat-item__val">41</span>
                <span class="stat-item__lbl">Works</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-item__val">9</span>
                <span class="stat-item__lbl">Exhibits</span>
            </div>
        </div>
    </div>

    <!-- CARD 3 -->
    <div class="artist-card">
        <div class="artist-card__img-wrap">
            <img src="https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=600&q=80"
                 alt="Yuki Tanaka" class="artist-card__img"
                 onerror="this.src='images/default_artist.webp'">
            <span class="artist-card__badge">003</span>
            <span class="artist-card__type-badge">Watercolor</span>
        </div>
        <div class="artist-card__body">
            <h2 class="artist-card__name">Yuki <em>Tanaka</em></h2>
            <p class="artist-card__origin">
                <svg width="9" height="9" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                Kyoto, Japan
            </p>
            <p class="artist-card__desc">Yuki bridges traditional Japanese ink techniques with contemporary watercolor. Her luminous compositions capture fleeting moments in nature with extraordinary restraint.</p>
            <div class="artist-card__tags">
                <span class="tag">Ink</span>
                <span class="tag">Landscape</span>
                <span class="tag">Minimalism</span>
            </div>
        </div>
        <div class="artist-card__footer">
            <div class="stat-item">
                <span class="stat-item__val">63</span>
                <span class="stat-item__lbl">Works</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-item__val">7</span>
                <span class="stat-item__lbl">Exhibits</span>
            </div>
        </div>
    </div>

    <!-- CARD 4 -->
    <div class="artist-card">
        <div class="artist-card__img-wrap">
            <img src="https://images.unsplash.com/photo-1560250097-0b93528c311a?w=600&q=80"
                 alt="Luca Ferretti" class="artist-card__img"
                 onerror="this.src='images/default_artist.webp'">
            <span class="artist-card__badge">004</span>
            <span class="artist-card__type-badge">Photography</span>
        </div>
        <div class="artist-card__body">
            <h2 class="artist-card__name">Luca <em>Ferretti</em></h2>
            <p class="artist-card__origin">
                <svg width="9" height="9" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                Milan, Italy
            </p>
            <p class="artist-card__desc">Luca's fine-art photography blurs the line between image and painting. Working in long exposures and controlled light, he constructs photographs that feel like memories — half-seen, deeply felt.</p>
            <div class="artist-card__tags">
                <span class="tag">Photography</span>
                <span class="tag">Long Exposure</span>
                <span class="tag">Fine Art</span>
            </div>
        </div>
        <div class="artist-card__footer">
            <div class="stat-item">
                <span class="stat-item__val">120</span>
                <span class="stat-item__lbl">Works</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-item__val">15</span>
                <span class="stat-item__lbl">Exhibits</span>
            </div>
        </div>
    </div>

    <!-- CARD 5 -->
    <div class="artist-card">
        <div class="artist-card__img-wrap">
            <img src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&q=80"
                 alt="Amara Osei" class="artist-card__img"
                 onerror="this.src='images/default_artist.webp'">
            <span class="artist-card__badge">005</span>
            <span class="artist-card__type-badge">Mixed Media</span>
        </div>
        <div class="artist-card__body">
            <h2 class="artist-card__name">Amara <em>Osei</em></h2>
            <p class="artist-card__origin">
                <svg width="9" height="9" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                Accra, Ghana
            </p>
            <p class="artist-card__desc">Amara weaves together fabric, found objects, and acrylic paint to explore cultural identity and displacement. Her layered works pulse with color and memory, celebrating the complexity of the African diaspora.</p>
            <div class="artist-card__tags">
                <span class="tag">Textile</span>
                <span class="tag">Identity</span>
                <span class="tag">Color</span>
            </div>
        </div>
        <div class="artist-card__footer">
            <div class="stat-item">
                <span class="stat-item__val">55</span>
                <span class="stat-item__lbl">Works</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-item__val">11</span>
                <span class="stat-item__lbl">Exhibits</span>
            </div>
        </div>
    </div>

    <!-- CARD 6 -->
    <div class="artist-card">
        <div class="artist-card__img-wrap">
            <img src="https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=600&q=80"
                 alt="Dmitri Volkov" class="artist-card__img"
                 onerror="this.src='images/default_artist.webp'">
            <span class="artist-card__badge">006</span>
            <span class="artist-card__type-badge">Digital Art</span>
        </div>
        <div class="artist-card__body">
            <h2 class="artist-card__name">Dmitri <em>Volkov</em></h2>
            <p class="artist-card__origin">
                <svg width="9" height="9" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                St. Petersburg, Russia
            </p>
            <p class="artist-card__desc">Dmitri creates immersive digital worlds rooted in Slavic folklore and surrealist tradition. His large-format prints fuse algorithmic process with deeply personal mythology.</p>
            <div class="artist-card__tags">
                <span class="tag">Digital</span>
                <span class="tag">Surrealism</span>
                <span class="tag">Print</span>
            </div>
        </div>
        <div class="artist-card__footer">
            <div class="stat-item">
                <span class="stat-item__val">38</span>
                <span class="stat-item__lbl">Works</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-item__val">6</span>
                <span class="stat-item__lbl">Exhibits</span>
            </div>
        </div>
    </div>

    <!-- CARD 7 -->
    <div class="artist-card">
        <div class="artist-card__img-wrap">
            <img src="https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=600&q=80"
                 alt="Sofia Mendez" class="artist-card__img"
                 onerror="this.src='images/default_artist.webp'">
            <span class="artist-card__badge">007</span>
            <span class="artist-card__type-badge">Ceramics</span>
        </div>
        <div class="artist-card__body">
            <h2 class="artist-card__name">Sofia <em>Mendez</em></h2>
            <p class="artist-card__origin">
                <svg width="9" height="9" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/><circle cx="12" cy="10" r="3"/>
                </svg>
                Oaxaca, Mexico
            </p>
            <p class="artist-card__desc">Sofia elevates traditional Oaxacan pottery into contemporary fine art. Her hand-built ceramic vessels — raw, purposefully imperfect — carry the weight of pre-Columbian memory.</p>
            <div class="artist-card__tags">
                <span class="tag">Ceramics</span>
                <span class="tag">Craft</span>
                <span class="tag">Heritage</span>
            </div>
        </div>
        <div class="artist-card__footer">
            <div class="stat-item">
                <span class="stat-item__val">29</span>
                <span class="stat-item__lbl">Works</span>
            </div>
            <div class="stat-divider"></div>
            <div class="stat-item">
                <span class="stat-item__val">4</span>
                <span class="stat-item__lbl">Exhibits</span>
            </div>
        </div>
    </div>

</div><!-- /artists-grid -->

<jsp:include page="/views/components/footer.jsp" />
</body>
</html>
