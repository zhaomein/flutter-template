import 'dart:io';
import '../models/base/table.dart';
import '../models/message.dart';
import '../../extensions/dynamic_extension.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static final DbProvider _singleton = DbProvider._internal();
  static const VERSION = 1;
  static const DB_FILE = 'app-database.db';

  Database _database;

  factory DbProvider() {
    return _singleton;
  }

  DbProvider._internal();

  Future<Database> get database async {
    if (_database != null)
    return _database;

    //if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future drop() async {
    final Database db = await database;
    print('$tag: Drop db!');
    String path = join(await getDatabasesPath(), DB_FILE);
    await File(path).delete();
  }

  Future<Database> initDB() async {
    String databasesPath = await getDatabasesPath();
    String dbPath = join(databasesPath, DB_FILE);
    print('$tag: path $dbPath');

    var database = await openDatabase(dbPath, version: VERSION,
      onUpgrade: (oldVersion, newVersion, db) {
        print("$tag: run upgrade!");
      },
      onCreate: (db, version) async {
        print('$tag: DB file created!');
        await Table(Message.table).createTable(Message.tableColumns, db: db);
      }
    );

    return database;
  }
}