import 'dart:convert';

import 'package:biodata/models/modelsiswa.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:biodata/models/api.dart';
import 'package:http/http.dart' as http;

import 'package:biodata/ui/form.dart';


class Edit extends StatefulWidget{
  final ModelSiswa sw;

  Edit({required this.sw});

  @override
  State<StatefulWidget> createState() => EditState();
}
class EditState extends State<Edit>{
  final formkey = GlobalKey<FormState>();

  late TextEditingController nisnController, namaController,
    alamatController, jenis_kelaminController, agamaController, tanggal_lahirController;

  Future editSw() async {
    return await http.post(
        Uri.parse(BaseUrl.edit),
        body: {
          "id": widget.sw.id.toString(),
          "nisn": nisnController.text,
          "nama": namaController.text,
          "alamat": alamatController.text,
          "jenis_kelamin": jenis_kelaminController.text,
          "agama": agamaController.text,
          "tanggal_lahir": tanggal_lahirController.text
        }
    );
  }

  pesan() {
    Fluttertoast.showToast(
        msg: "Perubahan data berhasil",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void _onConfirm(context) async {
    http.Response response = await editSw();
    final data = json.decode(response.body);
    if(data['success']) {
      pesan();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override

  void initState() {
    nisnController = TextEditingController(text: widget.sw.nisn);
    namaController = TextEditingController(text: widget.sw.nama);
    alamatController = TextEditingController(text: widget.sw.alamat);
    jenis_kelaminController = TextEditingController(text: widget.sw.jenis_kelamin);
    agamaController = TextEditingController(text: widget.sw.agama);
    tanggal_lahirController = TextEditingController(text: widget.sw.tanggal_lahir);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Siswa",
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
      bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            child: Text("Update"),
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.orange,
                textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)
            ),
            onPressed: () {
              _onConfirm(context);
            },
          )
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: EditDataSiswa(
            formkey: formkey,
            nisnController: nisnController,
            namaController: namaController,
            alamatController: alamatController,
            jenis_kelaminController: jenis_kelaminController,
            agamaController: agamaController,
            tanggal_lahirController: tanggal_lahirController,
          ),
        ),
      ),
    );
  }

}