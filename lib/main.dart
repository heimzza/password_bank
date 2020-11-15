import 'package:flutter/material.dart';
import 'package:password_safe/screens/mySafes/my_safes_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySafes(),
    );
  }
}
