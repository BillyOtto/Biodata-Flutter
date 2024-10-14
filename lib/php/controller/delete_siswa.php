<?php
header('Content-Type: application/json');
include '../config/config.php';

$id = (int) $_POST['id'];
$sql = $conn->prepare("DELETE FROM Siswa WHERE id = ?");
$result = $sql->execute([$id]);

echo json_encode([
    'id' => $id,
    'success' => $result
]);
?>