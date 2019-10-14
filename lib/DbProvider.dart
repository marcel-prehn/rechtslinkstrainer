import 'dart:async';
import 'dart:io';

import 'package:synchronized/synchronized.dart';


import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rechtslinkstrainer/Progress.dart';
import 'package:rechtslinkstrainer/Result.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final String DATABASE = "results.db";
  static final String TABLE_NAME = "results";
  static final int DATABASE_VERSION = 4;

  DbProvider._();

  static final DbProvider db = DbProvider._();
  final lock = new Lock();

  Database _database;

  Future<Database> get database async {
    if (_database == null) {
      await lock.synchronized(() async {
        if (_database == null) {
          _database = await initDB();
        }
      });
    }
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DATABASE);
    return await openDatabase(path, version: DATABASE_VERSION, onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute("CREATE TABLE $TABLE_NAME ("
              "uuid TEXT PRIMARY KEY,"
              "practice_id INTEGER,"
              "timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,"
              "correct INTEGER,"
              "incorrect INTEGER"
              ");");
        });
  }

  saveResult(Result r) async {
    final db = await database;
    var res = await db.insert(TABLE_NAME, r.toMap());
    debugPrint("Successfully saved result: ${resultToJson(r)} with id $res");
    return res;
  }

  getResultByUuid(String uuid) async {
    final db = await database;
    var res = await db.query(TABLE_NAME, where: "uuid = ?", whereArgs: [uuid]);
    return res.isNotEmpty ? Result.fromMap(res.first) : null;
  }

  Future<List<Result>> getAllResults() async {
    final db = await database;
    var res = await db.query(TABLE_NAME);
    List<Result> list =
    res.isNotEmpty ? res.map((c) => Result.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Result>> getResultsByPracticeId(int practiceId) async {
    final db = await database;
    var res = await db
        .query(TABLE_NAME, where: "practice_id = ? ", whereArgs: [practiceId]);
    List<Result> list =
    res.isNotEmpty ? res.map((c) => Result.fromMap(c)).toList() : [];
    return list;
  }

  Future<Progress> getProgressByPracticeId(int practiceId) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT round(SUM(correct) / cast((SUM(correct) + SUM(incorrect)) as float), 4) * 100 AS value from results WHERE practice_id = 1;");
    debugPrint("Found progress by practice id: ${res.toString()}");
    return res.isNotEmpty ? Progress.fromMap(res.first) : null;
  }

  deleteResultByUuid(String uuid) async {
    final db = await database;
    return db.delete(TABLE_NAME, where: "uuid = ?", whereArgs: [uuid]);
  }
}
