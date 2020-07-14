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

import '../../bloc/customer_bloc/customer_bloc.dart';
import '../../bloc/customer_bloc/customer_event.dart';

class NotificationStnkExpireView extends StatefulWidget {
  @override
  _NotificationStnkExpireViewState createState() =>
      _NotificationStnkExpireViewState();
}

class _NotificationStnkExpireViewState extends State<NotificationStnkExpireView> {
  var formatDob = DateFormat("yyyy-MM-dd");
  var searchByNameCtrl = new TextEditingController();

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

  void searchStnkByName(String query) {
    // ignore: close_sinks
    final qnaBloc = BlocProvider.of<CustomerBloc>(context);
    qnaBloc.add(SearchStnkExpired(query));
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: searchByName(),
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
                  // var custName = state.value
                  //     .map((e) => e.customerName)
                  //     .toSet()
                  //     .toList()[index];
                  // var data = state.value
                  //     .where((f) => f.expiredDateStnk != null)
                  //     .toSet()
                  //     .toList()
                  //     .toSet()
                  //     .toList()[index];
                  var data = searchByNameCtrl == null
                      ? state.value
                          .where((f) => f.expiredDateStnk != null)
                          .toList()[index]
                      : state.value
                          .where((f) =>
                              f.expiredDateStnk != null &&
                              f.customerName.toLowerCase().contains(
                                  searchByNameCtrl.text.toLowerCase()))
                          .toList()[index];
                  return ListTile(
                    title: Text("${data.customerName}"),
                    subtitle: Text(
                        "${formatDob.format(DateTime.parse(data.expiredDateStnk))}"),
                    leading: CircleAvatar(
                      backgroundColor: Colors.indigoAccent,
                      foregroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                          "https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.navigate_next),
                      onPressed: () {
                        _onCheckDetailsStnk(data);
                      },
                    ),
                  );
                },
                itemCount: searchByNameCtrl == null
                    ? state.value
                        .where((f) => f.expiredDateStnk != null)
                        .toList()
                        .length
                    : state.value
                        .where((f) =>
                            f.expiredDateStnk != null &&
                            f.customerName
                                .toLowerCase()
                                .contains(searchByNameCtrl.text.toLowerCase()))
                        .toList()
                        .length,
                // itemCount: state.value
                //     .map((e) => e.customerName)
                //     .toSet()
                //     .toList()
                //     .length,
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }

  Widget searchByName() {
    return Padding(
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
            padding: const EdgeInsets.only(left: 20.0, right: 2.0),
            child: Theme(
              data: ThemeData(hintColor: Colors.transparent),
              child: TextFormField(
                style: TextStyle(
                  fontSize: 13,
                  letterSpacing: 0.7,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 16),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xFF6991C7),
                    size: 24.0,
                  ),
                  hintText: "Cari",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                  ),
                ),
                controller: searchByNameCtrl,
                onEditingComplete: () {
                  searchStnkByName(searchByNameCtrl.text);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
