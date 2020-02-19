import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';

class BookServiceListView extends StatefulWidget {
  @override
  _BookServiceListViewState createState() => _BookServiceListViewState();
}

class _BookServiceListViewState extends State<BookServiceListView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: Text(
          "Book Service",
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
          return SlidableBookServiceView(
            index: index,
            callback: () {},
          );
        },
        itemCount: BookService.getBook().length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: HexColor('#E07B36'),
      ),
    );
  }
}

class SlidableBookServiceView extends StatelessWidget {
  final Function callback;
  final int index;
  SlidableBookServiceView({Key key, this.callback, this.index}): super(key: key);

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
                      padding: const EdgeInsets.only(
                          left: 5, top: 5, bottom: 15),
                      child: Text(
                        '${BookService.getBook()[index].serviceType}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
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
                      '${BookService.getBook()[index].customerName}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        '${BookService.getBook()[index].vehiclePoliceNumber}',
                        style: TextStyle(
                          fontSize: 13,
                          letterSpacing: 0.7,
                        ),
                      ),
                    ),
                    Text(
                      '${BookService.getBook()[index].locationService}',
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
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Container(
                          height: 18,
                          width: 70,
                          decoration: BoxDecoration(
                            color: BookService.getBook()[index].statusColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(
                            child: Text(
                              '${BookService.getBook()[index].status}',
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
                        '${BookService.getBook()[index].date}',
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        '${BookService.getBook()[index].time}',
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

class BookService {
  String serviceType;
  String status;
  Color statusColor;
  String customerName;
  String vehiclePoliceNumber;
  String locationService;
  String date;
  String time;

  BookService({
    this.serviceType,
    this.status,
    this.statusColor,
    this.customerName,
    this.vehiclePoliceNumber,
    this.locationService,
    this.date,
    this.time,
  });

  static List<BookService> getBook() {
    return<BookService>[
      BookService(
        serviceType: 'Service Berkala',
        status: 'Confirmation',
        statusColor: Colors.orangeAccent,
        customerName: 'Prima Jatnika',
        vehiclePoliceNumber: 'DX 1309 AS',
        locationService: 'Hasjrat Abadi Tandean',
        date: '2019-03-27',
        time: '07:00',
      ),
      BookService(
        serviceType: 'Perbaikan Umum',
        status: 'Confirmation',
        statusColor: Colors.orangeAccent,
        customerName: 'Haidi Ghufron',
        vehiclePoliceNumber: 'A 1019 ZA',
        locationService: 'Hasjrat Abadi Tandean',
        date: '2019-04-21',
        time: '13:00',
      ),
      BookService(
        serviceType: 'Service Berkala',
        status: 'Approved',
        statusColor: Colors.blueAccent,
        customerName: 'Abdul',
        vehiclePoliceNumber: 'D 9031 JA',
        locationService: 'Hasjrat Abadi Tandean',
        date: '2019-04-12',
        time: '15:00',
      ),
      BookService(
        serviceType: 'Perbaikan Umum',
        status: 'Reject',
        statusColor: Colors.red,
        customerName: 'M Yusuf',
        vehiclePoliceNumber: 'B 9141 DS',
        locationService: 'Hasjrat Abadi Tandean',
        date: '2019-04-19',
        time: '09:00',
      ),
    ];
  }
}
