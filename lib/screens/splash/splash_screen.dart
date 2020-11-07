import 'package:flutter/material.dart';
import 'package:password_safe/screens/addCard/add_card.dart';
import 'package:password_safe/screens/splash/body_old.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Şifrelerim"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              goToAddCard(context);
            },
          )
        ],
      ),
      body: Body(),
    );
  }

  void goToAddCard(BuildContext context) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardScreen(),
      ),
    );
    if (result != null) {
      if (result) {}
    }
  }
}
