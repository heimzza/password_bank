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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            buildFormField(),
            SizedBox(height: 20),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }

  buildFormField() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.account_balance),
              labelText: "Kasa adı",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            controller: txtName,
            validator: (value) {
              return value.length < 4
                  ? 'En az 4 karakter girin'
                  : value.length > 30
                      ? 'En fazla 30 karakter girebilirsiniz'
                      : null;
            },
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              icon: Icon(Icons.lock),
              labelText: "Şifresi",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            controller: txtPassword,
            validator: (value) {
              return value.length < 4
                  ? 'En az 4 karakter girin'
                  : value.length > 30
                      ? 'En fazla 30 karakter girebilirsiniz'
                      : null;
            },
          ),
        ],
      ),
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
        if (_formKey.currentState.validate()) {
          addSafe();
        }
      },
    );
  }

  void addSafe() async {
    safeBloc.addSafe(Safe(name: txtName.text, password: txtPassword.text));
    Navigator.pop(context);
  }
}
