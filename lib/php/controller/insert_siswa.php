<?php
header('Content-Type: application/json');
include '../config/config.php';

$nisn = $_POST['nisn'];
$nama = $_POST['nama'];
$alamat = $_POST['alamat'];
$jenis_kelamin = $_POST['jenis_kelamin'];
$agama = $_POST['agama'];
$tanggal_lahir = $_POST['tanggal_lahir'];

$sql = $conn->prepare("INSERT INTO siswa(nisn, nama, alamat, jenis_kelamin, agama, tanggal_lahir) 
           VALUES ( ?, ?, ?, ?, ?, ?)");
$result = $sql->execute([$nisn, $nama, $alamat, $jenis_kelamin, $agama, $tanggal_lahir]);

echo json_encode([
    'success' => $result
]);
?>