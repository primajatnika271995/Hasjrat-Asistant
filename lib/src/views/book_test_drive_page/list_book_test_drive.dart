import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_bloc.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_event.dart';
import 'package:salles_tools/src/bloc/booking_bloc/booking_drive_state.dart';
import 'package:salles_tools/src/models/list_booking_drive_model.dart';
import 'package:salles_tools/src/services/booking_drive_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/book_test_drive_page/add_book_test_drive.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:salles_tools/src/views/components/log.dart';

class BookTestDriveListView extends StatefulWidget {
  @override
  _BookTestDriveListViewState createState() => _BookTestDriveListViewState();
}

class _BookTestDriveListViewState extends State<BookTestDriveListView> {
  String salesBranchCode;
  String salesOutletCode;

  var dateSelectedCtrl = new TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");
  final dateFormater = DateFormat("yyyy/MM/dd");

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
    ).then((f) {
      _getPreferences();
    });
  }

  Future<Null> _selectedDate(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: new DateTime.now(),
      initialLastDate: (new DateTime.now()).add(new Duration(days: 14)),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      log.info(picked);
      dateSelectedCtrl.value = TextEditingValue(
          text:
              '${dateFormater.format(picked[0]).toString()} s.d ${dateFormater.format(picked[1]).toString()}');

      // ignore: close_sinks
      final bookingDriveBloc = BlocProvider.of<BookingDriveBloc>(context);
      bookingDriveBloc.add(FetchListBookingDrive(ListBookingDrivePost(
        branchCode: salesBranchCode,
        outletCode: salesOutletCode,
        dateAfter: dateFormat.format(picked[1]).toString(),
        dateBefore: dateFormat.format(picked[0]).toString(),
      )));
    }
  }

  void _getPreferences() async {
    salesBranchCode = await SharedPreferencesHelper.getSalesBrachId();
    salesOutletCode = await SharedPreferencesHelper.getSalesOutletId();
    setState(() {});

    // ignore: close_sinks
    final bookingDriveBloc = BlocProvider.of<BookingDriveBloc>(context);
    bookingDriveBloc.add(FetchListBookingDrive(ListBookingDrivePost(
      branchCode: salesBranchCode,
      outletCode: salesOutletCode,
      dateAfter: dateFormat.format(DateTime.now().add(Duration(days: 7))).toString(),
      dateBefore: dateFormat.format(DateTime.now()).toString(),
    )));
  }

  @override
  void initState() {
    // TODO: implement initState
    _getPreferences();
    super.initState();
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Container(
              height: 30.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15.0,
                    spreadRadius: 0.0,
                  )
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 2.0),
                  child: Theme(
                    data: ThemeData(hintColor: Colors.transparent),
                    child: GestureDetector(
                      onTap: () {
                        _selectedDate(context);
                      },
                      child: AbsorbPointer(
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabled: false,
                            contentPadding: EdgeInsets.only(bottom: 17),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: Color(0xFF6991C7),
                              size: 24.0,
                            ),
                            hintText: "Cari berdasarkan Tanggal",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w400,
                              fontSize: 13,
                            ),
                          ),
                          controller: dateSelectedCtrl,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<BookingDriveBloc, BookingDriveState>(
        listener: (context, state) {
          if (state is BookingDriveLoading) {
            onLoading(context);
          }

          if (state is BookingDriveDisposeLoading) {
            Navigator.of(context, rootNavigator: false).pop();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BlocBuilder<BookingDriveBloc, BookingDriveState>(
                builder: (context, state) {
                  if (state is ListBookingDriveFailed) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Column(
                          children: <Widget>[
                            Image.asset("assets/icons/no_data.png",
                                height: 200),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state is ListBookingDriveSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.value.length,
                      itemBuilder: (context, index) {
                        return SlidableBookTestDriveView(
                          index: index,
                          value: state.value[index],
                        );
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ),
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
  final BookingDriveScheduleModel value;
  final int index;
  final dateFormat = DateFormat("dd-MM-yyyy hh:mm");
  SlidableBookTestDriveView({Key key, this.callback, this.index, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              children: <Widget>[
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       Padding(
                //         padding:
                //             const EdgeInsets.only(left: 5, top: 5, bottom: 15),
                //         child: Image.network(
                //           "https://m.toyota.astra.co.id/sites/default/files/2019-04/car-pearl.png",
                //           height: 70,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${value.customerName.toUpperCase()}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                        Text(
                          '${value.customerPhone}',
                          style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 0.7,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 5),
                          child: Text(
                            '${value.car.itemModel}',
                            style: TextStyle(
                              fontSize: 13,
                              letterSpacing: 0.7,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            decoration: value.approve == null
                                ? BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.circular(5),
                                  )
                                : value.approve == false
                                    ? BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(5),
                                      )
                                    : BoxDecoration(
                                        color: Colors.blueAccent,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                            child: Center(
                              child: value.approve == null
                                  ? Text(
                                      'New',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  : value.approve == false
                                      ? Text(
                                          'Rejected',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      : Text(
                                          'Approved',
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
                          '${dateFormat.format(DateTime.parse(value.schedule))}',
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
