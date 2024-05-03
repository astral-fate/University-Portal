<?php
session_start();

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "CollegeApplication";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check if user is logged in
if (isset($_SESSION['user_id'])) {
    $user_id = $_SESSION['user_id'];
    $sql = "SELECT * FROM users WHERE id = $user_id";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $user_info = $result->fetch_assoc();
    } else {
        echo "<p>User not found.</p>";
    }

    // Check if there's a new message for the user
    if (isset($_SESSION['message'])) {
        $message = $_SESSION['message'];
        unset($_SESSION['message']); // Clear the message after displaying
    }
} else {
    echo "<p>You are not logged in. <a href='signin.php'>Sign in</a></p>";
}

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <link rel="stylesheet" href="static/styles.css">
</head>
<body>
    <div class="container">
        <?php if (isset($user_info)): ?>
            <center><h1>Welcome, <?php echo htmlspecialchars($user_info['name']); ?></h1></center>
            <h2>Your Information:</h2>
            <ul>
                <li><strong>Username:</strong> <?php echo htmlspecialchars($user_info['name']); ?></li>
                <li><strong>First Name:</strong> <?php echo htmlspecialchars($user_info['name']); ?></li>
                <li><strong>Last Name:</strong> <?php echo htmlspecialchars($user_info['lastname']); ?></li>
                <li><strong>Email:</strong> <?php echo htmlspecialchars($user_info['email']); ?></li>
                <li><strong>Phone:</strong> <?php echo htmlspecialchars($user_info['phone']); ?></li>
                <li><strong>Date of Birth:</strong> <?php echo htmlspecialchars($user_info['dob']); ?></li>
                <li><strong>Address:</strong> <?php echo htmlspecialchars($user_info['address']); ?></li>
                <li><strong>City:</strong> <?php echo htmlspecialchars($user_info['city']); ?></li>
                <li><strong>State:</strong> <?php echo htmlspecialchars($user_info['state']); ?></li>
                <li><strong>Country:</strong> <?php echo htmlspecialchars($user_info['country']); ?></li>
                <li><strong>Zip Code:</strong> <?php echo htmlspecialchars($user_info['zipcode']); ?></li>
                <li><strong>Department:</strong> <?php echo htmlspecialchars($user_info['department']); ?></li>
            </ul>

            <?php if (isset($message)): ?>
                <div class="message">
                    <?php echo htmlspecialchars($message); ?>
                </div>
            <?php else: ?>
                <p>There is no update.</p>
            <?php endif; ?>

            <h2>Your application has been submitted</h2>
        <?php endif; ?>
    </div>
</body>
</html>