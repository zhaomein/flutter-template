import '../../../providers/database_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class Model {

  String get rowId;
  String get tableName;
  Map<String, dynamic> get asMap;

  Future<void> save() async {
    final Database db = await DbProvider().database;
    await db.insert(tableName, this.asMap);
  }

  Future<void> update() async {
    final Database db = await DbProvider().database;
    await db.update(tableName,
      this.asMap,
      where: '_id=?',
      whereArgs: [rowId]
    );
  }

  Future<bool> remove() async {
    final Database db = await DbProvider().database;
    final rowDeleted = await db.delete(tableName, where: '_id=?', whereArgs: [rowId]);
    return rowDeleted > 0;
  }

}