import 'package:flutter/material.dart';

class adminPage extends StatelessWidget {
  adminPage({this.username});
  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Admin"),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'Halo $username',
            style: TextStyle(fontSize: 20.0),
          ),
          RaisedButton(
              child: Text("LogOut"),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/MyHomePage');
              })
        ],
      ),
    );
  }
}
