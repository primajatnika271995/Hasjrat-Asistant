import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/finance_bloc/finance_bloc.dart';
import 'package:salles_tools/src/models/catalog_model.dart' as catalogModel;
import 'package:salles_tools/src/models/detail_catalog_model.dart';
import 'package:salles_tools/src/models/selector_model.dart';
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
import 'package:select_dialog/select_dialog.dart';

import '../../bloc/catalog_bloc/catalog_bloc.dart';
import '../../bloc/catalog_bloc/catalog_bloc.dart';
import '../../bloc/catalog_bloc/catalog_bloc.dart';
import '../../bloc/catalog_bloc/catalog_event.dart';
import '../../bloc/catalog_bloc/catalog_state.dart';
import '../../bloc/catalog_bloc/catalog_state.dart';
import '../../bloc/catalog_bloc/catalog_state.dart';
import '../../bloc/catalog_bloc/catalog_state.dart';
import '../../bloc/catalog_bloc/catalog_state.dart';
import '../../models/catalog_model.dart';
import '../../models/catalog_model.dart';
import '../../services/catalog_service.dart';
import '../../services/catalog_service.dart';
import '../components/loading_content.dart';

class DetailsCatalogView extends StatefulWidget {
  final String heroName;
  final CatalogModel data;
  DetailsCatalogView({this.heroName, this.data});

  @override
  _DetailsCatalogViewState createState() =>
      _DetailsCatalogViewState(this.heroName, this.data);
}

class _DetailsCatalogViewState extends State<DetailsCatalogView> {
  final String heroName;
  final CatalogModel data;
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
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final catalogBloc = BlocProvider.of<CatalogBloc>(context);
    catalogBloc.add(FetchDetailCatalog(DetailCatalogPost(id: data.id)));
    super.initState();
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
        body: BlocListener<CatalogBloc, CatalogState>(
          listener: (context, state) {
            if (state is CatalogLoading) {
              onLoading(context);
            }
            if (state is CatalogDisposeLoading) {
              Navigator.of(context, rootNavigator: false).pop();
            }
          },
          child: BlocBuilder<CatalogBloc, CatalogState>(
            builder: (context, state) {
              if (state is DetailCatalogFailed) {
                Navigator.of(context, rootNavigator: true).pop();
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: <Widget>[
                        Image.asset("assets/icons/error_banner.jpg",
                            height: 200),
                      ],
                    ),
                  ),
                );
              }

              if (state is DetailCatalogSuccess) {
                return NestedScrollView(
                  headerSliverBuilder: (context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      MainViewDetailsVehicle(
                        dataCatalog: state.value,
                      ),
                      TabViewDetailsVehicle(),
                    ];
                  },
                  body: TabBarView(
                    children: <Widget>[
                      CatalogReviewView(
                        valueCatalog: state.value,
                      ),
                      CatalogGalleryView(data: state.value),
                      CatalogSpecificationsView(data: state.value),
                    ],
                  ),
                );
              }
              return SizedBox();
            },
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
                    'Test Drive',
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
  final DetailCatalogModel dataCatalog;
  MainViewDetailsVehicle({this.heroName, this.dataCatalog});

  @override
  _MainViewDetailsVehicleState createState() =>
      _MainViewDetailsVehicleState(this.heroName, this.dataCatalog);
}

class _MainViewDetailsVehicleState extends State<MainViewDetailsVehicle> {
  final String heroName;
  final DetailCatalogModel dataCatalog;
  List<SelectorColorCar> _colorList = [];
  String _currentUrlImage = "";
  var currentSelectPriceList;
  var curentColorCtrl = new TextEditingController();
  _MainViewDetailsVehicleState(this.heroName, this.dataCatalog);

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
            SizedBox(
              height: 20,
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
                  child: dataCatalog.colours.isEmpty
                      ? Center(
                          child: Icon(
                            Icons.broken_image,
                            size: 100,
                            color: Colors.grey,
                          ),
                        )
                      : _currentUrlImage.isEmpty || _currentUrlImage == null
                          ? Image.network("${dataCatalog.colours[0].image}")
                          : Image.network("$_currentUrlImage"),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Text(
                  "${dataCatalog.itemClass1}",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }

  Widget dropdownMenu() {
    dataCatalog.colours.forEach((f) {
      _colorList.add(SelectorColorCar(
        colorInd: f.colorNameIn,
        imageUrl: f.image,
      ));
    });
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.8,
        height: 36,
        child: Container(
          height: 30,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 1),
              child: Theme(
                data: ThemeData(hintColor: Colors.transparent),
                child: GestureDetector(
                  onTap: () {
                    // _showListVehicle();
                    SelectDialog.showModal<SelectorColorCar>(
                      context,
                      label: "Pilihan Warna",
                      // selectedValue: currentSelectPriceList,
                      items: _colorList.toSet().toList(),
                      itemBuilder:
                          (context, SelectorColorCar color, bool isSelected) {
                        return Container(
                          decoration: !isSelected
                              ? null
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                          child: ListTile(
                            selected: isSelected,
                            title: Text("${color.colorInd}"),
                          ),
                        );
                      },
                      onChange: (SelectorColorCar selected) {
                        setState(() {
                          currentSelectPriceList = selected;
                          curentColorCtrl.text = selected.colorInd;
                          _currentUrlImage = selected.imageUrl;
                        });
                      },
                    );
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      readOnly: true,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                      decoration: new InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 5),
                        border: InputBorder.none,
                        enabled: false,
                        suffixIcon: Icon(
                          Icons.arrow_drop_down,
                          color: Color(0xFF6991C7),
                          size: 20,
                        ),
                        hintText: "Warna",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),
                      controller: curentColorCtrl,
                    ),
                  ),
                ),
              ),
            ),
          ),
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
            Tab(text: 'Galeri'),
            Tab(text: 'Spesifikasi'),
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
