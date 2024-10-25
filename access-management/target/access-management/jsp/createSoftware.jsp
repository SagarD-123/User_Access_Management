<!DOCTYPE html>
<html>
<head>
    <title>Create Software</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        form {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], textarea {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            box-sizing: border-box;
        }
        select {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
        }
        input[type="submit"] {
            padding: 10px 20px;
            background-color: #28a745;
            color: #fff;
            border: none;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>

<h2>Create New Software</h2>

<form action="createSoftware" method="POST">
    <label for="name">Software Name:</label>
    <input type="text" name="name" required>

    <label for="description">Description:</label>
    <textarea name="description" rows="4" required></textarea>

    <label for="access_levels">Access Levels:</label>
    <select name="access_levels" required>
        <option value="Read">Read</option>
        <option value="Write">Write</option>
        <option value="Admin">Admin</option>
    </select>

    <input type="submit" value="Create">
</form>

</body>
</html>
