import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/models/banner_model.dart';
import 'package:salles_tools/src/utils/currency_format.dart';
import 'package:salles_tools/src/utils/screen_size.dart';

class BannerDetailsView extends StatefulWidget {
  final Datum data;
  BannerDetailsView({this.data});

  @override
  _BannerDetailsViewState createState() => _BannerDetailsViewState();
}

class _BannerDetailsViewState extends State<BannerDetailsView> {
  final dateFormat = DateFormat("dd-MM-yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Banner",
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
          Hero(
            tag: "promotion-tag${widget.data.id}",
            child: Image.network(
              "${widget.data.url}",
              width: screenWidth(context),
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20),
            child: Text(
              "${widget.data.title.toUpperCase()}",
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
                  "Valid Until ${dateFormat.format(DateTime.parse(widget.data.expiredIn.toString()))}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: 10, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.data.notes}",
                  style: TextStyle(
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "*Syarat dan ketentuan berlaku.",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 11,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
