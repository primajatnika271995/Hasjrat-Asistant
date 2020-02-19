import 'package:flutter/material.dart';

class BookTestDriveListView extends StatefulWidget {
  @override
  _BookTestDriveListViewState createState() => _BookTestDriveListViewState();
}

class _BookTestDriveListViewState extends State<BookTestDriveListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Book Test Drive",
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
