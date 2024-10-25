<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - Access Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1><i class="fas fa-user-plus"></i> Sign Up</h1>
        </header>
        <main>
            <section class="card animate-fade-in">
                <h2><i class="fas fa-user-circle"></i> Create Your Account</h2>
                <c:if test="${not empty errorMessage}">
                    <div class="message error">${errorMessage}</div>
                </c:if>
                <form action="signup" method="POST" class="animate-fade-in">
                    <div class="form-group">
                        <label for="username"><i class="fas fa-user"></i> Username:</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password"><i class="fas fa-lock"></i> Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="form-group">
                        <label for="role"><i class="fas fa-user-tag"></i> Role:</label>
                        <select id="role" name="role" required>
                            <option value="Employee">Employee</option>
                            <option value="Manager">Manager</option>
                            <option value="Admin">Admin</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-user-plus"></i> Sign Up</button>
                </form>
                <div class="form-footer">
                    Already have an account? <a href="${pageContext.request.contextPath}/login">Log In</a>
                </div>
            </section>
        </main>
    </div>
</body>
</html>
