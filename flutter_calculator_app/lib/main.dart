import 'package:calculator/buttons.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var yaziEkran = '0';

  //final myTextStyle =
      //TextStyle(fontSize: 50, color: Colors.black, fontWeight: FontWeight.bold);

  final List<String> butonlar = [
    'M',
    'C',
    'MR',
    '÷',
    '7',
    '8',
    '9',
    'X',
    '4',
    '5',
    '6',
    '—',
    '1',
    '2',
    '3',
    '+',
    'AC',
    '0',
    '.',
    '=',
  ];

  bool isOperator(String x) {
    if (x == '÷' || x == 'X' || x == '—' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(167, 187, 203, 1),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.fromLTRB(18, 98, 37.5, 0),
                      child: Text(
                        yaziEkran,
                        style: TextStyle(fontSize: 100),
                      ))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: GridView.builder(
                  itemCount: butonlar.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return MyButton(
                        butonBas: () {
                          hesapla(butonlar[index]);
                        },
                        renk: isOperator(butonlar[index])
                            ? Color.fromRGBO(235, 136, 51, 1)
                            : Color.fromRGBO(215, 224, 224, 1),
                        yaziRenk: Colors.black,
                        butonYazi: butonlar[index]);
                  }),
            ),
          ),
        ],
      ),
    );
  }




  double ilkSayi = 0;
  double ikinciSayi = 0;
  double hafiza=0;
  dynamic sonuc = '';
  dynamic sonSonuc = '';
  dynamic islem = '';
  dynamic oncekiIslem = '';

  void hesapla(btnText) {

    if (btnText == 'M') {
      hafiza += double.parse(yaziEkran);
      sonuc ='';
      sonSonuc='0';
    } else if (btnText == 'C') {
      hafiza = 0;
    } else if (btnText == 'MR') {
      sonSonuc = hafiza.toString();
    }

    if (btnText == 'AC') {
      //ilkSayi = 0;
      //ikinciSayi = 0;
      sonuc = '';
      sonSonuc = '0';
      //islem = '';
      //oncekiIslem = '';
    } else if (islem == '=' && btnText == '=') {
      if (oncekiIslem == '+') {
        sonSonuc = topla();
      } else if (oncekiIslem == '—') {
        sonSonuc = cikar();
      } else if (oncekiIslem == 'X') {
        sonSonuc = carp();
      } else if (oncekiIslem == '÷') {
        sonSonuc = bol();
      }
    } else if (btnText == '+' ||
        btnText == '—' ||
        btnText == 'X' ||
        btnText == '÷' ||
        btnText == '=') {
      if (ilkSayi == 0) {
        ilkSayi = double.parse(sonuc);
      } else {
        ikinciSayi = double.parse(sonuc);
      }

      if (islem == '+') {
        sonSonuc = topla();
      } else if (islem == '—') {
        sonSonuc = cikar();
      } else if (islem == 'X') {
        sonSonuc = carp();
      } else if (islem == '÷') {
        sonSonuc = bol();
      }


      oncekiIslem = islem;
      islem = btnText;
      sonuc = '';
    } else if (btnText == '.') {
      if (!sonuc.toString().contains('.')) {
        sonuc = sonuc.toString() + '.';
      }
      sonSonuc = sonuc;
    } else if(btnText !='M' && btnText !='C' && btnText !='MR'){
      sonuc = sonuc + btnText;
      sonSonuc = sonuc;
    }

    setState(() {
      yaziEkran = sonSonuc;
    });
  }

  String topla() {
    sonuc = (ilkSayi + ikinciSayi).toString();
    ilkSayi = double.parse(sonuc);
    return doesContainDecimal(sonuc);
  }

  String cikar() {
    sonuc = (ilkSayi - ikinciSayi).toString();
    ilkSayi = double.parse(sonuc);
    return doesContainDecimal(sonuc);
  }

  String carp() {
    sonuc = (ilkSayi * ikinciSayi).toString();
    ilkSayi = double.parse(sonuc);
    return doesContainDecimal(sonuc);
  }

  String bol() {
    sonuc = (ilkSayi / ikinciSayi).toString();
    ilkSayi = double.parse(sonuc);
    return doesContainDecimal(sonuc);
  }

  String doesContainDecimal(dynamic sonuc) {
    if (sonuc.toString().contains('.')) {
      List<String> splitDecimal = sonuc.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return sonuc = splitDecimal[0].toString();
    }
    return sonuc;
  }
}
