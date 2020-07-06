import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_event.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_state.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/login_page/login_screen.dart';
import 'package:salles_tools/src/views/profile_page/validator_item.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> with TickerProviderStateMixin {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var passwordOldCtrl = new TextEditingController();
  var passwordNewCtrl = new TextEditingController();

  var username;

  AnimationController _controller;
  Animation<double> _fabScale;

  bool eightChars = false;
  bool specialChar = false;
  bool upperCaseChar = false;
  bool number = false;

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

  void getPreferences() async {
    username = await SharedPreferencesHelper.getUsername();
    passwordOldCtrl.text = username;
    setState(() {});
  }

  void _onChangePassword(){
    if (!_allValid()) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text("Harap Validasi Password Baru"),
          backgroundColor: HexColor('#C61818'),
        ),
      );
      return;
    }

    if (_allValid()) {
      // ignore: close_sinks
      final changePasswordBloc = BlocProvider.of<LoginBloc>(context);
      changePasswordBloc.add(ChangePassword(passwordNewCtrl.text, username));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getPreferences();
    passwordNewCtrl.addListener(() {
      setState(() {
        eightChars = passwordNewCtrl.text.length >= 8;
        number = passwordNewCtrl.text.contains(RegExp(r'\d'), 0);
        upperCaseChar = passwordNewCtrl.text.contains(new RegExp(r'[A-Z]'), 0);
        specialChar = passwordNewCtrl.text.isNotEmpty &&
            !passwordNewCtrl.text.contains(RegExp(r'^[\w_]+$'), 0);
      });

      if (_allValid()) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });

    _controller = AnimationController(vsync: this,
        duration: const Duration(milliseconds: 500));

    _fabScale = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));

    _fabScale.addListener((){
      setState(() {

      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Ubah Security Code",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            Alert(
                context: context,
                type: AlertType.success,
                title: 'Berhasil',
                desc:
                "Password anda berhasil diganti, silahkan Login ulang!",
                style: AlertStyle(
                  animationDuration: Duration(milliseconds: 500),
                  overlayColor: Colors.black54,
                  animationType: AnimationType.grow,
                ),
                buttons: [
                  DialogButton(
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      _onLogin();
                    },
                    color: HexColor("#C61818"),
                  ),
                ]).show();
          }

          if (state is ChangePasswordFailed) {
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Change Password Failed"),
                backgroundColor: HexColor('#C61818'),
              ),
            );
          }

          if (state is LoginLoading) {
            onLoading(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  labelText: "Username",
                  hintText: "Masukan Username anda",
                ),
                controller: passwordOldCtrl,
              ),
              TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password Baru",
                    hintText: "Masukan Password Baru"
                ),
                controller: passwordNewCtrl,
              ),
              ValidationItem("* Required 8 characters", eightChars),
              ValidationItem("* Required 1 special character", specialChar),
              ValidationItem("* Required 1 upper case", upperCaseChar),
              ValidationItem("* Required 1 number", number),
              SizedBox(height: 30),
              Container(
                width: screenWidth(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RaisedButton(
                    onPressed: () {
                      _onChangePassword();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text("Ubah Password",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: HexColor("#C61818"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _allValid() {
    return eightChars && number && specialChar && upperCaseChar;
  }
}
