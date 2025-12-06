import 'package:path/path.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal() {
    if (kIsWeb) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfiWeb;
    } else {
      sqfliteFfiInit();
    }
  }

  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path;
    if (kIsWeb) {
      path = 'mahasiswa.db';
    } else {
      path = join(await getDatabasesPath(), "mahasiswa.db");
    }

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE mahasiswa (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT,
            nim TEXT,
            alamat TEXT,
            hobi TEXT
          )
        """);
      },
    );
  }

  Future<void> create(Map<String, dynamic> data) async {
    final db = await database;
    await db.insert("mahasiswa", data);
  }

  Future<List<Map<String, dynamic>>> read() async {
    final db = await database;
    return await db.query("mahasiswa");
  }

  Future<void> update(int id, Map<String, dynamic> data) async {
    final db = await database;
    await db.update("mahasiswa", data, where: "id = ?", whereArgs: [id]);
  }

  Future<void> delete(int id) async {
    final db = await database;
    await db.delete("mahasiswa", where: "id = ?", whereArgs: [id]);
  }
}
