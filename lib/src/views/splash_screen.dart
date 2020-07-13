import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:location/location.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_bloc.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/bottom_navigation.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/login_page/login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Location location = new Location();

  void _onCheckDeviceInfo() async {
    DeviceInfoPlugin _deviceInfo = new DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    await SharedPreferencesHelper.setDeviceInfo(androidInfo.model);
  }

  void _onCheckImei() async {
    String imei = await ImeiPlugin.getImei(shouldShowRequestPermissionRationale: false);
    await SharedPreferencesHelper.setImeiDevice(imei);
  }

  void _onCheckLocation() async {
    location.onLocationChanged.listen((LocationData currentLocation) async {
      await SharedPreferencesHelper.setLatitudeLogin(currentLocation.latitude.toString());
      await SharedPreferencesHelper.setLongitudeLogin(currentLocation.longitude.toString());
    });
  }

  checkIfAuthenticated() async {
    await Future.delayed(Duration(seconds: 3));
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState

    checkIfAuthenticated().then((_) async {
      var token = await SharedPreferencesHelper.getAccessToken();
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

    _onCheckDeviceInfo();
    _onCheckImei();
    _onCheckLocation();
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
                  "Sales Assistant",
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
