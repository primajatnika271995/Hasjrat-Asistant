import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_bloc.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/bottom_navigation.dart';
import 'package:salles_tools/src/views/login_page/login_screen.dart';
//import 'package:scanbot_sdk/scanbot_sdk.dart';
//import 'package:scanbot_sdk/scanbot_sdk_models.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final String licenseKey =
      "PCceuanUfA+OLv12Cjg1gnmrQ69raf" +
          "u8FCLU5sVAK7vZFR7ocl8VK+Aln1qL" +
          "T5vngyJ6f2CCJXbiGEssRusq+Fm+pC" +
          "pwmRFqp5d7nVH0DHBZVdx6JsCxZjcH" +
          "+LAIhHvvHqx9ToQ964mBzRI5wSlGrC" +
          "S7rNhL+fmh4AAyPCX3HsWlK0B/xItu" +
          "ivwvipXaSsXbhanlLrJLEJCk5KAh/n" +
          "rQDat4XJPPV00XI+/Ngl3ZmS7ucxlA" +
          "pnoJSlePm5sRlGn2gqhoYkZ5BTJ/3y" +
          "o3Mj3mubzs8+OehrM3J0D2tylzyn0P" +
          "OosXqJcRmcfwXSLO/woMnORf7hJe9r" +
          "0eey4pFQ4EVA==\nU2NhbmJvdFNESw" +
          "pjb20uaGFzanJhdC5zYWxsZXNfdG9v" +
          "bHMKMTU4NjA0NDc5OQo1OTAKMw==\n";

  checkIfAuthenticated() async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState

    checkIfAuthenticated().then((_) async {
      var token = await SharedPreferencesHelper.getAccessToken();
      print(token);
      if (token == null) {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(LoginService()),
              child: LoginScreen(),
            ),
            transitionDuration: Duration(milliseconds: 750),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            },
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => BottomNavigationDrawer(),
            transitionDuration: Duration(milliseconds: 750),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            },
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

//    ScanbotSdk.initScanbotSdk(ScanbotSdkConfig(
//      loggingEnabled: true,
//      licenseKey: licenseKey, // see the license key notes below!
//    ));

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: -30,
            left: -30,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: HexColor('#212120'),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: -40,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: HexColor('#C61818'),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Positioned(
            bottom: -30,
            right: -30,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: HexColor('#212120'),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            right: -40,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: HexColor('#C61818'),
                borderRadius: BorderRadius.circular(200),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/icons/app-icon.jpeg"),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  "Sales Tools",
                  style: TextStyle(
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                    color: HexColor('#212120'),
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
