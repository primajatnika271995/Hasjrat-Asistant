import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/services/dms_service.dart';
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
    final dmsBloc = BlocProvider.of<DmsBloc>(context);
    dmsBloc.add(
      FetchProgramPenjualan(
        ProgramPenjualanPost(
          name: "",
          programId: "",
        ),
      ),
    );

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
    return BlocListener<DmsBloc, DmsState>(
      listener: (context, state) {
        if (state is DmsLoading) {
          return Container(
            height: 160,
            child: _loadingImageAnimation(context),
          );
        }
      },
      child: BlocBuilder<DmsBloc, DmsState>(
        builder: (context, state) {
          if (state is ListProgramPenjualanError) {
            print("list promo failed");
            return Container(
              height: 160,
              child: _loadingImageAnimation(context),
            );
          }

          if (state is ListProgramPenjualanSuccess) {
            print("List promo success");

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: state.value.data.length,
              itemBuilder: (context, index) {
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
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(children: <Widget>[
                              Image.network(
                                  "https://www.mistercarz.com.my/images/promo/2017/toyota.jpg",
                                  fit: BoxFit.cover,
                                  width: 1000.0),
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
                                    '${data.programPenjualanName}',
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
              },
            );
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
