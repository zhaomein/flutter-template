import '../../providers/database_provider.dart';
import '../../../extensions/dynamic_extension.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class Table {

  final String tableName;

  Table(this.tableName);

  Future<List> find(int id) async {
    final Database db = await DbProvider().database;

    return await db.query(tableName, where: "id = ?", whereArgs: [id]);
  }

  Future<List> rowQuery(String query) async {
    final Database db = await DbProvider().database;
    var res = await db.rawQuery(query);
    return res;
  }

  Future<void> insertAll(List<Model> models) async {
    final Database db = await DbProvider().database;
    print("$tag: $tableName - insert/update ${models.length} rows");
    db.transaction((txn) async {
      models.forEach((row) async {
        try {
          await txn.insert(tableName, row.asMap);
        } catch(e) {
          print('$tag: Updated ${row.rowId} on $tableName');
          await txn.update(tableName, row.asMap, where: '_id = ?', whereArgs: [row.rowId]);
        }
      });
    });
  }

  Future<int> delete({String where, List args}) async {
    final db = await DbProvider().database;
    print('$tag: Delete $tableName, $where, arg: $args');
    return await db.delete(tableName,
        where: where,
        whereArgs: args
    );
  }

  Future<void> createTable(tableColumns, {Database db}) async {

    Database currentDb = db;

    if(db == null) {
      currentDb = await DbProvider().database;
    }

    String sql = 'CREATE TABLE $tableName(';
    List<String> cols = [];
    tableColumns.forEach((field, type) {
      if(type is List) {
        cols.add('$field ${type.join(" ")}');
      } else {
        cols.add('$field $type');
      }
    });

    sql += cols.join(", ") + ');';
    print('$tag: Create $tableName SQL - $sql');
    await currentDb.execute(sql);
  }

  Future<List> query({
    String where, List whereArgs, int offset, int limit, String orderBy,
    String groupBy, List columns, String having
  }) async {

    print("$tag: Select $tableName - $where, $whereArgs - limit $limit");
    final Database db = await DbProvider().database;

    return await db.query(tableName,
        where: where,
        whereArgs: whereArgs,
        offset: offset,
        limit: limit,
        orderBy: orderBy,
        groupBy: groupBy,
        columns: columns,
        having: having
    );
  }
}