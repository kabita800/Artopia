<%@page contentType="text/html"%>
<html>
<head>
    <title>Register</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #74ebd5, #ACB6E5);
            height: 100vh;
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .box {
            width: 340px;
            background: rgba(255, 255, 255, 0.92);
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            backdrop-filter: blur(6px);
        }

        h2 {
            text-align: center;
            margin-bottom: 15px;
            color: #333;
        }

        input, select {
            width: 100%;
            margin: 10px 0;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            transition: 0.3s;
        }

        input:focus, select:focus {
            border-color: #28a745;
            box-shadow: 0 0 5px rgba(40,167,69,0.4);
        }

        button {
            width: 100%;
            padding: 12px;
            background: linear-gradient(45deg, #28a745, #5dd39e);
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            transform: scale(1.03);
        }

        .msg-success {
            color: green;
            text-align: center;
            font-size: 14px;
        }

        .msg-error {
            color: red;
            text-align: center;
            font-size: 14px;
        }

        .auth-link {
            text-align: center;
            margin-top: 15px;
            font-size: 14px;
        }

        .auth-link a {
            color: #007bff;
            text-decoration: none;
            font-weight: bold;
        }

        .auth-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>

<body>

<div class="box">

    <h2>Create Account</h2>

    <% if(request.getAttribute("success") != null) { %>
    <p class="msg-success"><%= request.getAttribute("success") %></p>
    <% } %>

    <% if(request.getAttribute("error") != null) { %>
    <p class="msg-error"><%= request.getAttribute("error") %></p>
    <% } %>

    <form action="../user-auth" method="post">

        <input type="hidden" name="action" value="register"/>

        <input type="text" name="name" placeholder="Full Name" required/>

        <input type="email" name="email" placeholder="Email Address" required/>

        <input type="password" name="password" placeholder="Create Password" required/>

        <select name="role" required>
            <option value="">Choose Role</option>
            <option value="USER">User</option>
            <option value="ADMIN">Admin</option>
        </select>

        <button type="submit">Register</button>

    </form>

    <p class="auth-link">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login">Login here</a>
    </p>

</div>

</body>
</html>