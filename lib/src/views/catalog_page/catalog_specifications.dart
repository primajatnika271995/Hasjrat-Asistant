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
        child: data.specifications.isEmpty || data.specifications == null
            ? Padding(
                padding: const EdgeInsets.only(top: 20, left: 15),
                child: Text(
                  "Data Spesifikasi Tidak Ada",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    fontSize: 16,
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data.specifications.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding:
                            const EdgeInsets.only(bottom: 5, left: 8, right: 8),
                        child: Card(
                          elevation: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: ExpansionTile(
                              title: Text(
                                "${data.itemModel} Tipe ${data.specifications[i].itemType}",
                                style: TextStyle(
                                    letterSpacing: 1.0, color: Colors.black),
                              ),
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ListTile(
                                      title: Text("Mesin"),
                                      subtitle: data.specifications[i].engine ==
                                              null
                                          ? Text(
                                              "Tidak ada data spesifikasi mesin")
                                          : Text(
                                              "${data.specifications[i].engine}"),
                                    ),
                                    ListTile(
                                      title: Text("Dimensi dan Berat"),
                                      subtitle: data.specifications[i]
                                                  .dimensionHeight ==
                                              null
                                          ? Text(
                                              "Tidak ada data spesifikasi Dimensi dan Berat")
                                          : Text(
                                              "${data.specifications[i].dimensionHeight}"),
                                    ),
                                    ListTile(
                                      title: Text("Sasis"),
                                      subtitle: data.specifications[i].chasis ==
                                              null
                                          ? Text(
                                              "Tidak ada data spesifikasi Sasis")
                                          : Text(
                                              "${data.specifications[i].chasis}"),
                                    ),
                                    ListTile(
                                      title: Text("Kapasitas"),
                                      subtitle: data
                                                  .specifications[i].capacity ==
                                              null
                                          ? Text(
                                              "Tidak ada data spesifikasi Kapasitas")
                                          : Text(
                                              "${data.specifications[i].capacity}"),
                                    ),
                                  ],
                                ),
                              ],
                              onExpansionChanged: (bool val) {
                                setState(() => this.dimensionIsExpanded = val);
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
