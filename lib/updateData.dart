import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UpdateData extends StatefulWidget {
  final List list;
  final int index;
  UpdateData({this.list, this.index});
  @override
  _UpdateDataState createState() => _UpdateDataState();
}

class _UpdateDataState extends State<UpdateData> {
  TextEditingController judulLaporan = new TextEditingController();
  TextEditingController idKategori = new TextEditingController();
  TextEditingController image = new TextEditingController();
  TextEditingController deskripsi = new TextEditingController();
  TextEditingController idUser = new TextEditingController();

  bool editMode = false;

  addUpdateData() {
    var url = 'http://192.168.1.5/lapor_crud/updatedata.php';
    http.post(url, body: {
      'judul_laporan': judulLaporan.text,
      'id_kategori': idKategori.text,
      'image': image.text,
      'deskripsi': deskripsi.text,
      'id_user': idUser.text
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Tambah Laporan"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            new Column(
              children: <Widget>[
                new TextField(
                  controller: judulLaporan,
                  decoration: new InputDecoration(
                    hintText: "Judul Harus Jelas!",
                    labelText: "Judul Laporan",
                  ),
                ),
                new TextField(
                  controller: idKategori,
                  decoration: new InputDecoration(
                    hintText: "Masukan Kategori",
                    labelText: "Kategori Laporan",
                  ),
                ),
                new TextField(
                  controller: image,
                  decoration: new InputDecoration(
                    hintText: "Tidak Lebih dari 2MB",
                    labelText: "Gambar",
                  ),
                ),
                new TextField(
                  controller: deskripsi,
                  decoration: new InputDecoration(
                    hintText: "Deskripsi Laporan",
                  ),
                ),
                new TextField(
                  controller: idUser,
                  decoration: new InputDecoration(
                    hintText: "Masukan id anda",
                  ),
                ),
                new RaisedButton(
                  child: new Text(
                    "UPDATE",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                  onPressed: () {
                    addUpdateData();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
