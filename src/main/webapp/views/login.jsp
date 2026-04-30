<%@page contentType="text/html"%>
<html>
<head>
  <title>Login</title>

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
      width: 320px;
      background: rgba(255, 255, 255, 0.9);
      padding: 25px;
      border-radius: 12px;
      box-shadow: 0 10px 25px rgba(0,0,0,0.2);
      backdrop-filter: blur(5px);
    }

    h2 {
      text-align: center;
      margin-bottom: 20px;
      color: #333;
    }

    input {
      width: 100%;
      margin: 10px 0;
      padding: 12px;
      border: 1px solid #ccc;
      border-radius: 8px;
      outline: none;
      transition: 0.3s;
    }

    input:focus {
      border-color: #007bff;
      box-shadow: 0 0 5px rgba(0,123,255,0.5);
    }

    button {
      width: 100%;
      padding: 12px;
      background: linear-gradient(45deg, #007bff, #00c6ff);
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

    .error {
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

  <h2>Welcome Back</h2>

  <p class="error">${error}</p>

  <form action="../user-auth" method="post">

    <input type="hidden" name="action" value="login"/>

    <input type="email" name="email" placeholder="Enter your email" required/>

    <input type="password" name="password" placeholder="Enter your password" required/>

    <button type="submit">Login</button>

  </form>

  <p class="auth-link">
    New here?
    <a href="register.jsp">Create an account</a>

  </p>

</div>

</body>
</html>