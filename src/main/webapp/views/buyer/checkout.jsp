<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Artopia Marketplace</title>
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
            --danger:      #e05252;
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
        .container { max-width: 820px; margin: 0 auto; padding: 0 2rem; }

        /* ── Hero ── */
        .checkout-hero {
            position: relative;
            padding: 5rem 2rem 2.5rem;
            text-align: center;
            overflow: hidden;
        }
        .checkout-hero::before {
            content: '';
            position: absolute; inset: 0;
            background: radial-gradient(ellipse 60% 50% at 50% 0%, rgba(245,197,24,.07) 0%, transparent 70%);
            pointer-events: none;
        }
        .checkout-hero h1 {
            font-family: var(--font-display);
            font-size: clamp(3rem, 7vw, 5rem);
            letter-spacing: .04em;
            color: var(--accent);
            line-height: 1;
            margin-bottom: .5rem;
            animation: fadeUp .6s ease both;
        }
        .checkout-hero p {
            font-size: 1rem;
            color: var(--muted);
            animation: fadeUp .6s .1s ease both;
        }

        /* ── Steps ── */
        .steps {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: .5rem;
            margin: 1.5rem 0 0;
            animation: fadeUp .6s .15s ease both;
        }
        .step {
            display: flex; align-items: center; gap: .4rem;
            font-size: .75rem; letter-spacing: .1em; text-transform: uppercase;
        }
        .step .dot {
            width: 26px; height: 26px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: .75rem; font-weight: 600;
            border: 1px solid var(--border);
            color: var(--muted);
        }
        .step.done .dot  { background: var(--success); border-color: var(--success); color: #000; }
        .step.active .dot { background: var(--accent); border-color: var(--accent); color: #000; }
        .step .label { color: var(--muted); }
        .step.active .label { color: var(--white); }
        .step-line { width: 40px; height: 1px; background: var(--border); }

        /* ── Checkout Card ── */
        .checkout-card {
            background: var(--black-card);
            border: 1px solid var(--border);
            border-radius: 10px;
            overflow: hidden;
            margin-bottom: 4rem;
            animation: fadeUp .6s .2s ease both;
            position: relative;
        }
        .checkout-card::before {
            content: '';
            display: block;
            height: 4px;
            background: linear-gradient(90deg, var(--accent), var(--accent-dim), transparent);
        }

        /* ── Invoice Header ── */
        .invoice-header {
            padding: 2rem 2.5rem 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 1rem;
            border-bottom: 1px solid var(--border);
        }
        .invoice-title {
            font-family: var(--font-display);
            font-size: 1.6rem; letter-spacing: .1em;
            color: var(--white);
        }
        .order-id-badge {
            font-size: .8rem; letter-spacing: .1em; text-transform: uppercase;
            color: var(--accent);
            background: var(--accent-bg);
            border: 1px solid rgba(245,197,24,.2);
            padding: .35rem 1rem; border-radius: 20px;
        }

        /* ── Items ── */
        .checkout-items { padding: 1.5rem 2.5rem; }
        .checkout-items h3 {
            font-size: .72rem; letter-spacing: .12em; text-transform: uppercase;
            color: var(--muted); margin-bottom: 1rem;
        }
        .co-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 1.2rem;
            padding: 1rem 0;
            border-bottom: 1px solid #1c1c1c;
        }
        .co-item:last-child { border-bottom: none; }
        .co-item-left { display: flex; align-items: center; gap: 1.2rem; }
        .co-thumb {
            width: 58px; height: 58px;
            object-fit: cover; border-radius: 4px;
            border: 1px solid var(--border); flex-shrink: 0;
        }
        .co-thumb-ph {
            width: 58px; height: 58px; border-radius: 4px;
            background: #1e1e1e; border: 1px solid var(--border);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.3rem; color: #333; flex-shrink: 0;
        }
        .co-title { font-size: 1rem; color: var(--white); font-weight: 500; }
        .co-artist {
            font-size: .78rem; color: var(--muted);
            text-transform: uppercase; letter-spacing: .06em;
        }
        .co-price {
            font-family: var(--font-display);
            font-size: 1.25rem; color: var(--accent);
            letter-spacing: .04em; white-space: nowrap;
        }

        /* ── Totals ── */
        .checkout-totals {
            margin: 0 2.5rem 1.5rem;
            background: var(--black-soft);
            border: 1px solid var(--border);
            border-radius: 6px;
            padding: 1.5rem 2rem;
        }
        .co-row {
            display: flex; justify-content: space-between;
            font-size: .92rem; color: #b0b0b0;
            margin-bottom: .8rem;
        }
        .co-row:last-child { margin-bottom: 0; }
        .co-row.grand {
            font-family: var(--font-display);
            font-size: 1.7rem; color: var(--white);
            margin-top: 1.2rem; padding-top: 1.2rem;
            border-top: 1px dashed var(--border);
        }
        .co-row.grand .g-price { color: var(--accent); }
        .discount-val { color: #6fcf6f !important; }
        .promo-badge {
            display: inline-block;
            font-size: .68rem; letter-spacing: .08em;
            background: rgba(76,175,130,.1); border: 1px solid rgba(76,175,130,.25);
            color: #6fcf6f; border-radius: 3px; padding: .1rem .5rem;
            margin-left: .4rem; vertical-align: middle;
        }

        /* ── Pay Button ── */
        .checkout-pay {
            padding: 0 2.5rem 2.5rem;
        }
        .btn-pay {
            width: 100%;
            background: var(--accent);
            color: var(--black);
            font-family: var(--font-display);
            font-size: 1.4rem;
            letter-spacing: .1em;
            padding: 1.2rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            transition: all .2s;
            display: flex; align-items: center; justify-content: center; gap: .6rem;
        }
        .btn-pay:hover {
            background: #ffd740;
            transform: translateY(-2px);
            box-shadow: 0 12px 32px rgba(245,197,24,.28);
        }
        .btn-pay:active { transform: translateY(0); }
        .btn-pay svg { width: 22px; height: 22px; }

        .btn-back {
            display: block; text-align: center;
            margin-top: 1rem;
            color: var(--muted); font-size: .85rem;
            letter-spacing: .06em; text-transform: uppercase;
        }
        .btn-back:hover { color: var(--white); }

        /* Security note */
        .secure-note {
            display: flex; align-items: center; justify-content: center;
            gap: .4rem; font-size: .78rem; color: var(--muted);
            margin-top: 1rem; letter-spacing: .05em;
        }
        .secure-note svg { width: 14px; height: 14px; color: var(--success); }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<!-- Navbar -->
<jsp:include page="../components/navbar.jsp" />

<main>
    <!-- ── Hero ── -->
    <section class="checkout-hero">
        <div class="container">
            <h1>Secure Checkout</h1>
            <p>Review your items and confirm your order.</p>

            <!-- Progress steps -->
            <div class="steps">
                <div class="step done">
                    <div class="dot">✓</div>
                    <span class="label">Cart</span>
                </div>
                <div class="step-line"></div>
                <div class="step active">
                    <div class="dot">2</div>
                    <span class="label">Review</span>
                </div>
                <div class="step-line"></div>
                <div class="step">
                    <div class="dot">3</div>
                    <span class="label">Confirmed</span>
                </div>
            </div>
        </div>
    </section>

    <section>
        <div class="container">

            <c:choose>
                <c:when test="${empty cart}">
                    <!-- Empty state: cart was cleared between page loads -->
                    <div style="text-align:center; padding:4rem 2rem; color:var(--muted);">
                        <p style="font-size:1.1rem;">Your cart is empty. <a href="${pageContext.request.contextPath}/gallery">Browse the gallery</a>.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="checkout-card">

                        <!-- Invoice Header -->
                        <div class="invoice-header">
                            <div class="invoice-title">Invoice Preview</div>
                            <span class="order-id-badge">${orderId}</span>
                        </div>

                        <!-- Items -->
                        <div class="checkout-items">
                            <h3>${cart.size()} item(s) in your order</h3>
                            <c:forEach var="item" items="${cart}">
                                <div class="co-item">
                                    <div class="co-item-left">
                                        <c:choose>
                                            <c:when test="${not empty item.imageUrl}">
                                                <img src="${pageContext.request.contextPath}/images/art/${item.imageUrl}"
                                                     class="co-thumb" alt="${item.title}"
                                                     onerror="this.style.display='none';this.nextElementSibling.style.display='flex';">
                                                <div class="co-thumb-ph" style="display:none;">🖼</div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="co-thumb-ph">🖼</div>
                                            </c:otherwise>
                                        </c:choose>
                                        <div>
                                            <div class="co-title">${item.title}</div>
                                            <div class="co-artist">by ${not empty item.artistName ? item.artistName : 'Unknown'}</div>
                                        </div>
                                    </div>
                                    <div class="co-price">$<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Totals -->
                        <div class="checkout-totals">
                            <div class="co-row">
                                <span>Subtotal (${cart.size()} item(s))</span>
                                <span>$<fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/></span>
                            </div>
                            <c:if test="${discountAmount > 0}">
                            <div class="co-row">
                                <span>
                                    Discount
                                    <c:if test="${not empty promoCode}">
                                        <span class="promo-badge">${promoCode}</span>
                                    </c:if>
                                    (<fmt:formatNumber value="${discountPercent * 100}" pattern="#"/>% off)
                                </span>
                                <span class="discount-val">— $<fmt:formatNumber value="${discountAmount}" pattern="#,##0.00"/></span>
                            </div>
                            </c:if>
                            <div class="co-row">
                                <span>Tax (9%)</span>
                                <span>$<fmt:formatNumber value="${tax}" pattern="#,##0.00"/></span>
                            </div>
                            <div class="co-row grand">
                                <span>Total Due</span>
                                <span class="g-price">$<fmt:formatNumber value="${total}" pattern="#,##0.00"/></span>
                            </div>
                        </div>

                        <!-- Pay Button -->
                        <div class="checkout-pay">
                            <form action="${pageContext.request.contextPath}/checkout" method="post">
                                <button type="submit" class="btn-pay">
                                    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                        <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
                                        <line x1="1" y1="10" x2="23" y2="10"></line>
                                    </svg>
                                    Confirm &amp; Pay — $<fmt:formatNumber value="${total}" pattern="#,##0.00"/>
                                </button>
                            </form>

                            <a href="${pageContext.request.contextPath}/cart" class="btn-back">← Back to Cart</a>

                            <div class="secure-note">
                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                    <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                                </svg>
                                Secured &amp; encrypted transaction
                            </div>
                        </div>

                    </div><!-- /checkout-card -->
                </c:otherwise>
            </c:choose>

        </div>
    </section>
</main>

<!-- Footer -->
<jsp:include page="../components/footer.jsp" />
<script src="${pageContext.request.contextPath}/views/js/script.js"></script>
</body>
</html>
