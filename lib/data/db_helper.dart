import 'dart:async';

import 'package:password_safe/models/SafeCard.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "safeCardDb.db");
    var safeCardDb = openDatabase(dbPath, version: 1, onCreate: createDb);
    return safeCardDb;
  }

  void createDb(Database db, int version) async {
    await db.execute(
        "Create table safeCards(id integer primary key autoincrement, name text, description text, password text)");
  }

  Future<List<SafeCard>> getSafeCards() async {
    Database db = await this.db;
    var result = await db.query("safeCards");
    return List.generate(result.length, (i) {
      return SafeCard.fromObject(result[i]);
    });
  }

  Future<int> insert(SafeCard safeCard) async {
    Database db = await this.db;
    var result = await db.insert("safeCards", safeCard.toMap());
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from safeCards where id= $id");
    return result;
  }

  Future<int> update(SafeCard safeCard) async {
    Database db = await this.db;
    var result = await db.update("safeCards", safeCard.toMap(),
        where: "id=?", whereArgs: [safeCard.id]);
    return result;
  }
}
