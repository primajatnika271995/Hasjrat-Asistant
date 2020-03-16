import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_bloc.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/login_page/login_screen.dart';
import 'package:salles_tools/src/views/profile_page/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _salesName;
  var _salesNIK;

  void _onEditProfile() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ProfileEditView(),
        transitionDuration: Duration(milliseconds: 750),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  void _onLogin() async {
    await SharedPreferencesHelper.setAccessToken(null);
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

  @override
  void initState() {
    // TODO: implement initState
    _getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(200),
        child: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          elevation: 5,
          title: Text(
            "My Profile",
            style: TextStyle(
              color: HexColor('#C61818'),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
          flexibleSpace: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$_salesName",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          "$_salesNIK",
                          style: TextStyle(
                            fontSize: 13,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 5),
                          child: LinearPercentIndicator(
                            percent: 0.6,
                            width: 150,
                            lineHeight: 17,
                            backgroundColor: Colors.grey.withOpacity(0.3),
                            progressColor: HexColor('#C61818'),
                          ),
                        ),
                        Text(
                          "60% Complete Profile",
                          style: TextStyle(
                            fontSize: 10,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    profileImage(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
//            ListTile(
//              onTap: null,
//              title: Text("Change Password"),
//              leading: Icon(Icons.lock_outline),
//              trailing: IconButton(
//                onPressed: () {},
//                icon: Icon(Icons.navigate_next),
//              ),
//            ),
//            Divider(),
            ListTile(
              onTap: null,
              title: Text("Term of Service"),
              leading: Icon(Icons.info_outline),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.navigate_next),
              ),
            ),
            Divider(),
            ListTile(
              onTap: null,
              title: Text("Privacy Police"),
              leading: Icon(Icons.security),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.navigate_next),
              ),
            ),
            Divider(),
            ListTile(
              onTap: null,
              title: Text("About"),
              leading: Icon(Icons.format_color_text),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.navigate_next),
              ),
            ),
            Divider(),
            ListTile(
              onTap: null,
              title: Text("Rate App"),
              leading: Icon(Icons.star_border),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.navigate_next),
              ),
            ),
            Divider(),
            ListTile(
              onTap: null,
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              trailing: IconButton(
                onPressed: () {
//                  _onLogin();
                  _onShowDialog();
                },
                icon: Icon(Icons.navigate_next),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 40),
      child: Column(
        children: <Widget>[
          Hero(
            tag: "profile-image",
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              backgroundImage: NetworkImage(
                  "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
            ),
          ),
          ButtonTheme(
            height: 20,
            child: OutlineButton(
              onPressed: () {
                _onEditProfile();
              },
              highlightElevation: 3,
              highlightedBorderColor: HexColor('#C61818'),
              borderSide: BorderSide(
                color: HexColor('#C61818'),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "Detail Profile",
                style: TextStyle(
                  fontSize: 12,
                  color: HexColor('#212120'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
