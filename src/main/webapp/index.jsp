<!DOCTYPE html>
<html>
<head>
    <title>Login Register Buttons</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 100px;
            background-color: #f4f4f4;
        }

        .btn {
            text-decoration: none;
            padding: 12px 25px;
            margin: 10px;
            border-radius: 8px;
            font-size: 16px;
            color: white;
            display: inline-block;
            transition: 0.3s ease;
        }

        .login-btn {
            background-color: #28a745;
        }

        .login-btn:hover {
            background-color: #218838;
        }

        .register-btn {
            background-color: #007bff;
        }

        .register-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<a href="views/login.jsp" class="btn login-btn">Login</a>
<a href="views/register.jsp" class="btn register-btn">Register</a>

</body>
</html>