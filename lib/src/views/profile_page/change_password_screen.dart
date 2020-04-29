import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'dart:math' as math;
import 'package:salles_tools/src/views/profile_page/validator_item.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> with TickerProviderStateMixin {

  var passwordOldCtrl = new TextEditingController();
  var passwordNewCtrl = new TextEditingController();

  AnimationController _controller;
  Animation<double> _fabScale;

  bool eightChars = false;
  bool specialChar = false;
  bool upperCaseChar = false;
  bool number = false;

  void _onChangePassword() {
    log.info(_allValid());
  }

  @override
  void initState() {
    // TODO: implement initState
    passwordNewCtrl.addListener(() {
      setState(() {
        eightChars = passwordNewCtrl.text.length >= 8;
        number = passwordNewCtrl.text.contains(RegExp(r'\d'), 0);
        upperCaseChar = passwordNewCtrl.text.contains(new RegExp(r'[A-Z]'), 0);
        specialChar = passwordNewCtrl.text.isNotEmpty &&
            !passwordNewCtrl.text.contains(RegExp(r'^[\w&.-]+$'), 0);
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
      body: Padding(
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
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password Lama",
                hintText: "Masukan Password Lama",
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
    );
  }

  bool _allValid() {
    return eightChars && number && specialChar && upperCaseChar;
  }
}
