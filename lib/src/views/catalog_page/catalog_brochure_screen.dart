import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_event.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_state.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:url_launcher/url_launcher.dart';

class CatalogBrochureScreen extends StatefulWidget {
  CatalogBrochureScreen({Key key}) : super(key: key);

  @override
  _CatalogBrochureScreenState createState() => _CatalogBrochureScreenState();
}

class _CatalogBrochureScreenState extends State<CatalogBrochureScreen> {
  @override
  void initState() {
    final catalogBloc = BlocProvider.of<CatalogBloc>(context);
    catalogBloc.add(FetchBrosurList());
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
          "Brochure",
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
            if (state is CatalogByCategoryFailed) {
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

            if (state is BrosurCatalogSuccess) {
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
                          return GestureDetector(
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                              ),
                              elevation: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${data.title}",
                                          style: TextStyle(
                                            letterSpacing: 0.5,
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "${data.description}",
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Hero(
                                      tag: "catalog-image$i",
                                      child: GestureDetector(
                                        onTap: () {
                                          print(
                                              "Download Brosur => ${data.title}");
                                          launch("${data.url}");
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(9.0),
                                              topRight: Radius.circular(9.0),
                                            ),
                                            color: Color(0xfff4f4f4),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              FontAwesomeIcons.download,
                                              size: 50,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
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
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
