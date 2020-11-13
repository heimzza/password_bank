import 'dart:async';

import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/SafeCard.dart';

class SafeCardBloc {
  final safeCardStreamController = StreamController.broadcast();

  Stream get getStream => safeCardStreamController.stream;
  final _dbHelper = DbHelper();

  void addToSafe(SafeCard card) async {
    _dbHelper.insert(card);
    safeCardStreamController.sink.add(_dbHelper.getSafeCards());
  }

  Future<List<SafeCard>> getCards() async {
    var cards = await _dbHelper.getSafeCards();
    //safeCardStreamController.sink.close();
    return cards;
  }

  void deleteAll() async {
    _dbHelper.deleteAll();
    safeCardStreamController.sink.add(_dbHelper.getSafeCards());
  }

  void delete(int id) async {
    _dbHelper.delete(id);
    safeCardStreamController.sink.add(_dbHelper.getSafeCards());
  }
}

final safeCardBloc = SafeCardBloc();
