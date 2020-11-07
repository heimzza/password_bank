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
        return snapshot.hasError
            ? Center(
                child: Text(snapshot.error.toString()),
              )
            : snapshot.hasData
                ? buildTest(snapshot)
                : Center(
                    child: Text("Veri yok"),
                  );
      },
    );
  }

  buildSafeCardListItems(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length, // problem
      itemBuilder: (context, index) {
        List<SafeCard> safeCards = snapshot.data;
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

  buildTest(AsyncSnapshot snapshot) {
    return Center(child: Text("test ${snapshot.data}"),);
  }
}
