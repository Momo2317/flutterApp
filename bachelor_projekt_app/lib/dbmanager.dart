import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbWheelManager {
  Database _database;

  Future openDb() async {
    if (_database == null) {
      _database = await openDatabase(join(await getDatabasesPath(), "wheel.db"),
          version: 1, onCreate: (Database db, int version) async {
        await db.execute(
            "CREATE TABLE wheel (id TEXT PRIMARY KEY, vl INTEGER, vr INTEGER, hl INTEGER, hr INTEGER)");
      });
    }
  }

  Future<int> insertWheel(Wheel wheel) async {
    await openDb();
    return await _database.insert('wheel', wheel.toMap());
  }
}

class Wheel {
  String zeichen;
  int vl;
  int vr;
  int hl;
  int hr;

  Wheel(
      {@required this.zeichen,
      @required this.vl,
      @required this.vr,
      @required this.hl,
      @required this.hr});
  Map<String, dynamic> toMap() {
    return {'zeichen': zeichen};
  }
}
