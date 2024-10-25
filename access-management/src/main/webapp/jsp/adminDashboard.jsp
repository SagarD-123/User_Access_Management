<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Access Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <div class="container">
        <header class="header">
            <h1><i class="fas fa-lock"></i> Admin Dashboard</h1>
        </header>
        <nav class="nav-menu">
            <ul>
                <li><a href="#pending-requests"><i class="fas fa-clock"></i> Pending Requests</a></li>
                <li><a href="#available-software"><i class="fas fa-laptop-code"></i> Available Software</a></li>
                <li><a href="#create-software"><i class="fas fa-plus-circle"></i> Create Software</a></li>
                <li><a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>
        <main>
            <section id="pending-requests" class="card animate-fade-in">
                <h2><i class="fas fa-clock"></i> Pending Access Requests</h2>
                <table>
                    <thead>
                        <tr>
                            <th>User</th>
                            <th>Software</th>
                            <th>Access Type</th>
                            <th>Reason</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${allRequests}" var="request">
                            <tr class="animate-fade-in">
                                <td><i class="fas fa-user"></i> ${request.username}</td>
                                <td><i class="fas fa-laptop-code"></i> ${request.softwareName}</td>
                                <td><i class="fas fa-key"></i> ${request.accessType}</td>
                                <td><i class="fas fa-comment"></i> ${request.reason}</td>
                                <td>
                                    <button class="btn btn-success approve-btn" data-id="${request.id}">
                                        <i class="fas fa-check"></i> Approve
                                    </button>
                                    <button class="btn btn-danger reject-btn" data-id="${request.id}">
                                        <i class="fas fa-times"></i> Reject
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
            
            <section id="available-software" class="card animate-fade-in">
                <h2><i class="fas fa-laptop-code"></i> Available Software Applications</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Access Levels</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${softwareList}" var="software">
                            <tr class="animate-fade-in">
                                <td><i class="fas fa-cube"></i> ${software.name}</td>
                                <td><i class="fas fa-info-circle"></i> ${software.description}</td>
                                <td><i class="fas fa-layer-group"></i> ${software.accessLevels}</td>
                                <td>
                                    <button class="btn btn-primary edit-software" data-id="${software.id}">
                                        <i class="fas fa-edit"></i> Edit
                                    </button>
                                    <button class="btn btn-danger delete-software" data-id="${software.id}">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </button>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </section>
            
            <section id="create-software" class="card animate-fade-in">
                <h2><i class="fas fa-plus-circle"></i> Create New Software</h2>
                <form action="admin" method="post" class="animate-fade-in">
                    <input type="hidden" name="action" value="createSoftware">
                    <div class="form-group">
                        <label for="name"><i class="fas fa-tag"></i> Software Name:</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="form-group">
                        <label for="description"><i class="fas fa-align-left"></i> Description:</label>
                        <textarea id="description" name="description" rows="4" required></textarea>
                    </div>
                    <div class="form-group">
                        <label for="access_levels"><i class="fas fa-layer-group"></i> Access Levels:</label>
                        <select id="access_levels" name="access_levels" required multiple>
                            <option value="Read">Read</option>
                            <option value="Write">Write</option>
                            <option value="Admin">Admin</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-plus"></i> Create Software</button>
                </form>
            </section>
        </main>
    </div>
    
    <div id="editSoftwareModal" class="modal">
        <div class="modal-content animate-scale-in">
            <span class="close">&times;</span>
            <h2><i class="fas fa-edit"></i> Edit Software</h2>
            <form action="admin" method="post">
                <input type="hidden" name="action" value="editSoftware">
                <input type="hidden" id="edit_software_id" name="software_id">
                <div class="form-group">
                    <label for="edit_name"><i class="fas fa-tag"></i> Software Name:</label>
                    <input type="text" id="edit_name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="edit_description"><i class="fas fa-align-left"></i> Description:</label>
                    <textarea id="edit_description" name="description" rows="4" required></textarea>
                </div>
                <div class="form-group">
                    <label for="edit_access_levels"><i class="fas fa-layer-group"></i> Access Levels:</label>
                    <select id="edit_access_levels" name="access_levels" required multiple>
                        <option value="Read">Read</option>
                        <option value="Write">Write</option>
                        <option value="Admin">Admin</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Update Software</button>
            </form>
        </div>
    </div>

    <script>
        $(document).ready(function() {
            $('.edit-software').click(function() {
                var softwareId = $(this).data('id');
                $('#edit_software_id').val(softwareId);
                $('#editSoftwareModal').fadeIn(300);
            });

            $('.close').click(function() {
                $('#editSoftwareModal').fadeOut(300);
            });

            $(window).click(function(event) {
                if (event.target == $('#editSoftwareModal')[0]) {
                    $('#editSoftwareModal').fadeOut(300);
                }
            });

            $('.approve-btn, .reject-btn').click(function() {
                var action = $(this).hasClass('approve-btn') ? 'approve' : 'reject';
                var requestId = $(this).data('id');
                // Here you would typically make an AJAX call to approve/reject the request
                alert('Request ' + requestId + ' ' + action + 'd');
                $(this).closest('tr').fadeOut(300, function() { $(this).remove(); });
            });

            $('.delete-software').click(function() {
                var softwareId = $(this).data('id');
                // Here you would typically make an AJAX call to delete the software
                if (confirm('Are you sure you want to delete this software?')) {
                    $(this).closest('tr').fadeOut(300, function() { $(this).remove(); });
                }
            });
        });
    </script>
</body>
</html>
