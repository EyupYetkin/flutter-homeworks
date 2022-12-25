import 'package:contact_app/accounts.dart';
import 'package:contact_app/contact.dart';
import 'package:contact_app/mainpage.dart';
import 'package:flutter/material.dart';

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
      home: const add(title: 'Flutter Demo Home Page'),
    );
  }
}

class add extends StatefulWidget {
  const add({super.key, required this.title, this.token});
  final String title;
  final token;

  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  var _controller1 = TextEditingController();
  var _controller2 = TextEditingController();
  var _controller3 = TextEditingController();
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
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: SizedBox(width:400,height: 50,child: ElevatedButton(onPressed: () {
                print(widget.token);
                Contact ac = Contact(_controller1.text, _controller2.text, _controller3.text);
                Accounts.ACCOUNTS[widget.token].Liste.add(ac);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> mainpage(title: Accounts.ACCOUNTS[widget.token].uye_adi,token: widget.token,))), (route) => false);
              },child: Text("Rehbere Ekle"),)),
            ),
          ],
        ),
      ),
    );
  }
}
