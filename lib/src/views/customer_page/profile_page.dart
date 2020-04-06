import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_bloc.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/services/booking_drive_service.dart';
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
  
  var formatDob = DateFormat("yyyy-MM-dd");

  void _onBookTestDrive() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => BookingDriveBloc(BookingDriveService()),
          child: BookTestDriveAddView(),
        ),
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
                color: HexColor('#C61818'),
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
                color: HexColor('#212120'),
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
              "Jenis\nKelamin",
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
              datum.gender == "L" ? "LAKI-LAKI" : "PEREMPUAN",
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
              datum.location == "DK" ? "DALAM KOTA" : "LUAR KOTA",
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
              "${formatDob.format(datum.dob)}",
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
