import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/injectors/injector.dart';
import 'package:salles_tools/src/models/reminder_sqlite_model.dart';
import 'package:salles_tools/src/services/sqlite_service.dart';
import 'package:salles_tools/src/views/app.dart';
import 'package:salles_tools/src/views/components/log.dart';

SqliteService _dbHelper = SqliteService();

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =  FlutterLocalNotificationsPlugin();

final timeFormat = DateFormat("h:mm a");

void checkTime() {
  Future<List<ReminderSqlite>> today = _dbHelper.getReminderToday();
  final DateTime now = DateTime.now();
  log.info("Time Now : ${timeFormat.format(now).toString()}");
    today.then((val) {
      val.forEach((f) {
        log.info("Waktu Pemberitahuan : ${f.timeReminder}");
        if (f.timeReminder == timeFormat.format(now).toString()) {
          log.info("Judul Pemberitahuan : ${f.timeReminder}");
          _showReminderNotification(f.taskType, f.taskDescription);
        }
      });
    });
}

void _showReminderNotification(String title, String msg) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'com.hasjrat.messages',
      'Reminder Notification',
      'Notification for Reminder',
      importance: Importance.Max, priority: Priority.High, ticker: 'ticker',
  );

  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics,
    iOSPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin.show(
      0, '$title', '$msg', platformChannelSpecifics,
      payload: 'Reminder',
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try {
    await setupLocator();
    await AndroidAlarmManager.initialize();
    runApp(App());
    await AndroidAlarmManager.periodic(Duration(minutes: 1), 0, checkTime);
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('@drawable/logo_apps');

    var initializationSettingsIOS = new IOSInitializationSettings();

    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  } catch(e) {
    log.warning(e.toString());
  }
}