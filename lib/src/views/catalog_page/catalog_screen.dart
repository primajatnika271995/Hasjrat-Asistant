import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_event.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_state.dart';
import 'package:salles_tools/src/services/catalog_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/catalog_page/details_selection_catalog.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/trusty_horizontal_menu.dart';

class CatalogScreen extends StatefulWidget {
  @override
  _CatalogScreenState createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  void _onSeeDetails(String heroName) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => DetailsCatalogView(
          heroName: heroName,
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

  @override
  void initState() {
    final catalogBLoc = BlocProvider.of<CatalogBloc>(context);
    catalogBLoc.add(FetchCatalogList());
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
          "Catalog",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(55),
          child: Container(
            height: 55,
            padding: EdgeInsets.symmetric(vertical: 5.0),
            alignment: Alignment.center,
            child: TrustyHorizontalMenu(
              list: [
                "MPV",
                "Sedan",
                "Sport",
                "Hybrid",
                "Hatchback",
                "SUV",
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
            if (state is CatalogListFailed) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context, rootNavigator: true).pop();
              });
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

            if (state is CatalogListSuccess) {
              print("CATALOG LIST DATA OK");
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 13),
                      child: GridView.builder(
                        itemCount: state.value.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 3 / 4,
                          crossAxisSpacing: 17,
                          mainAxisSpacing: 17,
                        ),
                        itemBuilder: (context, i) {
                          var data = state.value.data[i];

                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(9.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[300],
                                  offset: Offset(0, 3),
                                  blurRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Hero(
                                    tag: "catalog-image$i",
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(9.0),
                                            topRight: Radius.circular(9.0),
                                          ),
                                          color: Color(0xffe5e6ea),
                                        ),
                                        child: data.colours[0].image == null
                                            ? Image.network(
                                                "https://www.toyota.astra.co.id/files/thumb/92b0e7104a1238b/872/617/fit")
                                            : Image.network("${data.colours[0].image}")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "${data.itemModel}",
                                        style: TextStyle(
                                          letterSpacing: 0.8,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Text(
                                        "${data.itemType}",
                                        style: TextStyle(
                                            letterSpacing: 0.8,
                                            fontSize: 13,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  pageBuilder: (_, __, ___) =>
                                                      BlocProvider(
                                                    create: (context) =>
                                                        CatalogBloc(
                                                            CatalogService()),
                                                    child: DetailsCatalogView(
                                                        data: data),
                                                  ),
                                                  transitionDuration: Duration(
                                                      milliseconds: 750),
                                                  transitionsBuilder: (_,
                                                      Animation<double>
                                                          animation,
                                                      __,
                                                      Widget child) {
                                                    return Opacity(
                                                      opacity: animation.value,
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              decoration: BoxDecoration(
                                                color: HexColor('#C61818'),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey[400],
                                                    blurRadius: 5.0,
                                                    offset: Offset(0, 3),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                Icons.visibility,
                                                color: Colors.white,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
