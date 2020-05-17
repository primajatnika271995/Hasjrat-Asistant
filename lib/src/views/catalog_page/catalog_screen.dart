import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_event.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_state.dart';
import 'package:salles_tools/src/models/catalog_model.dart';
import 'package:salles_tools/src/services/catalog_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/catalog_page/catalog_brochure_screen.dart';
import 'package:salles_tools/src/views/catalog_page/details_selection_catalog.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/components/trusty_horizontal_menu.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String catalogCategori = "mpv";

  void _onSeeDetails(String heroName, CatalogModel data) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => CatalogBloc(CatalogService()),
          child: DetailsCatalogView(
            heroName: heroName,
            data: data,
          ),
        ),
        transitionDuration: Duration(milliseconds: 750),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  void _onSeeBrochure() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => CatalogBloc(CatalogService()),
          child: CatalogBrochureScreen(),
        ),
        transitionDuration: Duration(milliseconds: 750),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  void tabFilter(int id) {
    switch (id) {
      case 0:
        setState(() {
          catalogCategori = "mpv";
        });
        break;
      case 1:
        setState(() {
          catalogCategori = "hatchback";
        });
        break;
      case 2:
        setState(() {
          catalogCategori = "suv";
        });
        break;
      case 3:
        setState(() {
          catalogCategori = "sedan";
        });
        break;
      case 4:
        setState(() {
          catalogCategori = "sport";
        });
        break;
      case 5:
        setState(() {
          catalogCategori = "commercial";
        });
        break;
      case 6:
        setState(() {
          catalogCategori = "hybrid";
        });
        break;
    }

    // ignore: close_sinks
    final catalogBLoc = BlocProvider.of<CatalogBloc>(context);
    catalogBLoc.add(
        FetchCatalogByCategory(CategoryCatalogPost(category: catalogCategori)));
  }

  @override
  void initState() {
    // ignore: close_sinks
    final catalogBLoc = BlocProvider.of<CatalogBloc>(context);
    catalogBLoc.add(
        FetchCatalogByCategory(CategoryCatalogPost(category: catalogCategori)));
    super.initState();
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
          "Katalog",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Container(
            height: 55,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            alignment: Alignment.center,
            child: TrustyHorizontalMenu(
              callback: (id) {
                log.info("id Tab : $id");
                tabFilter(id);
              },
              list: [
                "MPV",
                "HatchBack",
                "SUV",
                "Sedan",
                "Sport",
                "Komersial",
                "Hibrid",
              ],
            ),
          ),
        ),
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
            if (state is CatalogByCategoryFailed) {
              Navigator.of(context, rootNavigator: true).pop();
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icons/no_data.png", height: 200),
                    ],
                  ),
                ),
              );
            }

            if (state is CatalogByCategorySuccess) {
              return state.value
                          .where((f) =>
                              f.archive != true &&
                              f.category == catalogCategori.toLowerCase())
                          .toList()
                          .length >=
                      1
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 13),
                            child: GridView.builder(
                              itemCount: state.value
                                  .where((f) =>
                                      f.enabled == true &&
                                      f.category ==
                                          catalogCategori.toLowerCase())
                                  .toList()
                                  .length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 3 / 4,
                                crossAxisSpacing: 17,
                                mainAxisSpacing: 17,
                              ),
                              itemBuilder: (context, i) {
                                var data = state.value
                                    .where((f) => f.archive != true)
                                    .toList()[i];
                                return GestureDetector(
                                  onTap: () {
                                    _onSeeDetails("catalog-image$i", data);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0),
                                    ),
                                    elevation: 3,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Hero(
                                            tag: "catalog-image$i",
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(9.0),
                                                  topRight:
                                                      Radius.circular(9.0),
                                                ),
                                                color: Color(0xffe5e6ea),
                                              ),
                                              child: data.colours[0].image ==
                                                          null ||
                                                      data.colours[0].image
                                                          .isEmpty
                                                  ? Center(
                                                      child: Icon(
                                                        Icons.broken_image,
                                                        size: 60,
                                                        color: Colors.white,
                                                      ),
                                                    )
                                                  : Image.network(
                                                      "${data.colours[0].image}",
                                                    ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(9.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "${data.itemClass1}",
                                                style: TextStyle(
                                                  letterSpacing: 0.8,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              // Text(
                                              //   "${data.itemType}",
                                              //   style: TextStyle(
                                              //     letterSpacing: 0.8,
                                              //     fontSize: 13,
                                              //     color: Colors.grey,
                                              //   ),
                                              // ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  : Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/icons/no_data.png",
                                height: 200),
                          ],
                        ),
                      ),
                    );
            }
            return SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _onSeeBrochure();
        },
        label: Text("Brosur"),
        icon: Icon(Icons.picture_as_pdf),
        backgroundColor: HexColor('#C61818'),
      ),
    );
  }
}
