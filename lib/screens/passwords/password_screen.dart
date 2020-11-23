import 'package:flutter/material.dart';
import 'package:password_safe/blocs/safe_card_bloc.dart';
import 'package:password_safe/screens/addCard/add_card.dart';
import 'package:password_safe/screens/passwords/body.dart';

class Passwords extends StatelessWidget {
  final int safeId;

  Passwords(this.safeId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[500],
        title: Text("Şifrelerim"),
        actions: [
          buildInfoButton(context),
          buildIconButtonToScreen(
            context,
            AddCardScreen(safeId),
            Icon(
              Icons.add,
              color: Colors.white60,
            ),
          ),
          buildIconButtonDeleteAll(
            Icon(
              Icons.delete_sweep,
              color: Colors.red[200],
            ),
            context,
          ),
        ],
      ),
      body: Body(safeId),
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

  IconButton buildIconButtonDeleteAll(Icon icon, BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: () {
        return showDialog(
          context: context,
          builder: (context) => buildAlertDialogDeleteAll(context),
        );
      },
    );
  }

  AlertDialog buildAlertDialogDeleteAll(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      title: Text("Bu kasadaki tüm kayıtlar silinecek!\nEmin misiniz?"),
      content: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.no_sim,
              color: Colors.red[700],
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Geri"),
        ),
        FlatButton(
          onPressed: () =>
              {safeCardBloc.deleteAll(safeId), Navigator.of(context).pop()},
          child: Text("Evet"),
        )
      ],
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
      title: Text("Kullanım kılavuzu şifreler"),
      content: SizedBox(
        height: 100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Şifre eklemek için',
                children: [
                  TextSpan(
                      text: ' "+" butonuna tıklayın',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: '\nŞifre silmek için',
                children: [
                  TextSpan(
                      text: ' sola doğru kaydırın',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Text.rich(
              TextSpan(
                text: '\nTüm şifreleri silmek için',
                children: [
                  TextSpan(
                      text: ' kırmızı çöp kutusuna tıklayın',
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
