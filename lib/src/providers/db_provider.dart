import 'dart:io';
import 'package:fetchtosqflite/src/models/human_model.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Human table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'human_manager.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Human('
          'id INTEGER PRIMARY KEY,'
          'email TEXT,'
          'name TEXT,'
          'job TEXT'
          ')');
    });
  }

  // Insert human on database
  createHuman(Human newHuman) async {
    await deleteAllHumans();
    final db = await database;
    final res = await db.insert('Human', newHuman.toJson());

    return res;
  }

  // Delete all humans
  Future<int> deleteAllHumans() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Human');

    return res;
  }

  Future<List<Human>> getAllHumans() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM HUMAN");

    List<Human> list =
        res.isNotEmpty ? res.map((c) => Human.fromJson(c)).toList() : [];

    return list;
  }
}
