import 'dart:async';

import 'package:password_safe/data/db_helper.dart';
import 'package:password_safe/models/Safe.dart';

class SafeBloc {
  final safeStreamController = StreamController.broadcast();

  Stream get getStream => safeStreamController.stream;
  final _dbHelper = DbHelper();

  void addSafe(Safe safe) async {
    _dbHelper.insertSafe(safe);
    safeStreamController.sink.add(_dbHelper.getSafes());
  }

  Future<List<Safe>> getSafes() async {
    var safes = await _dbHelper.getSafes();
    //safeStreamController.sink.close();
    return safes;
  }

  void delete(int id) async {
    _dbHelper.deleteSafe(id);
    safeStreamController.sink.add(_dbHelper.getSafeCards(id));
  }
}

final safeBloc = SafeBloc();
