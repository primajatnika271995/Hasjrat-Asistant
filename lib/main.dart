import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salles_tools/src/injectors/injector.dart';
import 'package:salles_tools/src/views/app.dart';
import 'package:salles_tools/src/views/components/log.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  try {
    await setupLocator();
    runApp(App());
  } catch(e) {
    log.warning(e.toString());
  }
}