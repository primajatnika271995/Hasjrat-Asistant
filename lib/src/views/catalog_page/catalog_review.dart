import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/catalog_model.dart';
import 'package:salles_tools/src/models/detail_catalog_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class CatalogReviewView extends StatefulWidget {
  final DetailCatalogModel valueCatalog;

  const CatalogReviewView({
    Key key,
    this.valueCatalog,
  }) : super(key: key);
  @override
  _CatalogReviewViewState createState() =>
      _CatalogReviewViewState(this.valueCatalog);
}

class _CatalogReviewViewState extends State<CatalogReviewView> {
  final DetailCatalogModel valueCatalog;

  _CatalogReviewViewState(this.valueCatalog);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            descriptionReview(),
          ],
        ),
      ),
    );
  }

  Widget descriptionReview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 15),
          child: valueCatalog.titleReview == null
              ? Text(
                  "Review Kendaraan",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    fontSize: 16,
                  ),
                )
              : Text(
                  "${valueCatalog.titleReview}",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.0,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.justify,
                ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
          child: valueCatalog.descriptionReview == null
              ? Text(
                  "Belum ada review kendaraan ini",
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 0.7,
                    color: Colors.grey,
                  ),
                )
              : Text(
                  "${valueCatalog.descriptionReview}",
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 0.7,
                    color: Colors.grey,
                  ),
            textAlign: TextAlign.justify,
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
                  Icon(
                    Icons.not_interested,
                    color: Colors.grey,
                  ),
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
                  Icon(
                    Icons.not_interested,
                    color: Colors.grey,
                  ),
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
                  Icon(
                    Icons.not_interested,
                    color: Colors.grey,
                  ),
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
                  Icon(
                    Icons.not_interested,
                    color: Colors.grey,
                  ),
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
