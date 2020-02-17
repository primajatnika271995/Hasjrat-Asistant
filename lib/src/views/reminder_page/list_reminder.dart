import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class ReminderListView extends StatefulWidget {
  @override
  _ReminderListViewState createState() => _ReminderListViewState();
}

class _ReminderListViewState extends State<ReminderListView> {
  bool pendingIsExpanded = false;
  bool todayIsExpanded = true;
  bool tomorrowIsExpanded = false;
  bool upcomingIsExpanded = false;

  int selectionData;

  List<String> _todayJob = [
    "Telfon customer untuk menawarkan mobil Cammry",
    "Mendatangi bazar mobil di Jakarta Selatan",
  ];

  List<IconData> _todayIcon = [
    Icons.phone,
    Icons.person,
  ];

  void _setSelectedData(int val) {
    setState(() {
      selectionData = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Reminder",
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
            ExpansionTile(
              title: Text(
                "Pending",
                style: TextStyle(
                  color: pendingIsExpanded ? HexColor('#E07B36') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.pendingIsExpanded = val);
              },
              children: <Widget>[],
            ),
            ExpansionTile(
              title: Text(
                "Today",
                style: TextStyle(
                  color: todayIsExpanded ? HexColor('#E07B36') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.todayIsExpanded = val);
              },
              initiallyExpanded: todayIsExpanded,
              children: <Widget>[
                ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return listData(index);
                  },
                ),
              ],
            ),
            ExpansionTile(
              title: Text(
                "Tomorrow",
                style: TextStyle(
                  color:
                      tomorrowIsExpanded ? HexColor('#E07B36') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.tomorrowIsExpanded = val);
              },
              children: <Widget>[],
            ),
            ExpansionTile(
              title: Text(
                "Upcoming",
                style: TextStyle(
                  color:
                      upcomingIsExpanded ? HexColor('#E07B36') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.upcomingIsExpanded = val);
              },
              children: <Widget>[],
            ),
          ],
        ),
      ),
    );
  }

  Widget listData(int index) {
    return RadioListTile(
      value: index,
      groupValue: selectionData,
      title: Text(
        _todayJob[index],
        style: TextStyle(
          fontSize: 13,
          color: Colors.black,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          Container(
            height: 18,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                "13:54",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Container(
            height: 18,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Icon(
                _todayIcon[index],
                size: 11,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      onChanged: (val) {
        _setSelectedData(val);
      },
      activeColor: HexColor('#E07B36'),
      selected: selectionData == index,
    );
  }
}
