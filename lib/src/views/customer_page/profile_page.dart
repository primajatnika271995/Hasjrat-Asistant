import 'package:flutter/material.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/book_service_page/add_book_service.dart';
import 'package:salles_tools/src/views/book_test_drive_page/add_book_test_drive.dart';

class ProfileScreen extends StatefulWidget {
  final Datum datum;
  ProfileScreen({Key key, this.datum});

  @override
  _ProfileScreenState createState() => _ProfileScreenState(this.datum);
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Datum datum;
  _ProfileScreenState(this.datum);

  void _onBookTestDrive() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BookTestDriveAddView(),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    );
  }

  void _onBookService() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BookServiceAddView(),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: <Widget>[
            cardCode(),
            Divider(),
            emailCustomer(),
            Divider(),
            nikCustomer(),
            Divider(),
            genderCustomer(),
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
                onPressed: () {
                  _onBookTestDrive();
                },
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
                onPressed: () {
                  _onBookService();
                },
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

  Widget cardCode() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Kode Kartu",
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
              "${datum.cardCode}",
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

  Widget genderCustomer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Text(
              "Jenis Kelamin",
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
              "${datum.gender}",
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
              "${datum.email}",
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
              "${datum.noKtp}",
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
              "${datum.phone1}",
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
              "${datum.location}",
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
              "${datum.dob}",
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
