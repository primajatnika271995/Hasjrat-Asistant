import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/login_bloc/login_bloc.dart';
import 'package:salles_tools/src/bloc/register_bloc/register_bloc.dart';
import 'package:salles_tools/src/bloc/register_bloc/register_event.dart';
import 'package:salles_tools/src/bloc/register_bloc/register_state.dart';
import 'package:salles_tools/src/services/login_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/login_page/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    var usernameCtrl = new TextEditingController();
    var passwordCtrl = new TextEditingController();
    var emailCtrl = new TextEditingController();

    void _onNavLogin() {
      Navigator.of(context).pushReplacement(
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
    }

    void _onCheckNIK() {
      // ignore: close_sinks
      final checkNIKBloc = BlocProvider.of<RegisterBloc>(context);
      checkNIKBloc.add(CheckNIK(usernameCtrl.text));
    }

    void _onRegister() {
      if (_formKey.currentState.validate()) {
        // ignore: close_sinks
        final checkNIKBloc = BlocProvider.of<RegisterBloc>(context);
        checkNIKBloc.add(
          PostRegister(
            RegisterPost(
              username: usernameCtrl.text,
              password: passwordCtrl.text,
              email: emailCtrl.text,
            ),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
//            Navigator.of(context).pop();
            _onNavLogin();
          }

          if (state is RegisterFailed) {
            log.warning("Failed");
            Navigator.of(context).pop();
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("NIK yang anda gunakan sudah didaftarkan!"),
                backgroundColor: HexColor('#891F1F'),
              ),
            );
          }

          if (state is RegisterLoading) {
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
                      padding: const EdgeInsets.only(left: 200, right: 20),
                      child: Image.asset(
                        "assets/icons/header_icon.png",
                        height: 110,
                        width: 170,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: -30,
                    child: Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: HexColor('#665C55'),
                        borderRadius: BorderRadius.circular(200),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: -40,
                    child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: HexColor('#891F1F'),
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Register",
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 20,
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              hintText: 'NIK',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: HexColor('#891F1F'),
                                ),
                              ),
                              suffixIcon:
                              BlocBuilder<RegisterBloc, RegisterState>(
                                builder: (context, state) {
                                  if (state is CheckNIKSuccess) {
                                    return Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    );
                                  }

                                  if (state is CheckNIKFailed) {
                                    return Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    );
                                  }

                                  if (state is CheckNIKLoading) {
                                    return CupertinoActivityIndicator();
                                  }

                                  return SizedBox();
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'NIK wajib diisi';
                              }
                              return null;
                            },
                            onEditingComplete: () {
                              _onCheckNIK();
                            },
                            controller: usernameCtrl,
                          ),
                          BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              if (state is CheckNIKSuccess) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    "NIK terdaftar!",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.green,
                                    ),
                                  ),
                                );
                              }

                              if (state is CheckNIKFailed) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 3),
                                  child: Text(
                                    "NIK tidak terdaftar!",
                                    style: TextStyle(
                                      letterSpacing: 1.0,
                                      color: Colors.red,
                                    ),
                                  ),
                                );
                              }

                              return SizedBox();
                            },
                          ),
                          BlocBuilder<RegisterBloc, RegisterState>(
                            builder: (context, state) {
                              if (state is CheckNIKSuccess) {
                                return Column(
                                  children: <Widget>[
                                    TextFormField(
                                      decoration: InputDecoration(
                                        hintText: 'Email',
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: HexColor('#891F1F'),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Email wajib diisi';
                                        }
                                        return null;
                                      },
                                      controller: emailCtrl,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Password',
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: HexColor('#891F1F'),
                                          ),
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
                                  ],
                                );
                              }

                              return SizedBox();
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                          ),
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
                        _onRegister();
                      },
                      color: HexColor('#891F1F'),
                      child: Text(
                        "Create",
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
            ],
          ),
        ),
      ),
    );
  }
}
