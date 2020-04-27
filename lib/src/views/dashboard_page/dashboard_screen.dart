import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_bloc.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_event.dart';
import 'package:salles_tools/src/bloc/dashboard_bloc/dashboard_state.dart';
import 'package:salles_tools/src/services/dashboard_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/utils/screen_size.dart';
import 'package:salles_tools/src/utils/shared_preferences_helper.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/dashboard_page/bar_chart.dart';
import 'package:salles_tools/src/views/dashboard_page/radial_chart.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var _employeeId;

  void _getTargetDashboard() async {
    _employeeId = await SharedPreferencesHelper.getSalesNIK();
    // ignore: close_sinks
    final dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    dashboardBloc.add(FetchTargetDashboard(TargetDashboardPost(
      employeeId: _employeeId,
    )));
  }

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    _getTargetDashboard();
    final dashboardBloc = BlocProvider.of<DashboardBloc>(context);
    dashboardBloc.add(FetchDashboard());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#C61818'),
      body: BlocListener<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardLoading) {
            onLoading(context);
          }

          if (state is DashboardDisposeLoading) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context, rootNavigator: false).pop();
            });
          }
        },
        child: BlocBuilder<DashboardBloc, DashboardState>(
            builder: (context, state) {
          if (state is DashboardFailed) {
            print("DASHBOARD WIDGET FAILED");
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context, rootNavigator: true).pop();
            });
            return Center(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  children: <Widget>[
                    Image.asset("assets/icons/error_banner.jpg", height: 200),
                  ],
                ),
              ),
            );
          }

          if (state is DashboardSuccess) {
            print("DASHBOARD WIDGET OK");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 340,
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
                        child: Text(
                          "Dashboard",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 20),
                        child: Text(
                          "Your Quantity",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 5, bottom: 5),
                        child: Container(
                          width: screenWidth(context),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Text(
                              "20 Unit",
                              style: TextStyle(
                                fontSize: 17,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      RadialChartView(),
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 15),
                            child: BarChartView(
                              dataDashboard: state.value,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: <Widget>[
                          //     Card(
                          //       elevation: 7,
                          //       child: Container(
                          //         child: Row(
                          //           children: <Widget>[
                          //             Padding(
                          //               padding:
                          //                   const EdgeInsets.only(left: 10),
                          //               child: Image.asset(
                          //                 "assets/icons/sad-icon.png",
                          //                 height: 40,
                          //               ),
                          //             ),
                          //             Container(
                          //               child: Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: <Widget>[
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(
                          //                       left: 10,
                          //                       right: 10,
                          //                       top: 15,
                          //                       bottom: 2,
                          //                     ),
                          //                     child: Text(
                          //                       "Penjualan Terendah",
                          //                       style: TextStyle(
                          //                         fontSize: 10,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                   Padding(
                          //                     padding: const EdgeInsets.only(
                          //                       left: 10,
                          //                       bottom: 15,
                          //                     ),
                          //                     child: Text(
                          //                       "3 orang",
                          //                       style: TextStyle(
                          //                         letterSpacing: 0.8,
                          //                         fontWeight: FontWeight.w700,
                          //                       ),
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //     Card(
                          //       elevation: 7,
                          //       child: Container(
                          //         child: Row(
                          //           children: <Widget>[
                          //             Padding(
                          //               padding:
                          //                   const EdgeInsets.only(left: 10),
                          //               child: Image.asset(
                          //                 "assets/icons/happy-icon.png",
                          //                 color: Colors.red,
                          //                 height: 40,
                          //               ),
                          //             ),
                          //             Column(
                          //               crossAxisAlignment:
                          //                   CrossAxisAlignment.start,
                          //               children: <Widget>[
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                     left: 10,
                          //                     right: 10,
                          //                     top: 15,
                          //                     bottom: 2,
                          //                   ),
                          //                   child: Text(
                          //                     "Penjualan Tertinggi",
                          //                     style: TextStyle(
                          //                       fontSize: 10,
                          //                     ),
                          //                   ),
                          //                 ),
                          //                 Padding(
                          //                   padding: const EdgeInsets.only(
                          //                     left: 10,
                          //                     bottom: 15,
                          //                   ),
                          //                   child: Text(
                          //                     "102 orang",
                          //                     style: TextStyle(
                          //                       letterSpacing: 0.8,
                          //                       fontWeight: FontWeight.w700,
                          //                     ),
                          //                   ),
                          //                 ),
                          //               ],
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return SizedBox();
        }),
      ),
    );
  }
}
