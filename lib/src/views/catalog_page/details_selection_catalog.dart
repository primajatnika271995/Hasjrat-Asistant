import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_accessories.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_gallery.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_review.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_specifications.dart';
import 'package:salles_tools/src/views/components/sliver_app_bar_delegate.dart';

class DetailsCatalogView extends StatefulWidget {
  final String heroName;
  DetailsCatalogView({this.heroName});

  @override
  _DetailsCatalogViewState createState() => _DetailsCatalogViewState();
}

class _DetailsCatalogViewState extends State<DetailsCatalogView> {
  int _tabLength = 4;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabLength,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          titleSpacing: 0,
          title: Text(
            "Toyota Camry",
            style: TextStyle(
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, bool innerBoxIsScrolled) {
            return <Widget>[
              MainViewDetailsVehicle(
                heroName: widget.heroName,
              ),
              TabViewDetailsVehicle(),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              CatalogReviewView(),
              CatalogGalleryView(),
              CatalogSpecificationsView(),
              CatalogAccessoriesView(),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          children: <Widget>[
            Expanded(
              child: ButtonTheme(
                height: 60,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Booking Test Drive',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.0,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  color: HexColor('#E07B36'),
                ),
              ),
            ),
            Expanded(
              child: ButtonTheme(
                height: 60,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Calculator',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 1.0,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  color: HexColor('#665C55'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainViewDetailsVehicle extends StatefulWidget {
  final String heroName;
  MainViewDetailsVehicle({this.heroName});

  @override
  _MainViewDetailsVehicleState createState() => _MainViewDetailsVehicleState();
}

class _MainViewDetailsVehicleState extends State<MainViewDetailsVehicle> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(225),
        child: Text(''),
      ),
      elevation: 1,
      flexibleSpace: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                dropdownMenu(),
              ],
            ),
            Expanded(
              child: Hero(
                tag: "${widget.heroName}",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9.0),
                      topRight: Radius.circular(9.0),
                    ),
                  ),
                  child: Image.network(
                      "https://m.toyota.astra.co.id/sites/default/files/2019-04/car-pearl.png"),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 80),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Camry LE Auto",
                          style: TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Rp 800.000.000",
                          style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "●",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.red,
                                ),
                              ),
                              Text(
                                "●",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "●",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Stock",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            color: Colors.grey,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          "15 Unit",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownMenu() {
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Container(
        width: 110,
        height: 36,
        child: FormField(
          builder: (FormFieldState state) {
            return InputDecorator(
              decoration: InputDecoration(
                hintText: 'Context Type',
                hintStyle: TextStyle(
                  fontSize: 13,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  child: DropdownButton<VehicleType>(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    hint: Text('Type'),
                    iconSize: 15,
                    isExpanded: true,
                    onChanged: (VehicleType newVal) {
                      state.didChange(newVal.type);
                    },
                    items: VehicleType.getType().map((VehicleType val) {
                      return DropdownMenuItem<VehicleType>(
                        value: val,
                        child: Text(val.type),
                      );
                    }).toList(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TabViewDetailsVehicle extends StatefulWidget {
  @override
  _TabViewDetailsVehicleState createState() => _TabViewDetailsVehicleState();
}

class _TabViewDetailsVehicleState extends State<TabViewDetailsVehicle> {
  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      floating: false,
      pinned: true,
      delegate: SliverAppBarDelegate(
        TabBar(
          tabs: <Widget>[
            Tab(text: 'Review'),
            Tab(text: 'Gallery'),
            Tab(text: 'Specifications'),
            Tab(text: 'Accessories'),
          ],
          isScrollable: true,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 4.0, color: HexColor('#E07B36')),
          ),
          labelColor: HexColor('#E07B36'),
          labelStyle: TextStyle(
            letterSpacing: 1.0,
            fontSize: 15,
            color: HexColor('#E07B36'),
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelColor: HexColor('#665C55'),
          unselectedLabelStyle: TextStyle(
            color: HexColor('#665C55'),
            letterSpacing: 1.0,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}


class VehicleType {
  String type;

  VehicleType({this.type});

  static List<VehicleType> getType() {
    return <VehicleType>[
      VehicleType(type: 'LE Auto'),
      VehicleType(type: 'LE Manual'),
    ];
  }
}
