import 'package:flutter/material.dart';

class CatalogAccessoriesView extends StatefulWidget {
  @override
  _CatalogAccessoriesViewState createState() => _CatalogAccessoriesViewState();
}

class _CatalogAccessoriesViewState extends State<CatalogAccessoriesView> {

  void _onShowFullImage(String tag, String img) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, _, __) {
          return Material(
            color: Colors.black54,
            child: Container(
              padding: EdgeInsets.all(30),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Hero(
                  tag: tag,
                  child: Image.network(
                    img,
                    width: 300.0,
                    height: 300.0,
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: GridView.builder(
                  itemCount: 4,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                    crossAxisSpacing: 17,
                    mainAxisSpacing: 17,
                  ),
                  itemBuilder: (context, i) {
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
                              tag: "catalog-accessories$i",
                              child: Material(
                                child: InkWell(
                                  onTap: () {
                                    _onShowFullImage("catalog-accessories$i", "https://di-uploads-pod6.dealerinspire.com/expresswaytoyota/uploads/2018/06/image_editor_Tq1.png");
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(9.0),
                                        topRight: Radius.circular(9.0),
                                      ),
                                      color: Color(0xffe5e6ea),
                                    ),
                                    child: Image.network(
                                      "https://di-uploads-pod6.dealerinspire.com/expresswaytoyota/uploads/2018/06/image_editor_Tq1.png",
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Blackout Emblem Overlay",
                                  style: TextStyle(
                                    letterSpacing: 0.8,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 5.0,
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
            )
          ],
        ),
      ),
    );
  }
}
