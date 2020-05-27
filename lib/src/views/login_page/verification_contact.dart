import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_bloc.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_event.dart';
import 'package:salles_tools/src/bloc/followup_bloc/followup_state.dart';
import 'package:salles_tools/src/models/followup_reminder_model.dart';
import 'package:salles_tools/src/models/reminder_sqlite_model.dart';
import 'package:salles_tools/src/services/sqlite_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/bottom_navigation.dart';
import 'package:salles_tools/src/views/components/log.dart';

class VerificationContactView extends StatefulWidget {
  @override
  _VerificationContactViewState createState() =>
      _VerificationContactViewState();
}

class _VerificationContactViewState extends State<VerificationContactView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  SqliteService _dbHelper = SqliteService();

  final dateFormat = DateFormat("dd MMMM yyyy");
  final timeFormat = DateFormat.Hm();

  var contactCtrl = new TextEditingController();

  void _onNavDashboard() {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => BottomNavigationDrawer(),
          transitionDuration: Duration(milliseconds: 750),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          },
        ),
        (Route<dynamic> route) => false);
  }

  void onCheckContact() async {
    var contact = await SharedPreferencesHelper.getSalesContact();

    if (contactCtrl.text == contact) {
      await SharedPreferencesHelper.setFirstInstall("no");
      _onNavDashboard();
      return;
    } {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("No. Telepon yang anda masukan tidak sesuai."),
        backgroundColor: HexColor('#C61818'),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final bookingDriveBloc = BlocProvider.of<FollowupBloc>(context);
    bookingDriveBloc.add(FetchFollowupReminder());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: Text(
          "Verifikasi No. Telpon",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<FollowupBloc, FollowupState>(
        listener: (context, state) {
          if (state is FollowupReminderSuccess) {
            log.info("Store Data");

            DateTime _now = DateTime.now();
            state.value.data.forEach((f) async {
              log.info("${dateFormat.format(f.prospectDate)}");

              if (f.prospectDate != null && _now.difference(f.prospectDate).inDays <= -1) {
                log.info("Upcoming Data");
                await _dbHelper.insert(ReminderSqlite(
                  "Call",
                  "${f.cardName} | Reminder Follow Up",
                  f.cardName,
                  dateFormat.format(f.prospectDate).toString(),
                  timeFormat.format(f.prospectDate).toString(),
                  "Reminder Followup",
                  'Upcoming',
                ));
              } else if (f.prospectDate != null) {
                log.info("Now Data");
                await _dbHelper.insert(ReminderSqlite(
                  "Call",
                  "${f.cardName} | Reminder Follow Up",
                  f.cardName,
                  dateFormat.format(DateTime.now()).toString(),
                  timeFormat.format(f.prospectDate).toString(),
                  "Reminder Followup",
                  'Now',
                ));
              }
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                color: Colors.white,
                width: screenWidth(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Text(
                        "Enter your mobile number",
                        style: TextStyle(
                          letterSpacing: 0.8,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(bottom: 15, left: 20, right: 20),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'eg. 08111000000',
                        ),
                        controller: contactCtrl,
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20, right: 40, bottom: 30),
                      child: Text(
                        "I agree to Hasjrat Sales Tools terms, condition and privacy",
                        style: TextStyle(
                          letterSpacing: 0.7,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
                      child: Container(
                        width: screenWidth(context),
                        child: RaisedButton(
                          onPressed: () {
                            onCheckContact();
                          },
                          color: HexColor("#C61818"),
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
