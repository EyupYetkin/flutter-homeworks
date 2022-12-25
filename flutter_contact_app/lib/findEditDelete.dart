import 'package:contact_app/contact.dart';
import 'package:flutter/material.dart';

import 'accounts.dart';
import 'mainpage.dart';

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
      home: const findEditDelete(title: 'Flutter Demo Home Page'),
    );
  }
}

class findEditDelete extends StatefulWidget {
  const findEditDelete({super.key, required this.title, this.token});
  final String title;
  final token;
  @override
  State<findEditDelete> createState() => _findEditDeleteState();
}

class _findEditDeleteState extends State<findEditDelete> {
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();
  var sayac = 0;
  var f = 0;
  var q;
  Contact yerelKisi = new Contact("y","y","y");

  showAlertDialog(BuildContext context) {
    Widget TamamButton = TextButton(
      child: Text("Tamam"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );


    AlertDialog alert = AlertDialog(
      title: Text("Tüh"),
      content: Text("Aradığınız Kişiyi Bulamadık"),
      actions: [
        TamamButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog2(BuildContext context) {
    Widget TamamButton = TextButton(
      child: Text("Tamam"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );


    AlertDialog alert2=AlertDialog(
      title: Text("Ne yazık"),
      content: Text("Sadece bir alan dolu olmalı"),
      actions: [TamamButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert2;
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(widget.title),
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
                  labelText: 'Ad',
                  hintText: 'Kisi Adi Giriniz',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _controller2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Soyad',
                  hintText: 'Kisi Soyadi Giriniz',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _controller3,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Telefon',
                  hintText: 'Telefon Giriniz',
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(8),
              child: Center(
                child: Row(
                  children: <Widget>[


                    SizedBox(width: 50,),
                    Expanded(child: ElevatedButton(onPressed: () {
                      setState(() {

                        if(_controller1.text.isEmpty){
                          sayac+=1;
                        }
                        if(_controller2.text.isEmpty){
                          sayac+=1;
                        }
                        if(_controller3.text.isEmpty){
                          sayac+=1;
                        }
                        if(sayac!=2){
                          showAlertDialog2(context);
                          _controller1.clear();
                          _controller2.clear();
                          _controller3.clear();
                          sayac=0;
                        }
                        else{
                          for(int i=0;i<Accounts.ACCOUNTS[widget.token].Liste.length;i++){
                            if(_controller1.text==Accounts.ACCOUNTS[widget.token].Liste[i].kisi_adi ||
                                _controller2.text==Accounts.ACCOUNTS[widget.token].Liste[i].kisi_soyadi ||
                                _controller3.text==Accounts.ACCOUNTS[widget.token].Liste[i].kisi_telefon)
                            {

                              yerelKisi = Accounts.ACCOUNTS[widget.token].Liste[i];
                              _controller1.text=Accounts.ACCOUNTS[widget.token].Liste[i].kisi_adi;
                              _controller2.text=Accounts.ACCOUNTS[widget.token].Liste[i].kisi_soyadi;
                              _controller3.text=Accounts.ACCOUNTS[widget.token].Liste[i].kisi_telefon;
                              f=1;
                              q=i;
                              break;
                            }
                          }
                          if(f==0){
                            showAlertDialog(context);
                            _controller1.clear();
                            _controller2.clear();
                            _controller3.clear();
                          }
                        }
                      });
                      },child: Text("Bul"))),






                    SizedBox(width: 25,),
                    Expanded(child: ElevatedButton(onPressed: () {
                      Accounts.ACCOUNTS[widget.token].Liste[q].kisi_adi=_controller1.text;
                      Accounts.ACCOUNTS[widget.token].Liste[q].kisi_soyadi=_controller2.text;
                      Accounts.ACCOUNTS[widget.token].Liste[q].kisi_telefon=_controller3.text;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Duzenlendi")));
                    },child: Text("Duzenle"))),
                    SizedBox(width: 50,),
                    Expanded(child: ElevatedButton(onPressed: () {
                      Accounts.ACCOUNTS[widget.token].Liste.removeAt(q);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Silindi")));
                      _controller1.clear();
                      _controller2.clear();
                      _controller3.clear();
                    },child: Text("Sil"))),
                    SizedBox(width: 50,),
                    Expanded(child: ElevatedButton(onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> mainpage(title: Accounts.ACCOUNTS[widget.token].uye_adi,token: widget.token))), (route) => false);

                    },child: Text("Anasayfa"))),
                    SizedBox(width: 50,),
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

