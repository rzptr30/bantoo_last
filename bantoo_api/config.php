<?php
$conn = new mysqli("localhost", "root", "", "bantoo_db");
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
// Tidak perlu else di sini, cukup stop jika error.
?>