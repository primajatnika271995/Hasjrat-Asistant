import 'package:intl/intl.dart';
import 'package:salles_tools/src/configs/sqlite_access.dart';
import 'package:salles_tools/src/models/reminder_sqlite_model.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {

  static const todoTable = 'tb_reminder';
  static const id = 'id';
  static const taskType = 'task_type';
  static const taskDescription = 'task_description';
  static const customerName = 'customer_name';
  static const dateReminder = 'date_reminder';
  static const timeReminder = 'time_reminder';
  static const status = 'status';
  static const notes = 'notes';
  static const createdBy = 'created_by';
  SqliteAcces _dbHelper = new SqliteAcces();

  Future<int> insert(ReminderSqlite reminder) async {
    Database db = await _dbHelper.initDB();
    final sql = '''
      INSERT INTO ${SqliteService.todoTable} (
        ${SqliteService.taskType},
        ${SqliteService.taskDescription},
        ${SqliteService.customerName},
        ${SqliteService.dateReminder},
        ${SqliteService.timeReminder},
        ${SqliteService.notes},
        ${SqliteService.status},
        ${SqliteService.createdBy}
      ) VALUES (
        ?, ?, ?, ?, ?, ?, ?, ?
      )
    ''';

    List<dynamic> params = [reminder.taskType, reminder.taskDescription, reminder.customerName, reminder.dateReminder, reminder.timeReminder, reminder.notes, reminder.status, reminder.createdBy];
    final result = await db.rawInsert(sql, params);
    return result;
  }

  Future<int> update(ReminderSqlite reminder, int id) async {
    Database db = await _dbHelper.initDB();
    final sql = '''
      UPDATE ${SqliteService.todoTable}
      SET ${SqliteService.taskType} = ?,
          ${SqliteService.taskDescription} = ?,
          ${SqliteService.dateReminder} = ?,
          ${SqliteService.timeReminder} = ?,
          ${SqliteService.notes} = ?,
          ${SqliteService.status} = ?,
          ${SqliteService.createdBy} = ?
      WHERE ${SqliteService.id} = ?    
    ''';

    List<dynamic> params = [reminder.taskType, reminder.taskDescription, reminder.dateReminder, reminder.timeReminder, reminder.notes, reminder.status, reminder.createdBy, id];
    final result = await db.rawUpdate(sql, params);

    return result;
  }

  Future<int> deleteFollowupReminder() async {
    Database db = await _dbHelper.initDB();

    int count = await db.delete(SqliteService.todoTable, where: 'id=?', whereArgs: ['Import DMS']);
    return count;
  }

  Future<int> delete(int id) async {
    Database db = await _dbHelper.initDB();

    int count = await db.delete(SqliteService.todoTable, where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<ReminderSqlite>> getReminderPending() async {
    Database db = await _dbHelper.initDB();

    DateTime now = DateTime.now();
    final dateFormat = DateFormat("dd MMMM yyyy");

    final sql = '''
      SELECT * 
      FROM ${SqliteService.todoTable}
      WHERE ${SqliteService.status} = "Pending"
    ''';

    final data = await db.rawQuery(sql);
    List<ReminderSqlite> reminder = List();

    for(final node in data) {
      final todo = ReminderSqlite.fromMap(node);
      reminder.add(todo);
    }

    return reminder;
  }

  Future<List<ReminderSqlite>> getReminderToday() async {
    Database db = await _dbHelper.initDB();

    DateTime now = DateTime.now();
    final dateFormat = DateFormat("dd MMMM yyyy");

    final sql = '''
      SELECT * 
      FROM ${SqliteService.todoTable}
      WHERE ${SqliteService.dateReminder} = "${dateFormat.format(now)}" AND ${SqliteService.status} = "Now"
    ''';

    final data = await db.rawQuery(sql);
    List<ReminderSqlite> reminder = List();

    for(final node in data) {
      final todo = ReminderSqlite.fromMap(node);
      reminder.add(todo);
    }

    return reminder;
  }

  Future<List<ReminderSqlite>> getReminderTomorrow() async {
    Database db = await _dbHelper.initDB();

    var now = DateTime.now();
    var nextDay = DateTime(now.year, now.month, now.day + 1);
    final dateFormat = DateFormat("dd MMMM yyyy");

    final sql = '''
      SELECT * 
      FROM ${SqliteService.todoTable}
      WHERE ${SqliteService.dateReminder} = "${dateFormat.format(nextDay)}" and ${SqliteService.status} = "Now"
    ''';

    final data = await db.rawQuery(sql);
    List<ReminderSqlite> reminder = List();

    for(final node in data) {
      final todo = ReminderSqlite.fromMap(node);
      reminder.add(todo);
    }

    return reminder;
  }

  Future<List<ReminderSqlite>> getReminderUpcoming() async {
    Database db = await _dbHelper.initDB();

    DateTime now = DateTime.now();
    var nextDay = DateTime(now.year, now.month, now.day + 2);
    final dateFormat = DateFormat("dd MMMM yyyy");

    final sql = '''
      SELECT * 
      FROM ${SqliteService.todoTable}
      WHERE ${SqliteService.status} = "Upcoming"
    ''';

    final data = await db.rawQuery(sql);
    List<ReminderSqlite> reminder = List();

    for(final node in data) {
      final todo = ReminderSqlite.fromMap(node);
      reminder.add(todo);
    }

    return reminder;
  }
}