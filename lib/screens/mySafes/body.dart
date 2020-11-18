import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:password_safe/blocs/safe_bloc.dart';
import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/Safe.dart';
import 'package:password_safe/screens/passwords/password_screen.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Safe> safes = [];
  int safeCount = 0;
  final dbHelper = DbHelper();
  var txtPassword = TextEditingController();
  final List<String> errors = [];
  final _formKey = GlobalKey<FormState>();

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  void initState() {
    getSafes();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: safes,
      stream: safeBloc.getStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text("Done!");
        } else if (snapshot.hasError) {
          return Text("Error!");
        } else if (snapshot.data is Future<List<Safe>>) {
          print("getSafes");
          getSafes();
          safeBloc.safeStreamController.sink.add(print);
          return buildSafeListItems(safes);
        } else {
          print("usual");
          return buildSafeListItems(safes);
        }
      },
    );
  }

  buildSafeListItems(List<Safe> safes) {
    return ListView.builder(
      itemCount: safes.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) =>
                      buildAlertDialog(context, safes[index]));
            },
            child: Dismissible(
              key: Key(safes[index].id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Color(0xFFFFE6E6),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Icon(Icons.delete_forever),
                  ],
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  safeBloc.delete(safes[index].id);
                  safes.removeAt(index);
                });
              },
              child: Card(
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                  title: Text(
                    "Kasa adı:  ${safes[index].name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void getSafes() async {
    var cardsFuture = dbHelper.getSafes();
    cardsFuture.then((data) {
      setState(() {
        this.safes = data;
        safeCount = data.length;
      });
    });
  }

  void goToScreen(BuildContext context, Widget screen) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Şifresi",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      controller: txtPassword,
    );
  }

  AlertDialog buildAlertDialog(BuildContext context, Safe safe) {
    return AlertDialog(
      title: Text("Şifrenizi girin"),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Icon(
              Icons.lock,
              color: Colors.red[200],
            ),
            buildPasswordField(),
            showError(),
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
          onPressed: () {
            if (safe.password == txtPassword.text) {
              setState(() {
                removeError(error: 'Yanlış şifre!');
              });
              Navigator.of(context).pop();
              goToScreen(context, Passwords(safe.id));
            } else {
              setState(() {
                addError(error: 'Yanlış şifre!');
              });
            }
          },
          child: Text("Devam et"),
        )
      ],
    );
  }

  Widget showError() {
    if (errors.length > 0) {
      return Text(errors[0].toString());
    } else {
      return SizedBox(height: 20);
    }
  }
}
