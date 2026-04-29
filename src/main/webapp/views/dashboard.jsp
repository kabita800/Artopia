<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Home</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #89f7fe, #66a6ff);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .container {
            background: white;
            padding: 40px;
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

        .btn {
            display: inline-block;
            padding: 10px 20px;
            margin: 5px;
            border-radius: 8px;
            text-decoration: none;
            color: white;
            font-size: 14px;
            transition: 0.3s;
        }

        .login {
            background: #28a745;
        }

        .login:hover {
            background: #218838;
        }

        .register {
            background: #007bff;
        }

        .register:hover {
            background: #0056b3;
        }
    </style>
</head>

<body>

<div class="container">

    <h1>Welcome to Artopia</h1>

    <p>Your simple JSP authentication system</p>

    <a href="views/login.jsp" class="btn login">Login</a>
    <a href="views/register.jsp" class="btn register">Register</a>

</div>

</body>
</html>