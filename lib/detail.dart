import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter/updateData.dart';
import 'dart:convert';

class detail extends StatefulWidget {
  List list;
  int index;
  detail({this.index, this.list});
  @override
  _detailState createState() => new _detailState();
}

class _detailState extends State<detail> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['judul_laporan']}"),
      ),
      body: new Container(
        height: 250.0,
        padding: const EdgeInsets.all(3.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[
                new Text(
                  "Judul Laporan : ${widget.list[widget.index]['judul_laporan']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                Divider(),
                new Text(
                  "Image : ${widget.list[widget.index]['image']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                new Text(
                  "Deskripsi : ${widget.list[widget.index]['deskripsi']}",
                  style: new TextStyle(fontSize: 20.0),
                ),
                Divider(),
                new Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Edit"),
                      color: Colors.blueAccent,
                      onPressed: () => Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context) => new UpdateData(),
                        ),
                      ),
                    ),
                    new RaisedButton(
                      child: new Text("Delete"),
                      color: Colors.redAccent,
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
