import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_event.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_state.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/components/log.dart';
import 'package:salles_tools/src/views/customer_page/details_customer.dart';
import 'package:sticky_headers/sticky_headers.dart';

class CustomerListView extends StatefulWidget {
  @override
  _CustomerListViewState createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  List<String> _alphabet = [];

  void _onViewDetailsCustomer() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => CustomerDetailsView(),
        transitionDuration: Duration(milliseconds: 150),
        transitionsBuilder:
            (_, Animation<double> animation, __, Widget child) {
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
//    getCustomer();
    // ignore: close_sinks
    final customerBloc = BlocProvider.of<CustomerBloc>(context);
    customerBloc.add(FetchCustomer(CustomerPost(
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
        titleSpacing: 0,
        title: Text(
          "Customer",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
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
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            BlocBuilder<CustomerBloc, CustomerState>(
              builder: (context, state) {
                if (state is CustomerLoading) {
                  _alphabet = [];
                  log.info("onLoading");
                  onLoading(context);
                }

                if (state is CustomerSuccess) {
                  Navigator.of(context).pop();
                  state.value.data.forEach((val) {
                    _alphabet.add(val.cardName.substring(0, 1).toUpperCase());
                  });
                  _alphabet.sort((a, b) {
                    return a.compareTo(b);
                  });
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return StickyHeader(
                        header: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                              child: Text(
                                "${_alphabet.toSet().toList()[index]}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Divider(
                              height: 10,
                            ),
                          ],
                        ),
                        content: Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.value.data.where((f) => f.cardName.substring(0, 1).toUpperCase() == _alphabet.toSet().toList()[index]).toList().length,
                            itemBuilder: (context, indexChild) {
                              var dataCustomer = state.value.data.where((f) => f.cardName.substring(0, 1).toUpperCase() == _alphabet.toSet().toList()[index]).toList();
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(
                                  onTap: () {
                                    _onViewDetailsCustomer();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text("${dataCustomer[indexChild].cardName}"),
                                      Text("●", style: TextStyle(color: Colors.orangeAccent),),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    itemCount: _alphabet.toSet().toList().length,
                  );
                }
                return Center(
                  child: Image.asset(
                    "assets/icons/empty_icon.png",
                    height: 100,
                    color: HexColor('#E07B36'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
