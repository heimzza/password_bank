import 'package:flutter/material.dart';
import 'package:password_safe/screens/addSafe/add_safe_screen.dart';
import 'package:password_safe/screens/mySafes/body.dart';

class MySafes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[500],
        title: Text('Kasalarım'),
        actions: [
          buildInfoButton(context),
          buildIconButtonToScreen(
            context,
            AddSafeScreen(),
            Icon(
              Icons.add,
              color: Colors.white60,
            ),
          ),
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

  buildInfoButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info),
      onPressed: () {
        return showDialog(
          context: context,
          builder: (context) => buildAlertDialogInfo(context),
        );
      },
    );
  }

  buildAlertDialogInfo(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      title: Text("Kullanım kılavuzu kasalar"),
      content: SizedBox(
        height: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Önemli:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                children: [
                  TextSpan(
                      text: ' Kasanıza bir kez şifre koyduktan sonra tekrar değiştiremezsiniz' +
                       ' ve kasayı şifre olmadan silemezsiniz.',
                      style: TextStyle(color: Colors.black)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: '\nKasa eklemek için',
                children: [
                  TextSpan(
                      text: ' "+" butonuna tıklayın',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: '\nKasa silmek için',
                children: [
                  TextSpan(
                      text: ' sola doğru kaydırın',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Tamam"),
        )
      ],
    );
  }
}
