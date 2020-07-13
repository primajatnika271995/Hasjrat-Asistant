import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_event.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/login_page/login_screen.dart';
import 'package:salles_tools/src/views/profile_page/change_password_screen.dart';
import 'package:salles_tools/src/views/profile_page/edit_profile.dart';
import 'package:salles_tools/src/views/profile_page/privacy_police_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Location location = new Location();
  LocationData _locationData;

  final double targetElevation = 3;
  double _elevation = 0;
  ScrollController _controller;

  var _salesName;
  var _salesNIK;
  var _latitude;
  var _longitude;

  String titleName = "";

  void _onEditProfile() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ProfileEditView(),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void _onChangePassword() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(LoginService()),
          child: ChangePasswordView(),
        ),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void _onSeePrivacyPolice() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PrivacyPoliceView(),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
      ),
    );
  }

  void _onCheckLocation() async {
    _locationData = await location.getLocation();

    _latitude = _locationData.latitude;
    _longitude = _locationData.longitude;
  }

  void _onLogin() async {
    var idHistory = await SharedPreferencesHelper.getHistoryLoginId();
    var imei = await SharedPreferencesHelper.getImeiDevice();
    var deviceInfo = await SharedPreferencesHelper.getDeviceInfo();

    log.info(imei);
    log.info(deviceInfo);
    // ignore: close_sinks
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    loginBloc.add(FetchLogout(idHistory, deviceInfo, imei, _latitude, _longitude));

    await SharedPreferencesHelper.setListCustomer(null);
    await SharedPreferencesHelper.setListLead(null);

    Navigator.of(context).pushAndRemoveUntil(
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
        (Route<dynamic> route) => false);
  }

  void _getPreferences() async {
    _salesName = await SharedPreferencesHelper.getSalesName();
    _salesNIK = await SharedPreferencesHelper.getSalesNIK();
    setState(() {});
  }

  void _onShowDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Do you want to exit?',
              style: TextStyle(
                fontSize: 14,
                letterSpacing: 0.7,
              ),
            ),
            actions: <Widget>[
              OutlineButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                borderSide: BorderSide(
                    color: Colors.transparent
                ),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
              ),
              OutlineButton(
                onPressed: () {
                  _onLogin();
                },
                borderSide: BorderSide(
                  color: Colors.transparent
                ),
                child: Text(
                  "OK",
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          );
        });
  }

  void _scrollListener() {
    double newElevation = _controller.offset > 1 ? targetElevation : 0;
    if (_elevation != newElevation) {
      setState(() {
        if (newElevation < 1) {
          titleName = "";
        } else {
          titleName = "Profil";
        }

        _elevation = newElevation;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _getPreferences();
    _onCheckLocation();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller?.removeListener(_scrollListener);
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: _elevation,
        centerTitle: true,
        title: Text('$titleName',
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            controller: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                profileContent(),
                SizedBox(height: 7),
                keamananContent(),
                SizedBox(height: 7),
                tentangContent(),
                SizedBox(height: 7),
                versionContent(),
                SizedBox(height: 10),
                Container(
                  width: screenWidth(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RaisedButton(
                      onPressed: () {
                        _onShowDialog();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text("Sign Out",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: HexColor("#C61818"),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileContent() {
    return Container(
      width: screenWidth(context),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 10),
              child: Text("Detail Profil",
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      child: Icon(Icons.account_circle),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("$_salesName",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text("$_salesNIK",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text("Akun",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _onEditProfile();
                  },
                  child: Container(
                    width: screenWidth(context),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Icon(Icons.person),
                                ),
                                Text("Detail Profil",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            ),
                            Icon(Icons.navigate_next),
                          ],
                        ),
                        Divider(color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget keamananContent() {
    return Container(
      width: screenWidth(context),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text("Keamanan",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onChangePassword();
              },
              child: Container(
                width: screenWidth(context),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.phonelink_lock),
                            ),
                            Text("Ubah Security Code",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        Icon(Icons.navigate_next),
                      ],
                    ),
                    Divider(color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget tentangContent() {
    return Container(
      width: screenWidth(context),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 20),
              child: Text("Tentang",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: screenWidth(context),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.info),
                              ),
                              Text("Panduan Sales Assistant",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: screenWidth(context),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.bubble_chart),
                              ),
                              Text("Syarat dan Ketentuan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                _onSeePrivacyPolice();
              },
              child: Container(
                width: screenWidth(context),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.beenhere),
                              ),
                              Text("Kebijakan Privasi",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: screenWidth(context),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(Icons.info_outline),
                              ),
                              Text("Pusat Bantuan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          Icon(Icons.navigate_next),
                        ],
                      ),
                    ),
                    Divider(color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget versionContent() {
    return Container(
      width: screenWidth(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: <Widget>[
            Text("Version 1.0.8 buildVersion 12",
              style: TextStyle(
                fontSize: 12,
              ),
            )
          ],
        ),
      ),
    );
  }
}
