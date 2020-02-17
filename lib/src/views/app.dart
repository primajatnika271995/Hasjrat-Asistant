import 'package:flutter/material.dart';
import 'package:salles_tools/src/views/components/bottom_navigation.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Open-Sans'),
      initialRoute: '/',
      routes: {
        '/': (context) => BottomNavigationDrawer(),
      },
    );
  }
}
