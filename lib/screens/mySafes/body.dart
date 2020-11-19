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
  final _formKey = GlobalKey<FormState>();

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
                      buildAlertDialog(context, false, index));
            },
            child: Dismissible(
              key: Key(safes[index].id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.red[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Spacer(),
                    Icon(Icons.delete_forever),
                  ],
                ),
              ),
              confirmDismiss: (direction) async{
                return await showDialog(
                    context: context,
                    builder: (context) =>
                        buildAlertDialog(context, true, index));
              },
              // onDismissed: (direction) {
              //   showDialog(
              //       context: context,
              //       builder: (context) =>
              //           buildAlertDialog(context, true, index));
              // },
              child: Card(
                color: Colors.blueGrey[100],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                  leading: Icon(Icons.account_balance),
                  title: Text(
                    "Kasa adı:  ${safes[index].name}",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Icon(Icons.lock),
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

  buildPasswordField(String password) {
    return Form(
      key: _formKey,
      child: TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            labelText: "Şifresi",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          validator: (value) {
            return value != password ? 'Yanlış şifre' : null;
          }),
    );
  }

  AlertDialog buildAlertDialog(
      BuildContext context, bool isOnDelete, int index) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      title: Text("Şifrenizi girin"),
      content: SizedBox(
        height: 150,
        child: Column(
          children: [
            Icon(
              Icons.lock,
              color: Colors.red[700],
            ),
            SizedBox(height: 30),
            buildPasswordField(safes[index].password),
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
            if (_formKey.currentState.validate()) {
              if (isOnDelete) {
                setState(() {
                  safeBloc.delete(safes[index].id);
                  safes.removeAt(index);
                  Navigator.of(context).pop(true);
                });
              } else {
                Navigator.of(context).pop();
                goToScreen(context, Passwords(safes[index].id));
              }
            }
          },
          child: Text("Devam et"),
        )
      ],
    );
  }
}
