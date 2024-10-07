import 'package:biodata/models/modelsiswa.dart';
import 'package:biodata/models/api.dart';
import 'package:biodata/ui/edit.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

class DetailSiswa extends StatefulWidget {
  final ModelSiswa sw;
  DetailSiswa({required this.sw});

  @override
  _DetailSiswaState createState() => _DetailSiswaState();
}

class _DetailSiswaState extends State<DetailSiswa> {
  void deleteSiswa(context) async {
    http.Response response = await http.post(Uri.parse(BaseUrl.hapus), body: {
      'id': widget.sw.id.toString(),
    });
    pesan() {
      Fluttertoast.showToast(
          msg: "Penghapusan Data Berhasil",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    final data = json.decode((response.body));
    if (data['success']) {
      pesan();
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  void confirmDelete(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text('Apakah Anda yakin menghapus data ini?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Icon(Icons.cancel),
              ),
              ElevatedButton(
                  onPressed: () => deleteSiswa(context),
                  child: Icon(Icons.check_circle))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Siswa'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            onPressed: () => confirmDelete(context),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ID : ${widget.sw.id}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "NISN : ${widget.sw.nisn}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text(
              "Nama : ${widget.sw.nama}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Alamat : ${widget.sw.alamat}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Gender : ${widget.sw.jenis_kelamin}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Agama : ${widget.sw.agama}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Tanggal Lahir : ${widget.sw.tanggal_lahir}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Nama : ${widget.sw.nama}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman FormInput
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Edit(sw: widget.sw)), // Pastikan FormInput benar diimport
          );
        },
        child: Icon(Icons.edit),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
