import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:personal_planner/profile.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: update(),
    );
  }
}

class update extends StatefulWidget {
  const update({this.gelenid});
  final gelenid;

  @override
  _updateState createState() => _updateState();
}

class _updateState extends State<update> {
  void showSuccessMessage() {
    /*
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Başarılı'),
          content: Text('Kaydınız başarıyla oluşturuldu.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Tamam'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
     */
  }
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

  DateTime? _selectedDate = null;
  int _maritalStatus = 0;
  var meddur = 'Bekar';
  bool _hasDriversLicense = false;
  int _ehliyet = 0;
  var ehliyet_sonuc='Yok';
  int _interest = 0;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  bool _isChecked3 = false;


  @override
  Widget build(BuildContext context) {
    String _tc;
    String _firstName;
    String _lastName;
    String _password;

    var _controller1 = TextEditingController();
    var _controller2 = TextEditingController();
    var _controller3 = TextEditingController();
    var _controller4 = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Güncelle!"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _controller1,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'TC Kimlik No'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'TC Kimlik No boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value) => _tc = value!,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    controller: _controller2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'İsim',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'İsim boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value) => _firstName = value!,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    controller: _controller3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Soyisim',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Soyisim boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value) => _lastName = value!,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    controller: _controller4,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Şifre',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Şifre boş olamaz';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value!,
                  ),
                ],
              ),
            ),
            Text("Doğum Günü"),
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
            Column(
              children: [
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        children: [
                          RadioListTile(
                            title: Text("Bekar"),
                            value: 1,
                            groupValue: _maritalStatus,
                            onChanged: (value) {
                              setState(() {
                                meddur = 'Bekar';
                                _maritalStatus = value as int;

                                print(_maritalStatus);
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Evli"),
                            value: 2,
                            groupValue: _maritalStatus,
                            onChanged: (value) {
                              setState(() {
                                meddur = 'Evli';
                                _maritalStatus = value as int;

                                print(_maritalStatus);
                              });
                            },
                          ),
                        ],
                      );
                    }),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return CheckboxListTile(
                        title: const Text('Yazılım'),
                        value: _isChecked1,
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              _isChecked1 = value!;
                              _interest += 1;
                            } else {
                              _interest -= 1;
                              _isChecked1 = value!;
                            }
                          });
                        },
                      );
                    }),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return CheckboxListTile(
                        title: const Text('Donanım'),
                        value: _isChecked2,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _isChecked2 = value!;
                              _interest += 2;
                            } else {
                              _interest -= 2;
                              _isChecked2 = value!;
                            }
                          });
                        },
                      );
                    }),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return CheckboxListTile(
                      title: const Text('Yapay Zeka'),
                      value: _isChecked3,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _isChecked3 = value!;
                            _interest += 4;
                          } else {
                            _interest -= 4;
                            _isChecked3 = value!;
                          }
                        });
                      },
                    );
                  },
                ),
                StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return SwitchListTile(
                      title: const Text('Ehliyet Bilgisi'),
                      value: _hasDriversLicense,
                      onChanged: (bool value) {
                        setState(() {
                          _hasDriversLicense = value;
                          if (_hasDriversLicense) {
                            ehliyet_sonuc= "Var";
                          } else {
                            ehliyet_sonuc= "Yok";
                          }
                        });
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: Text('Güncelle'),
                  onPressed: () async {
                    if(_controller1.text == '' ||_controller2.text == '' ||_controller3.text == '' ||_controller4.text == '' ||_maritalStatus == 0 ||_interest==0 || _selectedDate == null ) {


                      showAlertDialog(context);
                    } else {
                      Database db;
                      Directory klasor = await getApplicationDocumentsDirectory();
                      String veritabyolu = join(klasor.path, "personal.sqlite");

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
                      veriler["tc"] = _controller1.text;
                      veriler["isim"] = _controller2.text;
                      veriler["soyisim"] = _controller3.text;
                      veriler["sifre"] = _controller4.text;
                      veriler["dogumtarih"] = _selectedDate.toString();
                      veriler["medeni"] = meddur;
                      if(_interest==0){
                        veriler["ilgialan"] = '';
                      }
                      else if(_interest==1){
                        veriler["ilgialan"] = 'Yazılım';
                      }
                      else if(_interest==2){
                        veriler["ilgialan"] = 'Donanım';
                      }
                      else if(_interest==3){
                        veriler["ilgialan"] = 'Donanım-Yazılım';
                      }
                      else if(_interest==4){
                        veriler["ilgialan"] = 'Yapay Zeka';
                      }
                      else if(_interest==5){
                        veriler["ilgialan"] = 'Yapay Zeka-Yazılım';
                      }
                      else if(_interest==6){
                        veriler["ilgialan"] = 'Yapay Zeka-Donanım';
                      }
                      else if(_interest==7){
                        veriler["ilgialan"] = 'Yapay Zeka-Donanım-Yazılım';
                      }
                      veriler["ehliyet"] = ehliyet_sonuc;

                      await db.update("personals", veriler,
                      where: "id = ?", whereArgs: [widget.gelenid]);

                      print("Veri eklendi");

                      print("tc=>${_controller1.text}");
                      print("isim=>${_controller2.text}");
                      print("soyisim=>${_controller3.text}");
                      print("sifre=>${_controller4.text}");
                      print("DatePicker=>${_selectedDate}");
                      print("Radio=>${_maritalStatus}");
                      print("CheckBox=>${_interest}");
                      print("Switch=>${ehliyet_sonuc}");
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => profile(gelenid : widget.gelenid)),
                    );

                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureOr<void> dbOlustur(Database db, int version) async {
    await db.execute(
        "CREATE TABLE personals (id INTEGER PRIMARY KEY AUTOINCREMENT,tc TEXT,isim TEXT,soyisim TEXT, sifre TEXT, dogumtarih TEXT, medeni TEXT, ilgialan TEXT, ehliyet TEXT)");
  }
}
