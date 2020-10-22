import 'package:flutter/material.dart';
import 'package:password_safe/models/name_password.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listExample.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              title: Text(
                "Name:  ${listExample[index].name}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Password:  ${listExample[index].password}",
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
