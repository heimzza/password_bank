import 'package:flutter/material.dart';
import 'package:password_safe/blocs/safe_card_bloc.dart';
import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

class Body extends StatefulWidget {
  final int safeId;

  Body(this.safeId);

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
        hintText: "Ör. steamKullanıcıAdı",
        labelText: "Yeri",
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
        addCard(widget.safeId);
      },
    );
  }

  void addCard(int safeId) async {
    safeCardBloc
        .addToSafe(SafeCard(name: txtName.text, password: txtPassword.text, safeId: safeId));
    Navigator.pop(context);
  }
}
