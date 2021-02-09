import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  File _image;

  Future getImageGallery() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = imageFile;
    });
  }

  Future getImageCamera() async {
    // ignore: deprecated_member_use
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = imageFile;
    });
  }

  TextEditingController controllerJudul = new TextEditingController();
  TextEditingController controllerKategori = new TextEditingController();
  TextEditingController controllerImage = new TextEditingController();
  TextEditingController controllerDeskripsi = new TextEditingController();
  TextEditingController controllerIdUser = new TextEditingController();

  void addData() {
    var url = "http://192.168.1.5/lapor_crud/adddata.php";

    http.post(url, body: {
      "judul_laporan": controllerJudul.text,
      "id_kategori": controllerKategori.text,
      "image": controllerImage.text,
      "deskripsi": controllerDeskripsi.text,
      "id_user": controllerIdUser.text,
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
                _image == null
                    ? new Text("No image picked!")
                    : new Image.file(_image),
                new TextField(
                  controller: controllerJudul,
                  decoration: new InputDecoration(
                    hintText: "Judul Harus Jelas!",
                    labelText: "Judul Laporan",
                  ),
                ),
                new TextField(
                  controller: controllerKategori,
                  decoration: new InputDecoration(
                    hintText: "Masukan Kategori",
                    labelText: "Kategori Laporan",
                  ),
                ),
                Row(
                  children: [
                    new RaisedButton(
                      child: Icon(Icons.image),
                      onPressed: getImageGallery,
                    ),
                  ],
                ),
                Row(
                  children: [
                    new RaisedButton(
                      child: Icon(Icons.camera),
                      onPressed: getImageCamera,
                    ),
                  ],
                ),
                new TextField(
                  controller: controllerDeskripsi,
                  decoration: new InputDecoration(
                    hintText: "Deskripsi Laporan",
                  ),
                ),
                new TextField(
                  controller: controllerIdUser,
                  decoration: new InputDecoration(
                    hintText: "id_user",
                  ),
                ),
                new RaisedButton(
                  child: new Text(
                    "ADD DATA",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.redAccent,
                  onPressed: () {
                    addData();
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
