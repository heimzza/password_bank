import 'package:flutter/material.dart';
import 'package:password_safe/screens/addCard/body.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifre ekle"),
      ),
      body: Body(),
    );
  }
}
