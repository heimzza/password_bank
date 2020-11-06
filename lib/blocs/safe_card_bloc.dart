import 'dart:async';

import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

class SafeCardBloc {
  final safeCardStreamController = StreamController.broadcast();

  Stream get getStream => safeCardStreamController.stream;
  var dbHelper = DbHelper();

  void addToSafe(SafeCard card) async {
    dbHelper.insert(card);
    safeCardStreamController.sink.add(dbHelper.getSafeCards());
  }

   Future<List<SafeCard>> getCards() async {
    var cards = await dbHelper.getSafeCards();
    print(cards);
    return cards;
  }
}

final safeCardBloc = SafeCardBloc();