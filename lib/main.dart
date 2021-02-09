import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_flutter/adminPage.dart';
import 'package:login_flutter/splash.dart';
import 'package:login_flutter/userPage.dart';

void main() {
  runApp(MyApp());
}

String username = '';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: splash(),
      routes: <String, WidgetBuilder>{
        '/adminPage': (BuildContext) => new adminPage(
              username: username,
            ),
        '/userPage': (BuildContext) => new userPage(
              username: username,
            ),
        '/MyHomePage': (BuildContext) => new MyHomePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController user = new TextEditingController();
  TextEditingController pass = new TextEditingController();

  String msg = '';

  Future<List> _login() async {
    final response =
        await http.post("http://192.168.1.5/lapor_online/login.php", body: {
      "username": user.text,
      "password": pass.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "login fail";
      });
    } else {
      if (datauser[0]['level'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/adminPage');
      } else if (datauser[0]['level'] == 'user') {
        Navigator.pushReplacementNamed(context, '/userPage');
      }

      setState(() {
        username = datauser[0]['username'];
      });

      print(response.body);
      print(response.statusCode);
    }

    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Container(
        child: Center(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Lapor Online",
                  style: TextStyle(color: Colors.redAccent, fontSize: 20.0),
                ),
                Divider(),
                TextField(
                  controller: user,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (Colors.transparent),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: "Username",
                    filled: true,
                    fillColor: Colors.redAccent,
                    icon: Icon(
                      Icons.people,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
                Divider(),
                TextField(
                  controller: pass,
                  obscureText: true,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: (Colors.transparent),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.redAccent,
                    icon: Icon(
                      Icons.lock,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ),
                Divider(),
                RaisedButton(
                  color: Colors.white,
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  onPressed: () {
                    _login();
                  },
                ),
                Text(msg,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
