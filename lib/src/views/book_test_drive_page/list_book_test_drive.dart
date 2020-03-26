import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_bloc.dart';
import 'package:salles_tools/src/services/booking_drive_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/book_test_drive_page/add_book_test_drive.dart';

import '../../bloc/dms_bloc/dms_bloc.dart';
import '../../services/dms_service.dart';

class BookTestDriveListView extends StatefulWidget {
  @override
  _BookTestDriveListViewState createState() => _BookTestDriveListViewState();
}

class _BookTestDriveListViewState extends State<BookTestDriveListView> {

  void _onAddBookTestDrive() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => BookingDriveBloc(BookingDriveService()),
          child: BookTestDriveAddView(),
        ),
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
          "Book Test Drive",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return SlidableBookTestDriveView(
            index: index,
            callback: () {},
          );
        },
        itemCount: BookTestDrive.getBook().length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAddBookTestDrive();
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: HexColor('#C61818'),
      ),
    );
  }
}

class SlidableBookTestDriveView extends StatelessWidget {
  final Function callback;
  final int index;
  SlidableBookTestDriveView({Key key, this.callback, this.index}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border(
              bottom: BorderSide(
                color: Colors.black,
              ),
              top: BorderSide(
                color: Colors.black,
              ),
              left: BorderSide(
                color: Colors.black,
              ),
              right: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 5, bottom: 15),
                      child: Image.network(
                        "https://m.toyota.astra.co.id/sites/default/files/2019-04/car-pearl.png",
                        height: 70,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '${BookTestDrive.getBook()[index].customerName}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${BookTestDrive.getBook()[index].vehicleName}',
                        style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                    Text(
                      '${BookTestDrive.getBook()[index].locationName}',
                      style: TextStyle(
                        fontSize: 13,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 40, top: 10),
                        child: Container(
                          height: 18,
                          width: 70,
                          decoration: BoxDecoration(
                            color: BookTestDrive.getBook()[index].statusColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              '${BookTestDrive.getBook()[index].status}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '${BookTestDrive.getBook()[index].date}',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '${BookTestDrive.getBook()[index].time}',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}

class BookTestDrive {
  String status;
  Color statusColor;
  String customerName;
  String vehicleName;
  String locationName;
  String date;
  String time;

  BookTestDrive({
    this.status,
    this.statusColor,
    this.customerName,
    this.vehicleName,
    this.locationName,
    this.date,
    this.time,
  });

  static List<BookTestDrive> getBook() {
    return<BookTestDrive>[
      BookTestDrive(
        status: 'Confirmation',
        statusColor: Colors.orangeAccent,
        customerName: 'Prima Jatnika',
        vehicleName: 'Cammry LE Auto',
        locationName: 'Hasjrat Abadi Tandean',
        date: '2019-03-27',
        time: '07:00',
      ),
      BookTestDrive(
        status: 'Confirmation',
        statusColor: Colors.orangeAccent,
        customerName: 'Haidi Ghufron',
        vehicleName: 'C-HR',
        locationName: 'Hasjrat Abadi Tandean',
        date: '2019-04-21',
        time: '13:00',
      ),
      BookTestDrive(
        status: 'Approved',
        statusColor: Colors.blueAccent,
        customerName: 'Abdul',
        vehicleName: 'C-RV',
        locationName: 'Hasjrat Abadi Tandean',
        date: '2019-04-12',
        time: '15:00',
      ),
      BookTestDrive(
        status: 'Reject',
        statusColor: Colors.red,
        customerName: 'M Yusuf',
        vehicleName: 'Cammry LE Auto',
        locationName: 'Hasjrat Abadi Tandean',
        date: '2019-04-19',
        time: '09:00',
      ),
    ];
  }
}
