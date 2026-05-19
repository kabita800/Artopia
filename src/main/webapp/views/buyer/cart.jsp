<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Cart - Artopia Marketplace</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/views/css/styles.css">
    <link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=DM+Sans:ital,wght@0,300;0,400;0,500;1,300&display=swap" rel="stylesheet">
    <style>
        /* ── Reset & Base ── */
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
            position: fixed;
            inset: 0;
            background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)'/%3E%3C/svg%3E");
            opacity: .022;
            pointer-events: none;
            z-index: 9999;
        }

        a { color: var(--accent); text-decoration: none; transition: opacity .2s; }
        a:hover { opacity: .75; }

        .container    { max-width: 1160px; margin: 0 auto; padding: 0 2rem; }

        /* ── Hero / Page Title ── */
        .cart-hero {
            position: relative;
            padding: 5rem 2rem 3.5rem;
            overflow: hidden;
        }
        .cart-hero::before {
            content: '';
            position: absolute;
            inset: 0;
            background: radial-gradient(ellipse 55% 60% at 20% 50%, rgba(245,197,24,.09) 0%, transparent 70%);
            pointer-events: none;
        }
        .cart-hero-inner {
            display: flex;
            align-items: flex-end;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 1rem;
        }
        .cart-hero h1 {
            font-family: var(--font-display);
            font-size: clamp(3rem, 7vw, 6rem);
            letter-spacing: .04em;
            color: var(--accent);
            line-height: 1;
        }
        .cart-hero .item-count {
            font-size: .85rem;
            font-weight: 500;
            letter-spacing: .12em;
            text-transform: uppercase;
            color: var(--muted);
            padding-bottom: .4rem;
        }
        .cart-hero .item-count span {
            color: var(--white);
        }

        .divider {
            height: 1px;
            background: linear-gradient(90deg, var(--border-glow), transparent);
            opacity: .25;
            margin: 0 2rem;
        }

        /* ── Main Layout ── */
        .cart-layout {
            display: grid;
            grid-template-columns: 1fr 360px;
            gap: 2.5rem;
            padding: 3rem 0 5rem;
            align-items: start;
        }
        @media (max-width: 900px) {
            .cart-layout { grid-template-columns: 1fr; }
        }

        /* ── Cart Items List ── */
        .cart-items {
            display: flex;
            flex-direction: column;
            gap: 1px; /* items separated by border lines */
        }

        /* Empty state */
        .empty-cart {
            text-align: center;
            padding: 5rem 2rem;
            border: 1px dashed var(--border);
            border-radius: 8px;
        }
        .empty-cart .empty-icon {
            font-size: 4rem;
            opacity: .2;
            margin-bottom: 1.2rem;
            display: block;
        }
        .empty-cart h3 {
            font-family: var(--font-display);
            font-size: 1.8rem;
            letter-spacing: .06em;
            color: var(--muted);
            margin-bottom: .6rem;
        }
        .empty-cart p { color: var(--muted); font-size: .95rem; margin-bottom: 1.8rem; }

        /* ── Cart Item Card ── */
        .cart-item {
            display: grid;
            grid-template-columns: 100px 1fr auto;
            gap: 1.4rem;
            align-items: center;
            background: var(--black-card);
            border: 1px solid var(--border);
            border-radius: 6px;
            padding: 1.2rem 1.4rem;
            margin-bottom: .7rem;
            transition: border-color .25s, background .25s;
            animation: fadeUp .5s ease both;
        }
        .cart-item:hover {
            border-color: rgba(245,197,24,.25);
            background: var(--black-hover);
        }
        @media (max-width: 560px) {
            .cart-item {
                grid-template-columns: 72px 1fr;
                grid-template-rows: auto auto;
            }
            .cart-item-actions { grid-column: 1 / -1; display: flex; justify-content: space-between; align-items: center; }
        }

        /* Artwork thumbnail */
        .cart-item-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 4px;
            background: #222;
            display: block;
            border: 1px solid var(--border);
        }
        .cart-item-img-placeholder {
            width: 100px;
            height: 100px;
            border-radius: 4px;
            background: #1e1e1e;
            border: 1px solid var(--border);
            display: flex;
            align-items: center;
            justify-content: center;
            color: #333;
            font-size: 1.8rem;
        }

        /* Item details */
        .cart-item-details { min-width: 0; }
        .cart-item-details .artwork-title {
            font-family: var(--font-display);
            font-size: 1.25rem;
            letter-spacing: .05em;
            color: var(--white);
            margin-bottom: .2rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .cart-item-details .artist-name {
            font-size: .82rem;
            font-weight: 500;
            letter-spacing: .1em;
            text-transform: uppercase;
            color: var(--accent);
            margin-bottom: .6rem;
        }
        .cart-item-details .item-meta {
            font-size: .82rem;
            color: var(--muted);
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }
        .item-meta .tag {
            background: var(--black-soft);
            border: 1px solid var(--border);
            padding: .15rem .6rem;
            border-radius: 3px;
            font-size: .75rem;
            letter-spacing: .06em;
        }

        /* Qty + Price + Remove */
        .cart-item-actions {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: .8rem;
        }
        .item-price {
            font-family: var(--font-display);
            font-size: 1.5rem;
            letter-spacing: .04em;
            color: var(--accent);
            line-height: 1;
        }

        .qty-control {
            display: flex;
            align-items: center;
            gap: 0;
            border: 1px solid var(--border);
            border-radius: 4px;
            overflow: hidden;
        }
        .qty-btn {
            background: var(--black-soft);
            border: none;
            color: var(--white);
            width: 32px;
            height: 32px;
            font-size: 1rem;
            cursor: pointer;
            transition: background .2s, color .2s;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .qty-btn:hover { background: var(--accent); color: var(--black); }
        .qty-display {
            width: 36px;
            text-align: center;
            font-size: .9rem;
            font-weight: 500;
            background: transparent;
            color: var(--white);
            border: none;
            border-left: 1px solid var(--border);
            border-right: 1px solid var(--border);
            height: 32px;
            outline: none;
        }

        .btn-remove {
            background: none;
            border: none;
            color: var(--muted);
            cursor: pointer;
            font-size: .75rem;
            font-weight: 500;
            letter-spacing: .08em;
            text-transform: uppercase;
            display: flex;
            align-items: center;
            gap: .3rem;
            padding: .2rem 0;
            transition: color .2s;
        }
        .btn-remove:hover { color: var(--danger); }
        .btn-remove svg { width: 13px; height: 13px; }

        /* ── Order Summary ── */
        .order-summary {
            background: var(--black-card);
            border: 1px solid var(--border);
            border-radius: 8px;
            padding: 2rem;
            position: sticky;
            top: 2rem;
            animation: fadeUp .5s .2s ease both;
        }
        .order-summary h2 {
            font-family: var(--font-display);
            font-size: 1.6rem;
            letter-spacing: .08em;
            color: var(--accent);
            margin-bottom: 1.6rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: .9rem;
            margin-bottom: .85rem;
            color: #b0b0b0;
        }
        .summary-row.total {
            font-family: var(--font-display);
            font-size: 1.6rem;
            letter-spacing: .05em;
            color: var(--white);
            margin-top: 1.2rem;
            padding-top: 1.2rem;
            border-top: 1px solid var(--border);
            margin-bottom: 0;
        }
        .summary-row.total .total-price { color: var(--accent); }

        .promo-row {
            display: flex;
            gap: .5rem;
            margin: 1.4rem 0;
        }
        .promo-input {
            flex: 1;
            background: var(--black-soft);
            border: 1px solid var(--border);
            color: var(--white);
            font-family: var(--font-body);
            font-size: .9rem;
            padding: .6rem .9rem;
            border-radius: 4px;
            outline: none;
            transition: border-color .25s;
        }
        .promo-input:focus { border-color: var(--accent); }
        .promo-input::placeholder { color: #444; }
        .btn-promo {
            background: var(--black-soft);
            border: 1px solid var(--border);
            color: var(--accent);
            font-family: var(--font-display);
            letter-spacing: .08em;
            font-size: .9rem;
            padding: .6rem 1.1rem;
            border-radius: 4px;
            cursor: pointer;
            transition: background .2s, border-color .2s;
            white-space: nowrap;
        }
        .btn-promo:hover { background: var(--accent-bg); border-color: var(--accent); }

        /* Checkout button */
        .btn-checkout {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: .6rem;
            width: 100%;
            background: var(--accent);
            color: var(--black);
            font-family: var(--font-display);
            font-size: 1.2rem;
            letter-spacing: .1em;
            padding: 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-top: 1.6rem;
            transition: background .2s, transform .15s, box-shadow .2s;
            text-decoration: none;
        }
        .btn-checkout:hover {
            background: #ffd740;
            transform: translateY(-2px);
            box-shadow: 0 10px 28px rgba(245,197,24,.25);
            opacity: 1;
        }
        .btn-checkout:active { transform: translateY(0); }
        .btn-checkout svg { width: 18px; height: 18px; }

        .btn-continue {
            display: block;
            text-align: center;
            width: 100%;
            margin-top: .9rem;
            font-size: .82rem;
            font-weight: 500;
            letter-spacing: .08em;
            text-transform: uppercase;
            color: var(--muted);
            text-decoration: none;
            transition: color .2s;
        }
        .btn-continue:hover { color: var(--white); opacity: 1; }

        /* Trust badges */
        .trust-badges {
            display: flex;
            justify-content: center;
            gap: 1.4rem;
            margin-top: 1.8rem;
            padding-top: 1.4rem;
            border-top: 1px solid var(--border);
        }
        .badge {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: .3rem;
            font-size: .7rem;
            letter-spacing: .08em;
            text-transform: uppercase;
            color: var(--muted);
        }
        .badge svg { width: 20px; height: 20px; color: var(--muted); }

        /* Primary button for empty state */
        .btn-primary {
            display: inline-flex;
            align-items: center;
            gap: .5rem;
            background: var(--accent);
            color: var(--black);
            font-family: var(--font-display);
            font-size: 1.1rem;
            letter-spacing: .1em;
            padding: .75rem 2rem;
            border-radius: 4px;
            transition: background .2s, transform .15s;
        }
        .btn-primary:hover { background: #ffd740; transform: translateY(-2px); opacity: 1; }

        /* ── Animations ── */
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(20px); }
            to   { opacity: 1; transform: translateY(0); }
        }
        .cart-hero h1    { animation: fadeUp .6s ease both; }
        .cart-hero .item-count { animation: fadeUp .6s .1s ease both; }

        /* Stagger cart items */
        .cart-item:nth-child(1) { animation-delay: .1s; }
        .cart-item:nth-child(2) { animation-delay: .18s; }
        .cart-item:nth-child(3) { animation-delay: .26s; }
        .cart-item:nth-child(4) { animation-delay: .34s; }
    </style>
</head>
<body>

<!-- Navbar -->
<jsp:include page="../components/navbar.jsp" />

<main>

    <!-- ── Hero ── -->
    <section class="cart-hero">
        <div class="container">
            <div class="cart-hero-inner">
                <h1>Your Cart</h1>
                <p class="item-count">
                    <span>${cart != null ? cart.size() : 0}</span> items
                </p>
            </div>
        </div>
    </section>

    <div class="divider"></div>

    <!-- ── Cart Body ── -->
    <section>
        <div class="container">
            <div class="cart-layout">

                <!-- ── Left: Items ── -->
                <div class="cart-items" id="cartItemsContainer">
                    <c:choose>
                        <c:when test="${empty cart}">
                            <div class="empty-cart">
                                <span class="empty-icon">🛒</span>
                                <h3>Your cart is empty</h3>
                                <p>Looks like you haven't added any artwork yet. Start exploring!</p>
                                <a href="${pageContext.request.contextPath}/gallery" class="btn-primary">
                                    Browse Gallery
                                </a>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="item" items="${cart}">
                                <div class="cart-item">
                                    <c:choose>
                                        <c:when test="${not empty item.imageUrl}">
                                            <img src="${pageContext.request.contextPath}/images/art/${item.imageUrl}" class="cart-item-img" alt="${item.title}" onerror="this.src='${pageContext.request.contextPath}/views/images/placeholder.jpg'">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="cart-item-img-placeholder">🖼</div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="cart-item-details">
                                        <div class="artwork-title">${item.title}</div>
                                        <div class="artist-name">by ${not empty item.artistName ? item.artistName : 'Unknown'}</div>
                                        <div class="item-meta">
                                            <c:if test="${not empty item.category}">
                                                <span class="tag">${item.category}</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="cart-item-actions">
                                        <div class="item-price">$<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></div>
                                        <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to remove this item from your cart?');">
                                            <input type="hidden" name="action" value="remove">
                                            <input type="hidden" name="id" value="${item.id}">
                                            <button type="submit" class="btn-remove">
                                                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <polyline points="3 6 5 6 21 6"></polyline>
                                                    <path d="M19 6l-1 14H6L5 6"></path>
                                                    <path d="M10 11v6M14 11v6"></path>
                                                </svg>
                                                Remove
                                            </button>
                                        </form>
                                    </div>
                                </div>
                            </c:forEach>
                            <div style="margin-top: 1rem; text-align: right;">
                                <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to clear your entire cart?');">
                                    <input type="hidden" name="action" value="clear">
                                    <button type="submit" class="btn-remove" style="font-size:.82rem; margin-left: auto;">
                                        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="width:14px;height:14px;">
                                            <polyline points="3 6 5 6 21 6"></polyline>
                                            <path d="M19 6l-1 14H6L5 6"></path>
                                        </svg>
                                        Clear entire cart
                                    </button>
                                </form>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div><!-- /cart-items -->

                <!-- ── Right: Order Summary ── -->
                <aside class="order-summary">
                    <h2>Order Summary</h2>

                    <div class="summary-row">
                        <span>Subtotal</span>
                        <span id="summarySubtotal">$<fmt:formatNumber value="${subtotal}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping</span>
                        <span>Calculated at checkout</span>
                    </div>
                    <div class="summary-row">
                        <span>Tax (est. 9%)</span>
                        <span id="summaryTax">$<fmt:formatNumber value="${subtotal * 0.09}" pattern="#,##0.00"/></span>
                    </div>
                    <div class="summary-row">
                        <span>Discount</span>
                        <span style="color: #6fcf6f;" id="summaryDiscount">— $0.00</span>
                    </div>

                    <!-- Promo Code -->
                    <div class="promo-row">
                        <input type="text" class="promo-input" placeholder="Promo code" id="promoCode">
                        <button class="btn-promo" onclick="applyPromo()">Apply</button>
                    </div>
                    <div id="promoMessage" style="font-size:.8rem; color: var(--muted); margin-top: -.6rem; margin-bottom: .4rem; min-height: 1rem;"></div>

                    <div class="summary-row total">
                        <span>Total</span>
                        <span class="total-price" id="summaryTotal">$<fmt:formatNumber value="${subtotal + (subtotal * 0.09)}" pattern="#,##0.00"/></span>
                    </div>

                    <form action="${pageContext.request.contextPath}/cart" method="post" id="checkoutForm">
                        <input type="hidden" name="action" value="applyPromo">
                        <input type="hidden" name="promoCode" id="promoCodeHidden" value="">
                        <button type="submit" class="btn-checkout"
                                <c:if test="${empty cart}">disabled style="opacity:.5;cursor:not-allowed;"</c:if>>
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="1" y="4" width="22" height="16" rx="2" ry="2"></rect>
                                <line x1="1" y1="10" x2="23" y2="10"></line>
                            </svg>
                            Proceed to Checkout
                        </button>
                    </form>

                    <a href="${pageContext.request.contextPath}/gallery" class="btn-continue">
                        ← Continue Shopping
                    </a>

                    <!-- Trust Badges -->
                    <div class="trust-badges">
                        <div class="badge">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                                <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                            </svg>
                            Secure
                        </div>
                        <div class="badge">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
                            </svg>
                            Protected
                        </div>
                        <div class="badge">
                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round">
                                <path d="M20 12V22H4V12"></path>
                                <path d="M22 7H2v5h20V7z"></path>
                                <path d="M12 22V7"></path>
                                <path d="M12 7H7.5a2.5 2.5 0 0 1 0-5C11 2 12 7 12 7z"></path>
                                <path d="M12 7h4.5a2.5 2.5 0 0 0 0-5C13 2 12 7 12 7z"></path>
                            </svg>
                            Easy Returns
                        </div>
                    </div>

                </aside>

            </div><!-- /cart-layout -->
        </div>
    </section>

</main>

<!-- Footer -->
<jsp:include page="../components/footer.jsp" />

<script src="${pageContext.request.contextPath}/views/js/script.js"></script>
<script>
    let currentDiscountPercent = 0;
    const initialSubtotal = ${subtotal != null ? subtotal : 0};

    function updateSummary() {
        const discountAmount = initialSubtotal * currentDiscountPercent;
        const subtotalAfterDiscount = initialSubtotal - discountAmount;
        const tax = subtotalAfterDiscount * 0.09;
        const total = subtotalAfterDiscount + tax;

        document.getElementById('summarySubtotal').textContent = '$' + initialSubtotal.toFixed(2);
        document.getElementById('summaryDiscount').textContent = '— $' + discountAmount.toFixed(2);
        document.getElementById('summaryTax').textContent = '$' + tax.toFixed(2);
        document.getElementById('summaryTotal').textContent = '$' + total.toFixed(2);
    }

    // ── Promo Code ──
    function applyPromo() {
        const code  = document.getElementById('promoCode').value.trim().toUpperCase();
        const msg   = document.getElementById('promoMessage');
        const valid = { 'ART10': 0.10, 'ARTOPIA20': 0.20 };

        if (!code) {
            msg.style.color = 'var(--muted)';
            msg.textContent = 'Please enter a promo code.';
            currentDiscountPercent = 0;
            updateSummary();
            return;
        }

        if (valid[code]) {
            msg.style.color = '#6fcf6f';
            msg.textContent = '✓ ' + (valid[code]*100) + '% off applied!';
            currentDiscountPercent = valid[code];
            updateSummary();
        } else {
            msg.style.color = 'var(--danger)';
            msg.textContent = '✕ Invalid or expired code.';
            currentDiscountPercent = 0;
            updateSummary();
        }
    }

    // Allow Enter key on promo input
    document.getElementById('promoCode').addEventListener('keydown', function(e) {
        if (e.key === 'Enter') applyPromo();
    });

    // Before submitting checkout form, copy the typed promo code into the hidden field
    document.getElementById('checkoutForm').addEventListener('submit', function() {
        document.getElementById('promoCodeHidden').value =
            document.getElementById('promoCode').value.trim();
    });

    document.addEventListener('DOMContentLoaded', () => {
        // Clear local storage cart if it was left behind
        localStorage.removeItem('artopia_cart');
    });
</script>
</body>
</html>
