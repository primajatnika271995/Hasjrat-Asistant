import 'package:flutter/material.dart';

class ProspectDetailsView extends StatefulWidget {
  @override
  _ProspectDetailsViewState createState() => _ProspectDetailsViewState();
}

class _ProspectDetailsViewState extends State<ProspectDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Customer",
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
