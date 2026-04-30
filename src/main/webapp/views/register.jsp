<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Artopia</title>

    <style>
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
        }

        body{
            font-family:Arial, sans-serif;
            background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
            height:100vh;
            display:flex;
            justify-content:center;
            align-items:center;
        }

        .box{
            width:380px;
            background:rgba(255,255,255,0.95);
            padding:30px;
            border-radius:14px;
            box-shadow:0 15px 30px rgba(0,0,0,0.25);
        }

        h2{
            text-align:center;
            margin-bottom:20px;
            color:#222;
        }

        .sub{
            text-align:center;
            color:#666;
            font-size:14px;
            margin-bottom:20px;
        }

        input,select{
            width:100%;
            padding:12px;
            margin:10px 0;
            border:1px solid #ccc;
            border-radius:8px;
            font-size:15px;
            outline:none;
        }

        input:focus,select:focus{
            border-color:#c9a84c;
            box-shadow:0 0 5px rgba(201,168,76,0.4);
        }

        button{
            width:100%;
            padding:13px;
            border:none;
            border-radius:8px;
            background:#c9a84c;
            color:#111;
            font-size:16px;
            font-weight:bold;
            cursor:pointer;
            margin-top:10px;
            transition:0.3s;
        }

        button:hover{
            background:#b89435;
        }

        .msg-success{
            color:green;
            text-align:center;
            margin-bottom:10px;
            font-size:14px;
        }

        .msg-error{
            color:red;
            text-align:center;
            margin-bottom:10px;
            font-size:14px;
        }

        .auth-link{
            text-align:center;
            margin-top:18px;
            font-size:14px;
            color:#555;
        }

        .auth-link a{
            color:#007bff;
            text-decoration:none;
            font-weight:bold;
        }

        .auth-link a:hover{
            text-decoration:underline;
        }

        .role-note{
            font-size:12px;
            color:#666;
            margin-top:4px;
            margin-bottom:10px;
        }
    </style>
</head>

<body>

<div class="box">

    <h2>Create Account</h2>
    <p class="sub">Join Artopia Marketplace</p>

    <% if(request.getAttribute("success") != null){ %>
    <p class="msg-success"><%= request.getAttribute("success") %></p>
    <% } %>

    <% if(request.getAttribute("error") != null){ %>
    <p class="msg-error"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="../user-auth" method="post">

        <input type="hidden" name="action" value="register">

        <input type="text" name="name" placeholder="Full Name" required>

        <input type="email" name="email" placeholder="Email Address" required>

        <input type="password" name="password" placeholder="Create Password" required>

        <select name="role" required>
            <option value="">Select Role</option>
            <option value="ARTIST">ARTIST</option>
            <option value="BUYER">BUYER</option>
            <option value="ADMIN">ADMIN</option>
        </select>

        <p class="role-note">
            Artist = Can add artwork |
            Buyer = Can purchase artwork |
            Admin = Manage system
        </p>

        <button type="submit">Register</button>

    </form>

    <p class="auth-link">
        Already have an account?
        <a href="login.jsp">Login Here</a>
    </p>

</div>

</body>
</html>