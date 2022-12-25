import 'package:contact_app/main.dart';
import 'package:contact_app/account.dart';
import 'package:contact_app/contact.dart';
import 'package:flutter/material.dart';
import 'accounts.dart';

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
      home: const signup(title: 'Flutter Demo Home Page'),
    );
  }
}

class signup extends StatefulWidget {
  const signup({super.key, required this.title});
  final String title;

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
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
                  labelText: 'Uye Adi',
                  hintText: 'Uye Adi Giriniz',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _controller2,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Kullanici Adi',
                  hintText: 'Kullanici Adi Giriniz',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: _controller3,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Parola',
                  hintText: 'Parola Giriniz',
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(8),
              child: Center(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 100,),
                    Expanded(child: ElevatedButton(onPressed: () {
                      Account ac = Account(_controller1.text, _controller2.text, _controller3.text);
                      Accounts.ACCOUNTS.add(ac);
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=> MyHomePage(title: 'Giris Yap!',))), (route) => false);
                    },child: Text("Kaydol"))),
                    SizedBox(width: 100,),
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
