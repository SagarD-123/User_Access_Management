<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manager Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #3498db;
            --secondary-color: #2ecc71;
            --background-color: #ecf0f1;
            --text-color: #34495e;
            --danger-color: #e74c3c;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background-color: var(--background-color);
            color: var(--text-color);
            line-height: 1.6;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        header {
            background-color: var(--primary-color);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        h1, h2 {
            text-align: center;
            margin-bottom: 1rem;
        }

        .message, .error-message {
            padding: 1rem;
            border-radius: 4px;
            margin-bottom: 1rem;
            animation: fadeIn 0.5s ease-out;
        }

        .message {
            background-color: var(--secondary-color);
            color: white;
        }

        .error-message {
            background-color: var(--danger-color);
            color: white;
        }

        .requests-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .requests-table th, .requests-table td {
            padding: 1rem;
            text-align: left;
        }

        .requests-table th {
            background-color: var(--primary-color);
            color: white;
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .requests-table tr:nth-child(even) {
            background-color: #f8f9fa;
        }

        .requests-table tr:hover {
            background-color: #e9ecef;
            transition: background-color 0.3s ease;
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-approve {
            background-color: var(--secondary-color);
            color: white;
        }

        .btn-reject {
            background-color: var(--danger-color);
            color: white;
        }

        .btn-logout {
            background-color: white;
            color: var(--primary-color);
            border: 2px solid white;
        }

        .btn:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .btn-logout:hover {
            background-color: var(--primary-color);
            color: white;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <header>
        <div class="container">
            <div class="header-content">
                <h1>Manager Dashboard</h1>
                <form action="logout" method="get">
                    <button type="submit" class="btn btn-logout">Logout</button>
                </form>
            </div>
        </div>
    </header>

    <main class="container">
        <h2>Pending Access Requests</h2>

        <c:if test="${not empty message}">
            <div class="message">${message}</div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="error-message">${errorMessage}</div>
        </c:if>

        <table class="requests-table">
            <thead>
                <tr>
                    <th>User</th>
                    <th>Software</th>
                    <th>Access Type</th>
                    <th>Reason</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="request" items="${pendingRequests}">
                    <tr>
                        <td>${request.username}</td>
                        <td>${request.softwareName}</td>
                        <td>${request.accessType}</td>
                        <td>${request.reason}</td>
                        <td>${request.status}</td>
                        <td class="action-buttons">
                            <form action="${pageContext.request.contextPath}/approval" method="post">
                                <input type="hidden" name="request_id" value="${request.id}">
                                <input type="hidden" name="action" value="approve">
                                <button type="submit" class="btn btn-approve">Approve</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/approval" method="post">
                                <input type="hidden" name="request_id" value="${request.id}">
                                <input type="hidden" name="action" value="reject">
                                <button type="submit" class="btn btn-reject">Reject</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </main>
</body>
</html> 