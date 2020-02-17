import 'package:flutter/material.dart';

class PromotionListView extends StatefulWidget {
  final Function callback;
  PromotionListView({Key key, this.callback}) : super(key: key);

  @override
  _PromotionListViewState createState() => _PromotionListViewState();
}

class _PromotionListViewState extends State<PromotionListView> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 16),
      child: Container(
        height: 160,
        width: double.infinity,
        child: ListView.builder(
          padding:
          const EdgeInsets.only(top: 0, bottom: 0, right: 3, left: 3),
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            var count = 4;
            var animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                parent: animationController,
                curve: Interval((1 / count) * index, 1.0,
                    curve: Curves.fastOutSlowIn)));
            animationController.forward();

            return PromotionView(
              animation: animation,
              animationController: animationController,
              callback: () {},
            );
          },
        ),
      ),
    );

  }
}

class PromotionView extends StatelessWidget {
  final VoidCallback callback;
  final AnimationController animationController;
  final Animation animation;

  PromotionView({Key key, this.callback, this.animationController, this.animation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: new Matrix4.translationValues(
                100 * (1.0 - animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: Card(
                elevation: 0,
                color: Colors.grey[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 250,
                      height: 148,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: NetworkImage(
                              'http://gamh.org/wp-content/uploads/2019/02/news.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

