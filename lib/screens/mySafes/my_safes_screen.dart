import 'package:flutter/material.dart';
import 'package:password_safe/screens/mySafes/body.dart';

class MySafes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kasalarım'),
      ),
      body: Body(),
    );
  }
}