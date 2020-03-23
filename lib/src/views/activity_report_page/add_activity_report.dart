import 'package:flutter/material.dart';

class AddActivityReportView extends StatefulWidget {
  @override
  _AddActivityReportViewState createState() => _AddActivityReportViewState();
}

class _AddActivityReportViewState extends State<AddActivityReportView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Add Activity Report",
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
