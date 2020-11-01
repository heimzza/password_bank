import 'dart:async';

import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

class SafeCardBloc{
  final safeCardStreamController = StreamController.broadcast();

  Stream get getStream => safeCardStreamController.stream;
  var dbHelper = DbHelper();


  void addToSafe(SafeCard card){
    dbHelper.insert(card);
    safeCardStreamController.sink.add(dbHelper.getSafeCards());
  }

  Future<List<SafeCard>> getCards() async {
    return dbHelper.getSafeCards();
  }
}

final safeCardBloc = SafeCardBloc();