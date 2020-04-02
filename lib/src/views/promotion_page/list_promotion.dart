import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_bloc.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_event.dart';
import 'package:salles_tools/src/bloc/dms_bloc/dms_state.dart';
import 'package:salles_tools/src/models/program_penjualan_model.dart';
import 'package:salles_tools/src/services/dms_service.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/promotion_page/details_promotion.dart';

class PromotionListScreen extends StatefulWidget {
  @override
  _PromotionListScreenState createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends State<PromotionListScreen> {

  final dateFormat = DateFormat("dd-MM-yyyy");

  void _onDetailsPromotion(Datum value) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => PromotionDetailsView(
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

  @override
  void initState() {
    // TODO: implement initState
    // ignore: close_sinks
    final promotionBloc = BlocProvider.of<DmsBloc>(context);
    promotionBloc.add(FetchProgramPenjualan(
        ProgramPenjualanPost(
          id: "",
          limit: "10",
          start: "0",
        ),
      ),
    );
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
          "Promotion",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<DmsBloc, DmsState>(
        listener: (context, state) {
          if (state is DmsLoading) {
            onLoading(context);
          }

          if (state is DmsDisposeLoading) {
            Navigator.of(context).pop();
          }
        },
        child: SingleChildScrollView(
          child: BlocBuilder<DmsBloc, DmsState>(
            builder: (context, state) {
              if (state is ListProgramPenjualanSuccess) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = state.value.data[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 5,
                        child: ListTile(
                          onTap: () {
                            _onDetailsPromotion(data);
                          },
                          title: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "${data.programPenjualanName}",
                              style: TextStyle(
                                letterSpacing: 1.0,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Diskon ${data.models[0].discPl}% untuk ${data.models[0].itemName}",
                                style: TextStyle(
                                  letterSpacing: 1.0,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Valid Until ${dateFormat.format(DateTime.parse(data.endDate.toString()))}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                    child: Container(
                                      height: 18,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${data.paymentTypeName}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
        ),
      ),
    );
  }
}
