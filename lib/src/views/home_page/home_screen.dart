import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_bloc.dart';
import 'package:salles_tools/src/bloc/knowledge_base_bloc/knowledge_base_bloc.dart';
import 'package:salles_tools/src/bloc/sales_month_bloc/sales_month_bloc.dart';
import 'package:salles_tools/src/bloc/sales_month_bloc/sales_month_event.dart';
import 'package:salles_tools/src/bloc/sales_month_bloc/sales_month_state.dart';
import 'package:salles_tools/src/services/activity_report_service.dart';
import 'package:salles_tools/src/services/catalog_service.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/services/finance_service.dart';
import 'package:salles_tools/src/services/knowledge_base_service.dart';
import 'package:salles_tools/src/services/sales_month_service.dart';
import 'package:salles_tools/src/utils/app_theme.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/activity_report_page/list_activity_report.dart';
import 'package:salles_tools/src/views/book_service_page/add_book_service.dart';
import 'package:salles_tools/src/views/book_service_page/list_book_service.dart';
import 'package:salles_tools/src/views/book_test_drive_page/list_book_test_drive.dart';
import 'package:salles_tools/src/views/calculator_basic_page/calculator_basic_screen.dart';
import 'package:salles_tools/src/views/calculator_page/calculator_stepper.dart';
import 'package:salles_tools/src/views/calendar_event_page/calendar_event_screen.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_screen.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/customer_page/list_customer.dart';
import 'package:salles_tools/src/views/home_page/list_banner.dart';
import 'package:salles_tools/src/views/knowledge_base_page/knowledge_base_screen.dart';
import 'package:salles_tools/src/views/notification_page/notification_screen.dart';
import 'package:salles_tools/src/views/price_list_page/price_list_screen.dart';
import 'package:salles_tools/src/views/promotion_page/list_promotion.dart';
import 'package:salles_tools/src/views/prospect_customer_page/sales_input.dart';
import 'package:salles_tools/src/views/reminder_page/list_reminder.dart';
import 'package:sqflite/sqflite.dart';

import '../../bloc/booking_bloc/booking_drive_bloc.dart';
import '../../configs/sqlite_access.dart';
import '../../services/booking_drive_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _salesName;
  var _branchName;
  var _outletName;

  var _outletId;
  var _branchId;

  List<String> _menuName = [
    "Pelanggan",
    "Prospek Pelanggan",
    "Katalog",
    "Kalkulator Simulasi",
    "Kalkulator",
    "Pengingat\nJadwal",
    "Booking\nService",
    "Booking\nTest Drive",
    "Sales\nProgram",
    "Laporan\nAktifitas",
    "Kalender",
    "Harga\nKendaraan",
    "Informasi",
  ];

  List<String> _moreMenuName = [
    "Knowledge\nBase",
    "Activity\nReport",
    "Price List",
    "Promotion",
  ];

  List<String> _assetsMenu = [
    "assets/icons/costumer_icon.png",
    "assets/icons/prospect_costumer_icon.png",
    "assets/icons/catalog_icon.png",
    "assets/icons/calculator_icon.png",
    "assets/icons/calculator_basic_icon.png",
    "assets/icons/reminder_icon.png",
    "assets/icons/book_service_icon.png",
    "assets/icons/book_test_drive_icon.png",
    "assets/icons/promotion_icon_2.png",
    "assets/icons/activity_report_icon.png",
    "assets/icons/calendar_icon.png",
    "assets/icons/price_list_icon.png",
    "assets/icons/knowledge_base_icon.png",
  ];

  List<String> _assetsMoreMenu = [
    "assets/icons/knowledge_base_icon.png",
    "assets/icons/activity_report_icon.png",
    "assets/icons/price_list_icon.png",
    "assets/icons/promotion_icon.png",
  ];

  List _menuNavigation = [
    BlocProvider(
      create: (context) => CustomerBloc(CustomerService()),
      child: CustomerListView(),
    ),
    SalesInputView(),
    BlocProvider(
      create: (context) => CatalogBloc(CatalogService()),
      child: CatalogScreen(),
    ),
    BlocProvider(
      create: (context) => FinanceBloc(FinanceService()),
      child: CalculatorStepperScreen(),
    ),
    CalculatorBasicScreen(),
    ReminderListView(),
//    BookServiceListView(),
    BlocProvider(
      create: (context) => BookingDriveBloc(BookingDriveService()),
      child: BookServiceAddView(),
    ),
    BlocProvider(
      create: (context) => BookingDriveBloc(BookingDriveService()),
      child: BookTestDriveListView(),
    ),
    BlocProvider(
      create: (context) => DmsBloc(DmsService()),
      child: PromotionListScreen(),
    ),
    BlocProvider(
      create: (context) => ActivityReportBloc(ActivityReportService()),
      child: ActivityReportListView(),
    ),
    BlocProvider(
      create: (context) => CustomerBloc(CustomerService()),
      child: CalendarEventScreen(),
    ),
    BlocProvider(
      create: (context) => DmsBloc(DmsService()),
      child: PriceListView(),
    ),
    BlocProvider(
      create: (context) => KnowledgeBaseBloc(KnowledgeBaseService()),
      child: KnowledgeBaseScreen(),
    ),
  ];

  List _moreMenuNavigation = [
    BlocProvider(
      create: (context) => KnowledgeBaseBloc(KnowledgeBaseService()),
      child: KnowledgeBaseScreen(),
    ),
    BlocProvider(
      create: (context) => ActivityReportBloc(ActivityReportService()),
      child: ActivityReportListView(),
    ),
    BlocProvider(
      create: (context) => DmsBloc(DmsService()),
      child: PriceListView(),
    ),
    BlocProvider(
      create: (context) => DmsBloc(DmsService()),
      child: PromotionListScreen(),
    ),
  ];

  void _showMoreMenu() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Container(
          height: screenHeight(context) / 2,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 1.0,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Material(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => _moreMenuNavigation[index],
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
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          _assetsMoreMenu[index],
                          height: 70,
                        ),
                        Flexible(
                          child: Text(
                            _moreMenuName[index],
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
          ),
        );
      },
    );
  }

  void _getPreferences() async {
    _salesName = await SharedPreferencesHelper.getSalesName();
    _branchName = await SharedPreferencesHelper.getSalesBrach();
    _outletName = await SharedPreferencesHelper.getSalesOutlet();
    _outletId = await SharedPreferencesHelper.getSalesOutletId();
    _branchId = await SharedPreferencesHelper.getSalesBrachId();
    setState(() {});

    // ignore: close_sinks
    final salesMonthBloc = BlocProvider.of<SalesMonthBloc>(context);
    salesMonthBloc.add(FetchSalesMonth(
        SalesMonthPost(branchCode: _branchId, outletCode: _outletId)));
  }

  var jumlahReminder = 0;

  void countReminder() async {
    SqliteAcces _dbHelper = new SqliteAcces();
    Database db = await _dbHelper.initDB();

    final count = Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM tb_reminder_v2'));

    print("total reminder $count");

    setState(() {
      jumlahReminder = count;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    countReminder();
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
      body: BlocListener<SalesMonthBloc, SalesMonthState>(
        listener: (context, state) {
          if (state is SalesMonthSuccess) {
            log.info("Sales Month : ${state.salesData.name}");
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await showGeneralDialog(
                  barrierColor: Colors.grey.withOpacity(0.5),
                  context: context,
                  barrierLabel: '',
                  barrierDismissible: true,
                  transitionDuration: Duration(milliseconds: 1000),
                  transitionBuilder: (context, a1, a2, widget) {
                    final curvedValue =
                        Curves.easeInOutBack.transform(a1.value) - 1.0;
                    return Transform(
                      transform: Matrix4.translationValues(
                          0.0, curvedValue * 200, 0.0),
                      child: Opacity(
                        opacity: a1.value,
                        child: AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Container(
                            height: 300,
                            width: 200,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Sales of The Month",
                                      style: TextStyle(
                                        letterSpacing: 0.8,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 25),
                                    child: Text(
                                      "${state.salesData.name}",
                                      style: TextStyle(
                                        letterSpacing: 0.8,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Image.asset(
                                          "assets/icons/circular_frame.png"),
                                      Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: CircleAvatar(
                                            radius: 65,
                                            backgroundColor: Colors.transparent,
                                            foregroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                              "${state.salesData.imageUrl}",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  pageBuilder: (context, animation1, animation2) {});
            });
          }
        },
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: <Widget>[
            sliverAppBar(),
            sliverGridMenu(),
            SliverToBoxAdapter(
              child: Divider(
                thickness: 2,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(left: 8, right: 8, bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Promosi",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BlocProvider(
                create: (context) => CatalogBloc(CatalogService()),
                child: BannerListView(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sliverAppBar() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: paddingTop(context)),
        child: Container(
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/new_header_icon.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Image.asset(
                      "assets/icons/hasjrat_toyota_logo.png",
                      height: 50,
                      width: 130,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 15),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NotificationScreen(),
                          ),
                        );
                      },
                      icon: Stack(
                        children: [
                          Image.asset(
                            'assets/icons/notification_icon.png',
                            height: 20,
                            color: Colors.white,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              height: 8,
                              width: 8,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Selamat Datang",
                  style: AppTheme.selamatDatangStyle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, top: 80),
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "$_salesName",
                          style: AppTheme.namaSalesStyle,
                        ),
                        Text(
                          "Hasjrat Toyota $_branchName Outlet $_outletName",
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

  Widget sliverGridMenu() {
    return SliverPadding(
      padding: EdgeInsets.only(top: 10),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.75,
          mainAxisSpacing: 10.0,
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
                  child: _assetsMenu[index] == "assets/icons/reminder_icon.png"
                      ? Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Image.asset(
                                    "assets/icons/reminder_icon.png",
                                    height: 55,
                                  ),
                                  Flexible(
                                    child: Text(
                                      _menuName[index],
                                      style: TextStyle(
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(color: Colors.white),
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                    "$jumlahReminder",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              _assetsMenu[index],
                              height: 55,
                            ),
                            Flexible(
                              child: Text(
                                _menuName[index],
                                style: TextStyle(
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
          childCount: 11,
        ),
      ),
    );
  }
}
