import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/detail_catalog_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/models/catalog_model.dart' as catalogModel;

class CatalogSpecificationsView extends StatefulWidget {
  final DetailCatalogModel data;
  const CatalogSpecificationsView({
    Key key,
    this.data,
  }) : super(key: key);
  @override
  _CatalogSpecificationsViewState createState() =>
      _CatalogSpecificationsViewState(this.data);
}

class _CatalogSpecificationsViewState extends State<CatalogSpecificationsView> {
  final DetailCatalogModel data;
  bool dimensionIsExpanded = false;
  bool engineIsExpanded = false;
  bool performanceIsExpanded = false;
  bool safetyIsExpanded = false;
  bool capacityIsExpanded = false;

  _CatalogSpecificationsViewState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: data.features.isEmpty || data.features == null
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icons/no_data.png", height: 200),
                    ],
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  ExpansionTile(
                    title: Text(
                      "Dimension and Weight",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: dimensionIsExpanded
                            ? HexColor('#C61818')
                            : Colors.black,
                      ),
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 17, bottom: 5, right: 17),
                              child: data.features[3] == null
                                  ? Text(
                                      "Belum ada data Spesifikasi Dimensi dan Berat")
                                  : Text(
                                      "${data.features[3].description}",
                                      style: TextStyle(
                                        letterSpacing: 0.7,
                                        fontSize: 13,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    onExpansionChanged: (bool val) {
                      setState(() => this.dimensionIsExpanded = val);
                    },
                  ),
                  ExpansionTile(
                    title: Text(
                      "Engine",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: engineIsExpanded
                            ? HexColor('#C61818')
                            : Colors.black,
                      ),
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 17, bottom: 5, right: 17),
                              child: data.features[2].description == null
                                  ? Text(
                                      "Belum ada data Spesifikasi Dimensi dan Berat")
                                  : Text(
                                      "${data.features[2].description}",
                                      style: TextStyle(
                                        letterSpacing: 0.7,
                                        fontSize: 13,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    onExpansionChanged: (bool val) {
                      setState(() => this.engineIsExpanded = val);
                    },
                  ),
                  ExpansionTile(
                    title: Text(
                      "Performance",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: performanceIsExpanded
                            ? HexColor('#C61818')
                            : Colors.black,
                      ),
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 17, bottom: 5, right: 17),
                              child: data.features[0].description == null
                                  ? Text("Belum ada data Spesifikasi Performa")
                                  : Text(
                                      "${data.features[0].description}",
                                      style: TextStyle(
                                        letterSpacing: 0.7,
                                        fontSize: 13,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    onExpansionChanged: (bool val) {
                      setState(() => this.performanceIsExpanded = val);
                    },
                  ),
                  ExpansionTile(
                    title: Text(
                      "Safety",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: safetyIsExpanded
                            ? HexColor('#C61818')
                            : Colors.black,
                      ),
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 17, bottom: 5, right: 17),
                              child: data.features[4].description == null
                                  ? Text("Belum ada data Spesifikasi Performa")
                                  : Text(
                                      "${data.features[4].description}",
                                      style: TextStyle(
                                        letterSpacing: 0.7,
                                        fontSize: 13,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    onExpansionChanged: (bool val) {
                      setState(() => this.safetyIsExpanded = val);
                    },
                  ),
                  ExpansionTile(
                    title: Text(
                      "Capacity",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        color: capacityIsExpanded
                            ? HexColor('#C61818')
                            : Colors.black,
                      ),
                    ),
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 17, bottom: 5, right: 17),
                              child: data.features[1].description == null
                                  ? Text("Belum ada data Spesifikasi Kapasitas")
                                  : Text(
                                      "${data.features[1].description}",
                                      style: TextStyle(
                                        letterSpacing: 0.7,
                                        fontSize: 13,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
