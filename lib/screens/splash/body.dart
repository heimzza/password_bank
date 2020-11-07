import 'package:flutter/material.dart';
import 'package:password_safe/blocs/safe_card_bloc.dart';
import 'package:password_safe/models/SafeCard.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: safeCardBloc.getCards(),
      stream: safeCardBloc.getStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("No data yet");
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Text("Done!");
        } else if (snapshot.hasError) {
          return Text("Error!");
        } else {
          return Text("Data is here! ${snapshot.data}");
        }
      },
    );
  }

  buildSafeCardListItems(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length, // problem
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(top: 8),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              title: Text(
                "Name:  ${snapshot.data[index].name}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Password:  ${snapshot.data[index].password}",
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

  buildTest(AsyncSnapshot snapshot) {
    return Center(
      child: Text("test ${snapshot.data}"),
    );
  }
}
