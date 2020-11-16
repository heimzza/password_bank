import 'package:flutter/material.dart';
import 'package:password_safe/screens/addSafe/add_safe_screen.dart';
import 'package:password_safe/screens/mySafes/body.dart';

class MySafes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kasalarım'),
        actions: [
          buildIconButtonToScreen(context, AddSafeScreen(), Icon(Icons.add)),
          
        ],
      ),
      body: Body(),
    );
  }
  IconButton buildIconButtonToScreen(
      BuildContext context, Widget screen, Icon icon) {
    return IconButton(
      icon: icon,
      onPressed: () {
        goToScreen(context, screen);
      },
    );
  }

  void goToScreen(BuildContext context, Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}