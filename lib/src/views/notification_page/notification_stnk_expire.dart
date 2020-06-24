import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/models/stnk_expired_model.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/notification_page/details_stnk_expired.dart';

class NotificationStnkExpireView extends StatefulWidget {
  @override
  _NotificationStnkExpireViewState createState() => _NotificationStnkExpireViewState();
}

class _NotificationStnkExpireViewState extends State<NotificationStnkExpireView> {

  var formatDob = DateFormat("yyyy-MM-dd");

  List<StnkExpiredModel> tmpData = [];

  void _onCheckDetailsStnk(StnkExpiredModel value) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => DetailsStnkExpiredView(
          value: value,
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
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final customerBloc = BlocProvider.of<CustomerBloc>(context);
    customerBloc.add(FetchStnkExpired());
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
          "Notifikasi STNK",
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
            Navigator.of(context, rootNavigator: false).pop();
          }
        },
        child: BlocBuilder<CustomerBloc, CustomerState>(
          builder: (context, state) {
            if (state is CustomerFailed) {
              Navigator.of(context, rootNavigator: true).pop();
              return Center(
                child: Image.asset(
                  "assets/icons/empty_icon.png",
                  height: 100,
                  color: HexColor('#C61818'),
                ),
              );
            }

            if (state is CustomerError) {
              Navigator.of(context, rootNavigator: true).pop();
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

            if (state is StnkExpiredSuccess) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {

                  var custName = state.value.map((e) => e.customerName).toSet().toList()[index];
                  var data = tmpData.where((f) => f.expiredDateStnk != null).toSet().toList().toSet().toList()[index];
                  return ListTile(
                    title: Text("$custName"),
                    subtitle: Text("${formatDob.format(DateTime.parse(data.expiredDateStnk))}"),
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                      backgroundImage: NetworkImage("https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.navigate_next),
                      onPressed: () {
                        _onCheckDetailsStnk(data );
                      },
                    ),
                  );
                },
                itemCount: state.value.map((e) => e.customerName).toSet().toList().length,
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
