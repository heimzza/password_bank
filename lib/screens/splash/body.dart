import 'package:flutter/material.dart';
import 'package:password_safe/blocs/safe_card_bloc.dart';
import 'package:password_safe/models/SafeCard.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<SafeCard> safeCards = [];
  int cardCount = 0;

  @override
  void initState() {
    getCards();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: safeCards,
      stream: safeCardBloc.getStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text("Done!");
        } else if (snapshot.hasError) {
          return Text("Error!");
        } else {
          getCards();
          return buildSafeCardListItems(safeCards);
        }
      },
    );
  }

  buildSafeCardListItems(List<SafeCard> cards) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Card(
            margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
            child: ListTile(
              title: Text(
                "Yeri:  ${cards[index].name}",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                "Şifresi:  ${cards[index].password}",
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
    var cardsFuture = safeCardBloc.getCards();
    cardsFuture.then((data) {
      setState(() {
        this.safeCards = data;
        cardCount = data.length;
      });
    });
  }
}
