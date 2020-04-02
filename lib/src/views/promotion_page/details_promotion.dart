import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/models/program_penjualan_model.dart';
import 'package:salles_tools/src/utils/currency_format.dart';

class PromotionDetailsView extends StatefulWidget {
  final Datum data;
  PromotionDetailsView({this.data});

  @override
  _PromotionDetailsViewState createState() => _PromotionDetailsViewState();
}

class _PromotionDetailsViewState extends State<PromotionDetailsView> {
  final dateFormat = DateFormat("dd-MM-yyyy");

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20),
            child: Text(
              "${widget.data.programPenjualanName}",
              style: TextStyle(
                letterSpacing: 1.0,
                fontSize: 17,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 2),
                child: Icon(Icons.date_range, size: 14),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 5),
                child: Text(
                  "Valid Until ${dateFormat.format(DateTime.parse(widget.data.endDate.toString()))}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 11,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${widget.data.programPenjualanType} kendaraan ${widget.data.models[0].itemName} hingga ${widget.data.models[0].discPl}%"
                  " dengan Cashback hingga Rp ${CurrencyFormat().data.format(widget.data.models[0].cashbackHasjrat)}",
                  style: TextStyle(
                    letterSpacing: 0.8,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Hanya untuk pembelian secara ${widget.data.paymentTypeName}.",
                  style: TextStyle(
                    letterSpacing: 0.8,
                  ),
                ),
                Text(
                  "*Syarat dan ketentuan berlaku.",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    fontSize: 11,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
