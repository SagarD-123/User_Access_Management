<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Access Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1>Welcome, ${user.username}</h1>
        </header>
        <nav class="nav-menu">
            <ul>
                <li><a href="#available-software">Available Software</a></li>
                <li><a href="#your-requests">Your Requests</a></li>
                <li><a href="logout">Logout</a></li>
            </ul>
        </nav>
        <main>
            <section id="available-software" class="card">
                <h2>Available Software</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${softwareList}" var="software">
                            <tr>
                                <td>${software.name}</td>
                                <td>${software.description}</td>
                                <td>
                                    <form action="requestAccess" method="post">
                                        <input type="hidden" name="software_id" value="${software.id}">
                                        <select name="access_type">
                                            <option value="Read">Read</option>
                                            <option value="Write">Write</option>
                                        </select>
                                        <button type="submit" class="btn">Request Access</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
            
            <section id="your-requests" class="card">
                <h2>Your Requests</h2>
                <table id="requestTable">
                    <thead>
                        <tr>
                            <th>Software</th>
                            <th>Access Type</th>
                            <th>Status</th>
                            <th>Reason</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="request" items="${userRequests}">
                            <tr>
                                <td>${request.softwareName}</td>
                                <td>${request.accessType}</td>
                                <td>${request.status}</td>
                                <td>${request.reason}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
        </main>
    </div>
    <script>
        function fetchRequestStatus() {
            $.ajax({
                url: 'requestStatus',
                method: 'GET',
                success: function (response) {
                    $('#requestTable tbody').html(response);
                }
            });
        }
        setInterval(fetchRequestStatus, 5000);
    </script>
</body>
</html>
