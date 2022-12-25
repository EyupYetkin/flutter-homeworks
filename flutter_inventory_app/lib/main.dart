import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory/nesne.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Nesne> Liste = [];

  var quantity = 0;
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  void decrementQuantity() {
    setState(() {
      if (quantity > 0) {
        quantity--;
      }
      //quantity
    });
  }

  var nesneAdi;
  void _change(String enteredKeyword) {
    nesneAdi = enteredKeyword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Uygulama ismi',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.yellow,
        centerTitle: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: AlignmentDirectional.centerStart,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      onChanged: (value) => _change(value),
                      decoration: InputDecoration(
                          labelText: 'Nesne adı',
                          labelStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            const BorderSide(width: 2, color: Colors.black),
                            borderRadius: BorderRadius.circular(20.0),
                          )),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          IconButton(
                            onPressed: () => decrementQuantity(),
                            icon: Icon(Icons.remove, color: Colors.black),
                            iconSize: 30,
                          ),
                          SizedBox(width: 15),
                          Text('${quantity}'),
                          SizedBox(width: 15),
                          IconButton(
                            onPressed: () => incrementQuantity(),
                            icon: Icon(Icons.add, color: Colors.black),
                            iconSize: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                alignment: AlignmentDirectional.centerEnd,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      var run = 0;
                      if (quantity != 0) {
                        if (Liste.isEmpty) {
                          Nesne nesneY = Nesne(nesneAdi, quantity);
                          Liste.add(nesneY);
                          quantity = 0;
                        } else {
                          for (int i = 0; i < Liste.length; i++) {
                            if (Liste[i].adi == nesneAdi) {
                              Liste[i].sayi = Liste[i].sayi + quantity;
                              quantity = 0;
                              run = 1;
                            }
                          }
                          if (run == 0) {
                            Nesne nesneY = Nesne(nesneAdi, quantity);
                            Liste.add(nesneY);
                            quantity = 0;
                          }
                        }
                      }
                    });
                  },
                  child: Text(
                    'Ekle',
                  ),
                  style: ElevatedButton.styleFrom(
                      onPrimary: Colors.black,
                      elevation: 0,
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
              child: ListView.builder(
                itemCount: Liste.length,
                itemBuilder: (context, index) => Card(
                  color: Colors.yellow[100 * index],
                  elevation: 0,
                  child: Column(
                    children: [
                      ListTile(
                          leading: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                width: 2,
                                color: Colors.black,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                Liste[index].sayi.toString(),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ),
                          title: Text(Liste[index].adi,
                              style: TextStyle(color: Colors.black)),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                Liste.removeAt(index);
                              });
                            },
                            icon: Icon(CupertinoIcons.minus_circle,
                                color: Colors.black),
                            iconSize: 30,
                          )),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Divider(
                          color: Colors.black,
                          thickness: 5,
                          indent: 8,
                          endIndent: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
