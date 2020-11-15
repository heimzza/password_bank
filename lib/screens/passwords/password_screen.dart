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
        title: Text("Şifrelerim"),
        actions: [
          buildIconButtonToScreen(context, AddCardScreen(), Icon(Icons.add)),
          buildIconButtonDelete(
            Icon(
              Icons.delete_sweep,
              color: Colors.red[200],
            ),
            context,
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

  IconButton buildIconButtonDelete(Icon icon, BuildContext context) {
    return IconButton(
      icon: icon,
      onPressed: () {
        return showDialog(
          context: context,
          builder: (context) => buildAlertDialog(context),
        );
      },
    );
  }

  AlertDialog buildAlertDialog(BuildContext context) {
    return AlertDialog(
      title: Text("Tüm kayıtlar silincek!!!\n Emin misiniz?"),
      content: Icon(
        Icons.no_sim,
        color: Colors.red[200],
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Hayır"),
        ),
        FlatButton(
          onPressed: () =>
              {safeCardBloc.deleteAll(safeId), Navigator.of(context).pop()},
          child: Text("Evet"),
        ),
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
}
