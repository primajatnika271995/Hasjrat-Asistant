import 'package:flutter/material.dart';
import 'package:salles_tools/src/views/bottom_navigation.dart';
import 'package:salles_tools/src/views/login_page/login_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Open-Sans'),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
      },
    );
  }
}
