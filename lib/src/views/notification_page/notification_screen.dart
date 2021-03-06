import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/notification_page/notification_birthday.dart';
import 'package:salles_tools/src/views/notification_page/notification_stnk_expire.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void _onCheckCustomerBirthday() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => CustomerBloc(CustomerService()),
          child: NotificationBirthdayView(),
        ),
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

  void _onCheckCustomerStnkExpire() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => CustomerBloc(CustomerService()),
          child: NotificationStnkExpireView(),
        ),
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
        titleSpacing: 0,
        title: Text(
          "Notifikasi",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: null,
              title: Text("Ulang Tahun Pelanggan"),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Jangan lupa ucapkan Ulang Tahun ya!",
                    style: TextStyle(
                      fontSize: 11,
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
              title: Text("STNK Kadaluwarsa"),
              subtitle: Text(
                "Ayo ingatkan Customer-mu sebelum STNKnya kadaluwarsa!",
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
                onPressed: () {
                  _onCheckCustomerStnkExpire();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
