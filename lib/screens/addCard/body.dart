import 'package:flutter/material.dart';
import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

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
      child: Column(
        children: [
          buildNameField(),
          buildPasswordField(),
          buildSaveButton(),
        ],
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Ör. steamKullanıcıAdı",
        labelText: "Adı",
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
        labelText: "Şifre",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      controller: txtPassword,
    );
  }

  buildSaveButton() {
    return FlatButton(
      child: Text("Ekle"),
      onPressed: () {
        addCard();
      },
    );
  }

  void addCard() async {
    print(txtName.text + txtPassword.text);
    var result = await dbHelper
        .insert(SafeCard(name: txtName.text, password: txtPassword.text));
    Navigator.pop(context, true);
  }
}
