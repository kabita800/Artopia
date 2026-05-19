<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed – Artopia</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --black:       #0a0a0a;
            --black-soft:  #111111;
            --black-card:  #161616;
            --black-hover: #1c1c1c;
            --border:      #2a2a2a;
            --border-glow: #f5c518;
            --accent:      #f5c518;
            --accent-dim:  #c9a012;
            --accent-bg:   rgba(245,197,24,.08);
            --white:       #f0f0f0;
            --muted:       #777777;
            --success:     #4caf82;
            --font-display: 'Bebas Neue', sans-serif;
            --font-body:    'DM Sans', sans-serif;
        }

        html { scroll-behavior: smooth; }

        body {
            background-color: var(--black);
            color: var(--white);
            font-family: var(--font-body);
            font-weight: 300;
            line-height: 1.7;
            min-height: 100vh;
        }

        /* grain overlay */
        body::before {
            content: '';
            position: fixed; inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
            opacity: .022;
            pointer-events: none;
            z-index: 9999;
        }

        a { color: var(--accent); text-decoration: none; transition: opacity .2s; }
        a:hover { opacity: .75; }

        .container { max-width: 800px; margin: 0 auto; padding: 0 2rem; }

        /* ── Success Banner ── */
        .success-banner {
            text-align: center;
            padding: 5rem 2rem 2rem;
            animation: fadeUp .6s ease both;
        }
        .check-circle {
            width: 80px; height: 80px;
            border-radius: 50%;
            background: rgba(76,175,130,.12);
            border: 2px solid var(--success);
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 1.5rem;
            animation: scaleIn .5s .1s cubic-bezier(.34,1.56,.64,1) both;
        }
        .check-circle svg { width: 36px; height: 36px; color: var(--success); }
        .success-banner h1 {
            font-family: var(--font-display);
            font-size: clamp(2.5rem, 7vw, 5rem);
            letter-spacing: .04em;
            color: var(--accent);
            line-height: 1;
            margin-bottom: .5rem;
        }
        .success-banner .sub {
            font-size: 1.05rem;
            color: var(--muted);
            margin-bottom: .3rem;
        }
        .success-banner .order-ref {
            font-size: .85rem;
            letter-spacing: .12em;
            text-transform: uppercase;
            color: var(--accent);
            background: var(--accent-bg);
            display: inline-block;
            padding: .3rem 1rem;
            border-radius: 20px;
            border: 1px solid rgba(245,197,24,.2);
            margin-top: .6rem;
        }

        /* ── Bill Card ── */
        .bill-card {
            background: var(--black-card);
            border: 1px solid var(--border);
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 4rem;
            animation: fadeUp .6s .2s ease both;
            position: relative;
        }

        /* top colour strip */
        .bill-card::before {
            content: '';
            display: block;
            height: 4px;
            background: linear-gradient(90deg, var(--accent), var(--accent-dim), transparent);
        }

        /* perforated divider */
        .perforation {
            position: relative;
            height: 1px;
            margin: 0 1.5rem;
            background: repeating-linear-gradient(
                to right,
                var(--border) 0, var(--border) 8px,
                transparent 8px, transparent 16px
            );
        }
        .perforation::before, .perforation::after {
            content: '';
            position: absolute;
            top: 50%; transform: translateY(-50%);
            width: 24px; height: 24px;
            border-radius: 50%;
            background: var(--black);
            border: 1px solid var(--border);
        }
        .perforation::before { left: -32px; }
        .perforation::after  { right: -32px; }

        /* ── Bill Header ── */
        .bill-top {
            padding: 2.5rem 2.5rem 2rem;
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .bill-brand {
            font-family: var(--font-display);
            font-size: 2.2rem;
            letter-spacing: .1em;
            color: var(--accent);
        }
        .bill-brand span { color: var(--white); }
        .bill-meta { text-align: right; }
        .bill-meta .meta-label {
            font-size: .75rem;
            letter-spacing: .1em;
            text-transform: uppercase;
            color: var(--muted);
        }
        .bill-meta .meta-val {
            font-size: .95rem;
            color: var(--white);
            font-weight: 500;
        }

        /* ── Buyer Info ── */
        .buyer-info {
            padding: 1.5rem 2.5rem;
            background: var(--black-soft);
            display: flex;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
            font-size: .9rem;
        }
        .buyer-info .info-block .label {
            font-size: .72rem;
            letter-spacing: .1em;
            text-transform: uppercase;
            color: var(--muted);
            margin-bottom: .2rem;
        }
        .buyer-info .info-block .value {
            color: var(--white);
            font-weight: 400;
        }

        /* ── Items Table ── */
        .items-section { padding: 2rem 2.5rem; }
        .items-section h3 {
            font-family: var(--font-display);
            font-size: 1.1rem;
            letter-spacing: .12em;
            color: var(--muted);
            text-transform: uppercase;
            margin-bottom: 1.2rem;
        }
        .bill-table { width: 100%; border-collapse: collapse; }
        .bill-table thead th {
            font-size: .72rem;
            letter-spacing: .12em;
            text-transform: uppercase;
            color: var(--muted);
            text-align: left;
            padding: .5rem 0;
            border-bottom: 1px solid var(--border);
        }
        .bill-table thead th:last-child { text-align: right; }
        .bill-table tbody tr { transition: background .2s; }
        .bill-table tbody tr:hover { background: var(--black-hover); }
        .bill-table tbody td {
            padding: 1.1rem 0;
            border-bottom: 1px solid #1a1a1a;
            vertical-align: middle;
        }
        .bill-table tbody tr:last-child td { border-bottom: none; }
        .item-thumb {
            width: 52px; height: 52px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid var(--border);
            display: block;
        }
        .item-thumb-placeholder {
            width: 52px; height: 52px;
            border-radius: 4px;
            background: #1e1e1e;
            border: 1px solid var(--border);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.2rem; color: #333;
        }
        .item-info-cell { display: flex; align-items: center; gap: 1.2rem; }
        .item-info-text .i-title {
            font-size: 1rem; color: var(--white); font-weight: 500;
        }
        .item-info-text .i-artist {
            font-size: .78rem; color: var(--muted);
            text-transform: uppercase; letter-spacing: .07em;
        }
        .item-info-text .i-cat {
            display: inline-block;
            font-size: .7rem; letter-spacing: .06em;
            background: var(--black-soft); border: 1px solid var(--border);
            border-radius: 3px; padding: .1rem .5rem; color: var(--muted);
            margin-top: .2rem;
        }
        .td-price {
            font-family: var(--font-display);
            font-size: 1.2rem; color: var(--accent);
            text-align: right; letter-spacing: .04em;
        }

        /* ── Totals ── */
        .totals-section {
            padding: 1.5rem 2.5rem 2.5rem;
        }
        .totals-table { width: 100%; }
        .totals-table td { padding: .45rem 0; font-size: .93rem; color: #b0b0b0; }
        .totals-table td:last-child { text-align: right; }
        .totals-table .sep td { padding: .6rem 0; }
        .totals-table .sep td:first-child {
            border-top: 1px dashed var(--border);
        }
        .totals-table .sep td:last-child {
            border-top: 1px dashed var(--border);
        }
        .totals-table .grand td {
            font-family: var(--font-display);
            font-size: 1.7rem; letter-spacing: .05em;
            color: var(--white); padding-top: 1.2rem;
        }
        .totals-table .grand .grand-price { color: var(--accent); }
        .discount-value { color: #6fcf6f !important; }
        .promo-tag {
            display: inline-block;
            font-size: .68rem; letter-spacing: .08em;
            background: rgba(76,175,130,.1); border: 1px solid rgba(76,175,130,.25);
            color: #6fcf6f; border-radius: 3px; padding: .1rem .5rem;
            margin-left: .5rem; vertical-align: middle;
        }

        /* ── Actions ── */
        .bill-actions {
            padding: 2rem 2.5rem;
            display: flex; gap: 1rem; flex-wrap: wrap;
            border-top: 1px solid var(--border);
            justify-content: space-between;
            align-items: center;
        }
        .btn-print {
            display: inline-flex; align-items: center; gap: .5rem;
            background: var(--accent); color: var(--black);
            font-family: var(--font-display); font-size: 1.1rem;
            letter-spacing: .1em; padding: .85rem 2rem;
            border: none; border-radius: 4px; cursor: pointer;
            transition: background .2s, transform .15s, box-shadow .2s;
        }
        .btn-print:hover {
            background: #ffd740;
            transform: translateY(-2px);
            box-shadow: 0 10px 28px rgba(245,197,24,.2);
        }
        .btn-print svg { width: 18px; height: 18px; }
        .btn-gallery {
            display: inline-flex; align-items: center; gap: .5rem;
            color: var(--muted); font-size: .85rem;
            font-weight: 500; letter-spacing: .08em; text-transform: uppercase;
            border: 1px solid var(--border); border-radius: 4px;
            padding: .85rem 1.5rem; transition: color .2s, border-color .2s;
        }
        .btn-gallery:hover { color: var(--white); border-color: var(--white); opacity: 1; }

        /* ── Thank You Note ── */
        .thankyou-note {
            text-align: center;
            padding: 3rem 2rem 5rem;
            animation: fadeUp .5s .4s ease both;
        }
        .thankyou-note p {
            font-size: .9rem; color: var(--muted);
            letter-spacing: .05em; max-width: 400px; margin: 0 auto;
        }

        /* ── Animations ── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        @keyframes scaleIn {
            from { opacity: 0; transform: scale(.5); }
            to   { opacity: 1; transform: scale(1); }
        }

        /* ── Print Styles ── */
        @media print {
            body { background: #fff !important; color: #000 !important; }
            body::before { display: none; }
            .no-print { display: none !important; }
            .bill-card { border: 1px solid #ccc !important; box-shadow: none !important; }
            .bill-actions { display: none !important; }
            a { color: #000 !important; }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<div class="no-print">
    <jsp:include page="../components/navbar.jsp" />
</div>

<main>
    <!-- ── Success Banner ── -->
    <section class="success-banner">
        <div class="container">
            <div class="check-circle">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                    <polyline points="20 6 9 17 4 12"></polyline>
                </svg>
            </div>
            <h1>Order Confirmed!</h1>
            <p class="sub">Thank you for your purchase, <strong>${bill_buyerName}</strong>.</p>
            <p class="sub">A confirmation has been recorded for <strong>${bill_buyerEmail}</strong>.</p>
            <span class="order-ref">Order ${bill_orderId}</span>
        </div>
    </section>

    <!-- ── Bill Card ── -->
    <section>
        <div class="container">
            <div class="bill-card" id="billCard">

                <!-- Top bar via ::before -->

                <!-- Header -->
                <div class="bill-top">
                    <div>
                        <div class="bill-brand">ARTO<span>PIA</span></div>
                        <div style="font-size:.8rem; color:var(--muted); margin-top:.2rem;">Official Tax Invoice</div>
                    </div>
                    <div class="bill-meta">
                        <div class="meta-label">Order ID</div>
                        <div class="meta-val">${bill_orderId}</div>
                        <div class="meta-label" style="margin-top:.8rem;">Date & Time</div>
                        <div class="meta-val">${bill_timestamp}</div>
                    </div>
                </div>

                <!-- Buyer Info -->
                <div class="buyer-info">
                    <div class="info-block">
                        <div class="label">Billed To</div>
                        <div class="value">${bill_buyerName}</div>
                        <div class="value" style="color:var(--muted); font-size:.88rem;">${bill_buyerEmail}</div>
                    </div>
                    <div class="info-block" style="text-align:right;">
                        <div class="label">Status</div>
                        <div class="value" style="color: #4caf82;">
                            ● Payment Confirmed
                        </div>
                        <div class="value" style="color:var(--muted); font-size:.88rem;">${bill_cart.size()} item(s) purchased</div>
                    </div>
                </div>

                <!-- Perforated divider -->
                <div class="perforation"></div>

                <!-- Items Table -->
                <div class="items-section">
                    <h3>Purchased Artworks</h3>
                    <table class="bill-table">
                        <thead>
                            <tr>
                                <th style="width:60%;">Artwork</th>
                                <th>Category</th>
                                <th>Price</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${bill_cart}">
                                <tr>
                                    <td>
                                        <div class="item-info-cell">
                                            <c:choose>
                                                <c:when test="${not empty item.imageUrl}">
                                                    <img src="${pageContext.request.contextPath}/images/art/${item.imageUrl}"
                                                         class="item-thumb" alt="${item.title}"
                                                         onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                                                    <div class="item-thumb-placeholder" style="display:none;">🖼</div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="item-thumb-placeholder">🖼</div>
                                                </c:otherwise>
                                            </c:choose>
                                            <div class="item-info-text">
                                                <div class="i-title">${item.title}</div>
                                                <div class="i-artist">by ${not empty item.artistName ? item.artistName : 'Unknown'}</div>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:if test="${not empty item.category}">
                                            <span class="i-cat">${item.category}</span>
                                        </c:if>
                                        <c:if test="${empty item.category}">
                                            <span style="color:var(--muted); font-size:.8rem;">—</span>
                                        </c:if>
                                    </td>
                                    <td class="td-price">$<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <!-- Perforated divider -->
                <div class="perforation"></div>

                <!-- Totals -->
                <div class="totals-section">
                    <table class="totals-table">
                        <tr>
                            <td>Subtotal</td>
                            <td>$<fmt:formatNumber value="${bill_subtotal}" pattern="#,##0.00"/></td>
                        </tr>
                        <c:if test="${bill_discountAmount > 0}">
                        <tr>
                            <td>
                                Discount
                                <c:if test="${not empty bill_promoCode}">
                                    <span class="promo-tag">${bill_promoCode}</span>
                                </c:if>
                                (<fmt:formatNumber value="${bill_discountPercent * 100}" pattern="#"/>% off)
                            </td>
                            <td class="discount-value">— $<fmt:formatNumber value="${bill_discountAmount}" pattern="#,##0.00"/></td>
                        </tr>
                        </c:if>
                        <tr>
                            <td>Tax (9%)</td>
                            <td>$<fmt:formatNumber value="${bill_tax}" pattern="#,##0.00"/></td>
                        </tr>
                        <!-- separator row -->
                        <tr class="sep"><td></td><td></td></tr>
                        <tr class="grand">
                            <td>Total Paid</td>
                            <td class="grand-price">$<fmt:formatNumber value="${bill_total}" pattern="#,##0.00"/></td>
                        </tr>
                    </table>
                </div>

                <!-- Actions -->
                <div class="bill-actions no-print">
                    <button class="btn-print" onclick="window.print()">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <polyline points="6 9 6 2 18 2 18 9"></polyline>
                            <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path>
                            <rect x="6" y="14" width="12" height="8"></rect>
                        </svg>
                        Print / Save PDF
                    </button>
                    <a href="${pageContext.request.contextPath}/gallery" class="btn-gallery">
                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width:16px;height:16px;">
                            <polyline points="15 18 9 12 15 6"></polyline>
                        </svg>
                        Continue Shopping
                    </a>
                </div>

            </div><!-- /bill-card -->
        </div>
    </section>

    <!-- Thank you note -->
    <div class="thankyou-note no-print">
        <div class="container">
            <p>🎨 Thank you for supporting artists on Artopia. Your purchase makes creativity possible.</p>
        </div>
    </div>

</main>

<!-- Footer -->
<div class="no-print">
    <jsp:include page="../components/footer.jsp" />
</div>

<script>
    // Trigger confetti animation on load
    (function() {
        const colors = ['#f5c518','#ffd740','#fff','#c9a012','#4caf82'];
        const canvas = document.createElement('canvas');
        canvas.style.cssText = 'position:fixed;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:99998;';
        document.body.appendChild(canvas);
        const ctx = canvas.getContext('2d');
        canvas.width = window.innerWidth;
        canvas.height = window.innerHeight;

        const pieces = Array.from({length: 120}, () => ({
            x: Math.random() * canvas.width,
            y: -20 - Math.random() * 100,
            w: 8 + Math.random() * 8,
            h: 4 + Math.random() * 6,
            color: colors[Math.floor(Math.random() * colors.length)],
            rotation: Math.random() * Math.PI * 2,
            rotSpeed: (Math.random() - .5) * .15,
            vx: (Math.random() - .5) * 3,
            vy: 2 + Math.random() * 4,
            opacity: 1
        }));

        let frame = 0;
        function draw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            pieces.forEach(p => {
                p.x  += p.vx;
                p.y  += p.vy;
                p.rotation += p.rotSpeed;
                if (frame > 80) p.opacity -= 0.008;
                ctx.save();
                ctx.globalAlpha = Math.max(0, p.opacity);
                ctx.translate(p.x, p.y);
                ctx.rotate(p.rotation);
                ctx.fillStyle = p.color;
                ctx.fillRect(-p.w/2, -p.h/2, p.w, p.h);
                ctx.restore();
            });
            frame++;
            if (frame < 160) requestAnimationFrame(draw);
            else canvas.remove();
        }
        draw();
    })();
</script>
</body>
</html>
