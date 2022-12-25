import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_planner/update.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class profile extends StatefulWidget {
  const profile({this.gelenid});
  final gelenid;

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  late Future<Map<String, dynamic>?> _satirFuture;

  @override
  void initState() {
    super.initState();
    _satirFuture = dbGoster();
  }

  Future<Map<String, dynamic>?>dbGoster() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String veritabyolu = join(klasor.path, "personal.sqlite");
    Database db = await openDatabase(veritabyolu);
    if (await databaseExists(veritabyolu)) {
      print("Var");

      List<Map<String, dynamic>> maps = await db.rawQuery(
          "SELECT * FROM personals WHERE id = ?", [widget.gelenid.toString()]);
      return maps[0];
    } else {
      print("Veri tabanı yok");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profilim"),
      ),
      body: Center(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: _satirFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic>? satir = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("ID=>${satir!["id"]}"),
                  Text("TC Kimlik=>" + satir["tc"].toString()),
                  Text("İsim=>" + satir["isim"]),
                  Text("Soyisim=>" + satir["soyisim"]),
                  Text("Sifre=>" + satir["sifre"]),
                  Text("Medeni=>" + satir["medeni"].toString()),
                  Text("İlgi Alanları=>" + satir["ilgialan"]),
                  Text("Ehliyet=>" + satir["ehliyet"].toString()),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  update(gelenid: widget.gelenid)),
                        );
                      },
                      child: Text("Güncellemek için bas!")),
                ],
              );
            } else if (snapshot.hasError) {
              return Text("Veri okuma hatası: ${snapshot.error}");
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

