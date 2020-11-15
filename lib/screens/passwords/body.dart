import 'package:flutter/material.dart';
import 'package:password_safe/blocs/safe_card_bloc.dart';
import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<SafeCard> safeCards = [];
  int cardCount = 0;
  final dbHelper = DbHelper();

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
        } else if (snapshot.data is Future<List<SafeCard>>) {
          print("getcards");
          getCards();
          safeCardBloc.safeCardStreamController.sink.add(print);
          return buildSafeCardListItems(safeCards);
        } else {
          print("usual");
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
          child: Dismissible(
            key: Key(safeCards[index].id.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: Color(0xFFFFE6E6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Spacer(),
                  Icon(Icons.delete_forever),
                ],
              ),
            ),
            onDismissed: (direction) {
              setState(() {
                safeCardBloc.delete(safeCards[index].id);
                safeCards.removeAt(index);
              });
            },
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
