import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/models/customer_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarEventScreen extends StatefulWidget {
  @override
  _CalendarEventScreenState createState() => _CalendarEventScreenState();
}

class _CalendarEventScreenState extends State<CalendarEventScreen> {

  List<Birthday> birthdays = [];

  List<Birthday> _getDataSource() {
    return birthdays;
  }

  @override
  void initState() {
    // ignore: close_sinks
    final customerBloc = BlocProvider.of<CustomerBloc>(context);
    customerBloc.add(FetchCustomerBirthDay(CustomerPost(
      cardCode: "",
      cardName: "",
      custgroup: "",
    )));
    customerBloc.add(FetchStnkExpired());

    // ignore: close_sinks
    final nationalHolidayBloc = BlocProvider.of<CustomerBloc>(context);
    nationalHolidayBloc.add(FetchNationalHoliday());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HexColor("#C61818"),
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Kalender",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: BlocListener<CustomerBloc, CustomerState>(
        listener: (context, state) {
          if (state is CustomerLoading) {
            log.info("onLoading");
            onLoading(context);
          }

          if (state is CustomerDisposeLoading) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context, rootNavigator: false).pop();
            });
          }

          if (state is CustomerSuccess) {
            state.value.data.forEach((data) {
              final DateTime today = data.dob;
              final DateTime now = DateTime.now();
              final DateTime startTime = DateTime(now.year, today.month, today.day, 7, 0, 0);
              final DateTime endTime = startTime.add(const Duration(hours: 9));

              birthdays.add(Birthday(data.cardName, startTime, endTime, const Color(0xFF0F8644), false));
              setState(() {});
            });

            // ignore: close_sinks
            final customerBloc = BlocProvider.of<CustomerBloc>(context);
            customerBloc.add(FetchStnkExpired());
          }

          if (state is StnkExpiredSuccess) {
            state.value.forEach((data) {
              final DateTime today = DateTime.parse(data.expiredDateStnk);
              final DateTime now = DateTime.now();
              final DateTime startTime = DateTime(now.year, today.month, today.day, 7, 0, 0);
              final DateTime endTime = startTime.add(const Duration(hours: 9));

              birthdays.add(Birthday(data.customerName, startTime, endTime, HexColor("#C61818"), false));
              setState(() {});
            });
          }

          if  (state is NationalHolidaySuccess) {
            state.value.forEach((data) {
              final DateTime today = data.date;
              final DateTime now = DateTime.now();
              final DateTime startTime = DateTime(now.year, today.month, today.day, 7, 0, 0);
              final DateTime endTime = startTime.add(const Duration(hours: 9));

              birthdays.add(Birthday(data.description, startTime, endTime, Colors.blue, false));
              setState(() {});
            });
          }
        },
        child: SfCalendar(
          view: CalendarView.month,
          firstDayOfWeek: 1,
          todayHighlightColor: HexColor("#C61818"),
          dataSource: BirtdayDataSource(_getDataSource()),
          selectionDecoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: HexColor("#C61818"),
              ),
              bottom: BorderSide(
                color: HexColor("#C61818"),
              ),
              left: BorderSide(
                color: HexColor("#C61818"),
              ),
              right: BorderSide(
                color: HexColor("#C61818"),
              ),
            ),
          ),
          monthViewSettings: MonthViewSettings(
            showAgenda: true,
            appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
          ),
        ),
      ),
    );
  }
}

class BirtdayDataSource extends CalendarDataSource {
  BirtdayDataSource(this.source);

  List<Birthday> source;

  @override
  List<dynamic> get appointments => source;

  @override
  DateTime getStartTime(int index) {
    return source[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return source[index].to;
  }

  @override
  String getSubject(int index) {
    return source[index].customerName;
  }

  @override
  Color getColor(int index) {
    return source[index].background;
  }

  @override
  bool isAllDay(int index) {
    return source[index].isAllDay;
  }
}

class Birthday {
  Birthday(this.customerName, this.from, this.to, this.background, this.isAllDay);

  String customerName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
