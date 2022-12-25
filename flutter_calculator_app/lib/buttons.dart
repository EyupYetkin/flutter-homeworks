import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final renk;
  final yaziRenk;
  final String? butonYazi;
  final butonBas;

  MyButton({this.renk, this.yaziRenk, this.butonBas, this.butonYazi});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: butonBas,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Container(
                color: renk,
                child: Center(
                  child: Text(
                    butonYazi!,
                    style: TextStyle(color: yaziRenk, fontSize: 60, fontWeight: FontWeight.bold),
                  ),
                ),
              )),
        ),
    );
  }
}
