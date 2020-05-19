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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.features.length,
                    itemBuilder: (context, i) {
                      return ExpansionTile(
                        title: Text(
                          "${data.features[i].title}",
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
                                  child: data.features[i].description == null
                                      ? Text(
                                          "Data dan Spesifikasi Kosong")
                                      : Text(
                                          "${data.features[i].description}",
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
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
