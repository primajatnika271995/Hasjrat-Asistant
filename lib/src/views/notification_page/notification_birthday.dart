import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';

class NotificationBirthdayView extends StatefulWidget {
  @override
  _NotificationBirthdayViewState createState() => _NotificationBirthdayViewState();
}

class _NotificationBirthdayViewState extends State<NotificationBirthdayView> {

  var formatDob = DateFormat("yyyy-MM-dd");
  var dateNow = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final customerBloc = BlocProvider.of<CustomerBloc>(context);
    customerBloc.add(FetchCustomerBirthDay(CustomerPost(
      cardCode: "",
      cardName: "",
      custgroup: "",
    )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Text(
          "Notification Birthday",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
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
        },
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerFailed) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context, rootNavigator: true).pop();
              });
              return Center(
                child: Image.asset(
                  "assets/icons/empty_icon.png",
                  height: 100,
                  color: HexColor('#C61818'),
                ),
              );
            }

            if (state is CustomerError) {
              Future.delayed(Duration(seconds: 3), () {
                Navigator.of(context, rootNavigator: true).pop();
              });
              return Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
                      Image.asset("assets/icons/error_banner.jpg", height: 200),
                      Text("502 Error Bad Gateway"),
                    ],
                  ),
                ),
              );
            }

            if (state is CustomerSuccess) {
              if (state.value.data.where((f) => f.dob.month == dateNow.month).toList().isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Column(
                      children: <Widget>[
                        Image.asset("assets/icons/no_data.png", height: 200),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    var data = state.value.data.where((f) => f.dob.month == dateNow.month).toList()[index];
                    return ListTile(
                      title: Text("${data.cardName}"),
                      subtitle: Text("${formatDob.format(data.dob)}"),
                      leading: CircleAvatar(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white,
                        backgroundImage: NetworkImage("https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.navigate_next),
                        onPressed: () {},
                      ),
                    );
                  },
                  itemCount: state.value.data.where((f) => f.dob.month == dateNow.month).toList().length,
                );
              }
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
