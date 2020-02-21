import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/app_theme.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/book_service_page/list_book_service.dart';
import 'package:salles_tools/src/views/book_test_drive_page/list_book_test_drive.dart';
import 'package:salles_tools/src/views/calculator_page/calculator_screen.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_screen.dart';
import 'package:salles_tools/src/views/customer_page/list_customer.dart';
import 'package:salles_tools/src/views/home_page/list_promotion.dart';
import 'package:salles_tools/src/views/knowledge_base_page/knowledge_base_screen.dart';
import 'package:salles_tools/src/views/prospect_customer_page/list_prospect_customer.dart';
import 'package:salles_tools/src/views/reminder_page/list_reminder.dart';

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

  List _menuNavigation = [
    BookTestDriveListView(),
    CatalogScreen(),
    CalculatorScreen(),
    KnowledgeBaseScreen(),
    BookServiceListView(),
    CustomerListView(),
    ProspectCustomerListView(),
    ReminderListView(),
  ];

  @override
  // TODO: implement context
  BuildContext get context => super.context;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppTheme.white,
      body: CustomScrollView(
        slivers: <Widget>[
          sliverAppBar(),
          sliverGridMenu(),
          SliverToBoxAdapter(
            child: Divider(),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 20, left: 8, right: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Promotions",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      letterSpacing: 0.7,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(
                        fontSize: 13,
                        color: HexColor('#E07B36'),
                        letterSpacing: 0.7,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: PromotionListView(),
          ),
        ],
      ),
    );
  }

  Widget sliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      backgroundColor: AppTheme.white,
      automaticallyImplyLeading: false,
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
                        Image.asset(
                          "assets/icons/logo_header_icon.png",
                          height: 50,
                        ),
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

  Widget sliverGridMenu() {
    return SliverPadding(
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
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (_, __, ___) => _menuNavigation[index],
                      transitionDuration: Duration(milliseconds: 150),
                      transitionsBuilder:
                          (_, Animation<double> animation, __, Widget child) {
                        return Opacity(
                          opacity: animation.value,
                          child: child,
                        );
                      },
                    ),
                  );
                },
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
    );
  }
}
