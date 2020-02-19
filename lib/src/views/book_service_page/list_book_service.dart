import 'package:flutter/material.dart';

class BookServiceListView extends StatefulWidget {
  @override
  _BookServiceListViewState createState() => _BookServiceListViewState();
}

class _BookServiceListViewState extends State<BookServiceListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Book Service",
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
