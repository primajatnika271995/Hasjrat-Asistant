import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/activity_report_page/add_activity_report.dart';

class ActivityReportListView extends StatefulWidget {
  @override
  _ActivityReportListViewState createState() => _ActivityReportListViewState();
}

class _ActivityReportListViewState extends State<ActivityReportListView> {
  var searchCtrl = new TextEditingController();

  void _onAddActivityReport() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => AddActivityReportView(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Activity Report",
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
            searchContent(),
            SizedBox(
              height: 20,
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Laporan Kejadian",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text("2020/03/03",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              subtitle: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            ),
            Divider(),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Laporan Kejadian",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text("2020/03/03",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 0.6,
                    ),
                  ),
                ],
              ),
              subtitle: Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry."),
            ),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAddActivityReport();
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: HexColor('#C61818'),
      ),
    );
  }
  
  Widget searchContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Container(
        height: 30.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 15.0,
              spreadRadius: 0.0,
            )
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 18),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: searchCtrl,
                onEditingComplete: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
