<%@page import="com.artopia1.user.model.User"%>

<%
    User u = (User) session.getAttribute("user");

    // Redirect if not logged in OR if NOT admin
    if (u == null || !"ADMIN".equals(u.getRole())) {
        response.sendRedirect("../views/login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Admin Dashboard</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            margin: 0;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            text-align: center;
            width: 350px;
        }

        h1 {
            color: #333;
            margin-bottom: 10px;
        }

        p {
            color: #666;
            margin-bottom: 20px;
        }

        button {
            padding: 10px 20px;
            background: #e74c3c;
            border: none;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #c0392b;
        }
    </style>
</head>

<body>

<div class="card">

    <h1>Welcome Admin</h1>

    <p>Hello, <strong><%= u.getName() %></strong> 👋</p>

    <p>You have full access to manage the system.</p>

    <form action="../user-auth" method="post">
        <input type="hidden" name="action" value="logout"/>
        <button type="submit">Logout</button>
    </form>

</div>

</body>
</html>