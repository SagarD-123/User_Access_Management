<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Request Access - Access Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <div class="container">
        <header class="header">
            <h1><i class="fas fa-key"></i> Request Access</h1>
        </header>
        <nav class="nav-menu">
            <ul>
                <li><a href="${pageContext.request.contextPath}/user"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
        <main>
            <section class="card animate-fade-in">
                <h2><i class="fas fa-file-alt"></i> Request Access to Software</h2>
                <c:if test="${not empty message}">
                    <div class="message success"><i class="fas fa-check-circle"></i> ${message}</div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="message error"><i class="fas fa-exclamation-circle"></i> ${errorMessage}</div>
                </c:if>
                <form action="requestAccess" method="POST" class="animate-fade-in">
                    <div class="form-group">
                        <label for="software_id"><i class="fas fa-laptop-code"></i> Software:</label>
                        <select id="software_id" name="software_id" required>
                            <option value="">Select Software</option>
                            <c:forEach var="software" items="${softwareList}">
                                <option value="${software.id}">${software.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="access_type"><i class="fas fa-lock"></i> Access Type:</label>
                        <select id="access_type" name="access_type" required>
                            <option value="Read">Read</option>
                            <option value="Write">Write</option>
                            <option value="Admin">Admin</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="reason"><i class="fas fa-comment"></i> Reason for Access:</label>
                        <textarea id="reason" name="reason" rows="4" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-paper-plane"></i> Request Access</button>
                </form>
            </section>
            
            <section class="card animate-fade-in">
                <h2><i class="fas fa-history"></i> Your Access Requests</h2>
                <table class="requests-table">
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
                                <td><i class="fas fa-laptop-code"></i> ${request.softwareName}</td>
                                <td><i class="fas fa-key"></i> ${request.accessType}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${request.status eq 'Approved'}">
                                            <span class="status-approved"><i class="fas fa-check-circle"></i> ${request.status}</span>
                                        </c:when>
                                        <c:when test="${request.status eq 'Rejected'}">
                                            <span class="status-rejected"><i class="fas fa-times-circle"></i> ${request.status}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-pending"><i class="fas fa-clock"></i> ${request.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td><i class="fas fa-comment"></i> ${request.reason}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
        </main>
    </div>
</body>
</html>
