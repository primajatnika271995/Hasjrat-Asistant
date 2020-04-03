import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/catalog_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class CatalogReviewView extends StatefulWidget {
  final CatalogModel data;

  const CatalogReviewView({Key key, this.data}) : super(key: key);
  @override
  _CatalogReviewViewState createState() => _CatalogReviewViewState(this.data);
}

class _CatalogReviewViewState extends State<CatalogReviewView> {
  final CatalogModel data;

  _CatalogReviewViewState(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          descriptionReview(),
          featureReview(),
        ],
      ),
    );
  }

  Widget descriptionReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 15),
          child: Text(
            "${data.itemModel} ${data.itemType}",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
          child: Text(
           "${data.descriptionReview}",
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 0.7,
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }

  Widget featureReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 25, left: 15),
          child: Text(
            "Feature & Specs",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 1.0,
              fontSize: 14,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.not_interested, color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "No data",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.not_interested, color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "No data",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.not_interested, color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "No data",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.not_interested, color: Colors.grey,),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      "No data",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
