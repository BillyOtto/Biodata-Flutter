<?php
header('Content-Type: application/json');
include '../config/config.php';

$id = $_POST['id'];
$nisn = $_POST['nisn'];
$nama = $_POST['nama'];
$alamat = $_POST['alamat'];
$jenis_kelamin = $_POST['jenis_kelamin'];
$agama = $_POST['agama'];
$tanggal_lahir = $_POST['tanggal_lahir'];

$sql = $conn->prepare("UPDATE siswa SET nisn = ?, nama = ?, alamat = ?, jenis_kelamin = ?, agama = ?, tanggal_lahir = ? WHERE id = ?");
$result = $sql->execute([$nisn, $nama, $alamat, $jenis_kelamin, $agama, $tanggal_lahir, $id]);

// echo $result;
echo json_encode([
    'success' => $result
]);
?> 