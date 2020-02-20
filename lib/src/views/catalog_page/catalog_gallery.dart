import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CatalogGalleryView extends StatefulWidget {
  @override
  _CatalogGalleryViewState createState() => _CatalogGalleryViewState();
}

class _CatalogGalleryViewState extends State<CatalogGalleryView> {
  int _currentImage = 0;

  static List<String> imgList = [
    'https://www.wardsauto.com/sites/wardsauto.com/files/styles/article_featured_retina/public/uploads/2018/04/cockpit1214.jpg?itok=hEG-1vUM',
    'https://www.peruzzi.com/assets/stock/expanded/white/640/2020toc02_640/2020toc020065_640_28.jpg?height=400',
    'https://static.tcimg.net/vehicles/oem/56cdc6d21886d2c3/2020-Toyota-Camry.jpg',
  ];

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
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
              child: sliderContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget sliderContent() {
    final slider = CarouselSlider(
      items: child,
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
            Text("${_currentImage + 1} / ${imgList.length}"),
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

  final List child = map<Widget>(
    imgList,
    (index, i) {
      return Container(
        margin: EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(children: <Widget>[
            Image.network(i, fit: BoxFit.cover, width: 1000.0),
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
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                  'Interior ${index + 1}',
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
      );
    },
  ).toList();
}
