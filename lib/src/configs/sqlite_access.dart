import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class SqliteAcces {
  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'reminder.db';

    var todoDatabase = openDatabase(path, version: 2, onCreate: _createDB,);
    return todoDatabase;
  }

  void _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tb_reminder (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_type TEXT,
        task_description TEXT,
        customer_name TEXT,
        date_reminder TEXT,
        time_reminder TEXT,
        notes TEXT
      )
    ''');
  }
}