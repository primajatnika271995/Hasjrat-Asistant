import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_bloc.dart';
import 'package:salles_tools/src/services/login_service.dart';
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
        '/': (context) => BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(LoginService()),
          child: LoginScreen(),
        ),
      },
    );
  }
}
