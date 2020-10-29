import 'package:flutter/material.dart';
import 'package:password_safe/screens/splash/body.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifrelerim"),
      ),
      body: Body(),
    );
  }
}
