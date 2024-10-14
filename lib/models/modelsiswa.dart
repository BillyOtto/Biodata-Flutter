class ModelSiswa {
  final int id;
  final String nisn, nama, alamat, jenis_kelamin, agama, tanggal_lahir;
  ModelSiswa({required this.id, required this.nisn,required this.nama,required this.alamat,
              required this.jenis_kelamin,required this.agama,required this.tanggal_lahir,});

  factory ModelSiswa.fromJson(Map<String, dynamic> json){
    return ModelSiswa(
        id: json['id'],
        nisn: json['nisn'],
        nama: json['nama'],
        alamat: json['alamat'],
        jenis_kelamin: json['jenis_kelamin'],
        agama: json['agama'],
        tanggal_lahir: json['tanggal_lahir']);
  }
  Map<String, dynamic> toJson() => {
    'nisn' : nisn,
    'nama' : nama,
    'alamat' : alamat,
    'jenis_kelamin' : jenis_kelamin,
    'agama' : agama,
    'tanggal_lahir' : tanggal_lahir,
  };
}