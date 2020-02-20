import 'package:flutter/material.dart';
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
    HomeScreen(),
    NotificationScreen(),
    DashboardScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home_icon.png', height: 25, color: HexColor('#665C55'),),
            activeIcon: Image.asset('assets/icons/home_icon.png', height: 25,),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/notification_icon.png', height: 25, color: HexColor('#665C55'),),
            activeIcon: Image.asset('assets/icons/notification_icon.png', height: 25,),
            title: Text("Notification"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/dashboard_icon.png', height: 25, color: HexColor('#665C55'),),
            activeIcon: Image.asset('assets/icons/dashboard_icon.png', height: 25,),
            title: Text("Dashboard"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile_icon.png', height: 25, color: HexColor('#665C55'),),
            activeIcon: Image.asset('assets/icons/profile_icon.png', height: 25,),
            title: Text("Profile"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor('#E07B36'),
        unselectedItemColor: HexColor('#665C55'),
        elevation: 15,
        onTap: _onItemTapped,
      ),
    );
  }
}
