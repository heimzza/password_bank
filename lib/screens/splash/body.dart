import 'package:flutter/material.dart';
import 'package:password_safe/database/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var dbHelper = DbHelper();
  List<SafeCard> safeCards = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: safeCards.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              title: Text(
                "Name:  ${safeCards[index].name}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Password:  ${safeCards[index].password}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
