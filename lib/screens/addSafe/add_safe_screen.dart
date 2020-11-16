import 'package:flutter/material.dart';
import 'package:password_safe/screens/addSafe/body.dart';


class AddSafeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kasa ekle'),
      ),
      body: Body(),
    );
  }
}