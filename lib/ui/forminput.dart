import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/api.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class FormTambah extends StatefulWidget {
  const FormTambah({super.key});
  @override
  State<StatefulWidget> createState() => FormTambahState();
}

class FormTambahState extends State<FormTambah> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nisnController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController jenis_kelaminController = TextEditingController();
  TextEditingController agamaController = TextEditingController();
  TextEditingController tanggal_lahirController = TextEditingController();

  String? selectedValue;
  String? selectedReligion; // Menyimpan nilai yang dipilih
  Future createSw() async {
    return await http.post(Uri.parse(BaseUrl.tambah), body: {
      'nisn': nisnController.text,
      'nama': namaController.text,
      'alamat': alamatController.text,
      "jenis_kelamin": jenis_kelaminController.text,
      "agama": agamaController.text,
      "tanggal_lahir": tanggal_lahirController.text,
    });
  }

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if (data['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Data Siswa",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: Container(
        child: Column(
          children: [
            _textboxNisn(),
            _textboxNama(),
            _textboxGender(),
            _textboxTanggal(),
            _textboxAgama(),
            _textboxAlamat(),
            const SizedBox(
                height: 20.0), // Memberikan jarak antara input form dan tombol
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  _textboxNisn() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "NISN Siswa",
          prefixIcon: Icon(
              Icons.person_pin_rounded), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        controller: nisnController,
      ),
    );
  }

  _textboxNama() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Nama Siswa",
          prefixIcon:
              Icon(Icons.person), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        controller: namaController,
      ),
    );
  }

  _textboxAlamat() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Alamat Siswa",
          prefixIcon:
              Icon(Icons.add_home), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        controller: alamatController,
      ),
    );
  }

  _textboxGender() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Jenis Kelamin',
          prefixIcon: Icon(Icons.wc), // Anda bisa mengganti ikon jika perlu
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text(
          'Pilih Jenis Kelamin',
          style: TextStyle(fontSize: 14),
        ),
        items: [
          DropdownMenuItem(
            value: '1', // ID untuk Laki-laki
            child: Text('Laki-laki', style: const TextStyle(fontSize: 14)),
          ),
          DropdownMenuItem(
            value: '2', // ID untuk Perempuan
            child: Text('Perempuan', style: const TextStyle(fontSize: 14)),
          ),
        ],
        // Menggunakan selectedValue jika ada, jika tidak, menggunakan nilai dari controller
        value: selectedValue ??
            (jenis_kelaminController.text.isNotEmpty
                ? jenis_kelaminController.text
                : null),
        onChanged: (String? value) {
          setState(() {
            selectedValue = value; // Set nilai yang dipilih
            jenis_kelaminController.text =
                selectedValue!; // Simpan ke controller
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pilih Jenis Kelamin Anda.';
          }
          return null;
        },
      ),
    );
  }

  _textboxAgama() {
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(value: '1', child: Text('Islam')),
      DropdownMenuItem(value: '2', child: Text('Kristen')),
      DropdownMenuItem(value: '3', child: Text('Katolik')),
      DropdownMenuItem(value: '4', child: Text('Hindu')),
      DropdownMenuItem(value: '5', child: Text('Buddha')),
      DropdownMenuItem(value: '6', child: Text('Konghucu')),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Agama',
          prefixIcon: Icon(Icons.mosque),
          border: InputBorder.none,
          contentPadding:
              EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text(
          'Pilih Agama',
          style: TextStyle(fontSize: 14),
        ),
        items: items,
        value: selectedReligion ??
            (agamaController.text.isNotEmpty ? agamaController.text : null),
        onChanged: (String? value) {
          setState(() {
            selectedReligion = value; // Set nilai yang dipilih
            agamaController.text =
                selectedReligion ?? ''; // Simpan ke controller
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pilih Agama Anda.';
          }
          return null;
        },
      ),
    );
  }

  _textboxTanggal() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextField(
        controller: tanggal_lahirController, // Controller untuk tanggal lahir
        decoration: const InputDecoration(
          labelText: "Tanggal Lahir Siswa",
          prefixIcon: Icon(Icons.cake), // Ikon kalender di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        readOnly: true,
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
          );

          if (pickedDate != null) {
            setState(() {
              tanggal_lahirController.text =
                  "${pickedDate.toLocal()}".split(' ')[0];
            });
          }
        },
      ),
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple, // Warna teks
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Membuat sudut tombol melengkung
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 30.0), // Padding di dalam tombol
        elevation: 5.0, // Efek shadow di bawah tombol
        shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
      ),
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
