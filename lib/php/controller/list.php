<?php 
header('Content-Type: application/json');
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

include '../config/config.php';

$stmt = $conn->prepare("SELECT siswa.id, siswa.nisn, siswa.nama, siswa.alamat, religion.nama AS agama, gender.gender_name AS jenis_kelamin, siswa.tanggal_lahir FROM siswa INNER JOIN religion ON siswa.agama = religion.id_agama INNER JOIN gender ON siswa.jenis_kelamin = gender.id_gender;");
$stmt ->execute();
$result = $stmt->fetchAll(PDO::FETCH_ASSOC);

echo json_encode($result);
?>