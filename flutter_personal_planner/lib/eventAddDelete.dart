import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class eventAddDelete extends StatefulWidget {
  eventAddDelete();

  @override
  State<eventAddDelete> createState() => _eventAddDeleteState();
}


class _eventAddDeleteState extends State<eventAddDelete> {
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Hatali Giris!"),
      content: Text("Tüm bilgileri doldurmalısın!"),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  late String _ea;
  var _controller1 = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();
  final _timeC = TextEditingController();
  DateTime? _selectedDate = null;

  @override
  Widget build(BuildContext context) {
    _timeC.text = '';
    return Scaffold(
        appBar: AppBar(
          title: Text("Etkinlik Ekle-Sil"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: _controller1,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Etkinlik Adı'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Etkinlik Adı boş olamaz';
                    }
                    return null;
                  },
                  onSaved: (value) => _ea = value!,
                ),
                SizedBox(height: 15),
                Text("Etkinlik Günü"),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return ElevatedButton(
                          onPressed: () async {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050),
                            ).then((value) {
                              print(value!);
                              print("${value.day}:${value.month}:${value.year}");
                              if (value != null) {
                                setState(() {
                                  _selectedDate = value;
                                });
                              }
                            });
                          },
                          child: Text(_selectedDate == null
                              ? 'Gün Seç'
                              : '${_selectedDate!.day.toString()}/${_selectedDate!.month.toString()}/${_selectedDate!.year.toString()}'));
                    }),
                SizedBox(height: 15),
                Text("Etkinlik Saati"),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return ElevatedButton(
                      onPressed: () async {
                      var time = await showTimePicker(context: context, initialTime: timeOfDay);

                  if (time != null) {
                    setState(() {
                      _timeC.text = "${time.hour}:${time.minute}";
                    });
                  }
                      },
                      child:
                          Text(_timeC.text == '' ? 'Saat Seç' : _timeC.text));
                }),
                SizedBox(height: 30,),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
                  ),
                  child: Text('Ekle'),
                  onPressed: () async {

                    if(_controller1.text == ''|| _selectedDate == null || _timeC.text == '') {


                      showAlertDialog(context);
                    } else {
                      Database db;
                      Directory klasor = await getApplicationDocumentsDirectory();
                      String veritabyolu = join(klasor.path, "event.sqlite");

                      if (await databaseExists(veritabyolu)) {
                        print("Var");
                        db = await openDatabase(
                          veritabyolu,
                          version: 1,
                        );
                      } else {
                        print("yok");
                        db = await openDatabase(veritabyolu,
                            version: 1, onCreate: dbOlustur);
                        print("Oluştu");
                      }
                      var veriler = Map<String, dynamic>();
                      veriler["ead"] = _controller1.text;
                      veriler["etarih"] = _selectedDate.toString();
                      veriler["esaat"] = _timeC.text;

                      await db.insert("events", veriler);
                      print("Veri eklendi");
                    }
                    print("Kayıt Başarılı");

                  },
                ),

              ],
            ),
          ),
        ));
  }
  FutureOr<void> dbOlustur(Database db, int version) async {
    await db.execute(
        "CREATE TABLE events (id INTEGER PRIMARY KEY AUTOINCREMENT,ead TEXT,etarih TEXT, esaat TEXT)");
  }
}
