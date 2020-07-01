import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_event.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_state.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/target_dashboard_bloc.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/target_dashboard_event.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/target_dashboard_state.dart';
import 'package:salles_tools/src/services/dashboard_service.dart';
import 'package:salles_tools/src/utils/currency_format.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/dashboard_page/bar_chart.dart';
import 'package:salles_tools/src/views/dashboard_page/radial_chart.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:salles_tools/src/views/dashboard_page/handle_chart_listEmpty.dart';
import 'package:select_dialog/select_dialog.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String yearMonth;
  var _employeeId;

  var yearFormat = DateFormat("MMMM");
  var bulan;

  List<String> newValueMonth = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  // String bulan = "Januari";

  void _getTargetDashboard() async {
    _employeeId = await SharedPreferencesHelper.getSalesNIK();

    final targetDashboardBloc = BlocProvider.of<TargetDashboardBloc>(context);
    switch (bulan) {
      case 'Januari':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202001',
        )));
        break;
      case 'Februari':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202002',
        )));
        break;
      case 'Maret':
        return targetDashboardBloc.add(FetchTargetDashboard(
            TargetDashboardPost(employeeId: _employeeId, yearMonth: '202003')));
        break;
      case 'April':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202004',
        )));
        break;
      case 'Mei':
        return targetDashboardBloc.add(FetchTargetDashboard(
            TargetDashboardPost(employeeId: _employeeId, yearMonth: '202005')));
        break;
      case 'Juni':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202006',
        )));
        break;
      case 'Juli':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202007',
        )));
        break;
      case 'Agustus':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202008',
        )));
        break;
      case 'September':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202009',
        )));
        break;
      case 'Oktober':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202010',
        )));
        break;
      case 'November':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202011',
        )));
        break;
      case 'Desember':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202012',
        )));
        break;
      default:
    }
  }

  void _newMonthTargetDashboard() async {
    _employeeId = await SharedPreferencesHelper.getSalesNIK();

    final targetDashboardBloc = BlocProvider.of<TargetDashboardBloc>(context);
    switch (bulan) {
      case 'Januari':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202001',
        )));
        break;
      case 'Februari':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202002',
        )));
        break;
      case 'Maret':
        return targetDashboardBloc.add(FetchTargetDashboard(
            TargetDashboardPost(employeeId: _employeeId, yearMonth: '202003')));
        break;
      case 'April':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202004',
        )));
        break;
      case 'Mei':
        return targetDashboardBloc.add(FetchTargetDashboard(
            TargetDashboardPost(employeeId: _employeeId, yearMonth: '202005')));
        break;
      case 'Juni':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202006',
        )));
        break;
      case 'Juli':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202007',
        )));
        break;
      case 'Agustus':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202008',
        )));
        break;
      case 'September':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202009',
        )));
        break;
      case 'Oktober':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202010',
        )));
        break;
      case 'November':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202011',
        )));
        break;
      case 'Desember':
        return targetDashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
          employeeId: _employeeId,
          yearMonth: '202012',
        )));
        break;
      default:
    }
  }

  void _getDashboard() async {
    _employeeId = await SharedPreferencesHelper.getSalesNIK();

    final targetDashboardBloc = BlocProvider.of<DashboardBloc>(context);
    switch (bulan) {
      case 'Januari':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202001',
        )));
        break;
      case 'Februari':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202002',
        )));
        break;
      case 'Maret':
        return targetDashboardBloc
            .add(FetchDashboard(DashboardPost(yearMonth: '202003')));
        break;
      case 'April':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202004',
        )));
        break;
      case 'Mei':
        return targetDashboardBloc
            .add(FetchDashboard(DashboardPost(yearMonth: '202005')));
        break;
      case 'Juni':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202006',
        )));
        break;
      case 'Juli':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202007',
        )));
        break;
      case 'Agustus':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202008',
        )));
        break;
      case 'September':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202009',
        )));
        break;
      case 'Oktober':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202010',
        )));
        break;
      case 'November':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202011',
        )));
        break;
      case 'Desember':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202012',
        )));
        break;
      default:
    }
  }

  void _newMonthDashboard() async {
    _employeeId = await SharedPreferencesHelper.getSalesNIK();

    final targetDashboardBloc = BlocProvider.of<DashboardBloc>(context);
    switch (bulan) {
      case 'Januari':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202001',
        )));
        break;
      case 'Februari':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202002',
        )));
        break;
      case 'Maret':
        return targetDashboardBloc
            .add(FetchDashboard(DashboardPost(yearMonth: '202003')));
        break;
      case 'April':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202004',
        )));
        break;
      case 'Mei':
        return targetDashboardBloc
            .add(FetchDashboard(DashboardPost(yearMonth: '202005')));
        break;
      case 'Juni':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202006',
        )));
        break;
      case 'Juli':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202007',
        )));
        break;
      case 'Agustus':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202008',
        )));
        break;
      case 'September':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202009',
        )));
        break;
      case 'Oktober':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202010',
        )));
        break;
      case 'November':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202011',
        )));
        break;
      case 'Desember':
        return targetDashboardBloc.add(FetchDashboard(DashboardPost(
          yearMonth: '202012',
        )));
        break;
      default:
    }
  }

  void _formatTanggalIndo() {
    initializeDateFormatting("id", null).then((_) {
      var formatter = new DateFormat.MMMM('id');
      print("konversi tanggal ${formatter.format(new DateTime.now())}");

      setState(() {
        bulan = formatter.format(DateTime.now());
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _formatTanggalIndo();
    _getTargetDashboard();
    _getDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#C61818'),
      body: MultiBlocListener(
        listeners: [
          BlocListener<TargetDashboardBloc, TargetDashboardState>(
            listener: (context, state) {
              if (state is TargetDashboardLoading) {
                onLoading(context);
              }

              if (state is TargetDashboardDisposeLoading) {
                Navigator.of(context, rootNavigator: false).pop();
              }
            },
          ),
          BlocListener<DashboardBloc, DashboardState>(
            listener: (context, state) {
              if (state is DashboardLoading) {
                onLoading(context);
              }

              if (state is DashboardDisposeLoading) {
                Navigator.of(context, rootNavigator: false).pop();
              }
            },
          ),
        ],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 295,
              color: HexColor('#C61818'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: paddingTop(context) + 10,
                      left: 15,
                      right: 15,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        SelectDialog.showModal<String>(
                          context,
                          label: "Dashboard Bulan",
                          items: newValueMonth,
                          showSearchBox: false,
                          onChange: (String selected) {
                            setState(() {
                              bulan = selected;
                            });
                            print("Bulan after change => $bulan");
                            _newMonthTargetDashboard();
                            _newMonthDashboard();
                          },
                        );
                      },
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Dashboard Bulan $bulan",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_drop_down, color: Colors.white, size: 25,)
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<TargetDashboardBloc, TargetDashboardState>(
                      builder: (context, targetState) {
                    if (targetState is TargetDashboardSuccess) {
                      return Column(
                        children: <Widget>[
                          SizedBox(height: 20),
                          targetState.value.isEmpty
                              ? HandleChartEmptyValue()
                              : RadialChartView(
                                  data: targetState.value[0],
                                ),
                        ],
                      );
                    }
                    return SizedBox();
                  }),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  boxShadow: [
                    BoxShadow(blurRadius: 13.0, color: Colors.black26),
                  ],
                ),
                child: BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, dashboardState) {
                  if (dashboardState is DashboardLoading) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                        boxShadow: [
                          BoxShadow(blurRadius: 13.0, color: Colors.black26),
                        ],
                      ),
                      height: 200,
                    );
                  }

                  if (dashboardState is DashboardSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 15),
                            child: BarChartView(
                              dataDashboard: dashboardState.value,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return SizedBox();
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
