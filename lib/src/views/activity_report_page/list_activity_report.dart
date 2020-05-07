import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_bloc.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_event.dart';
import 'package:salles_tools/src/bloc/activity_report_bloc/activity_report_state.dart';
import 'package:salles_tools/src/models/activity_report_model.dart';
import 'package:salles_tools/src/services/activity_report_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/activity_report_page/add_activity_report.dart';
import 'package:salles_tools/src/views/activity_report_page/details_activity_report.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';

class ActivityReportListView extends StatefulWidget {
  @override
  _ActivityReportListViewState createState() => _ActivityReportListViewState();
}

class _ActivityReportListViewState extends State<ActivityReportListView> {
  var searchCtrl = new TextEditingController();
  
  var dateFormat = DateFormat("yyyy/MM/dd");

  String outletCode;
  String branchCode;

  void _onAddActivityReport() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => ActivityReportBloc(ActivityReportService()),
          child: AddActivityReportView(),
        ),
        transitionDuration: Duration(milliseconds: 450),
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
      ),
    ).then((f) {
      getListActivityReport();
    });
  }

  void _onViewDetailsActivityReport(Datum value) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ActivityReportDetailsView(
          data: value,
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

  void getListActivityReport() async {
    branchCode = await SharedPreferencesHelper.getSalesBrachId();
    outletCode = await SharedPreferencesHelper.getSalesOutletId();
    setState(() {});

    // ignore: close_sinks
    final activityReportBloc = BlocProvider.of<ActivityReportBloc>(context);
    activityReportBloc.add(FetchActivityReport(
      branchCode,
      outletCode,
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    getListActivityReport();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Text(
          "Laporan Aktifitas",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: searchContent(),
        ),
      ),
      body: BlocListener<ActivityReportBloc, ActivityReportState>(
        listener: (context, state) {
          if (state is ActivityReportLoading) {
            onLoading(context);
          }

          if (state is ActivityReportDisposeLoading) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context, rootNavigator: false).pop();
            });
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              BlocBuilder<ActivityReportBloc, ActivityReportState>(
                builder: (context, state) {
                  if (state is ActivityReportFailed) {
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
                  }

                  if (state is ActivityReportError) {
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

                  if (state is ActivityReportSuccess) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      separatorBuilder: (BuildContext context, int index) => Divider(),
                      itemBuilder: (context, index) {
                        var data = state.value.data[index];
                        return ListTile(
                          onTap: () {
                            _onViewDetailsActivityReport(data);
                          },
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text("${data.title.toUpperCase()}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text("${dateFormat.format(DateTime.parse(data.createdDate))}",
                                style: TextStyle(
                                  fontSize: 10,
                                  letterSpacing: 0.6,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(data.description.isEmpty ? "-" : "${data.description}",
                            style: TextStyle(
                              fontSize: 11,
                            ),
                          ),
                        );
                      },
                      itemCount: state.value.data.length,
                    );
                  }

                  return SizedBox();
                },
              ),
              Divider(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAddActivityReport();
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: HexColor('#C61818'),
      ),
    );
  }
  
  Widget searchContent() {
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
                decoration: InputDecoration(
                  border: InputBorder.none,
                  enabled: false,
                  contentPadding: EdgeInsets.only(bottom: 18),
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
                controller: searchCtrl,
                onEditingComplete: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }
}
