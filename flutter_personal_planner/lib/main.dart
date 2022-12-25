import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_planner/signup.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'mainpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rehber Uygulamasi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Hatali Giris!"),
      content: Text("Kullanici Adi veya Parola yanlis."),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giriş Yap"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _controller1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'TC Kimlik',
                  hintText: 'TC Kimlik Giriniz',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _controller2,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Parola',
                  hintText: 'Parola Giriniz',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 50,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () async {
                              Directory klasor = await getApplicationDocumentsDirectory();
                              String veritabyolu = join(klasor.path, "personal.sqlite");
                              Database db = await openDatabase(veritabyolu);

                              List<Map> results = await db.rawQuery('SELECT * FROM personals WHERE tc = ?', [_controller1.text]);
                              if (results.isNotEmpty && results[0]['sifre'] == _controller2.text) {
                                var gelenid =results[0]['id'];
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => mainpage(gelenid: gelenid))),
                                    (route) => false);
                              } else {
                                _controller1.clear();
                                _controller2.clear();
                                showAlertDialog(context);
                              }
                            },
                            child: Text("Giriş Yap"))),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                            child: Text("Kayıt ol"))),
                    SizedBox(
                      width: 50,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
