import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_planner/events.dart';
import 'package:personal_planner/main.dart';
import 'package:personal_planner/profile.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const mainpage(),
    );
  }
}

class mainpage extends StatefulWidget {
  const mainpage({this.gelenid});

  final gelenid;

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ana Ekran"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Etkinliklerim'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => events()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Profilim'),
              onTap: () async {
                print("aaaaaaa");
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile(gelenid : widget.gelenid)),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Çıkış Yap'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: ((context) => MyHomePage())),
                    (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
