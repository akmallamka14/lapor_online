import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter/adddata.dart';
import 'package:login_flutter/detail.dart';

class userPage extends StatelessWidget {
  userPage({this.username});
  final String username;

  Future<List> getData() async {
    final response =
        await http.get("http://192.168.1.5/lapor_crud/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Selamat Datang $username"),
      ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(
          Icons.add,
          size: 35.0,
        ),
        onPressed: () => Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => new AddData(),
          ),
        ),
      ),
      body: new FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(
                  list: snapshot.data,
                )
              : new Center(
                  child: new CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return Container(
          padding: const EdgeInsets.all(3.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
              new MaterialPageRoute(
                  builder: (BuildContext context) => new detail(
                        list: list,
                        index: i,
                      )),
            ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['judul_laporan']),
                leading: new Icon(Icons.info),
                subtitle: new Text("Deskripsi : ${list[i]['deskripsi']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
