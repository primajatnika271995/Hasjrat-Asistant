import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/catalog_model.dart' as catalogModel;
import 'package:salles_tools/src/models/detail_catalog_model.dart';

class CatalogGalleryView extends StatefulWidget {
  final DetailCatalogModel data;

  const CatalogGalleryView({Key key, this.data}) : super(key: key);
  @override
  _CatalogGalleryViewState createState() => _CatalogGalleryViewState(this.data);
}

class _CatalogGalleryViewState extends State<CatalogGalleryView> {
  final DetailCatalogModel data;
  int _currentImage = 0;

  List<String> _imgInterior = [
    'https://www.wardsauto.com/sites/wardsauto.com/files/styles/article_featured_retina/public/uploads/2018/04/cockpit1214.jpg?itok=hEG-1vUM',
    'https://www.peruzzi.com/assets/stock/expanded/white/640/2020toc02_640/2020toc020065_640_28.jpg?height=400',
    'https://static.tcimg.net/vehicles/oem/56cdc6d21886d2c3/2020-Toyota-Camry.jpg',
  ];

  _CatalogGalleryViewState(this.data);

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: data.galleriesExterior.isEmpty &&
                data.galleriesInterior.isEmpty &&
                data.galleriesSafety.isEmpty
            ? Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icons/no_data.png", height: 200),
                      Text(
                        "Data gambar kosong",
                        style: TextStyle(
                            letterSpacing: 1,
                            color: Colors.grey,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  data.galleriesInterior.isEmpty
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                "Interior",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: CarouselSlider.builder(
                                initialPage: 1,
                                autoPlay: false,
                                enlargeCenterPage: true,
                                viewportFraction: 0.9,
                                autoPlayCurve: Curves.bounceIn,
                                reverse: false,
                                height: 180,
                                enableInfiniteScroll: false,
                                aspectRatio: 2.0,
                                itemCount: data.galleriesInterior.length,
                                itemBuilder: (context, index) {
                                  var valueData = data.galleriesInterior[index];
                                  return Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Stack(children: <Widget>[
                                        Hero(
                                          tag: "promotion-tag${data.id}",
                                          child: Image.network(
                                              "${valueData.image}",
                                              fit: BoxFit.cover,
                                              width: 1000.0),
                                        ),
                                        valueData.description == null
                                            ? SizedBox()
                                            : Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, bottom: 10),
                                                  child: Text(
                                                    "${valueData.description}",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                        letterSpacing: 1,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                      ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                  data.galleriesExterior.isEmpty
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                "Exterior",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: CarouselSlider.builder(
                                initialPage: 1,
                                autoPlay: false,
                                enlargeCenterPage: true,
                                viewportFraction: 0.9,
                                autoPlayCurve: Curves.bounceIn,
                                reverse: false,
                                height: 180,
                                enableInfiniteScroll: false,
                                aspectRatio: 2.0,
                                itemCount: data.galleriesExterior.length,
                                itemBuilder: (context, index) {
                                  var valueData = data.galleriesExterior[index];
                                  return Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Stack(children: <Widget>[
                                        Hero(
                                          tag: "promotion-tag${data.id}",
                                          child: Image.network(
                                              "${valueData.image}",
                                              fit: BoxFit.cover,
                                              width: 1000.0),
                                        ),
                                        valueData.description == null
                                            ? SizedBox()
                                            : Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, bottom: 10),
                                                  child: Text(
                                                    "${valueData.description}",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                      ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                  data.galleriesSafety.isEmpty
                      ? SizedBox()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 15, top: 15),
                              child: Text(
                                "Keamanan",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.0,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: CarouselSlider.builder(
                                initialPage: 1,
                                autoPlay: false,
                                enlargeCenterPage: true,
                                viewportFraction: 0.9,
                                autoPlayCurve: Curves.bounceIn,
                                reverse: false,
                                height: 180,
                                enableInfiniteScroll: false,
                                aspectRatio: 2.0,
                                itemCount: data.galleriesSafety.length,
                                itemBuilder: (context, index) {
                                  var valueData = data.galleriesSafety[index];
                                  return Container(
                                    margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Stack(children: <Widget>[
                                        Hero(
                                          tag: "promotion-tag${data.id}",
                                          child: Image.network(
                                              "${valueData.image}",
                                              fit: BoxFit.cover,
                                              width: 1000.0),
                                        ),
                                        valueData.description == null
                                            ? SizedBox()
                                            : Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, bottom: 10),
                                                  child: Text(
                                                    "${valueData.description}",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w900),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                      ]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                ],
              ),
      ),
    );
  }

  Widget sliderContent() {
    final slider = CarouselSlider(
      items: _imgInterior
          .asMap()
          .map(
            (i, element) {
              return MapEntry(
                i,
                Container(
                  margin: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(children: <Widget>[
                      Hero(
                        tag: "catalog-gallery-$i",
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              _onShowFullImage("catalog-gallery-$i", element);
                            },
                            child: Image.network(
                              element,
                              fit: BoxFit.cover,
                              width: 1000.0,
                              height: 10000.0,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(200, 0, 0, 0),
                                Color.fromARGB(0, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          child: Text(
                            'Interior $i',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              );
            },
          )
          .values
          .toList(),
      autoPlay: false,
      enlargeCenterPage: true,
      viewportFraction: 0.5,
      height: 150,
      onPageChanged: (int newVal) {
        setState(() {
          _currentImage = newVal;
        });
      },
      initialPage: 2,
    );
    return Column(
      children: <Widget>[
        slider,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: IconButton(
                onPressed: () => slider.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                ),
                icon: Icon(Icons.navigate_before),
              ),
            ),
            Text("${_currentImage + 1} / ${_imgInterior.length}"),
            Flexible(
              child: IconButton(
                onPressed: () => slider.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                ),
                icon: Icon(Icons.navigate_next),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
