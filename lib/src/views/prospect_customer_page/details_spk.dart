import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/models/spk_model.dart';
import 'package:salles_tools/src/utils/currency_format.dart';

class SpkDetailsView extends StatefulWidget {
  final Datum value;
  SpkDetailsView({this.value});

  @override
  _SpkDetailsViewState createState() => _SpkDetailsViewState();
}

class _SpkDetailsViewState extends State<SpkDetailsView> {
  
  final dateFormat = DateFormat("yyy-MM-dd");
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Detail SPK",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            spkNum(),
            Divider(),
            spkBlanko(),
            Divider(),
            spkDateDec(),
            Divider(),
            spkCardName(),
            Divider(),
            spkPriceType(),
            Divider(),
            spkPrice(),
            Divider(),
            spkSalesName(),
            cardModel(),
            widget.value.credits != null ? cardCredit() : SizedBox(),
            cardAfi(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget spkNum() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "SPK Num",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.spkNum}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget spkBlanko() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "SPK Blanko",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.spkBlanko}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget spkCardName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Customer\nName",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.cardName}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget spkDateDec() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Tgl. Pengiriman",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${dateFormat.format(widget.value.decDate)}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget spkPriceType() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Price Type",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.spkPriceType}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget spkPrice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "SPK Price",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "Rp ${CurrencyFormat().data.format(widget.value.spkPrice)}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget spkSalesName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Sales Name",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              "${widget.value.salesName}",
              style: TextStyle(
                fontSize: 16,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget cardModel() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text("Model"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Kode Item"),
                  Text(
                    "${widget.value.models[0].itemCode}",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Model Kendaraan"),
                  Text("${widget.value.models[0].itemModel}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Tahun"),
                  Text("${widget.value.models[0].itemYear}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Type Kendaraan"),
                  Text("${widget.value.models[0].itemType}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Warna"),
                  Text("${widget.value.models[0].itemColour}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Harga"),
                  widget.value.models[0].price != null
                      ? Text(
                          "Rp ${CurrencyFormat().data.format(widget.value.models[0].price)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            fontSize: 16,
                          ),
                        )
                      : Text("-"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Harga OTR"),
                  widget.value.models[0].plOntr != null
                      ? Text(
                          "Rp ${CurrencyFormat().data.format(widget.value.models[0].plOntr)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            fontSize: 16,
                          ),
                        )
                      : Text("-"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardCredit() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text("Credit"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Nama Leasing"),
                  Text("${widget.value.credits.leasingName}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Lama Tenor"),
                  Text("${widget.value.credits.tenor} / bulan"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Nama Asuransi"),
                  Text("${widget.value.credits.namaAsuransi}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Jumlah DP"),
                  widget.value.credits.dpAmount != null
                      ? Text(
                          "Rp ${CurrencyFormat().data.format(widget.value.credits.dpAmount)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            fontSize: 16,
                          ),
                        )
                      : Text("-"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Cicilan"),
                  widget.value.credits.angsuran != null
                      ? Text(
                          "Rp ${CurrencyFormat().data.format(widget.value.credits.angsuran)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                            fontSize: 16,
                          ),
                        )
                      : Text("-"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardAfi() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: ExpansionTile(
          initiallyExpanded: true,
          title: Text("Afi"),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("SPK Afi Id"),
                  Text("${widget.value.afi.spkAfiId}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("No. KTP"),
                  Text("${widget.value.afi.nomorKtp}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Nama"),
                  Text("${widget.value.afi.nama1}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Kota"),
                  Text("${widget.value.afi.kabupatenName}"),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Provinsi"),
                  Text("${widget.value.afi.provinsiName}"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
