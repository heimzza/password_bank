import 'package:flutter/material.dart';
import 'package:password_safe/screens/addCard/body.dart';

class AddCardScreen extends StatelessWidget {
  final int safeId;

  AddCardScreen(this.safeId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[500],
        title: Text("Şifre ekle"),
      ),
      body: Body(safeId),
    );
  }
}
