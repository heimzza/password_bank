import 'package:flutter/material.dart';
import 'package:password_safe/blocs/safe_bloc.dart';
import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/Safe.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            buildNameField(),
            SizedBox(height: 20),
            buildPasswordField(),
            SizedBox(height: 20),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Ör. Banka şifrelerim",
        labelText: "Kasa adı",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      controller: txtName,
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

  buildSaveButton() {
    return FlatButton(
      color: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text("Ekle"),
      onPressed: () {
        addSafe();
      },
    );
  }

  void addSafe() async {
    safeBloc
        .addSafe(Safe(name: txtName.text, password: txtPassword.text));
    Navigator.pop(context);
  }
}