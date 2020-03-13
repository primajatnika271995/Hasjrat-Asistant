import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class CatalogSpecificationsView extends StatefulWidget {
  @override
  _CatalogSpecificationsViewState createState() =>
      _CatalogSpecificationsViewState();
}

class _CatalogSpecificationsViewState extends State<CatalogSpecificationsView> {
  bool dimensionIsExpanded = false;
  bool engineIsExpanded = false;
  bool performanceIsExpanded = false;
  bool safetyIsExpanded = false;
  bool capacityIsExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            ExpansionTile(
              title: Text(
                "Dimension and Weight",
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: dimensionIsExpanded ? HexColor('#C61818') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.dimensionIsExpanded = val);
              },
            ),
            ExpansionTile(
              title: Text(
                "Engine",
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: engineIsExpanded ? HexColor('#C61818') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.engineIsExpanded = val);
              },
            ),
            ExpansionTile(
              title: Text(
                "Performance",
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: performanceIsExpanded ? HexColor('#C61818') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.performanceIsExpanded = val);
              },
            ),
            ExpansionTile(
              title: Text(
                "Safety",
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: safetyIsExpanded ? HexColor('#C61818') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.safetyIsExpanded = val);
              },
            ),
            ExpansionTile(
              title: Text(
                "Capacity",
                style: TextStyle(
                  letterSpacing: 1.0,
                  color: capacityIsExpanded ? HexColor('#C61818') : Colors.black,
                ),
              ),
              onExpansionChanged: (bool val) {
                setState(() => this.capacityIsExpanded = val);
              },
            ),
          ],
        ),
      ),
    );
  }
}
