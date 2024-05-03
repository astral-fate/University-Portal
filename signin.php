<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Sign In</title>

    <link rel="stylesheet" href="static/styles.css">

</head>

<body>

    <div class="container">

        <h1>Sign In</h1>

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



        $email = $password = "";



        if ($_SERVER["REQUEST_METHOD"] == "POST") {

            if (isset($_POST['email'])) {

                $email = $conn->real_escape_string($_POST['email']);

            }

            if (isset($_POST['password'])) {

                $password = $conn->real_escape_string($_POST['password']);

            }



            if ($email && $password) {

                $sql = "SELECT id, password FROM users WHERE email = '$email'";

                $result = $conn->query($sql);

                if ($result->num_rows > 0) {

                    $row = $result->fetch_assoc();

                    if (password_verify($password, $row['password'])) {

                        $_SESSION['user_id'] = $row['id'];

                        // Redirect to profile.php

                        header("Location: profile.php");

                        exit();

                    } else {

                        echo "<p>Invalid password</p>";

                    }

                } else {

                    echo "<p>User not found</p>";

                }

            } else {

                echo "<p>Please enter both email and password.</p>";

            }

        }

        $conn->close();

        ?>



        <form action="signin.php" method="POST">

            <label for="email">Email:</label><br>

            <input type="email" id="email" name="email" required><br>

            <label for="password">Password:</label><br>

            <input type="password" id="password" name="password" required><br>

            <button type="submit">Sign In</button>

        </form>

    </div>

</body>

</html>
