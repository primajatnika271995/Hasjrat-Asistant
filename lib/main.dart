import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salles_tools/src/injectors/injector.dart';
import 'package:salles_tools/src/views/app.dart';
import 'package:salles_tools/src/views/components/log.dart';

void checkTime() {
  final DateTime now = DateTime.now();
  log.info("Time : $now");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try {
    await setupLocator();
    await AndroidAlarmManager.initialize();
    runApp(App());
    await AndroidAlarmManager.periodic(Duration(minutes: 1), 0, checkTime);
  } catch(e) {
    log.warning(e.toString());
  }
}