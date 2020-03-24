import 'package:flutter/material.dart';

class PromotionDetailsView extends StatefulWidget {
  @override
  _PromotionDetailsViewState createState() => _PromotionDetailsViewState();
}

class _PromotionDetailsViewState extends State<PromotionDetailsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Promotion",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "Paket Kemerdekaan",
              style: TextStyle(
                letterSpacing: 1.0,
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 2),
                child: Icon(Icons.date_range, size: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 5),
                child: Text(
                  "Valid Until 2020-03-03",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
          ),
        ],
      ),
    );
  }
}
