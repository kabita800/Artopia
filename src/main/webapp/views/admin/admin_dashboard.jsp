<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard</title>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>

        :root{
            --bg:#0a0a0a;
            --card:#151515;
            --border:rgba(255,255,255,0.08);

            --text:#ffffff;
            --muted:#8b8b8b;

            --accent:#c9a96e;
        }

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            background:var(--bg);
            color:var(--text);
            font-family:'Inter',sans-serif;
        }

        /* MAIN */

        .main{
            margin-left:260px;
            padding:35px;
        }

        /*  TOPBAR */

        .topbar{
            margin-bottom:35px;
        }

        .topbar h1{
            font-size:2rem;
            font-family:'Playfair Display', serif;
        }

        .topbar p{
            color:var(--muted);
            margin-top:8px;
        }

        /* STATS */

        .stats-grid{
            display:grid;
            grid-template-columns:repeat(4,1fr);
            gap:20px;
            margin-bottom:30px;
        }

        .stat-card{
            background:var(--card);
            border:1px solid var(--border);
            border-radius:18px;
            padding:24px;
            transition:0.3s;
        }

        .stat-card:hover{
            transform:translateY(-4px);
            border-color:rgba(201,169,110,0.3);
        }

        .stat-card h3{
            color:var(--accent);
            font-size:2rem;
            margin-bottom:10px;
        }

        .stat-card p{
            color:var(--muted);
        }

        /* DASHBOARD GRID */

        .dashboard-grid{
            display:grid;
            grid-template-columns:2fr 1fr;
            gap:25px;
            margin-bottom:25px;
        }

        .dashboard-card{
            background:var(--card);
            border:1px solid var(--border);
            border-radius:18px;
            overflow:hidden;
        }

        .dashboard-card-header{
            padding:20px 24px;
            border-bottom:1px solid var(--border);
        }

        .dashboard-card-header h2{
            font-family:'Playfair Display', serif;
            font-size:1.2rem;
        }

        .dashboard-card-body{
            padding:24px;
        }

        /*  ACTIVITY */

        .activity-item{
            display:flex;
            justify-content:space-between;
            padding:14px 0;
            border-bottom:1px solid rgba(255,255,255,0.05);
        }

        .activity-item:last-child{
            border-bottom:none;
        }

        .activity-info h4{
            font-size:0.95rem;
            margin-bottom:4px;
        }

        .activity-info p{
            color:var(--muted);
            font-size:0.82rem;
        }

        .activity-tag{
            color:var(--accent);
            font-weight:600;
            font-size:0.85rem;
        }

        /*  QUICK ACTIONS */

        .quick-actions{
            display:grid;
            grid-template-columns:1fr 1fr;
            gap:15px;
        }

        .quick-btn{
            background:#1b1b1b;
            border:1px solid var(--border);
            padding:20px;
            border-radius:14px;
            text-align:center;
            cursor:pointer;
            transition:0.3s;
        }

        .quick-btn:hover{
            transform:translateY(-3px);
            border-color:rgba(201,169,110,0.3);
            background:rgba(201,169,110,0.08);
        }

        .quick-btn h3{
            color:var(--accent);
            margin-bottom:6px;
        }

        .quick-btn p{
            color:var(--muted);
            font-size:0.82rem;
        }

        /* =====================================================
           BOTTOM CARDS
        ===================================================== */

        .bottom-grid{
            display:grid;
            grid-template-columns:repeat(3,1fr);
            gap:20px;
        }

        .mini-card{
            background:var(--card);
            border:1px solid var(--border);
            border-radius:18px;
            padding:24px;
        }

        .mini-card h3{
            color:var(--accent);
            margin-bottom:10px;
        }

        .mini-card p{
            color:var(--muted);
            line-height:1.6;
        }

        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media(max-width:1100px){

            .stats-grid{
                grid-template-columns:repeat(2,1fr);
            }

            .dashboard-grid{
                grid-template-columns:1fr;
            }

            .bottom-grid{
                grid-template-columns:1fr;
            }
        }

        @media(max-width:768px){

            .main{
                margin-left:0;
                padding:20px;
            }

            .stats-grid{
                grid-template-columns:1fr;
            }
        }

    </style>

</head>

<body>

<!-- SIDEBAR -->
<jsp:include page="/views/components/sideBar.jsp"/>

<!-- MAIN -->
<div class="main">

    <!-- TOP -->
    <div class="topbar">
        <h1>Admin Dashboard</h1>
        <p>Manage users, artworks, orders and platform activity.</p>
    </div>

    <!-- STATS -->
    <div class="stats-grid">

        <div class="stat-card">
            <h3>15K+</h3>
            <p>Total Users</p>
        </div>

        <div class="stat-card">
            <h3>8.2K</h3>
            <p>Artworks</p>
        </div>

        <div class="stat-card">
            <h3>1.9K</h3>
            <p>Orders</p>
        </div>

        <div class="stat-card">
            <h3>$54K</h3>
            <p>Total Revenue</p>
        </div>

    </div>

    <!-- DASHBOARD GRID -->
    <div class="dashboard-grid">

        <!-- ACTIVITY -->
        <div class="dashboard-card">

            <div class="dashboard-card-header">
                <h2>Recent Activity</h2>
            </div>

            <div class="dashboard-card-body">

                <div class="activity-item">
                    <div>
                        <h4>New Artwork Uploaded</h4>
                        <p>Golden Horizon by Abal</p>
                    </div>
                    <div class="activity-tag">$450</div>
                </div>

                <div class="activity-item">
                    <div>
                        <h4>User Registered</h4>
                        <p>Soni joined as Buyer</p>
                    </div>
                    <div class="activity-tag">New</div>
                </div>

                <div class="activity-item">
                    <div>
                        <h4>Artwork Sold</h4>
                        <p>Dreamscape purchased</p>
                    </div>
                    <div class="activity-tag">$620</div>
                </div>

                <div class="activity-item">
                    <div>
                        <h4>Artist Verified</h4>
                        <p>Utshab Gautam verified</p>
                    </div>
                    <div class="activity-tag">Done</div>
                </div>

            </div>

        </div>

        <!-- QUICK ACTIONS -->
        <div class="dashboard-card">

            <div class="dashboard-card-header">
                <h2>Quick Actions</h2>
            </div>

            <div class="dashboard-card-body">

                <div class="quick-actions">

                    <div class="quick-btn">
                        <h3>+ User</h3>
                        <p>Add new user</p>
                    </div>

                    <div class="quick-btn">
                        <h3>+ Art</h3>
                        <p>Upload artwork</p>
                    </div>

                    <div class="quick-btn">
                        <h3>Orders</h3>
                        <p>Manage sales</p>
                    </div>

                    <div class="quick-btn">
                        <h3>Reports</h3>
                        <p>Analytics</p>
                    </div>

                </div>

            </div>

        </div>

    </div>

    <!-- BOTTOM GRID -->
    <div class="bottom-grid">

        <div class="mini-card">
            <h3>Total Artists</h3>
            <p>1,245 active artists are selling artworks on Artopia.</p>
        </div>

        <div class="mini-card">
            <h3>Monthly Growth</h3>
            <p>Platform growth increased by 18% this month.</p>
        </div>

        <div class="mini-card">
            <h3>System Status</h3>
            <p>All systems are running smoothly without issues.</p>
        </div>

    </div>

</div>

</body>
</html>