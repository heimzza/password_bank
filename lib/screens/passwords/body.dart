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
  List<SafeCard> safeCards = [];
  int cardCount = 0;
  final dbHelper = DbHelper();

  @override
  void initState() {
    getCards(widget.safeId);
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
          getCards(widget.safeId);
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
            confirmDismiss: (direction) async {
              return await showDialog(
                  context: context,
                  builder: (context) => buildAlertDialog(context, index));
            },
            child: Card(
              color: Colors.blueGrey[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
              child: ListTile(
                leading: Icon(Icons.person_outline),
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

  void getCards(int safeId) async {
    var cardsFuture = dbHelper.getSafeCards(safeId);
    cardsFuture.then((data) {
      setState(() {
        this.safeCards = data;
        cardCount = data.length;
      });
    });
  }

  AlertDialog buildAlertDialog(BuildContext context, int index) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      title: Text("Kayıt silinecek, emin misiniz?"),
      content: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_forever,
              color: Colors.red[700],
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Geri"),
        ),
        FlatButton(
          onPressed: () {
            setState(() {
              safeCardBloc.delete(safeCards[index].id, safeCards[index].safeId);
              safeCards.removeAt(index);
            });
            Navigator.of(context).pop();
          },
          child: Text("Evet"),
        )
      ],
    );
  }
}
