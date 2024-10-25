<!DOCTYPE html>
<html>
<head>
    <title>Pending Requests</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        input[type="submit"] {
            padding: 5px 10px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<h2>Pending Requests</h2>

<table>
    <thead>
        <tr>
            <th>#</th>
            <th>Username</th>
            <th>Software</th>
            <th>Access Type</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
    </thead>
    <tbody>
        <%-- Loop through requests --%>
        <tr>
            <td>1</td>
            <td>john_doe</td>
            <td>Software A</td>
            <td>Write</td>
            <td>Pending</td>
            <td>
                <form action="pendingRequests" method="POST">
                    <input type="hidden" name="request_id" value="1">
                    <input type="submit" name="action" value="approve">
                    <input type="submit" name="action" value="reject">
                </form>
            </td>
        </tr>
    </tbody>
</table>

</body>
</html>
