import 'package:flutter/material.dart';

class NotificationStnkExpireView extends StatefulWidget {
  @override
  _NotificationStnkExpireViewState createState() => _NotificationStnkExpireViewState();
}

class _NotificationStnkExpireViewState extends State<NotificationStnkExpireView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Notifikasi STNK",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
    );
  }
}
