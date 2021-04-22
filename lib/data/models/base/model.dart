import 'package:mcaio/extensions/dynamic_extension.dart';
import 'package:mcaio/providers/database_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class Model {

  String get rowId;
  String get tableName;
  Map<String, dynamic> get asMap;

  Future<void> save() async {
    print('$tag: Create $tableName, $rowId');
    final Database db = await DbProvider().database;
    await db.insert(tableName, this.asMap);
  }

  Future<void> update() async {
    final Database db = await DbProvider().database;
    print('$tag: Update $tableName, $rowId');
    await db.update(tableName,
      this.asMap,
      where: 'id=?',
      whereArgs: [rowId]
    );
  }

  Future<bool> remove() async {
    final Database db = await DbProvider().database;
    final rowDeleted = await db.delete(tableName, where: 'id=?', whereArgs: [rowId]);
    return rowDeleted > 0;
  }

}