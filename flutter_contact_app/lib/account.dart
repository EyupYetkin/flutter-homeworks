import 'package:contact_app/contact.dart';

class Account{
  String uye_adi;
  String kullanici_adi;
  String parola;

  List<Contact> Liste = [];

  Account(this.uye_adi, this.kullanici_adi, this.parola);
}