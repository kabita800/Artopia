<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User - Admin</title>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Inter:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg: #0a0a0a;
            --card: #151515;
            --border: rgba(255, 255, 255, 0.08);
            --text: #ffffff;
            --muted: #8b8b8b;
            --accent: #c9a96e;
            --radius: 18px;
            --transition: 0.3s ease;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body { background: var(--bg); color: var(--text); font-family: 'Inter', sans-serif; }

        .main-content { margin-left: 260px; padding: 35px; }

        .page-header {
            margin-bottom: 30px;
        }

        .page-header h1 { font-size: 2rem; font-family: 'Playfair Display', serif; }

        .form-card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: var(--radius);
            padding: 30px;
            max-width: 600px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: var(--muted);
            font-size: 0.9rem;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 12px 16px;
            background: #101010;
            border: 1px solid var(--border);
            border-radius: 10px;
            color: #fff;
            outline: none;
            font-size: 1rem;
        }

        .form-group input:focus, .form-group select:focus {
            border-color: var(--accent);
        }

        .submit-btn {
            background: var(--accent);
            color: #000;
            border: none;
            padding: 14px 24px;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            font-size: 1rem;
            transition: var(--transition);
        }

        .submit-btn:hover {
            transform: translateY(-2px);
        }

        @media (max-width: 900px) {
            .main-content { margin-left: 0; padding: 20px; }
        }
    </style>
</head>

<body>

<jsp:include page="/views/components/sideBar.jsp" />

<div class="main-content">

    <div class="page-header">
        <h1>Edit User</h1>
    </div>

    <div class="form-card">
        <form action="${pageContext.request.contextPath}/admin/editUser" method="post">
            <input type="hidden" name="id" value="${editUser.id}">
            
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" value="${editUser.name}" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="${editUser.email}" required>
            </div>
            
            <div class="form-group">
                <label for="role">Role</label>
                <select id="role" name="role" required>
                    <option value="user" ${editUser.role == 'user' ? 'selected' : ''}>User (Buyer)</option>
                    <option value="artist" ${editUser.role == 'artist' ? 'selected' : ''}>Artist</option>
                    <option value="admin" ${editUser.role == 'admin' ? 'selected' : ''}>Admin</option>
                </select>
            </div>
            
            <button type="submit" class="submit-btn">Save Changes</button>
        </form>
    </div>

</div>

</body>
</html>
