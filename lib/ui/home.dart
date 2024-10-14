import 'dart:convert';
import 'dart:async';
import 'package:biodata/ui/DetailSiswa.dart';
import 'package:biodata/ui/forminput.dart'; // Pastikan nama file dan class sudah benar
import 'package:flutter/material.dart';
import 'package:biodata/models/modelsiswa.dart';
import 'package:biodata/models/api.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<ModelSiswa>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<ModelSiswa>> getSwList() async {
    final startTime = DateTime.now();
    final response =
        await http.get(Uri.parse(BaseUrl.data)).timeout(Duration(seconds: 10));
    final endTime = DateTime.now();
    print(
        'Network request took ${endTime.difference(startTime).inMilliseconds} milliseconds');

    final items = json.decode(response.body).cast<Map<String, dynamic>>();
    List<ModelSiswa> sw = items.map<ModelSiswa>((json) {
      return ModelSiswa.fromJson(json);
    }).toList();

    return sw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: FutureBuilder<List<ModelSiswa>>(
          future: sw,
          builder:
              (BuildContext context, AsyncSnapshot<List<ModelSiswa>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No data found");
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.person),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      "${data.nisn} - ${data.nama}",
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Alamat: ${data.alamat}"),
                        Text("Gender: ${data.jenis_kelamin}"),
                        Text("Agama: ${data.agama}"),
                        Text("Tanggal Lahir: ${data.tanggal_lahir}"),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailSiswa(sw: data)));
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke halaman FormInput
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FormTambah()), // Pastikan FormInput benar diimport
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
