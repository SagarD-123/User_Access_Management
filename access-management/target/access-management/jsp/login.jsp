<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Access Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1><i class="fas fa-lock"></i> Access Management System</h1>
        </header>
        <main>
            <div class="card animate-fade-in">
                <h2><i class="fas fa-sign-in-alt"></i> Login</h2>
                <c:if test="${not empty errorMessage}">
                    <div class="message error">${errorMessage}</div>
                </c:if>
                <form action="login" method="post" class="animate-fade-in">
                    <div class="form-group">
                        <label for="username"><i class="fas fa-user"></i> Username:</label>
                        <input type="text" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password"><i class="fas fa-key"></i> Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-sign-in-alt"></i> Login</button>
                </form>
                <div class="form-footer">
                    <p>Don't have an account?</p>
                    <a href="${pageContext.request.contextPath}/signup" class="btn btn-secondary">
                        <i class="fas fa-user-plus"></i> Sign Up
                    </a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
