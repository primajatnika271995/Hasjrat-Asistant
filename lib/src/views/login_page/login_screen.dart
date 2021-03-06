import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_event.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_state.dart';
import 'package:salles_tools/src/bloc/register_bloc/register_bloc.dart';
import 'package:salles_tools/src/services/followup_service.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/bottom_navigation.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/login_page/verification_contact.dart';
import 'package:salles_tools/src/views/profile_page/change_password_screen.dart';
import 'package:salles_tools/src/views/register_page/register_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool visibility = true;

  var usernameCtrl = new TextEditingController();
  var passwordCtrl = new TextEditingController();

  void _onShowPassword() {
    setState(() {
      visibility  = !visibility;
    });
  }

  void _onNavVerification(String token) {
    Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => BlocProvider<FollowupBloc>(
            create: (context) => FollowupBloc(FollowupService()),
            child: VerificationContactView(
              token: token,
            ),
          ),
          transitionDuration: Duration(milliseconds: 300),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
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

  void _onNavDashboard() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BottomNavigationDrawer(),
        transitionDuration: Duration(milliseconds: 300),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) {
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

  void onNavigator(String token) async {
    var firstInstall = await SharedPreferencesHelper.getFirstInstall();

    if (firstInstall != null) {
      Navigator.of(context).pop();
      _onNavVerification(token);
    }

    if (firstInstall == "no") {
      await SharedPreferencesHelper.setAccessToken(token);
      Navigator.of(context).pop();
      _onNavDashboard();
    }
  }

  void _onRegister() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(LoginService()),
          child: RegisterScreen(),
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
  }

  void _onChangePassword() async {
    await SharedPreferencesHelper.setUsername(usernameCtrl.text);
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

  void _onSubmit() {
    if (_formKey.currentState.validate()) {
      // ignore: close_sinks
      final loginBloc = BlocProvider.of<LoginBloc>(context);
      loginBloc.add(FetchLogin(usernameCtrl.text, passwordCtrl.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            Navigator.of(context).pop();
            _onNavVerification(state.authenticated.accessToken);
          }

          if (state is LoginFailed) {
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Error"),
                backgroundColor: HexColor('#C61818'),
              ),
            );
          }

          if (state is LoginError) {
            Navigator.of(context).pop();

            if (state.error.errorDescription == "Password Expired") {
              _onChangePassword();
            }

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("${state.error.errorDescription}"),
                backgroundColor: HexColor('#C61818'),
              ),
            );
          }

          if (state is LoginLoading) {
            onLoading(context);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 150, right: 20),
                      child: Image.asset(
                        "assets/icons/old_hasjrat_toyota_logo.png",
                        height: 180,
                        width: 230,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: -30,
                    child: Container(
                      height: 170,
                      width: 170,
                      decoration: BoxDecoration(
                        color: HexColor('#212120'),
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 80,
                    left: -50,
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        color: HexColor('#C61818'),
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Login",
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Username',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor('#C61818'),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Username wajib diisi';
                              }
                              return null;
                            },
                            controller: usernameCtrl,
                          ),
                          TextFormField(
                            obscureText: visibility,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor('#C61818'),
                                ),
                              ),
                              suffixIcon: IconButton(
                                onPressed: _onShowPassword,
                                icon: Icon(visibility ? Icons.visibility_off : Icons.visibility),
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Password wajib diisi';
                              }
                              return null;
                            },
                            controller: passwordCtrl,
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: () {
                        _onSubmit();
                      },
                      color: HexColor('#C61818'),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ],
                ),
              ),
//              Padding(
//                padding: const EdgeInsets.only(top: 25),
//                child: Row(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: <Widget>[
//                    Text(
//                      "New User ?",
//                      style: TextStyle(
//                        letterSpacing: 0.5,
//                      ),
//                    ),
//                    FlatButton(
//                      onPressed: () {
////                        _onRegister();
//                      },
//                      child: Text(
//                        "Registration",
//                        style: TextStyle(
//                          fontWeight: FontWeight.w700,
//                          letterSpacing: 1.0,
//                          color: HexColor('#C61818'),
//                          decoration: TextDecoration.underline,
//                        ),
//                      ),
//                    ),
//                  ],
//                ),
//              ),
            ],
          ),
        ),
      ),
    );
  }
}
