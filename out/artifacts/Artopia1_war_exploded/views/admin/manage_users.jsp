<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Manage Users - Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>

        :root{
            --bg:#0a0a0a;
            --card:#151515;
            --border:rgba(255,255,255,0.08);

            --text:#ffffff;
            --text-secondary:#cfcfcf;
            --muted:#8b8b8b;

            --accent: #c9a96e;
            --accent-soft:rgba(232,161,63,0.12);

            --danger:#ff5f5f;
            --success:#57d18c;

            --radius:18px;
            --transition:0.3s ease;
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

        /* MAIN CONTENT */

        .main-content{
            margin-left:260px;
            padding:35px;
        }

        .page-header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:30px;
        }

        .page-header h1{
            font-size:2rem;
            font-family:'Playfair Display', serif;
        }

        .page-header p{
            color:var(--muted);
            margin-top:6px;
        }

        .add-btn{
            background:var(--accent);
            color:#000;
            border:none;
            padding:12px 22px;
            border-radius:12px;
            font-weight:600;
            cursor:pointer;
            transition:var(--transition);
        }

        .add-btn:hover{
            transform:translateY(-2px);
        }

        /* TABLE CARD */

        .table-card{
            background:var(--card);
            border:1px solid var(--border);
            border-radius:var(--radius);
            overflow:hidden;
        }

        .table-header{
            padding:22px 28px;
            border-bottom:1px solid var(--border);
            display:flex;
            justify-content:space-between;
            align-items:center;
        }

        .table-header h2{
            font-size:1.2rem;
            font-family:'Playfair Display', serif;
        }

        .search-box input{
            background:#101010;
            border:1px solid var(--border);
            padding:10px 14px;
            border-radius:10px;
            color:#fff;
            outline:none;
            width:240px;
        }

        table{
            width:100%;
            border-collapse:collapse;
        }

        th{
            text-align:left;
            padding:18px 28px;
            color:var(--muted);
            font-size:0.82rem;
            font-weight:500;
            border-bottom:1px solid rgba(255,255,255,0.05);
        }

        td{
            padding:20px 28px;
            border-bottom:1px solid rgba(255,255,255,0.05);
            color:var(--text-secondary);
            font-size:0.92rem;
        }

        tr:hover{
            background:rgba(255,255,255,0.02);
        }

        /*  USER INFO */

        .user-info{
            display:flex;
            align-items:center;
            gap:12px;
        }

        .user-avatar{
            width:42px;
            height:42px;
            border-radius:50%;
            background:linear-gradient(135deg,#2a1800,#1a1000);
            display:flex;
            align-items:center;
            justify-content:center;
            color:var(--accent);
            font-weight:600;
            overflow:hidden;
        }

        .user-avatar img{
            width:100%;
            height:100%;
            object-fit:cover;
        }

        .user-name{
            font-weight:500;
            color:#fff;
        }

        .user-email{
            font-size:0.8rem;
            color:var(--muted);
            margin-top:3px;
        }

        /* ROLE + STATUS */

        .role{
            padding:6px 12px;
            border-radius:30px;
            font-size:0.75rem;
            font-weight:600;
            display:inline-block;
        }

        .admin-role{
            background:rgba(232,161,63,0.12);
            color:var(--accent);
        }

        .artist-role{
            background:rgba(87,209,140,0.12);
            color:var(--success);
        }

        .buyer-role{
            background:rgba(255,255,255,0.08);
            color:#d4d4d4;
        }

        .status{
            font-size:0.82rem;
            font-weight:500;
        }

        .active{
            color:var(--success);
        }

        .blocked{
            color:var(--danger);
        }

        /* ACTION BUTTONS */

        .action-buttons{
            display:flex;
            gap:10px;
        }

        .edit-btn,
        .delete-btn{
            border:none;
            padding:9px 14px;
            border-radius:8px;
            cursor:pointer;
            font-size:0.8rem;
            transition:var(--transition);
        }

        .edit-btn{
            background:rgba(232,161,63,0.12);
            color:var(--accent);
        }

        .delete-btn{
            background:rgba(255,95,95,0.12);
            color:var(--danger);
        }

        .edit-btn:hover,
        .delete-btn:hover{
            transform:translateY(-2px);
        }

        /* RESPONSIVE */

        @media(max-width:900px){

            .main-content{
                margin-left:0;
                padding:20px;
            }

            .page-header{
                flex-direction:column;
                align-items:flex-start;
                gap:20px;
            }

            .table-header{
                flex-direction:column;
                gap:15px;
                align-items:flex-start;
            }

            .search-box input{
                width:100%;
            }

            table{
                min-width:900px;
            }

            .table-card{
                overflow-x:auto;
            }

        }

    </style>
</head>

<body>

<!-- SIDEBAR -->
<jsp:include page="/views/components/sideBar.jsp" />

<!-- MAIN CONTENT -->

<div class="main-content">

    <!-- PAGE HEADER -->
    <div class="page-header">

        <div>
            <h1>Manage Users</h1>
            <p>Manage all users, artists, and buyers from one place.</p>
        </div>

        <button class="add-btn">
            + Add User
        </button>

    </div>

    <!-- TABLE -->
    <div class="table-card">

        <div class="table-header">

            <h2>User List</h2>

            <div class="search-box">
                <input type="text" placeholder="Search users...">
            </div>

        </div>

        <table>

            <thead>
            <tr>
                <th>User</th>
                <th>Role</th>
                <th>Status</th>
                <th>Joined</th>
                <th>Actions</th>
            </tr>
            </thead>

            <tbody>

            <!-- USER 1 -->
            <tr>

                <td>
                    <div class="user-info">

                        <div class="user-avatar">
                            <img src="${pageContext.request.contextPath}/views/images/kabita.jpeg"
                                 alt="Kabita">
                        </div>

                        <div>
                            <div class="user-name">Kabita Giri</div>
                            <div class="user-email">kabita@gmail.com</div>
                        </div>

                    </div>
                </td>

                <td>
                    <span class="role admin-role">
                        Admin
                    </span>
                </td>

                <td>
                    <span class="status active">
                        Active
                    </span>
                </td>

                <td>May 2026</td>

                <td>
                    <div class="action-buttons">
                        <button class="edit-btn">Edit</button>
                        <button class="delete-btn">Delete</button>
                    </div>
                </td>

            </tr>

            <!-- USER 2 -->
            <tr>

                <td>
                    <div class="user-info">

                        <div class="user-avatar">
                            A
                        </div>

                        <div>
                            <div class="user-name">Abal Bohara</div>
                            <div class="user-email">abal@gmail.com</div>
                        </div>

                    </div>
                </td>

                <td>
                    <span class="role artist-role">
                        Artist
                    </span>
                </td>

                <td>
                    <span class="status active">
                        Active
                    </span>
                </td>

                <td>April 2026</td>

                <td>
                    <div class="action-buttons">
                        <button class="edit-btn">Edit</button>
                        <button class="delete-btn">Delete</button>
                    </div>
                </td>

            </tr>

            <!-- USER 3 -->
            <tr>

                <td>
                    <div class="user-info">

                        <div class="user-avatar">
                            S
                        </div>

                        <div>
                            <div class="user-name">Soni Shrestha</div>
                            <div class="user-email">soni@gmail.com</div>
                        </div>

                    </div>
                </td>

                <td>
                    <span class="role buyer-role">
                        Buyer
                    </span>
                </td>

                <td>
                    <span class="status blocked">
                        Blocked
                    </span>
                </td>

                <td>March 2026</td>

                <td>
                    <div class="action-buttons">
                        <button class="edit-btn">Edit</button>
                        <button class="delete-btn">Delete</button>
                    </div>
                </td>

            </tr>

            </tbody>

        </table>

    </div>

</div>

</body>
</html>