import 'dart:async';

import 'package:password_safe/models/Safe.dart';
import 'package:password_safe/models/SafeCard.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _singleton = DbHelper._internal();

  factory DbHelper() {
    return _singleton;
  }

  DbHelper._internal();

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
        "Create table safeCards(id integer primary key autoincrement, name text, description text, password text, safeId integer)");
    await db.execute('Create table safes(id integer primary key autoincrement, name text, password text)');
  }

  Future<List<SafeCard>> getSafeCards(int safeId) async {
    Database db = await this.db;
    var result = await db.rawQuery("SELECT * FROM safeCards Where safeId=$safeId");
    return List.generate(result.length, (i) {
      return SafeCard.fromObject(result[i]);
    });
  }

  Future<List<Safe>> getSafes() async{
    Database db = await this.db;
    var result = await db.query('safes');
    return List.generate(result.length, (index) {
      return Safe.fromObject(result[index]);
    });
  }

  Future<int> insertSafeCard(SafeCard safeCard) async {
    Database db = await this.db;
    var result = await db.insert("safeCards", safeCard.toMap());
    return result;
  }

  Future<int> insertSafe(Safe safe) async {
    Database db = await this.db;
    var result = await db.insert('safes', safe.toMap());
    return result;
  }

  Future<int> deleteSafeCard(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from safeCards where id= $id");
    return result;
  }

  Future<int> deleteSafe(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete('delete from safes where id = $id');
    deleteAllSafeCard(id);
    return result;
  }

  Future<int> deleteAllSafeCard(int safeId) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from safeCards where safeId = $safeId");
    return result;
  }

  Future<int> updateSafeCard(SafeCard safeCard) async {
    Database db = await this.db;
    var result = await db.update("safeCards", safeCard.toMap(),
        where: "id=?", whereArgs: [safeCard.id]);
    return result;
  }
}
