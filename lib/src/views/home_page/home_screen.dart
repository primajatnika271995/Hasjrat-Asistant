import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/app_theme.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> _menuName = [
    "Book Test Drive",
    "Catalog",
    "Calculator",
    "Knowledge Base",
    "Book Service",
    "Costumer",
    "Prospect Costumer",
    "Reminder",
  ];

  List<String> _assetsMenu = [
    "assets/icons/book_test_drive_icon.png",
    "assets/icons/catalog_icon.png",
    "assets/icons/calculator_icon.png",
    "assets/icons/knowledge_base_icon.png",
    "assets/icons/book_service_icon.png",
    "assets/icons/costumer_icon.png",
    "assets/icons/prospect_costumer_icon.png",
    "assets/icons/reminder_icon.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: <Widget>[
          sliverAppBar(),
          SliverPadding(
            padding: EdgeInsets.only(top: 20),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              _assetsMenu[index],
                              height: 50,
                            ),
                            Flexible(
                              child: Text(
                                _menuName[index],
                                style: TextStyle(
                                  letterSpacing: 0.7,
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                childCount: 8,
              ),
            ),
          ),
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
                          style: AppTheme.selamatDatangStyle,
                        ),
                        Text(
                          "{Salles Hasjrat Name}",
                          style: AppTheme.namaSalesStyle,
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
