import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/target_dashboard_bloc.dart';
import 'package:salles_tools/src/bloc/sales_month_bloc/sales_month_bloc.dart';
import 'package:salles_tools/src/services/dashboard_service.dart';
import 'package:salles_tools/src/services/sales_month_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/dashboard_page/dashboard_screen.dart';
import 'package:salles_tools/src/views/home_page/home_screen.dart';
import 'package:salles_tools/src/views/notification_page/notification_screen.dart';
import 'package:salles_tools/src/views/profile_page/profile_screen.dart';

class BottomNavigationDrawer extends StatefulWidget {
  @override
  _BottomNavigationDrawerState createState() => _BottomNavigationDrawerState();
}

class _BottomNavigationDrawerState extends State<BottomNavigationDrawer> {
  int _selectedIndex = 0;

  List<Widget> _widgetPages = [
//    HomeScreen(),
    BlocProvider(
      create: (context) => SalesMonthBloc(SalesMonthService()),
      child: HomeScreen(),
    ),
    NotificationScreen(),
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TargetDashboardBloc(DashboardService()),
        ),
        BlocProvider(
          create: (context) => DashboardBloc(DashboardService()),
        ),
      ],
      child: DashboardScreen(),
    ),
    // BlocProvider(
    //   create: (context) => DashboardBloc(DashboardService()),
    //   child: DashboardScreen(),
    // ),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onBack() async {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        body: _widgetPages.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home_icon.png',
                height: 25,
                color: HexColor('#212120'),
              ),
              activeIcon: Image.asset(
                'assets/icons/home_icon.png',
                height: 25,
                color: HexColor('#C61818'),
              ),
              title: Text("Beranda"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/notification_icon.png',
                height: 25,
                color: HexColor('#212120'),
              ),
              activeIcon: Image.asset(
                'assets/icons/notification_icon.png',
                height: 25,
                color: HexColor('#C61818'),
              ),
              title: Text("Notifikasi"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/dashboard_icon.png',
                height: 25,
                color: HexColor('#212120'),
              ),
              activeIcon:
                  Image.asset('assets/icons/dashboard_icon.png', height: 25),
              title: Text("Dasbor"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/profile_icon.png',
                height: 25,
                color: HexColor('#212120'),
              ),
              activeIcon: Image.asset(
                'assets/icons/profile_icon.png',
                height: 25,
                color: HexColor('#C61818'),
              ),
              title: Text("Profil"),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: HexColor('#C61818'),
          unselectedItemColor: HexColor('#212120'),
          elevation: 15,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
