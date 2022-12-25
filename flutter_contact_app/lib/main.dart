import 'package:contact_app/accounts.dart';
import 'package:contact_app/mainpage.dart';
import 'package:contact_app/signup.dart';
import 'package:flutter/material.dart';


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
      home: const MyHomePage(title: 'Giris Sayfasi'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

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
                  labelText: 'Kullanici Adi',
                  hintText: 'Kullanici Adi Giriniz',
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
            Padding(padding: EdgeInsets.all(8),
              child: Center(
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 50,),

                    Expanded(child: ElevatedButton(onPressed: () {
                      var c=0;
                      for(int i=0; i<Accounts.ACCOUNTS.length; i++){
                        if(Accounts.ACCOUNTS[i].kullanici_adi == _controller1.text && Accounts.ACCOUNTS[i].parola == _controller2.text) {
                          c=1;
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: ((context)=>mainpage(title: Accounts.ACCOUNTS[i].uye_adi,token: i))), (route) => false);
                        }
                      }
                      if(c==0){
                        _controller1.clear();
                        _controller2.clear();
                        showAlertDialog(context);
                      }

                    },child: Text("deneme Yap"))),


                    SizedBox(width: 25,),
                    Expanded(child: ElevatedButton(onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const signup(title: 'Kayıt Ol!',)),
                      );
                    },child: Text("Uye ol"))),
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
