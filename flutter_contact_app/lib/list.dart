import 'package:contact_app/accounts.dart';
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
      home: const list(title: 'Flutter Demo Home Page'),
    );
  }
}

class list extends StatefulWidget {
  const list({super.key, required this.title, this.token});
  final String title;
  final token;

  @override
  State<list> createState() => _listState();
}

class _listState extends State<list> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  return Card(
                    child: SizedBox(
                        width: 300,
                        height: 100,
                        child: Center(
                            child:
                            Column(mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Kisi Adi",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Accounts.ACCOUNTS[widget.token].Liste[index].kisi_adi.toString()),
                                Text("Kisi Soyadi",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Accounts.ACCOUNTS[widget.token].Liste[index].kisi_soyadi.toString()),
                                Text("Telefon Numarasi",style: TextStyle(fontWeight: FontWeight.bold),),
                                Text(Accounts.ACCOUNTS[widget.token].Liste[index].kisi_telefon.toString()),
                              ],
                            ))),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.blue,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                  );
                },
                childCount: Accounts.ACCOUNTS[widget.token].Liste.length, // Kaç adet Liste oluşturacağını belirler.
              ),
            ),
          ],
        ),
      ),
    );
  }
}






