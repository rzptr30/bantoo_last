<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

echo json_encode([
    "status" => "success",
    "message" => "API connection successful",
    "timestamp" => date("Y-m-d H:i:s")
]);
?>