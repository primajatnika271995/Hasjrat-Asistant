import 'package:flutter/material.dart';
import 'package:salles_tools/src/views/promotion_page/details_promotion.dart';

class PromotionListScreen extends StatefulWidget {
  @override
  _PromotionListScreenState createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends State<PromotionListScreen> {

  void _onDetailsPromotion() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PromotionDetailsView(),
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Promotion",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Card(
                elevation: 5,
                child: ListTile(
                  onTap: () {
                    _onDetailsPromotion();
                  },
                  title: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      "Paket Kemerdekaan",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Potongan Harga Rp. 4.500.000 untuk mobil Agya.",
                        style: TextStyle(
                          letterSpacing: 1.0,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Valid Until 2020-03-03",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Container(
                              height: 18,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(
                                child: Text(
                                  "Detail",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
