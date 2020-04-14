import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_bloc.dart';
import 'package:salles_tools/src/models/catalog_model.dart' as catalogModel;
import 'package:salles_tools/src/services/booking_drive_service.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/services/finance_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/book_test_drive_page/add_book_test_drive.dart';
import 'package:salles_tools/src/views/calculator_page/calculator_stepper.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_gallery.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_review.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_specifications.dart';
import 'package:salles_tools/src/views/components/sliver_app_bar_delegate.dart';
import 'package:salles_tools/src/views/price_list_page/price_list_screen.dart';

class DetailsCatalogView extends StatefulWidget {
  final String heroName;
  final catalogModel.Datum data;
  DetailsCatalogView({this.heroName, this.data});

  @override
  _DetailsCatalogViewState createState() =>
      _DetailsCatalogViewState(this.heroName, this.data);
}

class _DetailsCatalogViewState extends State<DetailsCatalogView> {
  final String heroName;
  final catalogModel.Datum data;
  int _tabLength = 3;

  _DetailsCatalogViewState(this.heroName, this.data);

  void _onBookTestDrive() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => BookingDriveBloc(BookingDriveService()),
          child: BookTestDriveAddView(),
        ),
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

  void _onCalculate() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => FinanceBloc(FinanceService()),
          child: CalculatorStepperScreen(),
        ),
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

  void _onCheckPriceList() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => DmsBloc(DmsService()),
          child: PriceListView(),
        ),
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
    return DefaultTabController(
      length: _tabLength,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          titleSpacing: 0,
          title: Text(
            "${data.itemClass1}",
            // "test data",
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
                dataCatalog: data,
                heroName: heroName,
              ),
              TabViewDetailsVehicle(),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              CatalogReviewView(
                data: data,
              ),
              CatalogGalleryView(
                data: data,
              ),
              CatalogSpecificationsView(
                data: data,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 6,
                child: RaisedButton(
                  onPressed: () {
                    _onBookTestDrive();
                  },
                  child: Text(
                    'Booking Test Drive',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  color: HexColor('#C61818'),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _onCalculate();
                  },
                  child: Container(
                    height: 60,
                    child: Image.asset("assets/icons/old_calculator_icon.png"),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () {
                    _onCheckPriceList();
                  },
                  child: Container(
                    height: 60,
                    child: Image.asset("assets/icons/old_price_list_icon.png"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainViewDetailsVehicle extends StatefulWidget {
  final String heroName;
  final catalogModel.Datum dataCatalog;
  MainViewDetailsVehicle({this.heroName, this.dataCatalog});

  @override
  _MainViewDetailsVehicleState createState() =>
      _MainViewDetailsVehicleState(this.heroName, this.dataCatalog);
}

class _MainViewDetailsVehicleState extends State<MainViewDetailsVehicle> {
  final String heroName;
  final catalogModel.Datum data;
  List<String> _colorList = [];
  String _currentColor = "";

  _MainViewDetailsVehicleState(this.heroName, this.data);

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
                tag: "$heroName",
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(9.0),
                      topRight: Radius.circular(9.0),
                    ),
                  ),
                  child: data.colours.isEmpty
                      ? Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.grey,
                          ),
                        )
                      : Image.network("${data.colours[0].image}"),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  "${data.itemModel} ${data.itemType}",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dropdownMenu() {
    data.colours.forEach((val) {
      _colorList.add(val.colorNameIn);
    });
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
                  child: DropdownButton<String>(
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    hint: Text('Warna'),
                    iconSize: 15,
                    isExpanded: true,
                    onChanged: (String newVal) {
                      setState(() {
                        _currentColor = newVal;
                        state.didChange(newVal);
                      });
                    },
                    items: _colorList == null || _colorList.isEmpty
                        ? null
                        : _colorList.toSet().toList().map((String val) {
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    val,
                                    style: TextStyle(
                                      fontSize: 11.5,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
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
          ],
          isScrollable: false,
          indicator: UnderlineTabIndicator(
            borderSide: BorderSide(width: 4.0, color: HexColor('#C61818')),
          ),
          labelColor: HexColor('#C61818'),
          labelStyle: TextStyle(
            fontSize: 15,
            color: HexColor('#C61818'),
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelColor: HexColor('#212120'),
          unselectedLabelStyle: TextStyle(
            color: HexColor('#212120'),
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
