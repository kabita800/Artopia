<%--
   MANAGE ARTS PAGE - FULLY RESPONSIVE
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Arts - Admin Panel</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <style>

        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        :root{
            --bg:#0b0b0b;
            --card:#141414;
            --sidebar:#101010;
            --accent:#c9a96e;
            --text:#ffffff;
            --muted:#b3b3b3;
            --border:rgba(255,255,255,0.08);
            --hover:#1d1d1d;
        }

        body{
            font-family:Arial,sans-serif;
            background:var(--bg);
            color:var(--text);
            min-height:100vh;
            overflow-x:hidden;
        }

        /* =========================
           MAIN CONTENT
        ========================== */

        .main-content{
            margin-left:260px;
            padding:30px;
            min-height:100vh;
            transition:0.3s ease;
        }

        /* =========================
           TOPBAR
        ========================== */

        .topbar{
            display:flex;
            justify-content:space-between;
            align-items:center;
            gap:20px;
            margin-bottom:30px;
            flex-wrap:wrap;
        }

        .topbar h1{
            font-size:28px;
            font-weight:700;
            color:var(--text);
        }

        .add-btn{
            background:var(--accent);
            color:#000;
            border:none;
            padding:12px 20px;
            border-radius:10px;
            font-weight:bold;
            cursor:pointer;
            transition:0.3s;
            white-space:nowrap;
        }

        .add-btn:hover{
            transform:translateY(-2px);
        }

        /* =========================
           TABLE CONTAINER
        ========================== */

        .table-container{
            width:100%;
            background:var(--card);
            border:1px solid var(--border);
            border-radius:16px;
            overflow:hidden;
        }

        .table-wrapper{
            width:100%;
            overflow-x:auto;
        }

        table{
            width:100%;
            min-width:900px;
            border-collapse:collapse;
        }

        thead{
            background:#1b1b1b;
        }

        thead th{
            padding:18px;
            text-align:left;
            color:var(--accent);
            font-size:14px;
            border-bottom:1px solid var(--border);
            white-space:nowrap;
        }

        tbody tr{
            border-bottom:1px solid var(--border);
            transition:0.3s;
        }

        tbody tr:hover{
            background:var(--hover);
        }

        tbody td{
            padding:18px;
            color:var(--muted);
            vertical-align:middle;
        }

        /* =========================
           ART INFO
        ========================== */

        .art-info{
            display:flex;
            align-items:center;
            gap:14px;
            min-width:220px;
        }

        .art-image{
            width:70px;
            height:70px;
            border-radius:12px;
            object-fit:cover;
            border:2px solid var(--border);
            flex-shrink:0;
        }

        .art-name{
            color:white;
            font-weight:bold;
            margin-bottom:4px;
            font-size:15px;
        }

        .artist-name{
            font-size:13px;
            color:var(--muted);
        }

        /* =========================
           STATUS
        ========================== */

        .status{
            padding:7px 14px;
            border-radius:20px;
            font-size:12px;
            font-weight:bold;
            display:inline-block;
            white-space:nowrap;
        }

        .available{
            background:rgba(0,255,120,0.15);
            color:#00ff88;
        }

        .sold{
            background:rgba(255,80,80,0.15);
            color:#ff5b5b;
        }

        /* =========================
           ACTION BUTTONS
        ========================== */

        .action-buttons{
            display:flex;
            gap:10px;
            flex-wrap:wrap;
        }

        .btn{
            border:none;
            padding:9px 14px;
            border-radius:8px;
            cursor:pointer;
            font-size:13px;
            font-weight:bold;
            transition:0.3s;
            white-space:nowrap;
        }

        .btn:hover{
            transform:translateY(-2px);
        }

        .edit-btn{
            background:rgba(244,180,0,0.15);
            color:var(--accent);
        }

        .delete-btn{
            background:rgba(255,0,0,0.15);
            color:#ff5b5b;
        }

        /* =========================
           TABLE SCROLLBAR
        ========================== */

        .table-wrapper::-webkit-scrollbar{
            height:8px;
        }

        .table-wrapper::-webkit-scrollbar-thumb{
            background:rgba(255,255,255,0.15);
            border-radius:20px;
        }

        /* =========================
           LARGE TABLETS
        ========================== */

        @media(max-width:1200px){

            .main-content{
                margin-left:220px;
                padding:25px;
            }
        }

        /* =========================
           TABLETS
        ========================== */

        @media(max-width:992px){

            .main-content{
                margin-left:0;
                padding:20px;
            }

            .topbar{
                flex-direction:column;
                align-items:flex-start;
            }

            .topbar h1{
                font-size:24px;
            }

            .add-btn{
                width:100%;
            }

            .table-container{
                border-radius:14px;
            }
        }

        /* =========================
           MOBILE
        ========================== */

        @media(max-width:768px){

            .main-content{
                padding:16px;
            }

            .topbar{
                margin-bottom:20px;
            }

            .topbar h1{
                font-size:22px;
            }

            table{
                min-width:760px;
            }

            thead th{
                padding:15px;
                font-size:13px;
            }

            tbody td{
                padding:15px;
                font-size:14px;
            }

            .art-image{
                width:60px;
                height:60px;
            }

            .art-name{
                font-size:14px;
            }

            .artist-name{
                font-size:12px;
            }

            .btn{
                padding:8px 12px;
                font-size:12px;
            }

            .status{
                font-size:11px;
            }
        }

        /* =========================
           SMALL MOBILE
        ========================== */

        @media(max-width:480px){

            .main-content{
                padding:14px;
            }

            .topbar h1{
                font-size:20px;
            }

            .add-btn{
                padding:11px 16px;
                font-size:14px;
            }

            .table-container{
                border-radius:12px;
            }

            .art-info{
                gap:10px;
            }

            .art-image{
                width:55px;
                height:55px;
            }

            .action-buttons{
                flex-direction:column;
                align-items:flex-start;
            }

            .btn{
                width:100%;
            }
        }

    </style>

</head>

<body>

<jsp:include page="/views/components/sideBar.jsp" />

<div class="main-content">

    <!-- TOPBAR -->
    <div class="topbar">

        <h1>Manage Arts</h1>

        <button class="add-btn">
            + Add Artwork
        </button>

    </div>

    <!-- TABLE -->
    <div class="table-container">

        <div class="table-wrapper">

            <table>

                <thead>
                <tr>
                    <th>Artwork</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Upload Date</th>
                    <th>Actions</th>
                </tr>
                </thead>

                <tbody>

                <!-- ROW 1 -->
                <tr>

                    <td>
                        <div class="art-info">

                            <img src="${pageContext.request.contextPath}/views/images/art1.jpg"
                                 class="art-image"
                                 alt="Art">

                            <div>
                                <div class="art-name">Golden Sunset</div>
                                <div class="artist-name">by Kabita Giri</div>
                            </div>

                        </div>
                    </td>

                    <td>Digital Art</td>

                    <td>$250</td>

                    <td>
                        <span class="status available">
                            Available
                        </span>
                    </td>

                    <td>May 02, 2026</td>

                    <td>
                        <div class="action-buttons">

                            <button class="btn edit-btn">
                                Edit
                            </button>

                            <button class="btn delete-btn">
                                Delete
                            </button>

                        </div>
                    </td>

                </tr>

                <!-- ROW 2 -->
                <tr>

                    <td>
                        <div class="art-info">

                            <img src="${pageContext.request.contextPath}/views/images/art2.jpg"
                                 class="art-image"
                                 alt="Art">

                            <div>
                                <div class="art-name">Mountain View</div>
                                <div class="artist-name">by Soni Shrestha</div>
                            </div>

                        </div>
                    </td>

                    <td>Painting</td>

                    <td>$400</td>

                    <td>
                        <span class="status sold">
                            Sold
                        </span>
                    </td>

                    <td>April 28, 2026</td>

                    <td>
                        <div class="action-buttons">

                            <button class="btn edit-btn">
                                Edit
                            </button>

                            <button class="btn delete-btn">
                                Delete
                            </button>

                        </div>
                    </td>

                </tr>

                <!-- ROW 3 -->
                <tr>

                    <td>
                        <div class="art-info">

                            <img src="${pageContext.request.contextPath}/views/images/art3.jpg"
                                 class="art-image"
                                 alt="Art">

                            <div>
                                <div class="art-name">Abstract Soul</div>
                                <div class="artist-name">by Utshab Gautam</div>
                            </div>

                        </div>
                    </td>

                    <td>Abstract</td>

                    <td>$320</td>

                    <td>
                        <span class="status available">
                            Available
                        </span>
                    </td>

                    <td>May 05, 2026</td>

                    <td>
                        <div class="action-buttons">

                            <button class="btn edit-btn">
                                Edit
                            </button>

                            <button class="btn delete-btn">
                                Delete
                            </button>

                        </div>
                    </td>

                </tr>

                </tbody>

            </table>

        </div>

    </div>

</div>

</body>
</html>