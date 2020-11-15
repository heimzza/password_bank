import 'package:flutter/material.dart';
import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  
  var dbHelper = DbHelper();
  List<SafeCard> safeCards;
  int cardCount = 0;

  @override
  void initState() {
    getCards();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cardCount,
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

  void getCards() async {
    var cardsFuture = dbHelper.getSafeCards();
    cardsFuture.then((data) {
      setState(() {
        this.safeCards = data;
        cardCount = data.length;
      });
    });
  }

}
