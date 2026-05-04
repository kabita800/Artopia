
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Login - Artopia</title>

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
      width:320px;
      background:rgba(255,255,255,0.95);
      padding:30px;
      border-radius:14px;
      box-shadow:0 15px 30px rgba(0,0,0,0.25);
    }

    h2{
      text-align:center;
      margin-bottom:15px;
      color:#222;
    }

    .sub{
      text-align:center;
      color:#666;
      font-size:14px;
      margin-bottom:20px;
    }

    input{
      width:100%;
      padding:12px;
      margin:10px 0;
      border:1px solid #ccc;
      border-radius:8px;
      font-size:15px;
      outline:none;
    }

    input:focus{
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
  </style>
</head>

<body>

<div class="box">

  <h2>Welcome Back</h2>
  <p class="sub">Login to Artopia Marketplace</p>

  <% if(request.getAttribute("success") != null){ %>
  <p class="msg-success"><%= request.getAttribute("success") %></p>
  <% } %>

  <% if(request.getAttribute("error") != null){ %>
  <p class="msg-error"><%= request.getAttribute("error") %></p>
  <% } %>

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
```
