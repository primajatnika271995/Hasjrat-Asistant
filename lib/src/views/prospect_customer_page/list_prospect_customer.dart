import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:salles_tools/src/bloc/customer_bloc/customer_bloc.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_bloc.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_event.dart';
import 'package:salles_tools/src/bloc/lead_bloc/lead_state.dart';
import 'package:salles_tools/src/models/lead_model.dart';
import 'package:salles_tools/src/services/customer_service.dart';
import 'package:salles_tools/src/utils/hex_converter.dart';
import 'package:salles_tools/src/views/components/bottom_loader_content.dart';
import 'package:salles_tools/src/views/components/loading_content.dart';
import 'package:salles_tools/src/views/prospect_customer_page/add_prospect_contact.dart';
import 'package:salles_tools/src/views/prospect_customer_page/details_prospect_contact.dart';

class ProspectCustomerListView extends StatefulWidget {
  @override
  _ProspectCustomerListViewState createState() =>
      _ProspectCustomerListViewState();
}

class _ProspectCustomerListViewState extends State<ProspectCustomerListView> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;

  void _onAddProspectCustomer() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => BlocProvider(
          create: (context) => CustomerBloc(CustomerService()),
          child: ProspectContactAdd(),
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

  void _onViewDetailsContact(Datum value) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => ProspectContactDetailsView(value),
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

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      // ignore: close_sinks
      final leadBloc = BlocProvider.of<LeadBloc>(context);
      leadBloc.add(FetchLead(LeadPost(
        leadCode: "",
        leadName: "",
      )));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _scrollController.addListener(_onScroll);
//    // ignore: close_sinks
//    final leadBloc = BlocProvider.of<LeadBloc>(context);
//    leadBloc.add(FetchLead(LeadPost(
//      leadCode: "",
//      leadName: "",
//    )));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 3,
        titleSpacing: 0,
        title: Text(
          "Prospect Customer",
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocListener<LeadBloc, LeadState>(
        listener: (context, state) {
          if (state is LeadLoading) {
            onLoading(context);
          }

          if (state is LeadDisposeLoading) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.of(context, rootNavigator: false).pop();
            });
          }
        },
        child: BlocBuilder<LeadBloc, LeadState>(
          builder: (context, state) {
            if (state is LeadInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LeadFailed) {
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

            if (state is LeadSuccess) {
              return ListView.builder(
                shrinkWrap: true,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  return index >= state.leads.length
                      ? BottomLoader()
                      : SlidableCustomerView(
                          index: index,
                          value: state.leads[index],
                          callback: () {
                            _onViewDetailsContact(state.leads[index]);
                          },
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.leads.length
                    : state.leads.length + 1,
              );
            }
            return SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onAddProspectCustomer();
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: HexColor('#C61818'),
      ),
    );
  }
}

class SlidableCustomerView extends StatelessWidget {
  final Function callback;
  final Datum value;
  final int index;
  SlidableCustomerView({Key key, this.callback, this.value, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Card(
          elevation: 5,
          child: ListTile(
            onTap: () {
              this.callback();
            },
            leading: CircleAvatar(
              backgroundColor: Colors.indigoAccent,
              foregroundColor: Colors.white,
              backgroundImage: NetworkImage("https://content-static.upwork.com/uploads/2014/10/02123010/profilephoto_goodcrop.jpg"),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text(
                "${value.leadCode}",
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
                  "${value.cardName}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "${value.phone1}",
                  style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
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
                            "${value.suspectstatus}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      value.suspectDate == null ? "No Date" : "${value.suspectDate.day}/${value.suspectDate.month}/${value.suspectDate.year}",
                      style: TextStyle(
                        letterSpacing: 1.0,
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {},
        ),
      ],
    );
  }
}
