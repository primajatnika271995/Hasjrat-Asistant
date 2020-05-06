import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/models/stnk_expired_model.dart';

class DetailsStnkExpiredView extends StatefulWidget {
  final StnkExpiredModel value;
  DetailsStnkExpiredView({this.value});

  @override
  _DetailsStnkExpiredViewState createState() => _DetailsStnkExpiredViewState();
}

class _DetailsStnkExpiredViewState extends State<DetailsStnkExpiredView> {

  var formatStnkDate = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Detail STNK",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: <Widget>[
            customerName(),
            Divider(),
            customerContact(),
            Divider(),
            customerCarName(),
            Divider(),
            customerCarColor(),
            Divider(),
            chassisNumber(),
            Divider(),
            machineNumber(),
            Divider(),
            stnkExpiredDate(),
          ],
        ),
      ),
    );
  }

  Widget customerName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Nama\nPelanggan",
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
              "${widget.value.customerName}",
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

  Widget customerContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "No. Telp",
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
              "${widget.value.phone}",
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

  Widget customerCarName() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Jenis\nKendaraan",
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
              "${widget.value.carName}",
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

  Widget customerCarColor() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Warna",
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
              "${widget.value.carColor}",
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

  Widget chassisNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "No. Rangka",
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
              "${widget.value.chassisNumber}",
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

  Widget machineNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "No. Mesin",
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
              "${widget.value.machineNumber}",
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

  Widget stnkExpiredDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Tgl.\nKadaluwarsa",
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
              "${formatStnkDate.format(DateTime.parse(widget.value.expiredDateStnk))}",
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
}
