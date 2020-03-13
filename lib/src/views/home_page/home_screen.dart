import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_bloc.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_bloc.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/services/finance_service.dart';
import 'package:salles_tools/src/utils/app_theme.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/book_service_page/list_book_service.dart';
import 'package:salles_tools/src/views/book_test_drive_page/list_book_test_drive.dart';
import 'package:salles_tools/src/views/calculator_page/calculator_screen.dart';
import 'package:salles_tools/src/views/calculator_page/calculator_stepper.dart';
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

  var _salesName;

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
//    BlocProvider(
//      create: (context) => FinanceBloc(FinanceService()),
//      child: CalculatorScreen(),
//    ),
    BlocProvider(
      create: (context) => FinanceBloc(FinanceService()),
      child: CalculatorStepperScreen(),
    ),
    KnowledgeBaseScreen(),
    BookServiceListView(),
    BlocProvider(
      create: (context) => CustomerBloc(CustomerService()),
      child: CustomerListView(),
    ),
    BlocProvider(
      create: (context) => LeadBloc(CustomerService()),
      child: ProspectCustomerListView(),
    ),
    ReminderListView(),
  ];

  void _getPreferences() async {
    _salesName = await SharedPreferencesHelper.getSalesName();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    _getPreferences();
    super.initState();
  }

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
                        color: HexColor('#C61818'),
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
          Positioned(
            top: paddingTop(context) + 10,
            left: 20,
            child: Image.asset(
              "assets/icons/hasjrat_logo_apps.png",
              height: 40,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: HexColor('#C61818'),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100),
                ),
              ),
            ),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: paddingTop(context), left: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Text(
                          "Selamat Datang",
                          style: AppTheme.selamatDatangStyle,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "$_salesName",
                          style: AppTheme.namaSalesStyle,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
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
            right: 0,
            child: Container(
              height: 55,
              width: 55,
              decoration: BoxDecoration(
                color: HexColor('#212120'),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100),
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
