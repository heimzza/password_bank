import 'dart:async';

import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

class SafeCardBloc {
  final safeCardStreamController = StreamController.broadcast();

  Stream get getStream => safeCardStreamController.stream;
  final _dbHelper = DbHelper();

  void addToSafe(SafeCard card) async {
    _dbHelper.insertSafeCard(card);
    safeCardStreamController.sink.add(_dbHelper.getSafeCards(card.safeId));
  }

  Future<List<SafeCard>> getCards(int safeId) async {
    var cards = await _dbHelper.getSafeCards(safeId);
    //safeCardStreamController.sink.close();
    return cards;
  }

  void deleteAll(int safeId) async {
    _dbHelper.deleteAllSafeCard(safeId);
    safeCardStreamController.sink.add(_dbHelper.getSafeCards(safeId));
  }

  void delete(int id, int safeId) async {
    _dbHelper.deleteSafeCard(id);
    safeCardStreamController.sink.add(_dbHelper.getSafeCards(safeId));
  }
}

final safeCardBloc = SafeCardBloc();
