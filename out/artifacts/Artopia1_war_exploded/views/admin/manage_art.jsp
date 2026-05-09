<%--
   MANAGE ARTS PAGE
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
            --accent: #c9a96e;
            --text:#ffffff;
            --muted:#b3b3b3;
            --border:rgba(255,255,255,0.08);
            --hover:#1d1d1d;
        }

        body{
            font-family: Arial, sans-serif;
            background: var(--bg);
            color: var(--text);
            display:flex;
            min-height:100vh;
        }

        /* ==================================================
           MAIN CONTENT
        ================================================== */

        .main-content{
            flex:1;
            padding:30px;
            margin-left:260px;
        }

        .topbar{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:30px;
        }

        .topbar h1{
            font-size:28px;
        }

        .add-btn{
            background:var(--accent);
            color:#000;
            border:none;
            padding:12px 20px;
            border-radius:8px;
            font-weight:bold;
            cursor:pointer;
            transition:0.3s;
        }

        .add-btn:hover{
            transform:translateY(-2px);
        }

        /* ==================================================
           TABLE
        ================================================== */

        .table-container{
            background:var(--card);
            border:1px solid var(--border);
            border-radius:14px;
            overflow:hidden;
        }

        table{
            width:100%;
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

        /* ==================================================
           ART IMAGE
        ================================================== */

        .art-info{
            display:flex;
            align-items:center;
            gap:14px;
        }

        .art-image{
            width:70px;
            height:70px;
            border-radius:10px;
            object-fit:cover;
            border:2px solid var(--border);
        }

        .art-name{
            color:white;
            font-weight:bold;
            margin-bottom:4px;
        }

        .artist-name{
            font-size:13px;
            color:var(--muted);
        }

        /* ==================================================
           STATUS
        ================================================== */

        .status{
            padding:6px 12px;
            border-radius:20px;
            font-size:12px;
            font-weight:bold;
            display:inline-block;
        }

        .available{
            background:rgba(0,255,120,0.15);
            color:#00ff88;
        }

        .sold{
            background:rgba(255,80,80,0.15);
            color:#ff5b5b;
        }

        /* ==================================================
           ACTION BUTTONS
        ================================================== */

        .action-buttons{
            display:flex;
            gap:10px;
        }

        .btn{
            border:none;
            padding:8px 14px;
            border-radius:6px;
            cursor:pointer;
            font-size:13px;
            font-weight:bold;
            transition:0.3s;
        }

        .edit-btn{
            background:rgba(244,180,0,0.15);
            color:var(--accent);
        }

        .delete-btn{
            background:rgba(255,0,0,0.15);
            color:#ff5b5b;
        }

        .btn:hover{
            transform:translateY(-2px);
        }

        /* ==================================================
           RESPONSIVE
        ================================================== */

        @media(max-width:900px){

            body{
                flex-direction:column;
            }

            .main-content{
                padding:20px;
            }

            .table-container{
                overflow-x:auto;
            }

            table{
                min-width:900px;
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

</body>
</html>