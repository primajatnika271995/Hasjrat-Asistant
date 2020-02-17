import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/home_page/home_screen.dart';

class BottomNavigationDrawer extends StatefulWidget {
  @override
  _BottomNavigationDrawerState createState() => _BottomNavigationDrawerState();
}

class _BottomNavigationDrawerState extends State<BottomNavigationDrawer> {
  int _selectedIndex = 0;

  List<Widget> _widgetPages = [
    HomeScreen(),
    Center(
      child: Text("Notification"),
    ),
    Center(
      child: Text("Dashboard"),
    ),
    Center(
      child: Text("Profile"),
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/home_icon.png', height: 30, color: HexColor('#665C55'),),
            activeIcon: Image.asset('assets/icons/home_icon.png', height: 30,),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/notification_icon.png', height: 30, color: HexColor('#665C55'),),
            activeIcon: Image.asset('assets/icons/notification_icon.png', height: 30,),
            title: Text("Notification"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/dashboard_icon.png', height: 30, color: HexColor('#665C55'),),
            activeIcon: Image.asset('assets/icons/dashboard_icon.png', height: 30,),
            title: Text("Dashboard"),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icons/profile_icon.png', height: 30, color: HexColor('#665C55'),),
            activeIcon: Image.asset('assets/icons/profile_icon.png', height: 30,),
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
