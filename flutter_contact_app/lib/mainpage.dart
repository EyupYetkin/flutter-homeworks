import 'package:contact_app/main.dart';
import 'package:flutter/material.dart';

import 'add.dart';
import 'findEditDelete.dart';
import 'list.dart';

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
      home: const mainpage(title: 'Flutter Demo Home Page'),
    );
  }
}

class mainpage extends StatefulWidget {
  const mainpage({super.key, required this.title, this.token});
  final String title;
  final token;

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {

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
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(width:400,height: 50,child: ElevatedButton(onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> add(title: 'Ekle',token: widget.token,))), (route) => false);
              },child: Text("Ekle"))),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(width:400,height: 50,child: ElevatedButton(onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> findEditDelete(title: 'Bul-Duzenle-Sil',token: widget.token))), (route) => false);
              },child: Text("Bul-Duzenle-Sil"))),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(width:400,height: 50,child: ElevatedButton(onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => list(title: 'Listele',token: widget.token)),
                );
                },child: Text("Listele"))),
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: SizedBox(width:400,height: 50,child: ElevatedButton(onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> MyHomePage(title: 'Giris Sayfasi',))), (route) => false);
              },child: Text("Giris Sayfasi"),)),
            ),
          ],
        ),
      ),
    );
  }
}
