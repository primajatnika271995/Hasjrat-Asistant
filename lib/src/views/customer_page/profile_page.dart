import 'package:flutter/material.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: <Widget>[
            emailCustomer(),
            Divider(),
            nikCustomer(),
            Divider(),
            contactCustomer(),
            Divider(),
            tanggalLahirCustomer(),
            Divider(),
            alamatCustomer(),
            Divider(),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        children: <Widget>[
          Expanded(
            child: ButtonTheme(
              height: 60,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  'Booking Test Drive',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                color: HexColor('#E07B36'),
              ),
            ),
          ),
          Expanded(
            child: ButtonTheme(
              height: 60,
              child: RaisedButton(
                onPressed: () {},
                child: Text(
                  'Booking Service',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                color: HexColor('#665C55'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget emailCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Email",
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
              "bayuharsono@gmail.com",
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

  Widget nikCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "NIK",
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
              "3190018751021953",
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

  Widget contactCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
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
              "+62 85875074351",
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

  Widget alamatCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Alamat",
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
              "Jl. Cicalengka Raya No 11, Antapani Bandung",
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

  Widget tanggalLahirCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Tgl Lahir",
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
              "1995-12-27",
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
