import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/notification_page/notification_birthday.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void _onCheckCustomerBirthday() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => NotificationBirthdayView(),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  Future _onLoading() async {
    await Future.delayed(Duration(seconds: 3));
    return Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 7,
        automaticallyImplyLeading: false,
        title: Text(
          "Notification",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder(
        future: this._onLoading(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              onLoading(context);
              break;
            default:
              break;
          }
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ListTile(
                  onTap: null,
                  title: Text("Customers Birthday"),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Jangan lupa ucapkan Ulang Tahun ya!",
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: HexColor('#891F1F'),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 5),
                            child: Text(
                              "1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  leading: Icon(
                    Icons.redeem,
                    size: 35,
                    color: Colors.yellow[400],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {
                      _onCheckCustomerBirthday();
                    },
                  ),
                ),
                ListTile(
                  onTap: null,
                  title: Text("STNK Expired"),
                  subtitle: Text(
                    "Ayo ingatkan Customer-mu sebelum STNKnya expired!",
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  leading: Icon(
                    Icons.sentiment_dissatisfied,
                    size: 35,
                    color: Colors.deepPurpleAccent,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {},
                  ),
                ),
                ListTile(
                  onTap: null,
                  title: Text("Activity"),
                  subtitle: Text(
                    "Aktivitas Customer-mu!",
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  leading: Icon(
                    Icons.notifications_none,
                    size: 35,
                    color: Colors.blueAccent,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.navigate_next),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
