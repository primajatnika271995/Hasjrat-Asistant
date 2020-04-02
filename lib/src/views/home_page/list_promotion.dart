import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_bloc.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_event.dart';
import 'package:salles_tools/src/bloc/catalog_bloc/catalog_state.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:shimmer/shimmer.dart';

class PromotionListView extends StatefulWidget {
  final Function callback;
  PromotionListView({Key key, this.callback}) : super(key: key);

  @override
  _PromotionListViewState createState() => _PromotionListViewState();
}

class _PromotionListViewState extends State<PromotionListView>
    with TickerProviderStateMixin {
  bool loadImage = true;

  static List<String> imgList = [
    'https://www.mistercarz.com.my/images/promo/2017/toyota.jpg',
    'https://www.toyota.com.sg/-/media/b51f3f2474df4c529590a83159de81e1.png',
    'https://www.toyota.com.sg/-/media/b51f3f2474df4c529590a83159de81e1.png',
    'https://www.mistercarz.com.my/images/promo/2017/toyota.jpg',
  ];

  static List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final bannerBloc = BlocProvider.of<CatalogBloc>(context);
    bannerBloc.add(FetchBannerPromotionList());

    Timer(Duration(seconds: 3), () {
      setState(() => loadImage = false);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CatalogBloc, CatalogState>(
      listener: (context, state) {},
      child: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoading) {
            return Container(
              height: 160,
              child: _loadingImageAnimation(context),
            );
          }

          if (state is CatalogListFailed) {
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/icons/error_banner.jpg", height: 150),
                    Text(
                      "Promotion Not Available",
                      style: TextStyle(
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is BannerPromotionSuccess) {
            return CarouselSlider.builder(
                initialPage: 1,
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                autoPlayCurve: Curves.bounceIn,
                reverse: false,
                height: 180,
                enableInfiniteScroll: false,
                aspectRatio: 2.0,
                itemCount: state.value.data.length,
                itemBuilder: (context, index) {
                  var data = state.value.data[index];
                  return GestureDetector(
                    onTap: () {
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
                                    tag: "promotion-tag$index",
                                    child: Image.network(
                                      "https://www.mistercarz.com.my/images/promo/2017/toyota.jpg",
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
                    },
                    child: Container(
                      margin: EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(children: <Widget>[
                          Hero(
                            tag: "promotion-tag$index",
                            child: Image.network(
                                "https://www.mistercarz.com.my/images/promo/2017/toyota.jpg",
                                fit: BoxFit.cover,
                                width: 1000.0),
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
                                '${data.title}',
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
                });
          }
          return SizedBox();
        },
      ),
    );
  }

  final List child = map<Widget>(
    imgList,
    (index, i) {
      return GestureDetector(
        onTap: () {
          log.info(index);
        },
        child: Container(
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
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  child: Text(
                    'No. $index image',
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
  ).toList();

  Widget _loadingImageAnimation(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => PromotionViewShimmer(),
      itemCount: 2,
    );
  }
}

class PromotionViewShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey[50],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Shimmer.fromColors(
        baseColor: Colors.black38,
        highlightColor: Colors.white,
        child: Container(
          width: 250,
          height: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.black12,
          ),
        ),
      ),
    );
  }
}
