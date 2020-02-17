import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/app_theme.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: <Widget>[
          sliverAppBar(),
        ],
      ),
    );
  }

  Widget sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: AppTheme.white,
      flexibleSpace: Stack(
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, left: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Selamat Datang",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Text(
                          "{Salles Hasjrat Name}",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    "assets/icons/header_icon.png",
                    height: 170,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              height: 85,
              width: 85,
              decoration: BoxDecoration(
                color: HexColor('#665C55'),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: HexColor('#E07B36'),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
