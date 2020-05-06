import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/bottom_navigation.dart';

class VerificationContactView extends StatefulWidget {
  @override
  _VerificationContactViewState createState() =>
      _VerificationContactViewState();
}

class _VerificationContactViewState extends State<VerificationContactView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var contactCtrl = new TextEditingController();

  void _onNavDashboard() {
    Navigator.of(context).pushAndRemoveUntil(
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
        (Route<dynamic> route) => false);
  }

  void onCheckContact() async {
    var contact = await SharedPreferencesHelper.getSalesContact();

    if (contactCtrl.text == contact) {
      await SharedPreferencesHelper.setFirstInstall("no");
      _onNavDashboard();
      return;
    } {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("No. Telepon yang anda masukan tidak sesuai."),
        backgroundColor: HexColor('#C61818'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Verifikasi No. Telpon",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              width: screenWidth(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Text(
                      "Enter your mobile number",
                      style: TextStyle(
                        letterSpacing: 0.8,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'eg. 08111000000',
                      ),
                      controller: contactCtrl,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 40, bottom: 30),
                    child: Text(
                      "I agree to Hasjrat Sales Tools terms, condition and privacy",
                      style: TextStyle(
                        letterSpacing: 0.7,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                    child: Container(
                      width: screenWidth(context),
                      child: RaisedButton(
                        onPressed: () {
                          onCheckContact();
                        },
                        color: HexColor("#C61818"),
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
