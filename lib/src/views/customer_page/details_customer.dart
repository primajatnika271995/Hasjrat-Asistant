import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/customer_page/list_vehicle_customer_details.dart';
import 'package:salles_tools/src/views/customer_page/profile_page.dart';

class CustomerDetailsView extends StatefulWidget {
  final Datum datum;
  CustomerDetailsView({this.datum});

  @override
  _CustomerDetailsViewState createState() => _CustomerDetailsViewState();
}

class _CustomerDetailsViewState extends State<CustomerDetailsView> {
  final int _tabLength = 2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLength,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(250),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            titleSpacing: 0,
            title: Text(
              "Detail Customer",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 0.5,
              ),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            flexibleSpace: Column(
              children: <Widget>[
                profileImage(),
              ],
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Profile",
                ),
                Tab(
                  text: "Vehicle",
                ),
              ],
              indicatorColor: HexColor('#C61818'),
              labelColor: HexColor('#C61818'),
              labelStyle: TextStyle(
                letterSpacing: 1.0,
                fontSize: 15,
                color: HexColor('#C61818'),
              ),
              unselectedLabelColor: HexColor('#212120'),
              unselectedLabelStyle: TextStyle(
                color: HexColor('#212120'),
                letterSpacing: 1.0,
                fontSize: 15,
              ),
              isScrollable: false,
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ProfileScreen(
              datum: widget.datum,
            ),
            VehicleCustomerDetailsListView(
              datum: widget.datum,
            ),
          ],
        ),
      ),
    );
  }

  Widget profileImage() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 50,
            backgroundImage: NetworkImage(
                "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
          ),
          Text(
            "${widget.datum.cardName}",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}
